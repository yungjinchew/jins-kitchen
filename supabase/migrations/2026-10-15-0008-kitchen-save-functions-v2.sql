-- jins-kitchen — save functions, update 2 (15 Oct 2026)
-- Run ONCE in the Supabase SQL editor (project jins-kitchen / umqkgxsypcgvzkfjkzpc), the same way as
-- 2026-10-15-kitchen-save-functions.sql. That file must already be installed (it is).
-- What this adds — the fields the first version could not save, so no session ever needs a plain UPDATE:
--   kitchen_save_dish      + tags, occasion, nutrition_estimate
--   kitchen_save_meal      + cellar_iwine
--   kitchen_save_document  NEW: registers a stored docx/pdf (next version, clears the old is_latest)
-- Unchanged: kitchen_save_cook; every existing key and behaviour. Still not possible from a session, by design:
-- retiring a dish, unlinking a dish from a meal, deleting anything.
-- Safety as before: kitchen tables only, every overwrite logged to kitchen_revision, not callable with the
-- app's public (anon) key. The editor may warn about "UPDATE without WHERE": a false positive caused by
-- semicolons inside the $fn$ bodies. Every UPDATE has its WHERE.

begin;

-- ---------------------------------------------------------------- dish
CREATE OR REPLACE FUNCTION public.kitchen_save_dish(p_slug text, p jsonb, p_source text DEFAULT NULL)
RETURNS jsonb LANGUAGE plpgsql SET search_path = public AS $fn$
DECLARE
  allowed text[] := ARRAY['name','protein','category','cuisine','difficulty','servings','summary','equipment',
                          'governance_version','source','designed_unvalidated','method_md','status',
                          'tags','occasion','nutrition_estimate',
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
  IF p ? 'nutrition_estimate' AND jsonb_typeof(p->'nutrition_estimate') NOT IN ('object','null') THEN
    RAISE EXCEPTION 'kitchen_save_dish: nutrition_estimate must be a JSON object {kcal, protein_g, carbs_g, fat_g, per}'; END IF;
  FOR k IN SELECT unnest(ARRAY['category','cuisine','equipment','tags','occasion']) LOOP
    IF p ? k AND jsonb_typeof(p->k) <> 'array' THEN RAISE EXCEPTION 'kitchen_save_dish: % must be a JSON array', k; END IF;
  END LOOP;

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
    tags               = CASE WHEN p ? 'tags' THEN ARRAY(SELECT jsonb_array_elements_text(p->'tags')) ELSE d.tags END,
    occasion           = CASE WHEN p ? 'occasion' THEN ARRAY(SELECT jsonb_array_elements_text(p->'occasion')) ELSE d.occasion END,
    nutrition_estimate = CASE WHEN p ? 'nutrition_estimate' THEN nullif(p->'nutrition_estimate', 'null'::jsonb) ELSE d.nutrition_estimate END,
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
  allowed text[] := ARRAY['name','planned_date','service_time','status','pax','workflow_md','shared_prep_md','wine_pairing',
                          'cellar_iwine','dishes'];
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
    wine_pairing   = CASE WHEN p ? 'wine_pairing' THEN p->>'wine_pairing' ELSE m.wine_pairing END,
    cellar_iwine   = CASE WHEN p ? 'cellar_iwine' THEN nullif(p->>'cellar_iwine','') ELSE m.cellar_iwine END
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

-- ---------------------------------------------------------------- document (new)
CREATE OR REPLACE FUNCTION public.kitchen_save_document(p jsonb, p_source text DEFAULT NULL)
RETURNS jsonb LANGUAGE plpgsql SET search_path = public AS $fn$
DECLARE
  allowed text[] := ARRAY['owner_type','owner_slug','kind','governance_version','storage_path','file_name','bytes'];
  k text;
  v_owner uuid; v_ver int; v_id uuid; v_cleared int := 0; v_path text;
BEGIN
  IF p IS NULL OR jsonb_typeof(p) <> 'object' THEN RAISE EXCEPTION 'kitchen_save_document: p must be a JSON object'; END IF;
  FOR k IN SELECT jsonb_object_keys(p) LOOP
    IF NOT k = ANY(allowed) THEN RAISE EXCEPTION 'kitchen_save_document: field "%" not allowed', k; END IF;
  END LOOP;
  IF coalesce(p->>'owner_type','') NOT IN ('meal','dish') THEN
    RAISE EXCEPTION 'kitchen_save_document: owner_type must be meal or dish'; END IF;
  IF coalesce(p->>'kind','') NOT IN ('docx','pdf','html','md') THEN
    RAISE EXCEPTION 'kitchen_save_document: kind must be docx, pdf, html or md'; END IF;
  IF coalesce(p->>'file_name','') = '' OR position('/' in p->>'file_name') > 0 THEN
    RAISE EXCEPTION 'kitchen_save_document: file_name must be a bare file name'; END IF;

  IF p->>'owner_type' = 'meal' THEN
    SELECT id INTO v_owner FROM meal WHERE slug = p->>'owner_slug';
  ELSE
    SELECT id INTO v_owner FROM dish WHERE slug = p->>'owner_slug';
  END IF;
  IF v_owner IS NULL THEN RAISE EXCEPTION 'kitchen_save_document: % % not found', p->>'owner_type', p->>'owner_slug'; END IF;

  -- next version for this owner and kind; the files must already sit in that version's folder
  SELECT coalesce(max(version), 0) + 1 INTO v_ver FROM document
    WHERE owner_type = (p->>'owner_type')::owner_type AND owner_id = v_owner AND kind = (p->>'kind')::doc_kind;
  v_path := 'docs/' || (p->>'owner_slug') || '/v' || v_ver || '/' || (p->>'file_name');
  IF (p->>'storage_path') IS DISTINCT FROM v_path THEN
    RAISE EXCEPTION 'kitchen_save_document: storage_path must be % (next version is v%)', v_path, v_ver; END IF;

  UPDATE document SET is_latest = false
    WHERE owner_type = (p->>'owner_type')::owner_type AND owner_id = v_owner AND kind = (p->>'kind')::doc_kind AND is_latest;
  GET DIAGNOSTICS v_cleared = ROW_COUNT;

  INSERT INTO document (owner_type, owner_id, kind, version, governance_version, storage_path, file_name, bytes, generated_at, is_latest)
  VALUES ((p->>'owner_type')::owner_type, v_owner, (p->>'kind')::doc_kind, v_ver, nullif(p->>'governance_version',''),
          v_path, p->>'file_name', (p->>'bytes')::bigint, now(), true)
  RETURNING id INTO v_id;

  INSERT INTO kitchen_revision (source, entity, entity_id, slug, field, old_value, new_value)
  VALUES (p_source, 'document', v_id, p->>'owner_slug', 'register', NULL, p || jsonb_build_object('version', v_ver));

  RETURN jsonb_build_object('document_id', v_id, 'owner_slug', p->>'owner_slug', 'kind', p->>'kind', 'version', v_ver,
    'storage_path', v_path, 'previous_latest_cleared', v_cleared);
END $fn$;

REVOKE ALL ON FUNCTION public.kitchen_save_dish(text, jsonb, text) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.kitchen_save_meal(text, jsonb, text) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.kitchen_save_document(jsonb, text) FROM PUBLIC, anon, authenticated;

COMMENT ON TABLE public.kitchen_revision IS 'Append-only log of every value overwritten by kitchen_save_dish / kitchen_save_meal / kitchen_save_cook, and every document registered by kitchen_save_document. old_value restores the previous state.';
COMMENT ON FUNCTION public.kitchen_save_dish(text, jsonb, text) IS 'Create or revise a dish: SELECT public.kitchen_save_dish(slug, p, source). Keys of p (only keys present change): name, protein, category[], cuisine[], difficulty, servings, summary, equipment[], tags[], occasion[], nutrition_estimate {kcal, protein_g, carbs_g, fat_g, per}, governance_version, source, designed_unvalidated [{param, designed_value, note}], method_md, status (idea|designed|cooked; never back from cooked), ingredients [{name, qty, unit, qty_alt, buy_spec, buy_avoid, prep_note, pantry_check, optional}] (replaces the full list; validated, count-checked), new_ingredients [{name, department}]. Every overwrite is logged to kitchen_revision. Cannot retire a dish.';
COMMENT ON FUNCTION public.kitchen_save_meal(text, jsonb, text) IS 'Create or revise a meal: SELECT public.kitchen_save_meal(slug, p, source). Keys of p: name, planned_date, service_time, status (backlog|planned|cooked), pax, workflow_md, shared_prep_md, wine_pairing, cellar_iwine, dishes [{slug, role, service_order}] (links; never unlinks). Logged to kitchen_revision.';
COMMENT ON FUNCTION public.kitchen_save_cook(jsonb, text) IS 'Upsert a cook by (meal or dish, cooked_on): SELECT public.kitchen_save_cook(p, source). Keys of p: meal_slug or dish_slug, cooked_on, rating, execution_rating, repeat, cook_notes, deviations [], parameter_confirmations [{param, designed, observed, verdict}], household_split, wine_outcome, measurements [{gate, predicted, observed, probe}], measurement_dish_slug, mark_cooked. Non-empty values only; ratings never blanked. Measurements added once. Logged to kitchen_revision.';
COMMENT ON FUNCTION public.kitchen_save_document(jsonb, text) IS 'Register a stored document: SELECT public.kitchen_save_document(p, source). Keys of p: owner_type (meal|dish), owner_slug, kind (docx|pdf|html|md), storage_path (must be docs/<owner_slug>/v<next version>/<file_name>), file_name, bytes, governance_version. Sets the new row is_latest and clears the previous one. Logged to kitchen_revision.';

commit;

-- Check: four functions; dish lists tags, meal lists cellar_iwine.
SELECT proname, position('nutrition_estimate' in prosrc) > 0 AS has_new_dish_keys, position('cellar_iwine' in prosrc) > 0 AS has_cellar_iwine
FROM pg_proc WHERE proname LIKE 'kitchen_save_%' ORDER BY 1;
