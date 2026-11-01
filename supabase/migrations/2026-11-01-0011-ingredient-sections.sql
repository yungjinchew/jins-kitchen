-- jins-kitchen migration 0011 (2026-11-01): ingredient group headings — approved by Jin in session (1 Nov 2026)
--  * dish_ingredient.section — the heading an ingredient line sits under, for a dish built from parts
--    ("Pumpkin spice blend", "Pumpkin syrup", "For each latte"). Lines with the same section are consecutive,
--    in order of use; null means the dish has no groups (every older dish).
--  * kitchen_save_dish: ingredients accept "section"; the ingredients revision snapshot includes it.
-- Everything else in the function is unchanged from migration 0010.
-- Run in the Supabase SQL editor (the connector cancels migrations that contain UPDATE).

alter table public.dish_ingredient add column if not exists section text;
comment on column public.dish_ingredient.section is
  'Ingredient group heading for a dish built from parts (e.g. "Pumpkin syrup"); consecutive lines share it, in order of use; null = no groups.';

CREATE OR REPLACE FUNCTION public.kitchen_save_dish(p_slug text, p jsonb, p_source text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
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
  IF p ? 'designed_unvalidated' THEN
    IF jsonb_typeof(p->'designed_unvalidated') NOT IN ('array','null') THEN
      RAISE EXCEPTION 'kitchen_save_dish: designed_unvalidated must be a JSON array of {param, designed_value, note, measure}'; END IF;
    IF jsonb_typeof(p->'designed_unvalidated') = 'array' AND EXISTS (SELECT 1 FROM jsonb_array_elements(p->'designed_unvalidated') x
               WHERE x ? 'measure' AND jsonb_typeof(x->'measure') <> 'boolean') THEN
      RAISE EXCEPTION 'kitchen_save_dish: designed_unvalidated "measure" must be true or false'; END IF;
  END IF;
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
    designed_unvalidated = CASE WHEN p ? 'designed_unvalidated' THEN coalesce(nullif(p->'designed_unvalidated', 'null'::jsonb), '[]'::jsonb) ELSE d.designed_unvalidated END,
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
             'buy_spec',di.buy_spec,'buy_avoid',di.buy_avoid,'buy_note',di.buy_note,'prep_note',di.prep_note,
             'pantry_check',di.pantry_check,'optional',di.optional,'section',di.section) ORDER BY di.sort_order), '[]'::jsonb)
      INTO v_old_ings
      FROM dish_ingredient di JOIN ingredient i ON i.id = di.ingredient_id WHERE di.dish_id = v_id;

    DELETE FROM dish_ingredient WHERE dish_id = v_id;
    INSERT INTO dish_ingredient (dish_id, ingredient_id, qty, unit, qty_alt, buy_spec, buy_avoid, buy_note, prep_note, pantry_check, optional, section, sort_order)
    SELECT v_id, i.id, (t.x->>'qty')::numeric, nullif(t.x->>'unit',''), nullif(t.x->>'qty_alt',''), nullif(t.x->>'buy_spec',''),
           nullif(t.x->>'buy_avoid',''), nullif(t.x->>'buy_note',''), nullif(t.x->>'prep_note',''), coalesce((t.x->>'pantry_check')::boolean, false),
           coalesce((t.x->>'optional')::boolean, false), nullif(trim(t.x->>'section'),''), t.o::int
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
END $function$;

REVOKE ALL ON FUNCTION public.kitchen_save_dish(text, jsonb, text) FROM PUBLIC, anon, authenticated;
