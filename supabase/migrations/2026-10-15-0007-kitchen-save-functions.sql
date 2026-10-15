-- jins-kitchen — write path for Claude sessions and the inbox drain (15 Oct 2026)
-- Run ONCE in the Supabase SQL editor (project jins-kitchen / umqkgxsypcgvzkfjkzpc).
-- Why: the Supabase connector cancels any statement that contains UPDATE or DELETE before it
-- can be approved, so recipes cannot be saved from Claude. SELECT calls go through, so saves
-- now go through these three functions, called with SELECT (same pattern as kitchen_review_request).
-- Safety: kitchen tables only; never deletes a dish, meal or cook; leaves fields you do not pass
-- untouched; rejects unknown ingredient names; logs every overwritten value to kitchen_revision
-- (old_value restores it). Not callable with the app's public (anon) key.
-- The editor may warn about "UPDATE without WHERE": a false positive caused by semicolons inside
-- the $fn$ function bodies. Every UPDATE has its WHERE.

begin;

CREATE TABLE IF NOT EXISTS public.kitchen_revision (
  id bigserial PRIMARY KEY,
  at timestamptz NOT NULL DEFAULT now(),
  source text,
  entity text NOT NULL,          -- dish | meal | cook
  entity_id uuid NOT NULL,
  slug text,
  field text NOT NULL,
  old_value jsonb,
  new_value jsonb
);
CREATE INDEX IF NOT EXISTS kitchen_revision_entity_idx ON public.kitchen_revision (entity, entity_id, at DESC);
ALTER TABLE public.kitchen_revision ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.kitchen_revision FROM anon, authenticated;
COMMENT ON TABLE public.kitchen_revision IS 'Append-only log of every value overwritten by kitchen_save_dish / kitchen_save_meal / kitchen_save_cook. old_value restores the previous state.';

-- ---------------------------------------------------------------- dish
CREATE OR REPLACE FUNCTION public.kitchen_save_dish(p_slug text, p jsonb, p_source text DEFAULT NULL)
RETURNS jsonb LANGUAGE plpgsql SET search_path = public AS $fn$
DECLARE
  allowed text[] := ARRAY['name','protein','category','cuisine','difficulty','servings','summary','equipment',
                          'governance_version','source','designed_unvalidated','method_md','status',
                          'ingredients','new_ingredients'];
  units text[] := ARRAY['g','ml','tsp','tbsp','piece','clove','bunch','sprig','slice','cup','pinch'];
  depts text[] := ARRAY['Protein','Produce','Dairy','Bread','Frozen','Pantry','Oils & Liquids','Alcohol','Seasoning'];
  k text; e jsonb;
  v_id uuid; v_old jsonb; v_new jsonb; v_created boolean := false;
  v_changed text[] := '{}'; v_bad text[]; v_n int; v_old_ings jsonb;
