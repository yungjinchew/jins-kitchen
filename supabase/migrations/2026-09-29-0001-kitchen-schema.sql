-- jins-kitchen · migration 0001 · kitchen schema
-- Structured recipe data is the master; docx / PDF / HTML are renders.

create extension if not exists pgcrypto;

-- ---------------------------------------------------------------- enums
create type public.dish_status   as enum ('idea','designed','cooked','retired');
create type public.meal_status   as enum ('backlog','planned','cooked');
create type public.repeat_verdict as enum ('yes','with_modifications','no');
create type public.dish_role     as enum ('main','side','sauce','dessert','soup','bread','starter','salad');
create type public.doc_kind      as enum ('docx','pdf','html','md');
create type public.owner_type    as enum ('meal','dish');
create type public.list_status   as enum ('open','done');

-- ---------------------------------------------------------------- dish
create table public.dish (
  id                  uuid primary key default gen_random_uuid(),
  slug                text not null unique,
  name                text not null,
  protein             text,                    -- Beef, Pork, Lamb, Chicken, Duck, Fish, Shellfish, Seafood, Veg
  category            text[] not null default '{}',   -- Main, Side, Sauce, Dessert, Soup, Bread
  cuisine             text[] not null default '{}',
  difficulty          text,                    -- Easy, Medium, Special
  tags                text[] not null default '{}',
  occasion            text[] not null default '{}',
  status              public.dish_status not null default 'designed',
  source              text,
  governance_version  text,
  summary             text,
  method_md           text,                    -- full recipe body (markdown)
  servings            numeric,
  equipment           text[] not null default '{}',
  designed_unvalidated jsonb not null default '[]'::jsonb,   -- [{param, designed_value, note}]
  nutrition_estimate  jsonb,                   -- {kcal, protein_g, carbs_g, fat_g, per:'serving'}
  legacy_notion_id    text,                    -- migration provenance
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now()
);
create index dish_protein_idx  on public.dish (protein);
create index dish_status_idx   on public.dish (status);
create index dish_category_gin on public.dish using gin (category);
create index dish_tags_gin     on public.dish using gin (tags);
create index dish_name_trgm    on public.dish using gin (to_tsvector('english', name || ' ' || coalesce(summary,'')));

-- ---------------------------------------------------------------- ingredient
create table public.ingredient (
  id             uuid primary key default gen_random_uuid(),
  name           text not null unique,         -- canonical, lower-case singular
  department     text not null,                -- Protein, Produce, Dairy, Pantry, Bread, Oils & Liquids, Seasoning, Frozen, Alcohol
  pantry_default boolean not null default false,
  supplier_hint  text,                         -- e.g. Butcher Box
  created_at     timestamptz not null default now()
);

create table public.dish_ingredient (
  id            uuid primary key default gen_random_uuid(),
  dish_id       uuid not null references public.dish(id) on delete cascade,
  ingredient_id uuid not null references public.ingredient(id),
  qty           numeric,
  unit          text,                          -- g, ml, tsp, tbsp, piece, bunch, clove, sprig…
  qty_alt       text,                          -- human alt e.g. "3 tsp", "6½ tbsp"
  prep_note     text,                          -- "diced", "peeled and quartered"
  pantry_check  boolean not null default false,
  optional      boolean not null default false,
  sort_order    int not null default 0
);
create index dish_ingredient_dish_idx on public.dish_ingredient (dish_id);
create index dish_ingredient_ing_idx  on public.dish_ingredient (ingredient_id);

-- ---------------------------------------------------------------- meal
create table public.meal (
  id              uuid primary key default gen_random_uuid(),
  slug            text not null unique,
  name            text not null,
  planned_date    date,
  service_time    time not null default '18:00',
  status          public.meal_status not null default 'backlog',
  pax             int not null default 3,
  workflow_md     text,                        -- Meal Workflow (critical path, heat allocation, T-minus)
  shared_prep_md  text,
  wine_pairing    text,
  cellar_iwine    text,                        -- optional join key to cellar-hub public.cellar.iwine
  legacy_notion_id text,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);
create index meal_status_idx on public.meal (status);
create index meal_date_idx   on public.meal (planned_date desc);

create table public.meal_dish (
  meal_id       uuid not null references public.meal(id) on delete cascade,
  dish_id       uuid not null references public.dish(id) on delete restrict,
  role          public.dish_role not null,
  service_order int not null default 0,
  primary key (meal_id, dish_id)
);

-- ---------------------------------------------------------------- cook (one row per time cooked)
create table public.cook (
  id                      uuid primary key default gen_random_uuid(),
  meal_id                 uuid references public.meal(id) on delete set null,
  dish_id                 uuid references public.dish(id) on delete set null,
  cooked_on               date not null,
  rating                  numeric(3,1) check (rating between 0 and 10),
  execution_rating        numeric(3,1) check (execution_rating between 0 and 10),
  repeat                  public.repeat_verdict,
  cook_notes              text,
  deviations              jsonb not null default '[]'::jsonb,
  parameter_confirmations jsonb not null default '[]'::jsonb,  -- [{param, designed, observed, verdict}]
  household_split         text,
  wine_outcome            text,
  created_at              timestamptz not null default now(),
  check (meal_id is not null or dish_id is not null)
);
create index cook_dish_idx on public.cook (dish_id, cooked_on desc);
create index cook_meal_idx on public.cook (meal_id, cooked_on desc);

