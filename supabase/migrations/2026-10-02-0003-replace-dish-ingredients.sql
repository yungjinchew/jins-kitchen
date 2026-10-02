-- jins-kitchen · 2026-10-02 · NOT YET APPLIED (apply_migration was cancelled twice on 2 Oct; needs Jin's approval)
-- Atomically replaces one dish's ingredient rows. Fails if the dish or any ingredient name is unknown,
-- so a revision can never silently drop a line. Service role only (no anon / authenticated execute).
create or replace function public.kitchen_replace_dish_ingredients(p_slug text, p_rows jsonb)
returns integer
language plpgsql
security invoker
set search_path = public
as $$
declare
  v_id uuid;
  v_missing text;
  v_n integer;
begin
  select id into v_id from public.dish where slug = p_slug;
  if v_id is null then
    raise exception 'dish % not found', p_slug;
  end if;
  if p_rows is null or jsonb_typeof(p_rows) <> 'array' or jsonb_array_length(p_rows) = 0 then
    raise exception 'p_rows must be a non-empty json array';
  end if;
  select string_agg(r->>'name', ', ') into v_missing
  from jsonb_array_elements(p_rows) r
  where not exists (select 1 from public.ingredient i where i.name = lower(trim(r->>'name')));
  if v_missing is not null then
    raise exception 'unknown ingredient name(s): % — insert them into public.ingredient first', v_missing;
  end if;
  delete from public.dish_ingredient where dish_id = v_id;
  insert into public.dish_ingredient (dish_id, ingredient_id, qty, unit, qty_alt, prep_note, pantry_check, optional, sort_order)
  select v_id, i.id,
         nullif(t.r->>'qty','')::numeric,
         nullif(t.r->>'unit',''),
         nullif(t.r->>'qty_alt',''),
         nullif(t.r->>'prep_note',''),
         coalesce((t.r->>'pantry_check')::boolean, false),
         coalesce((t.r->>'optional')::boolean, false),
         t.ord::int
  from jsonb_array_elements(p_rows) with ordinality as t(r, ord)
  join public.ingredient i on i.name = lower(trim(t.r->>'name'));
  get diagnostics v_n = row_count;
  return v_n;
end;
$$;
revoke all on function public.kitchen_replace_dish_ingredients(text, jsonb) from public, anon, authenticated;
