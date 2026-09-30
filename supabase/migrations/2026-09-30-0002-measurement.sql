-- jins-kitchen · migration 0002 · measurement table (applied 2026-09-30)
create table public.measurement (
  id uuid primary key default gen_random_uuid(),
  dish_id uuid references public.dish(id) on delete cascade,
  cook_id uuid references public.cook(id) on delete cascade,
  gate text not null, predicted text, observed text, value_num numeric, unit text, probe text, notes text,
  measured_at timestamptz, sort_order int not null default 0, created_at timestamptz not null default now());
create index measurement_dish_idx on public.measurement (dish_id, sort_order);
create index measurement_cook_idx on public.measurement (cook_id, sort_order);
alter table public.measurement enable row level security;
create policy anon_read on public.measurement for select to anon, authenticated using (true);