BEGIN
  IF p_slug IS NULL OR p_slug !~ '^[a-z0-9]+(-[a-z0-9]+)*$' OR length(p_slug) > 60 THEN
    RAISE EXCEPTION 'kitchen_save_dish: bad slug %', p_slug; END IF;
  IF p IS NULL OR jsonb_typeof(p) <> 'object' THEN RAISE EXCEPTION 'kitchen_save_dish: p must be a JSON object'; END IF;
  FOR k IN SELECT jsonb_object_keys(p) LOOP
    IF NOT k = ANY(allowed) THEN RAISE EXCEPTION 'kitchen_save_dish: field "%" not allowed', k; END IF;
  END LOOP;
  IF p ? 'status' AND p->>'status' NOT IN ('idea','designed','cooked') THEN
    RAISE EXCEPTION 'kitchen_save_dish: status % not allowed here (retire a dish by hand)', p->>'status'; END IF;

  SELECT d.id, to_jsonb(d) INTO v_id, v_old FROM dish d WHERE d.slug = p_slug;
  IF v_id IS NULL THEN
    IF coalesce(p->>'name','') = '' THEN RAISE EXCEPTION 'kitchen_save_dish: new dish % needs a name', p_slug; END IF;
    INSERT INTO dish (slug, name, status)
    VALUES (p_slug, p->>'name', coalesce((p->>'status')::dish_status, 'designed'))
    RETURNING id INTO v_id;
    SELECT to_jsonb(d) INTO v_old FROM dish d WHERE d.id = v_id;
    v_created := true;
  END IF;

  UPDATE dish d SET
    name               = CASE WHEN p ? 'name' THEN p->>'name' ELSE d.name END,
    protein            = CASE WHEN p ? 'protein' THEN nullif(p->>'protein','') ELSE d.protein END,
    category           = CASE WHEN p ? 'category' THEN ARRAY(SELECT jsonb_array_elements_text(p->'category')) ELSE d.category END,
    cuisine            = CASE WHEN p ? 'cuisine' THEN ARRAY(SELECT jsonb_array_elements_text(p->'cuisine')) ELSE d.cuisine END,
    difficulty         = CASE WHEN p ? 'difficulty' THEN p->>'difficulty' ELSE d.difficulty END,
    servings           = CASE WHEN p ? 'servings' THEN (p->>'servings')::numeric ELSE d.servings END,
    summary            = CASE WHEN p ? 'summary' THEN p->>'summary' ELSE d.summary END,
    equipment          = CASE WHEN p ? 'equipment' THEN ARRAY(SELECT jsonb_array_elements_text(p->'equipment')) ELSE d.equipment END,
    governance_version = CASE WHEN p ? 'governance_version' THEN p->>'governance_version' ELSE d.governance_version END,
    source             = CASE WHEN p ? 'source' THEN p->>'source' ELSE d.source END,
    designed_unvalidated = CASE WHEN p ? 'designed_unvalidated' THEN p->'designed_unvalidated' ELSE d.designed_unvalidated END,
    method_md          = CASE WHEN p ? 'method_md' THEN p->>'method_md' ELSE d.method_md END,
    status             = CASE WHEN p ? 'status' AND NOT (d.status = 'cooked' AND p->>'status' IN ('idea','designed'))
                              THEN (p->>'status')::dish_status ELSE d.status END
  WHERE d.id = v_id
  RETURNING to_jsonb(d) INTO v_new;

  FOR k IN SELECT jsonb_object_keys(p) LOOP
    IF k NOT IN ('ingredients','new_ingredients') AND (v_old->k) IS DISTINCT FROM (v_new->k) THEN
      INSERT INTO kitchen_revision (source, entity, entity_id, slug, field, old_value, new_value)
      VALUES (p_source, 'dish', v_id, p_slug, k, v_old->k, v_new->k);
      v_changed := v_changed || k;
    END IF;
  END LOOP;

  IF p ? 'new_ingredients' THEN
    FOR e IN SELECT * FROM jsonb_array_elements(p->'new_ingredients') LOOP
      IF coalesce(e->>'name','') = '' OR e->>'name' <> lower(e->>'name') THEN
        RAISE EXCEPTION 'kitchen_save_dish: new ingredient name must be lower-case and non-empty: %', e->>'name'; END IF;
      IF NOT (e->>'department') = ANY(depts) THEN
        RAISE EXCEPTION 'kitchen_save_dish: department % not allowed for %', e->>'department', e->>'name'; END IF;
      INSERT INTO ingredient (name, department) VALUES (e->>'name', e->>'department') ON CONFLICT (name) DO NOTHING;
    END LOOP;
  END IF;

  IF p ? 'ingredients' THEN
    IF jsonb_typeof(p->'ingredients') <> 'array' OR jsonb_array_length(p->'ingredients') = 0 THEN
      RAISE EXCEPTION 'kitchen_save_dish: ingredients must be a non-empty array'; END IF;
    SELECT array_agg(DISTINCT x->>'name') INTO v_bad FROM jsonb_array_elements(p->'ingredients') x
      WHERE NOT EXISTS (SELECT 1 FROM ingredient i WHERE i.name = x->>'name');
    IF v_bad IS NOT NULL THEN
      RAISE EXCEPTION 'kitchen_save_dish: unknown ingredient name(s) %; reuse a canonical name or pass new_ingredients', v_bad; END IF;
    SELECT array_agg(DISTINCT x->>'unit') INTO v_bad FROM jsonb_array_elements(p->'ingredients') x
      WHERE nullif(x->>'unit','') IS NOT NULL AND NOT (x->>'unit') = ANY(units);
    IF v_bad IS NOT NULL THEN RAISE EXCEPTION 'kitchen_save_dish: unit(s) % not allowed', v_bad; END IF;

    SELECT coalesce(jsonb_agg(jsonb_build_object('name',i.name,'qty',di.qty,'unit',di.unit,'qty_alt',di.qty_alt,
             'buy_spec',di.buy_spec,'buy_avoid',di.buy_avoid,'prep_note',di.prep_note,
             'pantry_check',di.pantry_check,'optional',di.optional) ORDER BY di.sort_order), '[]'::jsonb)
      INTO v_old_ings
      FROM dish_ingredient di JOIN ingredient i ON i.id = di.ingredient_id WHERE di.dish_id = v_id;

    DELETE FROM dish_ingredient WHERE dish_id = v_id;
    INSERT INTO dish_ingredient (dish_id, ingredient_id, qty, unit, qty_alt, buy_spec, buy_avoid, prep_note, pantry_check, optional, sort_order)
    SELECT v_id, i.id, (t.x->>'qty')::numeric, nullif(t.x->>'unit',''), nullif(t.x->>'qty_alt',''), nullif(t.x->>'buy_spec',''),
           nullif(t.x->>'buy_avoid',''), nullif(t.x->>'prep_note',''), coalesce((t.x->>'pantry_check')::boolean, false),
           coalesce((t.x->>'optional')::boolean, false), t.o::int
    FROM jsonb_array_elements(p->'ingredients') WITH ORDINALITY AS t(x, o)
    JOIN ingredient i ON i.name = t.x->>'name';
    GET DIAGNOSTICS v_n = ROW_COUNT;
    IF v_n <> jsonb_array_length(p->'ingredients') THEN
      RAISE EXCEPTION 'kitchen_save_dish: inserted % ingredient rows, expected %', v_n, jsonb_array_length(p->'ingredients'); END IF;
    IF v_old_ings IS DISTINCT FROM p->'ingredients' THEN
      INSERT INTO kitchen_revision (source, entity, entity_id, slug, field, old_value, new_value)
      VALUES (p_source, 'dish', v_id, p_slug, 'ingredients', v_old_ings, p->'ingredients');
      v_changed := v_changed || 'ingredients'::text;
    END IF;
    UPDATE dish SET updated_at = now() WHERE id = v_id;
  END IF;

  RETURN jsonb_build_object('slug', p_slug, 'dish_id', v_id, 'created', v_created,
    'changed', to_jsonb(v_changed),
    'ingredient_rows', (SELECT count(*) FROM dish_ingredient WHERE dish_id = v_id));
