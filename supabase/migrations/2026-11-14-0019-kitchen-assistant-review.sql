-- jins-kitchen migration 0019 (2026-11-14): Ask Claude in the app, stage 3 (the review loop inside the app)
--  * assistant_change gains: edits (the model's own edit list, so a reconciled revision can restate it), review_status
--    (none | running | passed | open | failed), review (the loop's state and the Review log: rounds, findings, decisions,
--    open disagreements, reviewer, cost) and review_lock (one step at a time).
--  * kitchen_assistant_change_apply: a material change now applies when its review has passed with nothing open.
--    Everything else is as in 0018 (minor applies on the tap; check and undo unchanged; the same fixed list of fields).
--  * kitchen_assistant_review_lock(change, seconds): takes the step lock, so two polls never run the same step twice.
--  * kitchen_assistant_usage: adds the reviews started in 24 h, the daily review cap, and the Claude cost of reviews to
--    the month's estimate.
--  * kitchen_config: assistant_review_daily_limit = 5 (Jin, 14 Nov 2026).
-- Jin's rules for the in-app review (14 Nov 2026): it follows recipe_review_protocol.md (GPT through the kitchen review
-- service, Claude reconciling, three rounds plus the confirmation pass); a Claude critic stands in when GPT cannot
-- review, and the Review log says so; an open disagreement holds the change for the Cooking project (no Apply).
-- Applied 14 Nov 2026 through the Supabase connector (apply_migration); the three function bodies md5-checked against this file.

alter table public.assistant_change add column if not exists edits jsonb;
alter table public.assistant_change add column if not exists review_status text not null default 'none';
alter table public.assistant_change add column if not exists review jsonb;
alter table public.assistant_change add column if not exists review_lock timestamptz;
do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'assistant_change_review_status_check') then
    alter table public.assistant_change add constraint assistant_change_review_status_check
      check (review_status in ('none', 'running', 'passed', 'open', 'failed'));
  end if;
end $$;

insert into public.kitchen_config (key, value, updated_at) values ('assistant_review_daily_limit', '5', now())
on conflict (key) do nothing;

create or replace function public.kitchen_assistant_change_apply(p_change uuid, p_mode text)
returns jsonb language plpgsql set search_path to 'public' as $fn$
declare
  dish_keys text[] := array['method_md', 'summary', 'servings', 'equipment', 'nutrition_estimate', 'ingredients', 'new_ingredients'];
  meal_keys text[] := array['workflow_md', 'shared_prep_md', 'shopping_notes', 'service_time', 'pax'];
  c public.assistant_change; s jsonb; g jsonb; k text; r jsonb;
  v_saves jsonb; v_guards jsonb; v_res jsonb := '[]'::jsonb; v_after jsonb := '[]'::jsonb;
  v_at timestamptz; v_src text; v_err text;
begin
  if p_mode is null or p_mode not in ('check', 'apply', 'undo') then
    raise exception 'kitchen_assistant_change_apply: mode must be check, apply or undo';
  end if;
  select * into c from public.assistant_change where id = p_change for update;
  if not found then return jsonb_build_object('status', 'not_found'); end if;

  if p_mode = 'undo' then
    if c.status <> 'applied' then return jsonb_build_object('status', 'not_applied', 'change_status', c.status); end if;
    v_saves := c.undo; v_guards := c.applied_guards;
  else
    if c.status <> 'proposed' then return jsonb_build_object('status', 'not_open', 'change_status', c.status); end if;
    -- a material change applies only after the review loop has passed with nothing open (ASK 1.2)
    if p_mode = 'apply' and c.class <> 'minor' and coalesce(c.review_status, 'none') <> 'passed' then
      return jsonb_build_object('status', 'needs_review');
    end if;
    v_saves := c.saves; v_guards := c.guards;
  end if;
  if v_saves is null or jsonb_typeof(v_saves) <> 'array' or jsonb_array_length(v_saves) = 0
     or v_guards is null or jsonb_typeof(v_guards) <> 'array' or jsonb_array_length(v_guards) = 0 then
    return jsonb_build_object('status', 'error', 'message', 'the change has nothing to save');
  end if;

  -- every record the change touches is as it was when the change was worked out
  for g in select * from jsonb_array_elements(v_guards) loop
    if g->>'entity' = 'dish' then select d.updated_at into v_at from public.dish d where d.slug = g->>'slug';
    else select m.updated_at into v_at from public.meal m where m.slug = g->>'slug'; end if;
    if v_at is null or v_at <> (g->>'updated_at')::timestamptz then
      if p_mode = 'apply' then
        update public.assistant_change set status = 'stale', note = 'The recipe changed after this was proposed.' where id = c.id;
      end if;
      return jsonb_build_object('status', 'stale', 'entity', g->>'entity', 'slug', g->>'slug');
    end if;
  end loop;

  v_src := 'Ask in app ' || to_char(now() at time zone 'Asia/Singapore', 'YYYY-MM-DD')
           || case when p_mode = 'undo' then ' (undo): ' else ': ' end || left(c.summary, 160);
  begin
    for s in select * from jsonb_array_elements(v_saves) loop
      if jsonb_typeof(s->'p') <> 'object' then raise exception 'a save has no fields'; end if;
      if s->>'entity' = 'dish' then
        if not exists (select 1 from public.dish d where d.slug = s->>'slug') then raise exception 'dish % does not exist', s->>'slug'; end if;
        for k in select jsonb_object_keys(s->'p') loop
          if not k = any(dish_keys) then raise exception 'field "%" of a dish cannot be changed from the app', k; end if;
        end loop;
        r := public.kitchen_save_dish(s->>'slug', s->'p', v_src);
      elsif s->>'entity' = 'meal' then
        if not exists (select 1 from public.meal m where m.slug = s->>'slug') then raise exception 'meal % does not exist', s->>'slug'; end if;
        for k in select jsonb_object_keys(s->'p') loop
          if not k = any(meal_keys) then raise exception 'field "%" of a meal cannot be changed from the app', k; end if;
        end loop;
        r := public.kitchen_save_meal(s->>'slug', s->'p', v_src);
      else
        raise exception 'unknown entity %', s->>'entity';
      end if;
      v_res := v_res || jsonb_build_array(r);
    end loop;
    if p_mode = 'check' then raise exception sqlstate 'KA001' using message = 'check only'; end if;
  exception
    when sqlstate 'KA001' then
      return jsonb_build_object('status', 'ok', 'mode', 'check', 'results', v_res);
    when others then
      get stacked diagnostics v_err = message_text;
      return jsonb_build_object('status', 'error', 'message', v_err);
  end;

  select coalesce(jsonb_agg(jsonb_build_object('entity', x->>'entity', 'slug', x->>'slug', 'updated_at',
           case when x->>'entity' = 'dish' then (select d.updated_at from public.dish d where d.slug = x->>'slug')
                else (select m.updated_at from public.meal m where m.slug = x->>'slug') end)), '[]'::jsonb)
    into v_after from jsonb_array_elements(v_guards) x;

  if p_mode = 'apply' then
    update public.assistant_change set status = 'applied', applied_at = now(), applied_guards = v_after, result = v_res where id = c.id;
    return jsonb_build_object('status', 'applied', 'results', v_res);
  end if;
  update public.assistant_change set status = 'undone', undone_at = now(), result = v_res where id = c.id;
  return jsonb_build_object('status', 'undone', 'results', v_res);
