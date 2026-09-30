begin;
update public.meal set shared_prep_md=coalesce(nullif(shared_prep_md,''),$m$**Lemons: 2 total —** zest both (2 tsp: 1 tsp → Salmon, 1 tsp → Barley), then juice one (1 tsp → Broccolini, remainder spare) and cut the second into wedges. Zest before juicing or cutting.

**Flat-leaf parsley: chop 2 tbsp total —** 1 tbsp → Barley, 1 tbsp → Salad

Dill is used on the salmon only and garlic in the salmon only; neither is aggregated. Olive oil appears in all four components but requires no shared prep task — each application differs in treatment and is listed within its own dish.
$m$) where slug=$m$aegean-salmon-dinner$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order) select m.id,d.id,$m$main$m$::dish_role,1 from public.meal m, public.dish d where m.slug=$m$aegean-salmon-dinner$m$ and d.slug=$m$aegean-roasted-salmon$m$ and not exists (select 1 from public.meal_dish x where x.meal_id=m.id and x.dish_id=d.id);
insert into public.meal_dish (meal_id,dish_id,role,service_order) select m.id,d.id,$m$side$m$::dish_role,2 from public.meal m, public.dish d where m.slug=$m$aegean-salmon-dinner$m$ and d.slug=$m$aegean-roasted-broccolini$m$ and not exists (select 1 from public.meal_dish x where x.meal_id=m.id and x.dish_id=d.id);
insert into public.meal_dish (meal_id,dish_id,role,service_order) select m.id,d.id,$m$side$m$::dish_role,3 from public.meal m, public.dish d where m.slug=$m$aegean-salmon-dinner$m$ and d.slug=$m$aegean-pearl-barley$m$ and not exists (select 1 from public.meal_dish x where x.meal_id=m.id and x.dish_id=d.id);
insert into public.meal_dish (meal_id,dish_id,role,service_order) select m.id,d.id,$m$salad$m$::dish_role,4 from public.meal m, public.dish d where m.slug=$m$aegean-salmon-dinner$m$ and d.slug=$m$aegean-cucumber-tomato-salad$m$ and not exists (select 1 from public.meal_dish x where x.meal_id=m.id and x.dish_id=d.id);
insert into public.document (owner_type,owner_id,kind,version,governance_version,storage_path,file_name,bytes,is_latest) values ($m$meal$m$::owner_type,(select id from public.meal where slug=$m$aegean-salmon-dinner$m$),$m$docx$m$::doc_kind,1,null,$m$docs/aegean-salmon-dinner/v1/aegean-salmon-dinner.docx$m$,$m$aegean-salmon-dinner.docx$m$,26269,true);
insert into public.document (owner_type,owner_id,kind,version,governance_version,storage_path,file_name,bytes,is_latest) values ($m$meal$m$::owner_type,(select id from public.meal where slug=$m$aegean-salmon-dinner$m$),$m$pdf$m$::doc_kind,1,null,$m$docs/aegean-salmon-dinner/v1/aegean-salmon-dinner.pdf$m$,$m$aegean-salmon-dinner.pdf$m$,220704,true);
commit;