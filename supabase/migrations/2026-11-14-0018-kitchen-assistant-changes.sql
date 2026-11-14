-- jins-kitchen migration 0018 (2026-11-14): Ask Claude in the app, stage 2 (changes behind an Apply card)
--  * assistant_change: one row per change the in-app Claude proposes. The Edge Function turns Claude's small edits into
--    save payloads (saves), the payloads that put the old values back (undo), the updated_at of every record it read
--    (guards) and a plain before/after list for the card (display). The model never writes to a recipe.
--  * kitchen_assistant_change_apply(change, mode): the only way a proposal reaches a recipe.
--      check : runs the saves through kitchen_save_dish / kitchen_save_meal and rolls them back (a dry run at proposal time)
--      apply : Jin's tap. Minor changes only; a material change answers needs_review and nothing is written.
--      undo  : puts the old values back, if nothing else has changed the record since.
--    All saves of one change run in one transaction. A record changed since the proposal answers stale. Only the fields
--    listed in the function can be written, whatever the payload says: no names, status, links, versions or wine.
--  * kitchen_assistant_change_close(change, 'saved' | 'declined', note): the Cooking project closes a change Jin sent
--    for review, and answers the queue comment it was filed under.
-- Review rule (Jin, 14 Nov 2026): until the app runs the GPT review itself (stage 3), a material change is held for the
-- review loop in the Cooking project; only minor changes (wording, buying and shopping notes) apply on his tap.
-- Everything here is revoked from anon and authenticated.
-- Applied 14 Nov 2026 by Claude through the Supabase connector (apply_migration); both function bodies md5-checked against
-- this file. Checked live the same day: a dry run leaves the dish byte-identical and logs no revision; apply then undo on one
-- dish's summary returned the original text; a material change, a forbidden field and a stale record are each refused.

create table if not exists public.assistant_change (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  thread_id uuid not null references public.assistant_thread (id),
  message_id uuid references public.assistant_message (id),
  device_id uuid references public.assistant_device (id),
  owner_type text not null check (owner_type in ('meal', 'dish')),
  slug text not null,
  summary text not null,
  class text not null check (class in ('minor', 'material')),
  class_reason text,
  status text not null default 'proposed'
    check (status in ('proposed', 'applied', 'undone', 'discarded', 'filed', 'saved', 'declined', 'stale', 'failed')),
  saves jsonb not null,
  undo jsonb not null,
  guards jsonb not null,
  display jsonb not null default '[]'::jsonb,
  applied_guards jsonb,
  applied_at timestamptz,
  undone_at timestamptz,
  result jsonb,
  comment_id bigint,
  note text,
  error text
);
create index if not exists assistant_change_thread_idx on public.assistant_change (thread_id, created_at);
alter table public.assistant_change enable row level security;
revoke all on public.assistant_change from anon, authenticated;
grant all on public.assistant_change to service_role;

insert into public.kitchen_config (key, value, updated_at) values ('assistant_max_tokens', '6000', now())
on conflict (key) do update set value = excluded.value, updated_at = now();

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
    if p_mode = 'apply' and c.class <> 'minor' then return jsonb_build_object('status', 'needs_review'); end if;
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

-- The Cooking project closes a change Jin sent for review: select public.kitchen_assistant_change_close('<id>', 'saved', 'Reviewed, GPT 2 rounds; saved with the bake at 40 min.');
create or replace function public.kitchen_assistant_change_close(p_change uuid, p_status text, p_note text default null)
returns jsonb language plpgsql set search_path to 'public' as $fn$
declare c public.assistant_change;
begin
  if p_status is null or p_status not in ('saved', 'declined') then
    raise exception 'kitchen_assistant_change_close: status must be saved or declined';
  end if;
  select * into c from public.assistant_change where id = p_change for update;
  if not found then return jsonb_build_object('status', 'not_found'); end if;
  if c.status not in ('filed', 'proposed', 'stale') then
    return jsonb_build_object('status', 'not_open', 'change_status', c.status);
  end if;
  update public.assistant_change set status = p_status, note = nullif(trim(p_note), '') where id = c.id;
  if c.comment_id is not null then
    update public.kitchen_comment
       set status = case when p_status = 'saved' then 'applied' else 'rejected' end,
           response = coalesce(nullif(trim(p_note), ''), response), responded_at = now()
     where id = c.comment_id and status in ('open', 'needs-jin');
  end if;
  return jsonb_build_object('status', p_status, 'change', c.id, 'comment', c.comment_id);
end $fn$;

revoke all on function public.kitchen_assistant_change_apply(uuid, text) from public, anon, authenticated;
revoke all on function public.kitchen_assistant_change_close(uuid, text, text) from public, anon, authenticated;
grant execute on function public.kitchen_assistant_change_apply(uuid, text) to service_role;
grant execute on function public.kitchen_assistant_change_close(uuid, text, text) to service_role;