END $fn$;

-- ---------------------------------------------------------------- meal
CREATE OR REPLACE FUNCTION public.kitchen_save_meal(p_slug text, p jsonb, p_source text DEFAULT NULL)
RETURNS jsonb LANGUAGE plpgsql SET search_path = public AS $fn$
DECLARE
  allowed text[] := ARRAY['name','planned_date','service_time','status','pax','workflow_md','shared_prep_md','wine_pairing','dishes'];
  k text; e jsonb;
  v_id uuid; v_old jsonb; v_new jsonb; v_created boolean := false; v_changed text[] := '{}';
  v_dish uuid; v_linked int := 0;
BEGIN
  IF p_slug IS NULL OR p_slug !~ '^[a-z0-9]+(-[a-z0-9]+)*$' OR length(p_slug) > 60 THEN
    RAISE EXCEPTION 'kitchen_save_meal: bad slug %', p_slug; END IF;
  IF p IS NULL OR jsonb_typeof(p) <> 'object' THEN RAISE EXCEPTION 'kitchen_save_meal: p must be a JSON object'; END IF;
  FOR k IN SELECT jsonb_object_keys(p) LOOP
    IF NOT k = ANY(allowed) THEN RAISE EXCEPTION 'kitchen_save_meal: field "%" not allowed', k; END IF;
  END LOOP;

  SELECT m.id, to_jsonb(m) INTO v_id, v_old FROM meal m WHERE m.slug = p_slug;
  IF v_id IS NULL THEN
    IF coalesce(p->>'name','') = '' THEN RAISE EXCEPTION 'kitchen_save_meal: new meal % needs a name', p_slug; END IF;
    INSERT INTO meal (slug, name, status, pax)
    VALUES (p_slug, p->>'name',
            coalesce((p->>'status')::meal_status, CASE WHEN p ? 'planned_date' THEN 'planned'::meal_status ELSE 'backlog'::meal_status END),
            coalesce((p->>'pax')::int, 3))
    RETURNING id INTO v_id;
    SELECT to_jsonb(m) INTO v_old FROM meal m WHERE m.id = v_id;
    v_created := true;
  END IF;

  UPDATE meal m SET
    name           = CASE WHEN p ? 'name' THEN p->>'name' ELSE m.name END,
    planned_date   = CASE WHEN p ? 'planned_date' THEN (p->>'planned_date')::date ELSE m.planned_date END,
    service_time   = CASE WHEN p ? 'service_time' THEN (p->>'service_time')::time ELSE m.service_time END,
    status         = CASE WHEN p ? 'status' THEN (p->>'status')::meal_status ELSE m.status END,
    pax            = CASE WHEN p ? 'pax' THEN (p->>'pax')::int ELSE m.pax END,
    workflow_md    = CASE WHEN p ? 'workflow_md' THEN p->>'workflow_md' ELSE m.workflow_md END,
    shared_prep_md = CASE WHEN p ? 'shared_prep_md' THEN p->>'shared_prep_md' ELSE m.shared_prep_md END,
    wine_pairing   = CASE WHEN p ? 'wine_pairing' THEN p->>'wine_pairing' ELSE m.wine_pairing END
  WHERE m.id = v_id
  RETURNING to_jsonb(m) INTO v_new;

  FOR k IN SELECT jsonb_object_keys(p) LOOP
    IF k <> 'dishes' AND (v_old->k) IS DISTINCT FROM (v_new->k) THEN
      INSERT INTO kitchen_revision (source, entity, entity_id, slug, field, old_value, new_value)
      VALUES (p_source, 'meal', v_id, p_slug, k, v_old->k, v_new->k);
      v_changed := v_changed || k;
    END IF;
  END LOOP;

  IF p ? 'dishes' THEN
    FOR e IN SELECT * FROM jsonb_array_elements(p->'dishes') LOOP
      SELECT id INTO v_dish FROM dish WHERE slug = e->>'slug';
      IF v_dish IS NULL THEN RAISE EXCEPTION 'kitchen_save_meal: dish % does not exist (save it first)', e->>'slug'; END IF;
      IF EXISTS (SELECT 1 FROM meal_dish WHERE meal_id = v_id AND dish_id = v_dish) THEN
        UPDATE meal_dish SET role = coalesce((e->>'role')::dish_role, role),
                             service_order = coalesce((e->>'service_order')::int, service_order)
        WHERE meal_id = v_id AND dish_id = v_dish;
      ELSE
        INSERT INTO meal_dish (meal_id, dish_id, role, service_order)
        VALUES (v_id, v_dish, (e->>'role')::dish_role, coalesce((e->>'service_order')::int, 0));
        INSERT INTO kitchen_revision (source, entity, entity_id, slug, field, old_value, new_value)
        VALUES (p_source, 'meal', v_id, p_slug, 'link_dish', NULL, e);
        v_linked := v_linked + 1;
      END IF;
    END LOOP;
  END IF;

  RETURN jsonb_build_object('slug', p_slug, 'meal_id', v_id, 'created', v_created,
    'changed', to_jsonb(v_changed), 'dishes_linked', v_linked,
    'dish_count', (SELECT count(*) FROM meal_dish WHERE meal_id = v_id));
