-- jins-kitchen migration 0010 (2026-10-30): governance v3.11 — shopping detail in the data, "Write down on the day" readings
--  * dish_ingredient.buy_note — the purchase unit when it differs from the recipe unit ("1 lemon" for 1½ tbsp juice)
--  * meal.shopping_notes — buy-by timing, sizing, substitutions, items not on the list (one per line)
--  * kitchen_save_dish: ingredients accept buy_note; designed_unvalidated must be an array, and an item's optional
--    "measure" key must be true or false (measure: true marks a "Write down on the day" reading)
--  * kitchen_save_meal: accepts shopping_notes
--  * designed_unvalidated: null is still accepted and stored as [] (the column default)
--  * kitchen_config.review_brief_fallback refreshed to the review protocol v1.2 brief (used only if GitHub cannot be read)
-- Everything else in both functions is unchanged from migration 0008.

alter table public.dish_ingredient add column if not exists buy_note text;
alter table public.meal add column if not exists shopping_notes text;

insert into public.kitchen_config (key, value, updated_at)
values ('review_brief_fallback', $brief$You are the independent second reviewer of a home-cooking recipe or multi-component menu written for Jin, who lives in Singapore. Household: 3 adults; 2 induction hobs, one Bosch built-in oven, Tiger rice cooker, butane torch; outdoors a 3-burner gas stove and a binchotan grill; conservative salt and sugar; moderate carbohydrates. Where the draft states another location, party or equipment, judge against what the draft states. Review the DRAFT against the governance framework supplied in the input and against sound culinary science and food-safety practice. You are read-only: critique, do not rewrite the recipe.

Report only findings that would change the result on the plate, the safety of the food, or whether the timeline can actually be executed with the stated equipment and one cook. Check arithmetic: quantities, timings, T-minus timelines at both ends of every time band, oven and burner conflicts, holding limits, carryover. Check buying: every ingredient whose result depends on a variety, cut, grade, size or brand must state what to buy, and name what not to buy where the common substitute on the shelf would fail, on the ingredient line and on the shopping-list row itself, not only in the method or a sourcing note. A missing or contradictory buying spec that would lead the shopper to buy the wrong thing is MATERIAL. Check print safety: Critical Control Points, Adjustment Notes, the holding chain and the meal planning sections are not printed, so every safety control (a hold with its temperature and limit, a reheat endpoint, each cooling check with its reheat-or-discard branch, a doneness-safety check) must also appear in a method step or a timeline row. A safety control stated only in an unprinted section is MATERIAL.

Judge safety against the diner profile the draft states. Unless the profile declares a vulnerable diner (pregnant, immunocompromised, elderly or a young child), do not ask for a safer-endpoint alternative or a vulnerable-diner branch: a one-line statement of the trade-off is enough.

Do not raise terminology, formatting, naming or documentation points; under framework Section XIV those are not material. Where a safety control sits is not a documentation point.

If a PRIOR DECISION LOG is supplied, first check that every adopted change, and every branch, fallback or alternative it created, is carried through each place the component appears (ingredient line, shopping row, method, timeline at both ends of every band, holding chain, CCPs, storage), that any safety control it adds appears in a method step or a timeline row, and that it closes in the timeline; report any failure there before other findings. Do not re-raise a point that was declined with a stated reason unless that reason is factually wrong, and if so say exactly why.

If the input is marked CONFIRMATION PASS, check only that the changes adopted after the previous round are implemented and close in the timeline. Raise nothing else unless one of those changes caused it.

Output format, plain text: numbered findings, most important first, at most 8. Each finding: [MATERIAL] or [MINOR] · where (dish / section / step) · the problem and its mechanism · the specific change you propose, with numbers. Then a line starting "What is sound:" with one to three short points. The final line must be exactly "VERDICT: MATERIAL ISSUES" or "VERDICT: NO MATERIAL ISSUES". Use NO MATERIAL ISSUES when every remaining point is minor.$brief$, now())
on conflict (key) do update set value = excluded.value, updated_at = now();

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
             'pantry_check',di.pantry_check,'optional',di.optional) ORDER BY di.sort_order), '[]'::jsonb)
      INTO v_old_ings
      FROM dish_ingredient di JOIN ingredient i ON i.id = di.ingredient_id WHERE di.dish_id = v_id;

    DELETE FROM dish_ingredient WHERE dish_id = v_id;
    INSERT INTO dish_ingredient (dish_id, ingredient_id, qty, unit, qty_alt, buy_spec, buy_avoid, buy_note, prep_note, pantry_check, optional, sort_order)
    SELECT v_id, i.id, (t.x->>'qty')::numeric, nullif(t.x->>'unit',''), nullif(t.x->>'qty_alt',''), nullif(t.x->>'buy_spec',''),
           nullif(t.x->>'buy_avoid',''), nullif(t.x->>'buy_note',''), nullif(t.x->>'prep_note',''), coalesce((t.x->>'pantry_check')::boolean, false),
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
END $function$;

CREATE OR REPLACE FUNCTION public.kitchen_save_meal(p_slug text, p jsonb, p_source text DEFAULT NULL::text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
DECLARE
  allowed text[] := ARRAY['name','planned_date','service_time','status','pax','workflow_md','shared_prep_md','shopping_notes',
                          'wine_pairing','cellar_iwine','dishes'];
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
    shopping_notes = CASE WHEN p ? 'shopping_notes' THEN nullif(p->>'shopping_notes','') ELSE m.shopping_notes END,
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
END $function$;

COMMENT ON FUNCTION public.kitchen_save_dish(text, jsonb, text) IS 'Create or revise a dish: SELECT public.kitchen_save_dish(slug, p, source). Keys of p (only keys present change): name, protein, category[], cuisine[], difficulty, servings, summary, equipment[], tags[], occasion[], nutrition_estimate {kcal, protein_g, carbs_g, fat_g, per}, governance_version, source, designed_unvalidated [{param, designed_value, note, measure}] (measure true = a "Write down on the day" reading), method_md, status (idea|designed|cooked; never back from cooked), ingredients [{name, qty, unit, qty_alt, buy_spec, buy_avoid, buy_note, prep_note, pantry_check, optional}] (replaces the full list; validated, count-checked), new_ingredients [{name, department}]. Every overwrite is logged to kitchen_revision. Cannot retire a dish.';
COMMENT ON FUNCTION public.kitchen_save_meal(text, jsonb, text) IS 'Create or revise a meal: SELECT public.kitchen_save_meal(slug, p, source). Keys of p: name, planned_date, service_time, status (backlog|planned|cooked), pax, workflow_md, shared_prep_md, shopping_notes, wine_pairing, cellar_iwine, dishes [{slug, role, service_order}] (links; never unlinks). Logged to kitchen_revision.';
