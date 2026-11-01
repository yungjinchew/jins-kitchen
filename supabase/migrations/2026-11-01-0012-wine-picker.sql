-- jins-kitchen migration 0012 (2026-11-01): the app's cellar wine picker
--  * wine_pick: one row per pick the app asks for (meal or dish), the live cellar rows it was chosen from, the answer,
--    and whether Jin kept it. meal.wine_pairing stays the planned wine written by Claude; the app shows a kept pick
--    only where no planned wine exists (data protocol v1.12).
--  * kitchen_wine_request(kind, slug, nudge): fetches the live cellar export and the wine pairing reference from GitHub,
--    builds a compact description of the food, and asks GPT (the review service's OpenAI key and model) for one primary
--    pick and one backup. At most wine_daily_limit (10) requests in 24 h; nudges come from a fixed list.
--    If the cellar export cannot be read, the inventory is UNAVAILABLE and only style guidance comes back.
--  * kitchen_wine_result(id): collects the answer; every bottle named must match a row of the Current cellar table
--    (vintage and wine name) or the pick is not shown.
--  * kitchen_wine_keep(id, keep): marks the pick Jin keeps for that meal or dish.
-- The three kitchen_wine_* functions are callable by the app (anon); the helpers are not.

create table if not exists public.wine_pick (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  owner_type text not null check (owner_type in ('meal', 'dish')),
  slug text not null,
  nudge text,
  cellar_snapshot date,
  inventory_valid boolean not null default false,
  status text not null default 'requested' check (status in ('requested', 'done', 'invalid', 'error')),
  request_id bigint,
  model text,
  response_model text,
  usage jsonb,
  pick jsonb,
  raw_text text,
  error_detail text,
  completed_at timestamptz,
  kept boolean not null default false,
  cellar_rows jsonb
);
create index if not exists wine_pick_slug_idx on public.wine_pick (slug, created_at desc);
alter table public.wine_pick enable row level security;
do $$ begin
  if not exists (select 1 from pg_policies where schemaname = 'public' and tablename = 'wine_pick' and policyname = 'wine_pick_read') then
    create policy wine_pick_read on public.wine_pick for select to anon, authenticated using (true);
  end if;
end $$;
grant select on public.wine_pick to anon, authenticated;

insert into public.kitchen_config (key, value, updated_at) values
  ('wine_model', (select value from public.kitchen_config where key = 'review_model'), now()),
  ('wine_daily_limit', '10', now()),
  ('cellar_url', 'https://raw.githubusercontent.com/yungjinchew/jins-cellar-data/refs/heads/main/cellar.md', now())
on conflict (key) do nothing;

-- one dish, described for a pairing: name, protein, course, cuisine, summary, flavour architecture, ingredients
create or replace function public.wine_dish_ctx(p_id uuid, p_role text)
returns text language sql stable set search_path to 'public' as $fn$
  select concat_ws(E'\n',
    '### ' || coalesce(upper(p_role) || ': ', '') || d.name,
    nullif(concat_ws(' · ', d.protein, array_to_string(d.category, '/'), array_to_string(d.cuisine, ', ')), ''),
    nullif(d.summary, ''),
    (select 'Flavour architecture: ' || left(regexp_replace(regexp_replace(sec, '^[^\n]*\n', ''), '\s+', ' ', 'g'), 1200)
       from regexp_split_to_table(replace(coalesce(d.method_md, ''), E'\r', ''), E'\n(?=#{1,3} )') as sec
      where sec ~* '^\s*#{1,3}\s*(\d+\.\s*)?flavou?r architecture' limit 1),
    (select 'Ingredients: ' || string_agg(trim(concat_ws(' ', nullif(trim(to_char(di.qty, 'FM999990.##')), ''), di.unit, i.name,
              case when di.prep_note is not null then '(' || left(di.prep_note, 40) || ')' end)), '; ' order by di.sort_order)
       from public.dish_ingredient di join public.ingredient i on i.id = di.ingredient_id where di.dish_id = d.id)
  ) from public.dish d where d.id = p_id;
$fn$;

create or replace function public.wine_ctx(p_kind text, p_slug text)
returns text language plpgsql stable set search_path to 'public' as $fn$
declare m public.meal; d public.dish; v text;
begin
  if p_kind = 'meal' then
    select * into m from public.meal where slug = p_slug;
    if not found then return null; end if;
    select 'MEAL: ' || m.name || ' · for ' || coalesce(m.pax::text, '3') || E'\n\n'
           || coalesce(string_agg(public.wine_dish_ctx(md.dish_id, md.role::text), E'\n\n' order by md.service_order), '')
      into v from public.meal_dish md where md.meal_id = m.id;
    return v;
  end if;
  select * into d from public.dish where slug = p_slug;
  if not found then return null; end if;
  return E'DISH, served on its own:\n' || public.wine_dish_ctx(d.id, null);
end $fn$;

-- the Current cellar row a named bottle refers to (vintage and wine name), or null
create or replace function public.wine_match(p_rows jsonb, p jsonb)
returns jsonb language sql immutable as $fn$
  select x from jsonb_array_elements(coalesce(p_rows, '[]'::jsonb)) x
   where length(coalesce(p ->> 'wine', '')) >= 4
     and lower(trim(x ->> 'vintage')) = lower(trim(coalesce(p ->> 'vintage', '')))
     and (lower(x ->> 'wine') = lower(p ->> 'wine')
          or position(lower(p ->> 'wine') in lower(x ->> 'wine')) > 0
          or position(lower(x ->> 'wine') in lower(p ->> 'wine')) > 0)
   order by (lower(x ->> 'wine') = lower(p ->> 'wine')) desc
   limit 1;
$fn$;

create or replace function public.wine_pick_json(r public.wine_pick)
returns jsonb language sql immutable as $fn$
  select jsonb_build_object('id', r.id, 'created_at', r.created_at, 'owner_type', r.owner_type, 'slug', r.slug, 'nudge', r.nudge,
    'cellar_snapshot', r.cellar_snapshot, 'inventory_valid', r.inventory_valid, 'status', r.status, 'pick', r.pick,
    'kept', r.kept, 'error_detail', r.error_detail);
$fn$;

create or replace function public.kitchen_wine_request(p_kind text, p_slug text, p_nudge text default null)
returns jsonb language plpgsql security definer set search_path to 'public', 'extensions' as $fn$
declare
  v_key text; v_model text; v_base text; v_url text; v_limit integer; v_n integer;
  v_status integer; v_body text; v_cellar text; v_ref text; v_snap date; v_valid boolean := false;
  v_cur text; v_tasted text; v_rows jsonb := '[]'::jsonb; v_ctx text; v_instr text; v_input text;
  v_req bigint; v_id uuid; v_nudge text; v_recent public.wine_pick;
begin
  if p_kind is null or p_kind not in ('meal', 'dish') then raise exception 'kind must be meal or dish'; end if;
  if (p_kind = 'meal' and not exists (select 1 from public.meal where slug = p_slug))
     or (p_kind = 'dish' and not exists (select 1 from public.dish where slug = p_slug)) then
    return jsonb_build_object('status', 'not_found');
  end if;
  v_nudge := case coalesce(p_nudge, '')
    when '' then null
    when 'lighter' then 'Prefer a lighter, fresher bottle than the obvious pick.'
    when 'bolder' then 'Prefer a fuller, bolder bottle.'
    when 'white' then 'Prefer a white or sparkling wine if one can work with this food.'
    when 'special' then 'A special occasion: a more important bottle is welcome if it suits the food.'
    when 'everyday' then 'Keep it to an everyday bottle and save the important ones.'
    else '?' end;
  if v_nudge = '?' then raise exception 'unknown nudge'; end if;

  select * into v_recent from public.wine_pick
   where slug = p_slug and owner_type = p_kind and status = 'requested' and created_at > now() - interval '3 minutes'
   order by created_at desc limit 1;
  if found then return jsonb_build_object('status', 'requested', 'id', v_recent.id); end if;

  select value::integer into v_limit from public.kitchen_config where key = 'wine_daily_limit';
  select count(*) into v_n from public.wine_pick where created_at > now() - interval '24 hours';
  if v_n >= coalesce(v_limit, 10) then return jsonb_build_object('status', 'limit', 'limit', coalesce(v_limit, 10)); end if;

  select decrypted_secret into v_key from vault.decrypted_secrets where name = 'openai_api_key' limit 1;
  if v_key is null or length(trim(v_key)) = 0 then return jsonb_build_object('status', 'no_key'); end if;
  select value into v_model from public.kitchen_config where key = 'wine_model';
  if v_model is null then select value into v_model from public.kitchen_config where key = 'review_model'; end if;
  select value into v_base from public.kitchen_config where key = 'governance_base';
  select value into v_url from public.kitchen_config where key = 'cellar_url';

  begin
    perform extensions.http_set_curlopt('CURLOPT_TIMEOUT', '12');
    select status, content into v_status, v_body from extensions.http_get(v_url || '?t=' || extract(epoch from now())::bigint);
    if v_status = 200 and v_body ~ '## Current cellar' then v_cellar := v_body; end if;
  exception when others then v_cellar := null; end;
  begin
    select status, content into v_status, v_body from extensions.http_get(v_base || 'wine_pairing_cooking_reference.md');
    if v_status = 200 and length(v_body) > 1000 then v_ref := v_body; end if;
  exception when others then v_ref := null; end;
  if v_ref is null then
    return jsonb_build_object('status', 'error', 'message', 'The wine pairing rules could not be read from GitHub. Try again in a minute.');
  end if;

  if v_cellar is not null then
    v_snap := substring(v_cellar from 'snapshot (\d{4}-\d{2}-\d{2})')::date;
    select sec into v_cur from regexp_split_to_table(replace(v_cellar, E'\r', ''), E'\n(?=## )') sec where sec ~ '^## Current cellar' limit 1;
    select sec into v_tasted from regexp_split_to_table(replace(v_cellar, E'\r', ''), E'\n(?=## )') sec where sec ~ '^## Recently tasted' limit 1;
    select coalesce(jsonb_agg(jsonb_build_object('vintage', trim(a[2]), 'wine', trim(a[3]), 'producer', trim(a[4]), 'colour', trim(a[5]),
             'varietal', trim(a[6]), 'region', trim(a[7]), 'window', trim(a[8]), 'status', trim(a[9]), 'value', trim(a[10]),
             'my10', trim(a[11]), 'ct', trim(a[12]))), '[]'::jsonb)
      into v_rows
      from (select string_to_array(l, '|') a from regexp_split_to_table(coalesce(v_cur, ''), E'\n') l where l ~ '^\|\s*(\d{4}|NV)\s*\|') t;
    v_valid := jsonb_array_length(v_rows) > 0;
  end if;

  v_ctx := public.wine_ctx(p_kind, p_slug);
  v_instr := 'You choose a wine for a home meal from Jin''s own cellar in Singapore. Follow the WINE PAIRING REFERENCE in the input exactly: '
    || 'its objective, household and drinker preferences, food pairing logic, bottle selection rules and recommendation format '
    || '(one primary pick, and one backup only if it is useful). '
    || case when v_valid
         then 'Inventory state: VALID. The CURRENT CELLAR table in the input was fetched just now and is the only source of available bottles. '
              || 'Recommend only bottles that appear in it, using the exact Wine name and Vintage from the table. Never recommend from the '
              || 'Recently tasted table, from memory or from anywhere else. '
         else 'Inventory state: UNAVAILABLE (the live cellar export could not be read). Give general style guidance only and name no specific bottle. ' end
    || 'Do not mention bottle counts or storage locations. Answer with one JSON object and nothing else: '
    || '{"primary": PICK or null, "backup": PICK or null, "guidance": string or null}. PICK is {"pick_type": "Primary Pick" or "Bridge Pick" or '
    || '"Conditional Pick", "vintage": string, "wine": string, "producer": string, "why_food": string (at most two sentences: protein, sauce, '
    || 'fat, acidity, spice, herbs, cooking method, intensity), "why_taste": string (one sentence: which drinker it suits and why), '
    || '"serve": string (one sentence: serving temperature in °C and whether to decant or give it air, and for how long), '
    || '"window": string (drink now, benefits from air, or hold), "tradeoff": string (one sentence)}. "guidance" is a one or two sentence '
    || 'style note when no bottle is named, otherwise null. Plain language, no markdown.';
  v_input := E'=== WINE PAIRING REFERENCE ===\n' || v_ref
    || E'\n\n=== THE FOOD ===\n' || coalesce(v_ctx, p_slug)
    || case when v_nudge is not null then E'\n\n=== JIN''S NUDGE FOR THIS PICK ===\n' || v_nudge else '' end
    || case when v_valid then E'\n\n=== CURRENT CELLAR (live export, snapshot ' || coalesce(v_snap::text, 'unknown') || E') ===\n' || v_cur
         || coalesce(E'\n\n=== RECENTLY TASTED (history only: a taste signal, never available) ===\n' || v_tasted, '') else '' end;

  select net.http_post(
    url := 'https://api.openai.com/v1/responses',
    body := jsonb_build_object('model', v_model, 'instructions', v_instr, 'input', v_input),
    headers := jsonb_build_object('Content-Type', 'application/json', 'Authorization', 'Bearer ' || v_key),
    timeout_milliseconds := 150000
  ) into v_req;

  insert into public.wine_pick (owner_type, slug, nudge, cellar_snapshot, inventory_valid, status, request_id, model, cellar_rows)
  values (p_kind, p_slug, nullif(p_nudge, ''), v_snap, v_valid, 'requested', v_req, v_model, v_rows)
  returning id into v_id;
  return jsonb_build_object('status', 'requested', 'id', v_id, 'inventory_valid', v_valid, 'cellar_snapshot', v_snap);
end $fn$;

create or replace function public.kitchen_wine_result(p_id uuid)
returns jsonb language plpgsql security definer set search_path to 'public', 'extensions' as $fn$
declare
  r public.wine_pick; v_code integer; v_content text; v_err text; v_found boolean := false;
  v_json jsonb; v_text text; v_ans jsonb; v_p jsonb; v_b jsonb; v_m jsonb;
begin
  select * into r from public.wine_pick where id = p_id;
  if not found then return jsonb_build_object('status', 'not_found'); end if;
  if r.status <> 'requested' then return public.wine_pick_json(r); end if;

  select status_code, content, error_msg, true into v_code, v_content, v_err, v_found from net._http_response where id = r.request_id;
  if not coalesce(v_found, false) then
    if now() - r.created_at > interval '4 minutes' then
      update public.wine_pick set status = 'error', error_detail = 'No answer after 4 minutes.', completed_at = now() where id = p_id returning * into r;
      return public.wine_pick_json(r);
    end if;
    return jsonb_build_object('status', 'pending', 'id', r.id, 'waited', round(extract(epoch from (now() - r.created_at))));
  end if;

  if v_code = 200 then
    v_json := v_content::jsonb;
    select string_agg(c ->> 'text', E'\n') into v_text
      from jsonb_array_elements(coalesce(v_json -> 'output', '[]'::jsonb)) o,
           jsonb_array_elements(coalesce(o -> 'content', '[]'::jsonb)) c
     where c ? 'text';
    begin v_ans := substring(coalesce(v_text, '') from '\{.*\}')::jsonb; exception when others then v_ans := null; end;
    if v_ans is null or jsonb_typeof(v_ans) <> 'object' then
      update public.wine_pick set status = 'error', error_detail = 'The answer could not be read. Ask again.', raw_text = v_text,
             response_model = v_json ->> 'model', usage = v_json -> 'usage', completed_at = now() where id = p_id returning * into r;
      return public.wine_pick_json(r);
    end if;
    v_p := case when jsonb_typeof(v_ans -> 'primary') = 'object' then v_ans -> 'primary' end;
    v_b := case when jsonb_typeof(v_ans -> 'backup') = 'object' then v_ans -> 'backup' end;
    if r.inventory_valid then
      v_m := public.wine_match(r.cellar_rows, v_p);
      if v_m is null then
        update public.wine_pick set status = 'invalid', raw_text = v_text, response_model = v_json ->> 'model', usage = v_json -> 'usage', completed_at = now(),
               error_detail = case when v_p is null then 'No bottle was picked. Ask again.'
                                   else 'It named a bottle that is not in the current cellar (' || coalesce(v_p ->> 'vintage', '') || ' ' || coalesce(v_p ->> 'wine', '') || '), so the pick is not shown. Ask again.' end
         where id = p_id returning * into r;
        return public.wine_pick_json(r);
      end if;
      v_p := v_p || jsonb_build_object('cellar', v_m);
      if v_b is not null then
        v_m := public.wine_match(r.cellar_rows, v_b);
        v_b := case when v_m is null or (v_m = (v_p -> 'cellar') and lower(v_b ->> 'wine') = lower(v_p ->> 'wine')) then null else v_b || jsonb_build_object('cellar', v_m) end;
      end if;
    else
      v_p := null; v_b := null;
    end if;
    update public.wine_pick
       set status = 'done', pick = jsonb_build_object('primary', v_p, 'backup', v_b, 'guidance', v_ans ->> 'guidance'),
           raw_text = v_text, response_model = v_json ->> 'model', usage = v_json -> 'usage', completed_at = now()
     where id = p_id returning * into r;
    return public.wine_pick_json(r);
  end if;

  update public.wine_pick
     set status = 'error', completed_at = now(),
         error_detail = case when coalesce(v_content, '') ~* '(credit|billing|quota)' then 'The OpenAI account is out of credit; top it up, then ask again.'
                             else 'The pick failed (' || coalesce(v_code::text, 'no status') || '). Ask again in a minute.' end
   where id = p_id returning * into r;
  return public.wine_pick_json(r);
end $fn$;

create or replace function public.kitchen_wine_keep(p_id uuid, p_keep boolean default true)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare r public.wine_pick;
begin
  select * into r from public.wine_pick where id = p_id;
  if not found or r.status <> 'done' then return jsonb_build_object('status', 'not_found'); end if;
  if p_keep then
    update public.wine_pick set kept = false where slug = r.slug and owner_type = r.owner_type and id <> r.id and kept;
  end if;
  update public.wine_pick set kept = p_keep where id = p_id returning * into r;
  return public.wine_pick_json(r);
end $fn$;

revoke all on function public.wine_dish_ctx(uuid, text) from public, anon, authenticated;
revoke all on function public.wine_ctx(text, text) from public, anon, authenticated;
revoke all on function public.wine_match(jsonb, jsonb) from public, anon, authenticated;
revoke all on function public.wine_pick_json(public.wine_pick) from public, anon, authenticated;
revoke all on function public.kitchen_wine_request(text, text, text) from public;
revoke all on function public.kitchen_wine_result(uuid) from public;
revoke all on function public.kitchen_wine_keep(uuid, boolean) from public;
grant execute on function public.kitchen_wine_request(text, text, text) to anon, authenticated, service_role;
grant execute on function public.kitchen_wine_result(uuid) to anon, authenticated, service_role;
grant execute on function public.kitchen_wine_keep(uuid, boolean) to anon, authenticated, service_role;
