-- jins-kitchen migration 0014 (2026-11-02): dish versions
--  * dish.base_id: the baseline dish this one is a version of (one level: a baseline is never itself a version, and a
--    dish with versions cannot become one). dish.variant_label: a short name for the version, shown on the app's
--    version switch (a baseline may carry one too, e.g. "Red"). dish.variant_note: one line on what this version
--    changes against its baseline.
--  * kitchen_save_dish accepts base_slug (a dish slug, or null to clear), variant_label and variant_note. The function
--    is patched in place from its live definition, so nothing else in it changes; every change is logged to
--    kitchen_revision as before (base_slug is logged under its column, base_id).
-- Each version keeps its own ingredients, cook log, score and open checks; nothing is averaged across versions
-- (data protocol v1.17 §3.8).

alter table public.dish add column if not exists base_id uuid references public.dish(id) on delete set null;
alter table public.dish add column if not exists variant_label text;
alter table public.dish add column if not exists variant_note text;
do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'dish_base_not_self') then
    alter table public.dish add constraint dish_base_not_self check (base_id is null or base_id <> id);
  end if;
end $$;
create index if not exists dish_base_idx on public.dish (base_id) where base_id is not null;

do $mig$
declare d text; n text; b text;
begin
  d := pg_get_functiondef('public.kitchen_save_dish(text,jsonb,text)'::regprocedure);
  if position('base_slug' in d) > 0 then raise notice 'kitchen_save_dish already accepts base_slug'; return; end if;
  n := d;

  b := n; n := replace(n, $a$'ingredients','new_ingredients'];$a$, $a$'ingredients','new_ingredients','base_slug','variant_label','variant_note'];$a$);
  if n = b then raise exception 'migration 0014: anchor 1 (allowed keys) not found'; end if;

  b := n; n := replace(n, $a$v_n int; v_old_ings jsonb;$a$, $a$v_n int; v_old_ings jsonb; v_base uuid;$a$);
  if n = b then raise exception 'migration 0014: anchor 2 (declarations) not found'; end if;

  b := n; n := replace(n, $a$  UPDATE dish d SET
$a$, $a$  IF p ? 'base_slug' AND jsonb_typeof(p->'base_slug') NOT IN ('string','null') THEN
    RAISE EXCEPTION 'kitchen_save_dish: base_slug must be a dish slug or null'; END IF;
  IF nullif(p->>'base_slug','') IS NOT NULL THEN
    SELECT b.id INTO v_base FROM dish b WHERE b.slug = p->>'base_slug';
    IF v_base IS NULL THEN RAISE EXCEPTION 'kitchen_save_dish: base_slug % is not a dish', p->>'base_slug'; END IF;
    IF v_base = v_id THEN RAISE EXCEPTION 'kitchen_save_dish: a dish cannot be a version of itself'; END IF;
    IF EXISTS (SELECT 1 FROM dish b WHERE b.id = v_base AND b.base_id IS NOT NULL) THEN
      RAISE EXCEPTION 'kitchen_save_dish: % is itself a version; name its baseline instead', p->>'base_slug'; END IF;
    IF EXISTS (SELECT 1 FROM dish x WHERE x.base_id = v_id) THEN
      RAISE EXCEPTION 'kitchen_save_dish: % has versions of its own, so it cannot become a version', p_slug; END IF;
  END IF;

  UPDATE dish d SET
$a$);
  if n = b then raise exception 'migration 0014: anchor 3 (update start) not found'; end if;

  b := n; n := replace(n, $a$    nutrition_estimate = CASE WHEN p ? 'nutrition_estimate' THEN nullif(p->'nutrition_estimate', 'null'::jsonb) ELSE d.nutrition_estimate END,
$a$, $a$    nutrition_estimate = CASE WHEN p ? 'nutrition_estimate' THEN nullif(p->'nutrition_estimate', 'null'::jsonb) ELSE d.nutrition_estimate END,
    base_id            = CASE WHEN p ? 'base_slug' THEN v_base ELSE d.base_id END,
    variant_label      = CASE WHEN p ? 'variant_label' THEN nullif(trim(p->>'variant_label'),'') ELSE d.variant_label END,
    variant_note       = CASE WHEN p ? 'variant_note' THEN nullif(trim(p->>'variant_note'),'') ELSE d.variant_note END,
$a$);
  if n = b then raise exception 'migration 0014: anchor 4 (update columns) not found'; end if;

  b := n; n := replace(n, $a$IF k NOT IN ('ingredients','new_ingredients') AND (v_old->k) IS DISTINCT FROM (v_new->k) THEN$a$,
    $a$IF k NOT IN ('ingredients','new_ingredients') AND (v_old->(CASE WHEN k = 'base_slug' THEN 'base_id' ELSE k END)) IS DISTINCT FROM (v_new->(CASE WHEN k = 'base_slug' THEN 'base_id' ELSE k END)) THEN$a$);
  if n = b then raise exception 'migration 0014: anchor 5 (revision test) not found'; end if;

  b := n; n := replace(n, $a$VALUES (p_source, 'dish', v_id, p_slug, k, v_old->k, v_new->k);$a$,
    $a$VALUES (p_source, 'dish', v_id, p_slug, CASE WHEN k = 'base_slug' THEN 'base_id' ELSE k END, v_old->(CASE WHEN k = 'base_slug' THEN 'base_id' ELSE k END), v_new->(CASE WHEN k = 'base_slug' THEN 'base_id' ELSE k END));$a$);
  if n = b then raise exception 'migration 0014: anchor 6 (revision insert) not found'; end if;

  execute n;
end $mig$;