END $fn$;

-- ---------------------------------------------------------------- cook
CREATE OR REPLACE FUNCTION public.kitchen_save_cook(p jsonb, p_source text DEFAULT NULL)
RETURNS jsonb LANGUAGE plpgsql SET search_path = public AS $fn$
DECLARE
  allowed text[] := ARRAY['meal_slug','dish_slug','cooked_on','rating','execution_rating','repeat','cook_notes',
                          'deviations','parameter_confirmations','household_split','wine_outcome',
                          'measurements','measurement_dish_slug','mark_cooked'];
  k text;
  v_meal uuid; v_dish uuid; v_cook uuid; v_mdish uuid; v_old jsonb; v_new jsonb;
  v_created boolean := false; v_meas int := 0; v_changed text[] := '{}'; v_label text;
BEGIN
  IF p IS NULL OR jsonb_typeof(p) <> 'object' THEN RAISE EXCEPTION 'kitchen_save_cook: p must be a JSON object'; END IF;
  FOR k IN SELECT jsonb_object_keys(p) LOOP
    IF NOT k = ANY(allowed) THEN RAISE EXCEPTION 'kitchen_save_cook: field "%" not allowed', k; END IF;
  END LOOP;
  IF (p ? 'meal_slug') = (p ? 'dish_slug') THEN RAISE EXCEPTION 'kitchen_save_cook: pass exactly one of meal_slug or dish_slug'; END IF;
  IF NOT p ? 'cooked_on' THEN RAISE EXCEPTION 'kitchen_save_cook: cooked_on is required'; END IF;

  IF p ? 'meal_slug' THEN
    SELECT id INTO v_meal FROM meal WHERE slug = p->>'meal_slug';
    IF v_meal IS NULL THEN RAISE EXCEPTION 'kitchen_save_cook: meal % not found', p->>'meal_slug'; END IF;
    v_label := p->>'meal_slug';
    SELECT c.id, to_jsonb(c) INTO v_cook, v_old FROM cook c WHERE c.meal_id = v_meal AND c.cooked_on = (p->>'cooked_on')::date LIMIT 1;
  ELSE
    SELECT id INTO v_dish FROM dish WHERE slug = p->>'dish_slug';
    IF v_dish IS NULL THEN RAISE EXCEPTION 'kitchen_save_cook: dish % not found', p->>'dish_slug'; END IF;
    v_label := p->>'dish_slug';
    SELECT c.id, to_jsonb(c) INTO v_cook, v_old FROM cook c WHERE c.dish_id = v_dish AND c.cooked_on = (p->>'cooked_on')::date LIMIT 1;
  END IF;

  IF v_cook IS NULL THEN
    INSERT INTO cook (meal_id, dish_id, cooked_on) VALUES (v_meal, v_dish, (p->>'cooked_on')::date) RETURNING id INTO v_cook;
    SELECT to_jsonb(c) INTO v_old FROM cook c WHERE c.id = v_cook;
    v_created := true;
  END IF;

  -- only non-empty values are written; ratings are never blanked
  UPDATE cook c SET
    rating           = coalesce((p->>'rating')::numeric, c.rating),
    execution_rating = coalesce((p->>'execution_rating')::numeric, c.execution_rating),
    repeat           = coalesce(nullif(p->>'repeat','')::repeat_verdict, c.repeat),
    cook_notes       = coalesce(nullif(p->>'cook_notes',''), c.cook_notes),
    deviations       = CASE WHEN jsonb_typeof(p->'deviations') = 'array' AND jsonb_array_length(p->'deviations') > 0 THEN p->'deviations' ELSE c.deviations END,
    parameter_confirmations = CASE WHEN jsonb_typeof(p->'parameter_confirmations') = 'array' AND jsonb_array_length(p->'parameter_confirmations') > 0 THEN p->'parameter_confirmations' ELSE c.parameter_confirmations END,
    household_split  = coalesce(nullif(p->>'household_split',''), c.household_split),
    wine_outcome     = coalesce(nullif(p->>'wine_outcome',''), c.wine_outcome)
  WHERE c.id = v_cook
  RETURNING to_jsonb(c) INTO v_new;

  FOR k IN SELECT unnest(ARRAY['rating','execution_rating','repeat','cook_notes','deviations','parameter_confirmations','household_split','wine_outcome']) LOOP
    IF (v_old->k) IS DISTINCT FROM (v_new->k) THEN
      INSERT INTO kitchen_revision (source, entity, entity_id, slug, field, old_value, new_value)
      VALUES (p_source, 'cook', v_cook, v_label, k, v_old->k, v_new->k);
      v_changed := v_changed || k;
    END IF;
  END LOOP;

  IF jsonb_typeof(p->'measurements') = 'array' AND jsonb_array_length(p->'measurements') > 0
     AND NOT EXISTS (SELECT 1 FROM measurement WHERE cook_id = v_cook) THEN
    IF p ? 'measurement_dish_slug' THEN
      SELECT id INTO v_mdish FROM dish WHERE slug = p->>'measurement_dish_slug';
    ELSIF v_dish IS NOT NULL THEN
      v_mdish := v_dish;
    ELSE
      SELECT md.dish_id INTO v_mdish FROM meal_dish md WHERE md.meal_id = v_meal ORDER BY (md.role = 'main') DESC, md.service_order LIMIT 1;
    END IF;
    INSERT INTO measurement (dish_id, cook_id, gate, predicted, observed, probe, sort_order)
    SELECT v_mdish, v_cook, t.x->>'gate', nullif(t.x->>'predicted',''), nullif(t.x->>'observed',''), nullif(t.x->>'probe',''), t.o::int
    FROM jsonb_array_elements(p->'measurements') WITH ORDINALITY AS t(x, o);
    GET DIAGNOSTICS v_meas = ROW_COUNT;
  END IF;

  IF coalesce((p->>'mark_cooked')::boolean, false) THEN
    IF v_meal IS NOT NULL THEN
      UPDATE meal SET status = 'cooked', planned_date = (p->>'cooked_on')::date WHERE id = v_meal;
      UPDATE dish SET status = 'cooked' WHERE id IN (SELECT dish_id FROM meal_dish WHERE meal_id = v_meal) AND status <> 'retired';
    ELSE
      UPDATE dish SET status = 'cooked' WHERE id = v_dish AND status <> 'retired';
    END IF;
  END IF;

  RETURN jsonb_build_object('cook_id', v_cook, 'created', v_created, 'changed', to_jsonb(v_changed), 'measurements_inserted', v_meas);
END $fn$;

REVOKE ALL ON FUNCTION public.kitchen_save_dish(text, jsonb, text) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.kitchen_save_meal(text, jsonb, text) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.kitchen_save_cook(jsonb, text) FROM PUBLIC, anon, authenticated;

COMMENT ON FUNCTION public.kitchen_save_dish(text, jsonb, text) IS 'Create or revise a dish. Call with SELECT. Only keys present in p are changed; "ingredients" replaces the full list (validated, count-checked). Every overwrite is logged to kitchen_revision.';
COMMENT ON FUNCTION public.kitchen_save_meal(text, jsonb, text) IS 'Create or revise a meal and link dishes. Call with SELECT. Never unlinks or deletes. Logged to kitchen_revision.';
COMMENT ON FUNCTION public.kitchen_save_cook(jsonb, text) IS 'Upsert a cook by (meal or dish, cooked_on). Non-empty values only; ratings never blanked. Measurements added once. Logged to kitchen_revision.';

commit;

-- Check: should list the three functions and the table.
SELECT proname FROM pg_proc WHERE proname LIKE 'kitchen_save_%'
UNION ALL SELECT 'table: ' || to_regclass('public.kitchen_revision')::text;
