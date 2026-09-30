-- jins-kitchen · 2026-09-30 · ingredient canonicalisation
-- Each merge: repoint dish_ingredient rows from the variant to the canonical name, carry any lost qualifier into prep_note, delete the variant.
begin;
create temp table merge_map(variant text, canonical text, note text) on commit drop;
insert into merge_map values
 ('chili flake','chilli flakes',null),
 ('chilli flake','chilli flakes',null),
 ('extra virgin olive oil','extra-virgin olive oil',null),
 ('kosher salt, diamond crystal','diamond crystal kosher salt',null),
 ('flaky sea salt','flaky salt',null),
 ('fine salt','fine sea salt',null),
 ('dill, fresh','dill',null),
 ('fresh dill','dill',null),
 ('fresh parsley','flat-leaf parsley',null),
 ('italian parsley','flat-leaf parsley',null),
 ('parsley, flat-leaf','flat-leaf parsley',null),
 ('parsley','flat-leaf parsley',null),
 ('fresh lemon juice','lemon juice',null),
 ('lemon juice, fresh','lemon juice',null),
 ('rice wine vinegar','rice vinegar',null),
 ('greek yogurt, full-fat','greek yogurt','full-fat'),
 ('parmesan','parmigiano-reggiano',null),
 ('celery rib','celery stalk',null),
 ('chicken broth','chicken stock',null),
 ('brown onion','yellow onion',null),
 ('dry white wine (sauvignon blanc)','dry white wine','sauvignon blanc');

-- ensure canonical rows exist (all do today; guard anyway)
insert into public.ingredient(name, department)
select distinct m.canonical, i.department from merge_map m join public.ingredient i on i.name=m.variant
where not exists (select 1 from public.ingredient c where c.name=m.canonical);

update public.dish_ingredient di
set ingredient_id = c.id,
    prep_note = case when m.note is null then di.prep_note
                     when di.prep_note is null or di.prep_note='' then m.note
                     else di.prep_note || ', ' || m.note end
from merge_map m
join public.ingredient v on v.name=m.variant
join public.ingredient c on c.name=m.canonical
where di.ingredient_id = v.id;

delete from public.ingredient i using merge_map m where i.name=m.variant;

-- plain renames (no collision)
update public.ingredient set name='cilantro' where name='cilantro, fresh';
update public.ingredient set name='ginger'   where name='ginger, fresh';
update public.ingredient set name='sage'     where name='sage, fresh';

-- department corrections
update public.ingredient set department='Alcohol' where name in ('red wine, pinot noir / burgundy style','brandy / cognac');
update public.ingredient set department='Pantry'  where name in ('hot water');

-- pantry defaults: staples the shopping list should collapse by default
update public.ingredient set pantry_default=true where name in
 ('black pepper','diamond crystal kosher salt','kosher salt','fine sea salt','flaky salt','salt','white pepper',
  'olive oil','extra-virgin olive oil','neutral oil','all-purpose flour','flour','sugar','granulated sugar','caster sugar',
  'baking powder','cornstarch','dijon mustard','soy sauce','worcestershire sauce','honey','vanilla extract','tomato paste',
  'red wine vinegar','sherry vinegar','rice vinegar','vinegar','water','hot water','garlic powder','onion powder',
  'dried oregano','dried thyme','ground cumin','ground coriander','smoked paprika','sweet paprika','paprika','cayenne','nutmeg','ground nutmeg','bay leaf','chilli flakes');
commit;
select (select count(*) from public.ingredient) ingredients, (select count(*) from public.dish_ingredient) dish_ingredients,
       (select count(*) from public.ingredient where pantry_default) pantry_defaults;
