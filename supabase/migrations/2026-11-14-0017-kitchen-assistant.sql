-- jins-kitchen migration 0017 (2026-11-14): Ask Claude in the app, stage 1 (questions only)
--  * assistant_device: one row per phone or browser paired to the Ask panel. The app makes a random key that never
--    leaves the device; only its SHA-256 is stored here. A new device shows a 6-character pairing code; Jin sends the
--    code to Claude in a chat and Claude approves it with kitchen_assistant_pair_approve. No password, no email.
--  * assistant_thread / assistant_message: the conversation kept per meal or dish, with the model, token usage and
--    estimated cost of every answer. Not readable through the Data API: the app reads them through the
--    kitchen-assistant Edge Function, which checks the device first.
--  * kitchen_config: the model, the daily question cap (60), the monthly ceiling (US$15), the price list the cost
--    estimate uses, and where the spend switch (claude_api, in jins-restaurants) is read.
--  * The Edge Function (supabase/functions/kitchen-assistant) does the asking. It holds the Anthropic key as the
--    function secret ANTHROPIC_API_KEY; the key is never in this database, the app or a file.
-- Everything here is revoked from anon and authenticated; only service_role (the Edge Function, the Supabase
-- connector) can read or call it.
-- Applied 14 Nov 2026 by Claude through the Supabase connector (apply_migration ran without the cancelled prompt); the
-- three function bodies were md5-checked against this file after it ran. Asked by Jin 14 Nov ("Proceed with stage 1").

create table if not exists public.assistant_device (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  key_hash text not null unique,
  pair_code text not null,
  label text,
  status text not null default 'pending' check (status in ('pending', 'approved', 'revoked')),
  approved_at timestamptz,
  approved_by text,
  revoked_at timestamptz,
  last_seen_at timestamptz
);
create index if not exists assistant_device_code_idx on public.assistant_device (pair_code);

create table if not exists public.assistant_thread (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  owner_type text not null check (owner_type in ('meal', 'dish')),
  slug text not null,
  device_id uuid references public.assistant_device (id)
);
create index if not exists assistant_thread_slug_idx on public.assistant_thread (owner_type, slug, created_at desc);

create table if not exists public.assistant_message (
  id uuid primary key default gen_random_uuid(),
  thread_id uuid not null references public.assistant_thread (id),
  created_at timestamptz not null default now(),
  role text not null check (role in ('user', 'assistant')),
  content text not null default '',
  status text not null default 'ok' check (status in ('ok', 'partial', 'error')),
  model text,
  spend_mode text,
  usage jsonb,
  cost_usd numeric(10, 5),
  tools jsonb,
  error_detail text,
  ms integer,
  device_id uuid references public.assistant_device (id)
);
create index if not exists assistant_message_thread_idx on public.assistant_message (thread_id, created_at);
create index if not exists assistant_message_created_idx on public.assistant_message (created_at desc);

alter table public.assistant_device enable row level security;
alter table public.assistant_thread enable row level security;
alter table public.assistant_message enable row level security;
revoke all on public.assistant_device from anon, authenticated;
revoke all on public.assistant_thread from anon, authenticated;
revoke all on public.assistant_message from anon, authenticated;
grant all on public.assistant_device to service_role;
grant all on public.assistant_thread to service_role;
grant all on public.assistant_message to service_role;

insert into public.kitchen_config (key, value, updated_at) values
  ('assistant_model', 'claude-opus-5-5', now()),
  ('assistant_model_economy', 'claude-sonnet-5-5', now()),
  ('assistant_daily_limit', '60', now()),
  ('assistant_monthly_usd', '15', now()),
  ('assistant_max_tokens', '2000', now()),
  ('assistant_prices', '{"claude-opus-5-5":{"in":4,"cw":5,"cr":0.2,"out":20},"claude-sonnet-5-5":{"in":2,"cw":2.5,"cr":0.1,"out":10},"source":"platform.claude.com/docs/en/about-claude/pricing, USD per million tokens, read 14 Nov 2026"}', now()),
  ('spend_mode_url', 'https://dunebdadsixnpufqnsss.supabase.co/rest/v1/rpc/spend_mode', now()),
  ('spend_mode_key', 'sb_publishable_C9GDMXxN6sXBdFzb2zagmA_GFI_YlSu', now())