-- ---------------------------------------------------------------- documents (renders, versioned)
create table public.document (
  id                 uuid primary key default gen_random_uuid(),
  owner_type         public.owner_type not null,
  owner_id           uuid not null,
  kind               public.doc_kind not null,
  version            int not null default 1,
  governance_version text,
  storage_path       text not null,            -- bucket kitchen-docs
  file_name          text not null,
  bytes              bigint,
  generated_at       timestamptz not null default now(),
  is_latest          boolean not null default true,
  unique (owner_type, owner_id, kind, version)
);
create index document_owner_idx on public.document (owner_type, owner_id, is_latest);

-- ---------------------------------------------------------------- shopping
create table public.shopping_list (
  id         uuid primary key default gen_random_uuid(),
  meal_id    uuid references public.meal(id) on delete set null,
  name       text,
  status     public.list_status not null default 'open',
  created_at timestamptz not null default now()
);

create table public.shopping_item (
  id            uuid primary key default gen_random_uuid(),
  list_id       uuid not null references public.shopping_list(id) on delete cascade,
  ingredient_id uuid references public.ingredient(id),
  label         text not null,
  qty_text      text,
  department    text not null,
  attribution   text,                           -- "Coq 42 g · Purée 50 g"
  pantry_check  boolean not null default false,
  order_ahead   boolean not null default false, -- Butcher Box etc.
  checked       boolean not null default false,
  checked_at    timestamptz,
  sort_order    int not null default 0
);
create index shopping_item_list_idx on public.shopping_item (list_id, department, sort_order);

-- ---------------------------------------------------------------- updated_at trigger
create or replace function public.touch_updated_at() returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end $$;
create trigger dish_touch before update on public.dish for each row execute function public.touch_updated_at();
create trigger meal_touch before update on public.meal for each row execute function public.touch_updated_at();

-- ---------------------------------------------------------------- views
create or replace view public.dish_rating_rollup with (security_invoker = true) as
select d.id as dish_id,
       count(c.id)                                   as times_made,
       max(c.cooked_on)                              as last_made,
       (array_agg(c.rating order by c.cooked_on desc))[1]           as latest_rating,
       (array_agg(c.execution_rating order by c.cooked_on desc))[1] as latest_execution,
       (array_agg(c.repeat order by c.cooked_on desc))[1]           as latest_repeat,
       avg(c.rating)                                 as avg_rating
from public.dish d
left join public.cook c on c.dish_id = d.id
group by d.id;

create or replace view public.meal_menu with (security_invoker = true) as
select m.id as meal_id, m.slug, m.name, m.planned_date, m.status, m.wine_pairing,
       jsonb_agg(jsonb_build_object('dish_id', d.id, 'name', d.name, 'role', md.role,
                                    'protein', d.protein, 'order', md.service_order)
                 order by md.service_order) as dishes
from public.meal m
left join public.meal_dish md on md.meal_id = m.id
left join public.dish d on d.id = md.dish_id
group by m.id;

create or replace view public.open_validations with (security_invoker = true) as
select d.id as dish_id, d.name as dish, p->>'param' as param, p->>'designed_value' as designed_value, p->>'note' as note
from public.dish d, jsonb_array_elements(d.designed_unvalidated) p
where not exists (
  select 1 from public.cook c, jsonb_array_elements(c.parameter_confirmations) pc
  where c.dish_id = d.id and pc->>'param' = p->>'param' and pc->>'verdict' = 'confirmed'
);

-- ---------------------------------------------------------------- RLS: anon may read; only service role writes
alter table public.dish            enable row level security;
alter table public.ingredient      enable row level security;
alter table public.dish_ingredient enable row level security;
alter table public.meal            enable row level security;
alter table public.meal_dish       enable row level security;
alter table public.cook            enable row level security;
alter table public.document        enable row level security;
alter table public.shopping_list   enable row level security;
alter table public.shopping_item   enable row level security;

create policy anon_read on public.dish            for select to anon, authenticated using (true);
create policy anon_read on public.ingredient      for select to anon, authenticated using (true);
create policy anon_read on public.dish_ingredient for select to anon, authenticated using (true);
create policy anon_read on public.meal            for select to anon, authenticated using (true);
create policy anon_read on public.meal_dish       for select to anon, authenticated using (true);
create policy anon_read on public.cook            for select to anon, authenticated using (true);
create policy anon_read on public.document        for select to anon, authenticated using (true);
create policy anon_read on public.shopping_list   for select to anon, authenticated using (true);
create policy anon_read on public.shopping_item   for select to anon, authenticated using (true);

comment on schema public is 'jins-kitchen: structured recipe system of record (dedicated project). Writes only via Cowork (service role); PWA reads via anon.';
