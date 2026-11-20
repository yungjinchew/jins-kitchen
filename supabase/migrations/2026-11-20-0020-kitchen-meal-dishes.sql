-- jins-kitchen migration 0020 (2026-11-20): Ask Claude in the app, stage 4 (ASK 1.3): changing which dishes are in a meal
--  * kitchen_meal_unlink(meal, dish, source): takes one dish off a meal. The only way a link is removed. It logs the
--    removed link (role and service order) to kitchen_revision as field 'unlink_dish', touches the meal's updated_at,
--    and refuses to leave a meal with no dishes. The dish itself stays in the Library: dishes are never deleted.
--    Data protocol v1.21 §3.4 (Jin's yes, 20 Nov 2026; until then unlinking was impossible by design).
--  * kitchen_assistant_change_apply(change, mode), extended. A change may now also carry these saves:
--      {entity: 'dish_new', slug, p}                         create a dish (the new-dish keys below; status designed)
--      {entity: 'link',   slug: <meal>, dish, role, service_order}   put a saved dish on the meal (kitchen_save_meal)
--      {entity: 'unlink', slug: <meal>, dish}                take a dish off the meal (kitchen_meal_unlink)
--    and a guard {entity: 'dish_new', slug}: the slug must still be free. These three are material by definition: the
--    function refuses them in a change classed minor, and like every material change they apply only after the review
--    has passed. Undo puts removed dishes back with their old role and order and takes added ones off the meal; a dish
--    the change created stays in the Library, unlinked.
-- Jin's approval: "Approved" to the stage 4 plan, 20 Nov 2026 (Cooking project chat).
-- Everything here is revoked from anon and authenticated.

create or replace function public.kitchen_meal_unlink(p_meal_slug text, p_dish_slug text, p_source text)
returns jsonb language plpgsql set search_path to 'public' as $fn$
declare v_meal uuid; v_dish uuid; v_role text; v_order int; v_left int;
begin
  if coalesce(trim(p_source), '') = '' then raise exception 'kitchen_meal_unlink: give a source line'; end if;
  select id into v_meal from public.meal where slug = p_meal_slug;
  if v_meal is null then raise exception 'kitchen_meal_unlink: meal % does not exist', p_meal_slug; end if;
  select id into v_dish from public.dish where slug = p_dish_slug;
  if v_dish is null then raise exception 'kitchen_meal_unlink: dish % does not exist', p_dish_slug; end if;
  select role::text, service_order into v_role, v_order from public.meal_dish where meal_id = v_meal and dish_id = v_dish;
  if not found then raise exception 'kitchen_meal_unlink: % is not on meal %', p_dish_slug, p_meal_slug; end if;
  select count(*) into v_left from public.meal_dish where meal_id = v_meal and dish_id <> v_dish;
  if v_left = 0 then raise exception 'kitchen_meal_unlink: % is the only dish of %; a meal keeps at least one dish', p_dish_slug, p_meal_slug; end if;
  delete from public.meal_dish where meal_id = v_meal and dish_id = v_dish;
  insert into public.kitchen_revision (source, entity, entity_id, slug, field, old_value, new_value)
  values (p_source, 'meal', v_meal, p_meal_slug, 'unlink_dish',
          jsonb_build_object('slug', p_dish_slug, 'role', v_role, 'service_order', v_order), null);
  update public.meal set updated_at = now() where id = v_meal;
  return jsonb_build_object('slug', p_meal_slug, 'unlinked', p_dish_slug, 'role', v_role, 'service_order', v_order, 'dish_count', v_left);
end $fn$;

create or replace function public.kitchen_assistant_change_apply(p_change uuid, p_mode text)
returns jsonb language plpgsql set search_path to 'public' as $fn$
declare
  dish_keys text[] := array['method_md', 'summary', 'servings', 'equipment', 'nutrition_estimate', 'ingredients', 'new_ingredients'];
  new_dish_keys text[] := array['name', 'protein', 'category', 'cuisine', 'difficulty', 'servings', 'summary', 'equipment',
                                'nutrition_estimate', 'governance_version', 'source', 'method_md', 'status', 'ingredients', 'new_ingredients'];
  meal_keys text[] := array['workflow_md', 'shared_prep_md', 'shopping_notes', 'service_time', 'pax'];
  roles text[] := array['main', 'side', 'sauce', 'dessert', 'soup', 'bread', 'starter', 'salad'];
  c public.assistant_change; s jsonb; g jsonb; k text; r jsonb;
  v_saves jsonb; v_guards jsonb; v_res jsonb := '[]'::jsonb; v_after jsonb := '[]'::jsonb;
  v_at timestamptz; v_src text; v_err text; v_meal uuid; v_dish uuid;
begin
  if p_mode is null or p_mode not in ('check', 'apply', 'undo') then
    raise exception 'kitchen_assistant_change_apply: mode must be check, apply or undo';
  end if;
  select * into c from public.assistant_change where id = p_change for update;
  if not found then return jsonb_build_object('status', 'not_found'); end if;

  if p_mode = 'undo' then
    if c.status <> 'applied' then return jsonb_build_object('status', 'not_applied', 'change_status', c.status); end if;
    v_saves := c.undo; v_guards := c.applied_guards;
  else
    if c.status <> 'proposed' then return jsonb_build_object('status', 'not_open', 'change_status', c.status); end if;
    -- a material change applies only after the review loop has passed with nothing open (ASK 1.2)
    if p_mode = 'apply' and c.class <> 'minor' and coalesce(c.review_status, 'none') <> 'passed' then
      return jsonb_build_object('status', 'needs_review');
    end if;
    v_saves := c.saves; v_guards := c.guards;
  end if;
  if v_saves is null or jsonb_typeof(v_saves) <> 'array' or jsonb_array_length(v_saves) = 0
     or v_guards is null or jsonb_typeof(v_guards) <> 'array' or jsonb_array_length(v_guards) = 0 then
    return jsonb_build_object('status', 'error', 'message', 'the change has nothing to save');
  end if;
  -- adding, creating or removing a dish changes the plate: never in a change classed minor (ASK 1.3)
  if c.class = 'minor' and exists (select 1 from jsonb_array_elements(c.saves) x where x->>'entity' in ('dish_new', 'link', 'unlink')) then
    return jsonb_build_object('status', 'error', 'message', 'adding or removing a dish is a material change');
  end if;

  -- every record the change touches is as it was when the change was worked out; a new dish's slug is still free
  for g in select * from jsonb_array_elements(v_guards) loop
    if g->>'entity' = 'dish_new' then
      if exists (select 1 from public.dish d where d.slug = g->>'slug') then
        if p_mode = 'apply' then
          update public.assistant_change set status = 'stale', note = 'A dish with that name was saved after this was proposed.' where id = c.id;
        end if;
        return jsonb_build_object('status', 'stale', 'entity', 'dish', 'slug', g->>'slug');
      end if;
      continue;
    end if;
    if g->>'entity' = 'dish' then select d.updated_at into v_at from public.dish d where d.slug = g->>'slug';
    else select m.updated_at into v_at from public.meal m where m.slug = g->>'slug'; end if;
    if v_at is null or v_at <> (g->>'updated_at')::timestamptz then
      if p_mode = 'apply' then
        update public.assistant_change set status = 'stale', note = 'The recipe changed after this was proposed.' where id = c.id;
      end if;
      return jsonb_build_object('status', 'stale', 'entity', g->>'entity', 'slug', g->>'slug');
    end if;
  end loop;

  v_src := 'Ask in app ' || to_char(now() at time zone 'Asia/Singapore', 'YYYY-MM-DD')
           || case when p_mode = 'undo' then ' (undo): ' else ': ' end || left(c.summary, 160);
  begin
    for s in select * from jsonb_array_elements(v_saves) loop
      if s->>'entity' in ('dish', 'dish_new', 'meal') and jsonb_typeof(s->'p') <> 'object' then raise exception 'a save has no fields'; end if;
      if s->>'entity' = 'dish' then
        if not exists (select 1 from public.dish d where d.slug = s->>'slug') then raise exception 'dish % does not exist', s->>'slug'; end if;
        for k in select jsonb_object_keys(s->'p') loop
          if not k = any(dish_keys) then raise exception 'field "%" of a dish cannot be changed from the app', k; end if;
        end loop;
        r := public.kitchen_save_dish(s->>'slug', s->'p', v_src);
      elsif s->>'entity' = 'dish_new' then
        if exists (select 1 from public.dish d where d.slug = s->>'slug') then raise exception 'dish % already exists', s->>'slug'; end if;
        for k in select jsonb_object_keys(s->'p') loop
          if not k = any(new_dish_keys) then raise exception 'field "%" cannot be set on a new dish from the app', k; end if;
        end loop;
        if coalesce(s->'p'->>'status', 'designed') <> 'designed' then raise exception 'a dish created from the app starts as designed'; end if;
        r := public.kitchen_save_dish(s->>'slug', s->'p', v_src);
      elsif s->>'entity' = 'link' then
        if not coalesce(s->>'role', '') = any(roles) then raise exception 'role % is not a dish role', s->>'role'; end if;
        select id into v_meal from public.meal where slug = s->>'slug';
        select id into v_dish from public.dish where slug = s->>'dish';
        if v_meal is null or v_dish is null then raise exception 'meal % or dish % does not exist', s->>'slug', s->>'dish'; end if;
        if exists (select 1 from public.meal_dish where meal_id = v_meal and dish_id = v_dish) then
          raise exception 'dish % is already on meal %', s->>'dish', s->>'slug';
        end if;
        r := public.kitchen_save_meal(s->>'slug', jsonb_build_object('dishes', jsonb_build_array(jsonb_build_object(
               'slug', s->>'dish', 'role', s->>'role', 'service_order', coalesce((s->>'service_order')::int, 0)))), v_src);
      elsif s->>'entity' = 'unlink' then
        r := public.kitchen_meal_unlink(s->>'slug', s->>'dish', v_src);
      elsif s->>'entity' = 'meal' then
        if not exists (select 1 from public.meal m where m.slug = s->>'slug') then raise exception 'meal % does not exist', s->>'slug'; end if;
        for k in select jsonb_object_keys(s->'p') loop
          if not k = any(meal_keys) then raise exception 'field "%" of a meal cannot be changed from the app', k; end if;
        end loop;
        r := public.kitchen_save_meal(s->>'slug', s->'p', v_src);
      else
        raise exception 'unknown entity %', s->>'entity';
      end if;
      v_res := v_res || jsonb_build_array(r);
    end loop;
    if p_mode = 'check' then raise exception sqlstate 'KA001' using message = 'check only'; end if;
  exception
    when sqlstate 'KA001' then
      return jsonb_build_object('status', 'ok', 'mode', 'check', 'results', v_res);
    when others then
      get stacked diagnostics v_err = message_text;
      return jsonb_build_object('status', 'error', 'message', v_err);
  end;

  -- what undo will check: every record as it stands now (a dish the change created is now an existing dish)
  select coalesce(jsonb_agg(jsonb_build_object(
           'entity', case when x->>'entity' = 'meal' then 'meal' else 'dish' end, 'slug', x->>'slug', 'updated_at',
           case when x->>'entity' = 'meal' then (select m.updated_at from public.meal m where m.slug = x->>'slug')
                else (select d.updated_at from public.dish d where d.slug = x->>'slug') end)), '[]'::jsonb)
    into v_after from jsonb_array_elements(v_guards) x;

  if p_mode = 'apply' then
    update public.assistant_change set status = 'applied', applied_at = now(), applied_guards = v_after, result = v_res where id = c.id;
    return jsonb_build_object('status', 'applied', 'results', v_res);
  end if;
  update public.assistant_change set status = 'undone', undone_at = now(), result = v_res where id = c.id;
  return jsonb_build_object('status', 'undone', 'results', v_res);
end $fn$;

revoke all on function public.kitchen_meal_unlink(text, text, text) from public, anon, authenticated;
grant execute on function public.kitchen_meal_unlink(text, text, text) to service_role;
revoke all on function public.kitchen_assistant_change_apply(uuid, text) from public, anon, authenticated;
grant execute on function public.kitchen_assistant_change_apply(uuid, text) to service_role;
