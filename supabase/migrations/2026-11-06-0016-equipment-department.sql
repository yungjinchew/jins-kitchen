-- jins-kitchen migration 0016 (2026-11-06): ingredient department Equipment
-- Applied 2026-11-06 by Claude through the SQL editor in Jin's Chrome (paste SHA-256 9d601410…, "Success. No rows returned"); verified through the connector: 7 ingredients in Equipment, kitchen_save_dish accepts it.
--  * Non-food items a recipe names (foil, parchment, a pie tin, pie weights, kitchen twine, a freezer bag, binchotan) are
--    ingredient lines of department Equipment, not Pantry lines with a pantry check (data protocol v1.20 §3.2). The app
--    shows them as their own group on Shop, the dish page, the Sunday before-block and the printed shopping list
--    (jins-kitchen 9109293, print spec 1.5).
--  * kitchen_save_dish accepts Equipment for new_ingredients. Patched in place from its live definition, as in 0014, so
--    nothing else in the function changes.
--  * The seven existing non-food ingredients move from Pantry to Equipment.
-- Asked by Jin 6 Nov 2026 (foil, the pie tin and parchment are not pantry items); approved in chat ("go").

do $mig$
declare d text; n text;
begin
  d := pg_get_functiondef('public.kitchen_save_dish(text,jsonb,text)'::regprocedure);
  if position($a$'Seasoning','Equipment']$a$ in d) > 0 then
    raise notice 'kitchen_save_dish already accepts Equipment';
  else
    n := replace(d, $a$'Alcohol','Seasoning'];$a$, $a$'Alcohol','Seasoning','Equipment'];$a$);
    if n = d then raise exception 'migration 0016: anchor (department list) not found'; end if;
    execute n;
  end if;
end $mig$;

update public.ingredient set department = 'Equipment'
 where department = 'Pantry'
   and name in ('aluminium foil', 'parchment paper', 'pie tin', 'pie weights', 'kitchen twine', 'freezer bag', 'binchotan');