end $fn$;

create or replace function public.kitchen_assistant_review_lock(p_change uuid, p_seconds integer default 150)
returns boolean language plpgsql set search_path to 'public' as $fn$
declare n integer;
begin
  update public.assistant_change set review_lock = now() + make_interval(secs => greatest(coalesce(p_seconds, 150), 0))
   where id = p_change and (review_lock is null or review_lock < now() or coalesce(p_seconds, 150) <= 0);
  get diagnostics n = row_count;
  return n = 1;
end $fn$;

create or replace function public.kitchen_assistant_usage()
returns jsonb language sql stable set search_path to 'public' as $fn$
  select jsonb_build_object(
    'questions_24h', (select count(*) from public.assistant_message where role = 'user' and created_at > now() - interval '24 hours'),
    'daily_limit', (select value::integer from public.kitchen_config where key = 'assistant_daily_limit'),
    'month_start', (date_trunc('month', now() at time zone 'Asia/Singapore'))::date,
    'month_usd', (select coalesce(round(sum(cost_usd), 4), 0) from public.assistant_message
                   where created_at >= (date_trunc('month', now() at time zone 'Asia/Singapore') at time zone 'Asia/Singapore'))
               + (select coalesce(round(sum((review->>'cost_usd')::numeric), 4), 0) from public.assistant_change
                   where review ? 'cost_usd' and created_at >= (date_trunc('month', now() at time zone 'Asia/Singapore') at time zone 'Asia/Singapore')),
    'month_questions', (select count(*) from public.assistant_message
                   where role = 'user' and created_at >= (date_trunc('month', now() at time zone 'Asia/Singapore') at time zone 'Asia/Singapore')),
    'monthly_usd_cap', (select value::numeric from public.kitchen_config where key = 'assistant_monthly_usd'),
    'model', (select value from public.kitchen_config where key = 'assistant_model'),
    'reviews_24h', (select count(*) from public.assistant_change where (review->>'started_at')::timestamptz > now() - interval '24 hours'),
    'review_daily_limit', (select value::integer from public.kitchen_config where key = 'assistant_review_daily_limit'),
    'devices', coalesce((select jsonb_agg(jsonb_build_object('id', id, 'label', label, 'status', status, 'code', pair_code,
                                 'asked_at', created_at, 'last_seen_at', last_seen_at) order by created_at desc)
                           from public.assistant_device
                          where status = 'approved' or (status = 'pending' and created_at > now() - interval '24 hours')), '[]'::jsonb))
$fn$;

revoke all on function public.kitchen_assistant_change_apply(uuid, text) from public, anon, authenticated;
revoke all on function public.kitchen_assistant_review_lock(uuid, integer) from public, anon, authenticated;
revoke all on function public.kitchen_assistant_usage() from public, anon, authenticated;
grant execute on function public.kitchen_assistant_change_apply(uuid, text) to service_role;
grant execute on function public.kitchen_assistant_review_lock(uuid, integer) to service_role;
grant execute on function public.kitchen_assistant_usage() to service_role;
