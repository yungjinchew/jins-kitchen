-- jins-kitchen migration 0013 (2026-11-01): post-cook logs sent from the app go straight to Claude
--  * cook_inbox: one row per post-cook log the app sends (meal or dish). `log` is the same POST-COOK LOG block Jin used
--    to copy into a chat; `payload` carries the same values as fields. status new -> loaded | rejected.
--  * kitchen_cook_submit(kind, slug, payload, log, client_id): the app's Send to Claude button. A resend with the same
--    client_id replaces the row while it is still new (no duplicate cook); once loaded it is not changed. At most 20
--    new rows in 24 h; size-capped. Callable by the app (anon).
--  * kitchen_cook_inbox_close(id, status, result): Claude marks a row loaded (after kitchen_save_cook) or rejected,
--    with a one-line result the app shows. Not callable by the app.
-- Claude loads new rows in the daily Kitchen inbox drain and at the start of any cooking session with the Supabase
-- connector (data protocol v1.14 §5). Nothing here writes a cook row: kitchen_save_cook stays the only write path.

create table if not exists public.cook_inbox (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  owner_type text not null check (owner_type in ('meal', 'dish')),
  slug text not null,
  client_id text,
  payload jsonb not null default '{}'::jsonb,
  log text not null,
  status text not null default 'new' check (status in ('new', 'loaded', 'rejected')),
  handled_at timestamptz,
  result text
);
create unique index if not exists cook_inbox_client_idx on public.cook_inbox (client_id) where client_id is not null;
create index if not exists cook_inbox_status_idx on public.cook_inbox (status, created_at);
alter table public.cook_inbox enable row level security;
do $$ begin
  if not exists (select 1 from pg_policies where schemaname = 'public' and tablename = 'cook_inbox' and policyname = 'cook_inbox_read') then
    create policy cook_inbox_read on public.cook_inbox for select to anon, authenticated using (true);
  end if;
end $$;
-- the app reads only the status of what it sent, never the log text back
revoke all on public.cook_inbox from anon, authenticated;
grant select (id, created_at, owner_type, slug, client_id, status, handled_at, result) on public.cook_inbox to anon, authenticated;

create or replace function public.kitchen_cook_submit(p_kind text, p_slug text, p_payload jsonb, p_log text, p_client_id text default null)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare
  v_id uuid; v_status text; v_n int; v_ok boolean;
begin
  if p_kind not in ('meal', 'dish') then return jsonb_build_object('status', 'error', 'detail', 'kind must be meal or dish'); end if;
  if p_kind = 'meal' then select exists (select 1 from public.meal where slug = p_slug) into v_ok;
  else select exists (select 1 from public.dish where slug = p_slug) into v_ok; end if;
  if not v_ok then return jsonb_build_object('status', 'error', 'detail', 'no ' || p_kind || ' with that slug'); end if;
  if coalesce(length(p_log), 0) < 20 or length(p_log) > 20000 or pg_column_size(coalesce(p_payload, '{}'::jsonb)) > 60000
     or (p_client_id is not null and length(p_client_id) > 60) then
    return jsonb_build_object('status', 'error', 'detail', 'log is empty or too large');
  end if;
  if p_client_id is not null then
    select id, status into v_id, v_status from public.cook_inbox where client_id = p_client_id;
    if found then
      if v_status <> 'new' then
        return jsonb_build_object('status', 'already', 'id', v_id, 'state', v_status);
      end if;
      update public.cook_inbox set payload = coalesce(p_payload, '{}'::jsonb), log = p_log, owner_type = p_kind, slug = p_slug, created_at = now()
       where id = v_id;
      return jsonb_build_object('status', 'sent', 'id', v_id, 'resent', true);
    end if;
  end if;
  select count(*) into v_n from public.cook_inbox where created_at > now() - interval '24 hours';
  if v_n >= 20 then return jsonb_build_object('status', 'limit', 'limit', 20); end if;
  insert into public.cook_inbox (owner_type, slug, client_id, payload, log)
  values (p_kind, p_slug, p_client_id, coalesce(p_payload, '{}'::jsonb), p_log)
  returning id into v_id;
  return jsonb_build_object('status', 'sent', 'id', v_id);
end $fn$;

create or replace function public.kitchen_cook_inbox_close(p_id uuid, p_status text, p_result text default null)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare v_n int;
begin
  if p_status not in ('loaded', 'rejected') then return jsonb_build_object('status', 'error', 'detail', 'status must be loaded or rejected'); end if;
  update public.cook_inbox set status = p_status, handled_at = now(), result = left(p_result, 400)
   where id = p_id and status = 'new';
  get diagnostics v_n = row_count;
  return jsonb_build_object('status', case when v_n = 1 then p_status else 'unchanged' end, 'id', p_id);
end $fn$;

revoke all on function public.kitchen_cook_submit(text, text, jsonb, text, text) from public;
revoke all on function public.kitchen_cook_inbox_close(uuid, text, text) from public, anon, authenticated;
grant execute on function public.kitchen_cook_submit(text, text, jsonb, text, text) to anon, authenticated, service_role;
grant execute on function public.kitchen_cook_inbox_close(uuid, text, text) to service_role;