on conflict (key) do nothing;

-- Approve the device that is showing this pairing code. Called from a chat: select public.kitchen_assistant_pair_approve('K7M2QX', 'Jin''s phone');
create or replace function public.kitchen_assistant_pair_approve(p_code text, p_label text default null, p_by text default 'chat')
returns jsonb language plpgsql set search_path to 'public' as $fn$
declare d public.assistant_device;
begin
  select * into d from public.assistant_device
   where upper(pair_code) = upper(trim(p_code)) and status = 'pending' and created_at > now() - interval '24 hours'
   order by created_at desc limit 1;
  if not found then
    return jsonb_build_object('status', 'not_found',
      'hint', 'No device is waiting with that code. Codes last 24 hours: open Ask in the app again for a fresh one.');
  end if;
  update public.assistant_device
     set status = 'approved', approved_at = now(), approved_by = p_by, label = coalesce(nullif(trim(p_label), ''), label)
   where id = d.id;
  return jsonb_build_object('status', 'approved', 'device', d.id, 'label', coalesce(nullif(trim(p_label), ''), d.label),
                            'asked_at', d.created_at);
end $fn$;

-- Turn a device off (a lost phone). select public.kitchen_assistant_revoke('<device id>');
create or replace function public.kitchen_assistant_revoke(p_device uuid, p_by text default 'chat')
returns jsonb language plpgsql set search_path to 'public' as $fn$
declare n integer;
begin
  update public.assistant_device set status = 'revoked', revoked_at = now(), approved_by = coalesce(approved_by, p_by)
   where id = p_device and status <> 'revoked';
  get diagnostics n = row_count;
  return jsonb_build_object('status', case when n = 1 then 'revoked' else 'not_found' end, 'device', p_device);
end $fn$;

-- What the Ask panel has used: today, this month (Singapore time), the limits, and the paired devices.
create or replace function public.kitchen_assistant_usage()
returns jsonb language sql stable set search_path to 'public' as $fn$
  select jsonb_build_object(
    'questions_24h', (select count(*) from public.assistant_message where role = 'user' and created_at > now() - interval '24 hours'),
    'daily_limit', (select value::integer from public.kitchen_config where key = 'assistant_daily_limit'),
    'month_start', (date_trunc('month', now() at time zone 'Asia/Singapore'))::date,
    'month_usd', (select coalesce(round(sum(cost_usd), 4), 0) from public.assistant_message
                   where created_at >= (date_trunc('month', now() at time zone 'Asia/Singapore') at time zone 'Asia/Singapore')),
    'month_questions', (select count(*) from public.assistant_message
                   where role = 'user' and created_at >= (date_trunc('month', now() at time zone 'Asia/Singapore') at time zone 'Asia/Singapore')),
    'monthly_usd_cap', (select value::numeric from public.kitchen_config where key = 'assistant_monthly_usd'),
    'model', (select value from public.kitchen_config where key = 'assistant_model'),
    'devices', coalesce((select jsonb_agg(jsonb_build_object('id', id, 'label', label, 'status', status, 'code', pair_code,
                                 'asked_at', created_at, 'last_seen_at', last_seen_at) order by created_at desc)
                           from public.assistant_device
                          where status = 'approved' or (status = 'pending' and created_at > now() - interval '24 hours')), '[]'::jsonb))
$fn$;

revoke all on function public.kitchen_assistant_pair_approve(text, text, text) from public, anon, authenticated;
revoke all on function public.kitchen_assistant_revoke(uuid, text) from public, anon, authenticated;
revoke all on function public.kitchen_assistant_usage() from public, anon, authenticated;
grant execute on function public.kitchen_assistant_pair_approve(text, text, text) to service_role;
grant execute on function public.kitchen_assistant_revoke(uuid, text) to service_role;
grant execute on function public.kitchen_assistant_usage() to service_role;
