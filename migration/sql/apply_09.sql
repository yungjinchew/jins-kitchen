begin;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$short-ribs-dinner$m$,$m$Red Wine Braised Short Ribs Dinner$m$,$m$2026-02-01$m$,$m$cooked$m$::meal_status,3,null,null,null,$m$301e0391ce6380dfb7e8e8f4ef9fdeb1$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$short-ribs-red-wine-braised$m$,$m$Red Wine Braised Short Ribs$m$,$m$Beef$m$,array[$m$Main$m$]::text[],array[$m$French$m$]::text[],$m$Medium$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,null,null,$m$Dry-brined bone-in short ribs seared and braised in red wine and beef stock on a mirepoix base, finished with a glossy butter-mounted sauce.$m$,$m$**🥩 Red Wine Braised Short Ribs**
**Ingredients**<br>☐ 1.2–1.4 kg bone-in short ribs<br>☐ Kosher salt<br>☐ Black pepper<br>☐ 1 tbsp neutral oil (if needed)
*Aromatics*<br>☐ 1 large onion, diced<br>☐ 1 medium carrot, diced<br>☐ 2 celery stalks, diced<br>☐ 5 garlic cloves, smashed
*Umami Base*<br>☐ 2 tbsp tomato paste<br>☐ 2 anchovy fillets (optional)
*Liquids*<br>☐ 750 ml dry red wine<br>☐ 500 ml beef stock
*Herbs*<br>☐ 2 sprigs thyme<br>☐ 1 bay leaf<br>☐ 1 tsp black peppercorns
*Finish*<br>☐ 1 tbsp cold unsalted butter<br>☐ 1 tsp sherry or red wine vinegar
**Method**
*Dry Brine (Ahead)*<br>☐ Salt ribs lightly (≈1 tsp per kg)<br>☐ Refrigerate uncovered 8–24 hrs
*Sear*<br>☐ Preheat oven to 160°C / 320°F<br>☐ Pat ribs dry<br>☐ Sear deeply on all sides over medium-high heat<br>☐ Remove ribs
*Build Base*<br>☐ Reduce heat to medium<br>☐ Cook onion, carrot, and celery 6–8 min<br>☐ Add garlic and anchovy (1 min)<br>☐ Stir in tomato paste until brick red
*Deglaze & Braise*<br>☐ Add wine and scrape fond<br>☐ Simmer 5–7 min<br>☐ Add stock and herbs<br>☐ Return ribs (liquid ⅔ up sides)<br>☐ Cover and braise 2½–3 hrs
*Finish Sauce*<br>☐ Remove ribs<br>☐ Strain liquid<br>☐ Reduce until glossy<br>☐ Whisk in butter<br>☐ Add vinegar<br>☐ Adjust salt<br>☐ Return ribs to sauce and hold warm$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$301e0391ce6380dfb7e8e8f4ef9fdeb1$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1200, $m$g$m$, $m$1.2–1.4 kg$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$short rib, bone-in$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$if needed$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$neutral oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$large, diced$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$medium, diced$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$carrot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$diced$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$celery stalk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 5, $m$clove$m$, null, $m$smashed$m$, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$tomato paste$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, null, false, true, 10
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$anchovy fillet$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 750, $m$ml$m$, null, null, false, false, 11
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$dry red wine$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 500, $m$ml$m$, null, null, false, false, 12
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$beef stock$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$sprig$m$, null, null, false, false, 13
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$thyme$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, null, false, false, 14
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$bay leaf$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 15
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$black peppercorn$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$cold$m$, false, false, 16
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$unsalted butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 17
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-red-wine-braised$m$ and i.name=$m$sherry or red wine vinegar$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$short-ribs-soft-polenta$m$,$m$Soft Polenta$m$,null,array[$m$Side$m$]::text[],array[$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,null,null,$m$Slow-cooked soft polenta enriched with butter and grated Parmigiano-Reggiano.$m$,$m$**🌽 Soft Polenta**
**Ingredients**<br>☐ 1 cup (170 g) polenta<br>☐ 5 cups (1.2 L) water or light stock<br>☐ 1¼ tsp fine sea salt<br>☐ 3 tbsp butter<br>☐ ½ cup grated Parmigiano-Reggiano
**Method**<br>☐ Bring liquid and salt to simmer<br>☐ Whisk in polenta slowly<br>☐ Cook on low 30–35 min, stirring often<br>☐ Stir in butter and cheese<br>☐ Loosen with hot water if needed$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$301e0391ce6380dfb7e8e8f4ef9fdeb1$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 170, $m$g$m$, $m$1 cup$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-soft-polenta$m$ and i.name=$m$polenta$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1200, $m$ml$m$, $m$5 cups$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-soft-polenta$m$ and i.name=$m$water or light stock$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.25, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-soft-polenta$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-soft-polenta$m$ and i.name=$m$butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$cup$m$, null, $m$grated$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-soft-polenta$m$ and i.name=$m$parmigiano-reggiano$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$short-ribs-french-glazed-carrots$m$,$m$French Glazed Carrots$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,null,null,$m$Carrot batons cooked covered in butter, water and sugar, then reduced to a glaze.$m$,$m$**🥕 French Glazed Carrots**
**Ingredients**<br>☐ 400 g carrots, cut into batons<br>☐ 20 g butter<br>☐ 120 ml water<br>☐ 1½ tsp sugar<br>☐ ½ tsp kosher salt
**Method**<br>☐ Combine all in sauté pan<br>☐ Bring to boil, then cover<br>☐ Cook 6–8 min until tender<br>☐ Remove lid and reduce to glaze$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$301e0391ce6380dfb7e8e8f4ef9fdeb1$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 400, $m$g$m$, null, $m$cut into batons$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-french-glazed-carrots$m$ and i.name=$m$carrot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 20, $m$g$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-french-glazed-carrots$m$ and i.name=$m$butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 120, $m$ml$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-french-glazed-carrots$m$ and i.name=$m$water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-french-glazed-carrots$m$ and i.name=$m$sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-french-glazed-carrots$m$ and i.name=$m$kosher salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$short-ribs-parsley-lemon-gremolata$m$,$m$Parsley–Lemon Gremolata$m$,null,array[$m$Sauce$m$]::text[],array[$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,null,null,$m$Parsley, lemon zest and grated garlic gremolata mixed just before serving.$m$,$m$**🌿 Parsley–Lemon Gremolata**
**Ingredients**<br>☐ 2 tbsp finely chopped parsley<br>☐ ½ tsp lemon zest<br>☐ ¼ small garlic clove, grated<br>☐ ½ tsp olive oil<br>☐ Pinch salt
☐ Mix just before serving$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$301e0391ce6380dfb7e8e8f4ef9fdeb1$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$finely chopped$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-parsley-lemon-gremolata$m$ and i.name=$m$parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-parsley-lemon-gremolata$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$clove$m$, $m$¼ small clove$m$, $m$small, grated$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-parsley-lemon-gremolata$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-parsley-lemon-gremolata$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-parsley-lemon-gremolata$m$ and i.name=$m$salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$short-ribs-arugula-salad$m$,$m$Arugula Salad$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],array[$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,null,null,$m$Arugula tossed with olive oil, lemon juice or sherry vinegar and salt just before plating.$m$,$m$**🥗 Arugula Salad**
**Ingredients**<br>☐ 2 handfuls arugula<br>☐ 1 tbsp olive oil<br>☐ 1 tsp lemon juice or sherry vinegar<br>☐ Pinch salt
☐ Toss just before plating$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$301e0391ce6380dfb7e8e8f4ef9fdeb1$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, null, $m$2 handfuls$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-arugula-salad$m$ and i.name=$m$arugula$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-arugula-salad$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-arugula-salad$m$ and i.name=$m$lemon juice or sherry vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$short-ribs-arugula-salad$m$ and i.name=$m$salt$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$short-ribs-dinner$m$ and d.slug=$m$short-ribs-red-wine-braised$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$short-ribs-dinner$m$ and d.slug=$m$short-ribs-soft-polenta$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$short-ribs-dinner$m$ and d.slug=$m$short-ribs-french-glazed-carrots$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$short-ribs-dinner$m$ and d.slug=$m$short-ribs-parsley-lemon-gremolata$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 5 from public.meal m, public.dish d where m.slug=$m$short-ribs-dinner$m$ and d.slug=$m$short-ribs-arugula-salad$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-02-01$m$::date, 9.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$short-ribs-dinner$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$dry-aged-pork-tomahawk$m$,$m$Reverse-Seared Dry-Aged Pork Tomahawk$m$,$m$Pork$m$,array[$m$Main$m$]::text[],array[$m$French$m$]::text[],$m$Special$m$,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Governance Framework v3.5 — docx 2026-09-27-dry-aged-pork-tomahawk-dinner-final, plus in-chat revisions. Butcher Box Singapore, 30–40 day dry-aged Gooralie pork tomahawk.$m$,$m$v3.5$m$,$m$Reverse-seared 30–40 day dry-aged Gooralie pork tomahawk, split into loin and belly, low-roasted at 225°F/107°C and seared in cast iron, served with cider–shallot jus, potato–celeriac purée, fennel–Granny Smith salad and hispi cabbage.$m$,null,3,array[$m$Bosch oven$m$,$m$rack over tray$m$,$m$leave-in probe$m$,$m$cast iron$m$,$m$outdoor gas$m$,$m$binchotan$m$,$m$broiler$m$,$m$Tiger Keep Warm$m$,$m$TempSpike Plus$m$]::text[],$m$[{"param": "Sear gain (pork)", "designed_value": "not measured", "note": "Still untested — not measured this cook; readings #3 and #4 not reported."}, {"param": "Post-sear carryover (pork)", "designed_value": "not measured", "note": "Still untested — not measured this cook."}, {"param": "Plate temperature (pork)", "designed_value": "not measured", "note": "Still untested — not measured this cook."}, {"param": "Thin loin (≤4 cm) sear straight from oven", "designed_value": "Stop at about 138–140°F; verify ≥145°F/63°C after the rest", "note": "Next-time item, designed."}, {"param": "Belly crackling in the oven", "designed_value": "High heat, rind-up, after the loin exits", "note": "Next-time item, designed."}, {"param": "Hispi in cast iron", "designed_value": "Char the cut faces in cast iron, then add stock and butter, cover to steam the core and baste", "note": "Designed, untested."}]$m$::jsonb,null,$m$3e8e0391ce6381bda0aac8b72a48748f$m$);
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-09-27$m$::date, 8, 7.5, $m$no$m$::repeat_verdict, $m$First cook. Two 3.5 cm dry-aged tomahawks with the belly split off and cooked separately; loins pulled at 130°F/54°C after 60 and 67 min at 225°F/107°C, lost 8–14°F over an 8-min pre-sear rest, then overshot during a sear run without a leave-in probe and finished more well-done than intended. Jus, potato–celeriac purée and fennel–Granny Smith salad performed well; belly rind burnt in cast iron, and hispi on binchotan was too slow and was finished under the broiler. Not repeating the cut: yield is belly-heavy and belly is readily available — buy loin instead.

## Cook record — 2026-09-27
**Recipe version:** Governance Framework v3.5, docx `2026-09-27-dry-aged-pork-tomahawk-dinner-final`, with two later in-chat revisions: loin sear moved to cast iron on outdoor gas; hispi moved to the binchotan.
**Ratings:** Meal 8 · Execution 7.5 · Repeat: No (cut — see Next time)
### What was actually cooked
Butcher Box Singapore, 30–40 day dry-aged pork tomahawks, 700 g + 730 g, received frozen and thawed. Loin eye 3.5 cm. Rind present and pre-scored by the butcher, running over both the belly and the loin fat cap.
Split the day before: loins with rib bone, rind removed leaving \~5 mm fat (702 g, salted 5.6 g, \~3 hr same-day, uncovered); belly in \~8 cm pieces plus loin-rind strips (631 g, salted 5 g, overnight, rind-up, uncovered).
Served to 3. Menu: loin, belly, loin-rind crackling, cider–shallot jus (Thatchers Gold, medium dry), potato–celeriac purée, shaved fennel–Granny Smith salad, hispi cabbage.
### Material deviations from the written plan
<table header-row="true">
<tr>
<td>Deviation</td>
<td>Detail</td>
</tr>
<tr>
<td>Purée</td>
<td>Celeriac found; potato–celeriac version made instead of the all-potato fallback.</td>
</tr>
<tr>
<td>Hispi</td>
<td>Binchotan start abandoned as too slow and required too much movement between stations; finished under the broiler.</td>
</tr>
<tr>
<td>Loin sear</td>
<td>No leave-in probe at the fire; sear stop was not temperature-guided. Readings #3 and #4 not reported.</td>
</tr>
<tr>
<td>Pre-sear rest</td>
<td>Second loin rested on the rack still over the hot tray.</td>
</tr>
</table>
### Designed-parameter confirmation
**Configuration:** 3.5 cm bone-in dry-aged loin, rind removed (\~5 mm fat), two pieces, fridge-cold, rack over tray, Bosch oven at 225°F/107°C, leave-in probe in the loin eye.
**Confirmed for this configuration:**
- **Low-roast duration to 130°F/54°C: 60 and 67 min** against a designed 40–70 min band.
- **Loin-rind crackling rendered in cast iron:** crisp and well received.
- **Cider–shallot jus with a medium-dry cider:** complemented the pork.
- **Potato–celeriac purée:** very well received. **Tiger Keep Warm hold of approx. 60 min confirmed** — held without texture loss (65:35 potato–celeriac, recipe quantity).
**Failed or revised:**
- **Pre-sear rest, 8 min uncovered:** designed as a rise (+15 to +20°F total). Observed **−14°F and −8°F** (115.9°F and 122°F at E+8). A 3.5 cm loin out of a 225°F oven carries too little surface heat to drive carryover and cools on the rack; the piece left over the hot tray cooled less. The 8-min rest validated on the 7 cm rack chop does not transfer to thin loin.
- **Reading-#2 sear gate:** both readings fell in the lowest branch (normal sear with fat-edge stand), which produced an overshoot. The thresholds assumed the rest would raise temperature; they are not valid for thin cuts.
- **Belly rind crisped rind-down in cast iron, 12–18 min:** rind burnt. The belly meat itself cooked well.
- **Hispi on binchotan:** too slow for service. Broiler finish gave char and crispness, but the dish was judged incomplete in flavour.
**Still untested — not measured this cook:** sear gain, post-sear carryover and plate temperature for pork.
### Household verdict
The loin was the attraction. The belly was well cooked but read as ordinary: it filled the plate without adding anything the loin did not.
### Wine pairing outcome
**2022 Domaine du Vieux Télégraphe “Télégramme” Châteauneuf-du-Pape — worked well.** Vintage and cuvée matched from the live cellar export (snapshot 2026-09-27), the only Vieux Télégraphe bottle listed. Second Grenache-led Châteauneuf to work with reverse-seared pork, after the 2021 Mont-Redon on 30 Aug.
### Next time
1. **Buy loin, not the tomahawk** — a bone-in rack or thick loin chops. The tomahawk's yield is mostly belly, which is available separately.
2. **Thin loin (≤4 cm): no pre-sear rest.** Pat dry and sear straight from the oven with the TempSpike Plus in through the sear, exposed end angled away from the pan surface. Stop at about 138–140°F and verify ≥145°F/63°C after the rest (designed).
3. **Belly crackling in the oven, not the pan:** high heat, rind-up, after the loin exits (designed).
4. **Hispi: char the cut faces in cast iron, then add stock and butter, cover to steam the core and baste** (designed, untested).
5. **Capture readings #3 and #4 and plate temperature** — pork sear gain and carryover remain unmeasured.$m$, $m$["Purée: Celeriac found; potato–celeriac version made instead of the all-potato fallback.", "Hispi: Binchotan start abandoned as too slow and required too much movement between stations; finished under the broiler.", "Loin sear: No leave-in probe at the fire; sear stop was not temperature-guided. Readings #3 and #4 not reported.", "Pre-sear rest: Second loin rested on the rack still over the hot tray.", "Loin sear moved to cast iron on outdoor gas; hispi moved to the binchotan (in-chat revisions to the docx)."]$m$::jsonb, $m$[{"param": "Low-roast duration to 130°F/54°C (3.5 cm bone-in dry-aged loin, 225°F/107°C)", "designed": "40–70 min band", "observed": "60 and 67 min", "verdict": "confirmed"}, {"param": "Loin-rind crackling rendered in cast iron", "designed": "crisp crackling", "observed": "crisp and well received", "verdict": "confirmed"}, {"param": "Cider–shallot jus with a medium-dry cider", "designed": "complements the pork", "observed": "complemented the pork (Thatchers Gold, medium dry)", "verdict": "confirmed"}, {"param": "Potato–celeriac purée Tiger Keep Warm hold", "designed": "approx. 60 min hold", "observed": "held without texture loss (65:35 potato–celeriac, recipe quantity)", "verdict": "confirmed"}, {"param": "Pre-sear rest, 8 min uncovered", "designed": "rise of +15 to +20°F total", "observed": "−14°F and −8°F (115.9°F and 122°F at E+8)", "verdict": "diverged"}, {"param": "Reading-#2 sear gate", "designed": "thresholds assume the rest raises temperature", "observed": "both readings fell in the lowest branch (normal sear with fat-edge stand), producing an overshoot", "verdict": "diverged"}, {"param": "Belly rind crisped rind-down in cast iron", "designed": "12–18 min", "observed": "rind burnt; belly meat itself cooked well", "verdict": "diverged"}, {"param": "Hispi on binchotan", "designed": "binchotan char", "observed": "too slow for service; broiler finish gave char and crispness but dish judged incomplete in flavour", "verdict": "diverged"}, {"param": "Sear gain (pork)", "designed": "not stated", "observed": "not measured", "verdict": "unresolved"}, {"param": "Post-sear carryover (pork)", "designed": "not stated", "observed": "not measured", "verdict": "unresolved"}, {"param": "Plate temperature (pork)", "designed": "not stated", "observed": "not measured", "verdict": "unresolved"}]$m$::jsonb, $m$The loin was the attraction. The belly was well cooked but read as ordinary: it filled the plate without adding anything the loin did not.$m$, $m$2022 Domaine du Vieux Télégraphe “Télégramme” Châteauneuf-du-Pape — worked well. Vintage and cuvée matched from the live cellar export (snapshot 2026-09-27), the only Vieux Télégraphe bottle listed. Second Grenache-led Châteauneuf to work with reverse-seared pork, after the 2021 Mont-Redon on 30 Aug.$m$ from public.dish d where d.slug=$m$dry-aged-pork-tomahawk$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$binchotan-wagyu-dinner$m$,$m$Binchotan MB5+ Wagyu Sirloin Dinner$m$,$m$2025-12-21$m$,$m$cooked$m$::meal_status,3,$m$## ⏱️ TIMING & FLOW (STRESS-FREE)
<table header-row="true">
<tr>
<td>Time before eating</td>
<td>What to do</td>
</tr>
<tr>
<td>60–45 min</td>
<td>Steak out of fridge, start rice, make cucumber salad</td>
</tr>
<tr>
<td>30 min</td>
<td>Finish garlic rice, keep warm</td>
</tr>
<tr>
<td>20 min</td>
<td>Light binchotan</td>
</tr>
<tr>
<td>10 min</td>
<td>Grill asparagus & shishitos</td>
</tr>
<tr>
<td>5–7 min</td>
<td>Grill steak</td>
</tr>
<tr>
<td>Serve</td>
<td>Rest → slice → eat</td>
</tr>
</table>$m$,null,null,$m$2d9e0391ce6380c0ba1bc5bef49dbc6d$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$wagyu-binchotan-sirloin$m$,$m$Binchotan MB5+ Wagyu Sirloin$m$,$m$Beef$m$,array[$m$Main$m$]::text[],array[$m$Japanese$m$]::text[],$m$Medium$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$MB5+ wagyu sirloin seasoned with fine salt only and grilled briefly over white-hot binchotan, pulled at 49–50°C and sliced thin.$m$,$m$## 1️⃣ Wagyu Sirloin (MB5+, 280–300g)
**Seasoning**
- Fine sea salt only (just before grilling)
**Method**
1. Thaw fully; bring to room temp (45–60 min).
2. Pat completely dry.
3. Season lightly with fine salt **right before grilling**.
4. Grill over fully white-hot binchotan:
	- \~45–60 sec per side
	- Optional quick render on fat edge
5. **Pull at 120–122°F (49–50°C)**
6. Rest 5–7 min.
7. Slice thin across the grain.
**Serve with**
- Premium paste or fresh wasabi
- Yuzu kosho (tiny dabs)
- Flaky salt
- Optional lemon wedges$m$,3,array[$m$konro$m$,$m$binchotan$m$]::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380c0ba1bc5bef49dbc6d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 280, $m$g$m$, $m$280–300g$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$wagyu-binchotan-sirloin$m$ and i.name=$m$wagyu sirloin, mb5+$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$just before grilling$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$wagyu-binchotan-sirloin$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$premium paste or fresh; to serve$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$wagyu-binchotan-sirloin$m$ and i.name=$m$wasabi$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$tiny dabs; to serve$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$wagyu-binchotan-sirloin$m$ and i.name=$m$yuzu kosho$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$to serve$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$wagyu-binchotan-sirloin$m$ and i.name=$m$flaky salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$to serve$m$, false, true, 6
from public.dish d, public.ingredient i where d.slug=$m$wagyu-binchotan-sirloin$m$ and i.name=$m$lemon wedge$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$wagyu-garlic-rice$m$,$m$Japanese Garlic Rice (Light & Fragrant)$m$,null,array[$m$Side$m$]::text[],array[$m$Japanese$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Japanese short-grain rice cooked with kombu and folded into gently cooked garlic oil.$m$,$m$## 2️⃣ Japanese Garlic Rice (Light & Fragrant)
**Ingredients**
- 1 cup Japanese short-grain rice (uncooked)
- 1 cup water
- 1–2 small pieces kombu (optional; remove after cooking)
- 2 cloves garlic, very finely minced
- 1–1½ tbsp neutral oil (rice bran / grapeseed)
- Salt
- Tiny pinch white pepper (optional)
**Method**
1. Rinse rice; cook with water (+ kombu if using).
2. Remove kombu immediately after cooking.
3. Heat oil on low–medium; gently cook garlic until fragrant **not browned**.
4. Fold rice into garlic oil.
5. Season lightly with salt (+ white pepper if using).
6. Keep warm, covered.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380c0ba1bc5bef49dbc6d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$cup$m$, null, $m$uncooked$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$wagyu-garlic-rice$m$ and i.name=$m$japanese short-grain rice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$cup$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$wagyu-garlic-rice$m$ and i.name=$m$water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$1–2 small pieces$m$, $m$remove after cooking$m$, false, true, 3
from public.dish d, public.ingredient i where d.slug=$m$wagyu-garlic-rice$m$ and i.name=$m$kombu$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, null, $m$very finely minced$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$wagyu-garlic-rice$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, $m$1–1½ tbsp$m$, $m$rice bran / grapeseed$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$wagyu-garlic-rice$m$ and i.name=$m$neutral oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$wagyu-garlic-rice$m$ and i.name=$m$salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$tiny pinch$m$, null, false, true, 7
from public.dish d, public.ingredient i where d.slug=$m$wagyu-garlic-rice$m$ and i.name=$m$white pepper$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$wagyu-grilled-asparagus$m$,$m$Grilled Asparagus (Clean & Bright)$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Japanese$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Asparagus tossed in neutral oil and grilled until lightly charred, finished with lemon juice or sesame oil.$m$,$m$## 3️⃣ Grilled Asparagus (Clean & Bright)
**Ingredients**
- 1 bunch asparagus
- 1–1½ tbsp neutral oil
- Fine sea salt
- Finish: lemon juice **or** a few drops sesame oil (choose one)
**Method**
1. Snap off woody ends.
2. Toss with oil and light salt.
3. Grill over medium–high heat:
	- Roll occasionally
	- Until lightly charred and just tender (3–4 min)
4. Finish off heat with lemon **or** sesame oil.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380c0ba1bc5bef49dbc6d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$bunch$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$wagyu-grilled-asparagus$m$ and i.name=$m$asparagus$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, $m$1–1½ tbsp$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$wagyu-grilled-asparagus$m$ and i.name=$m$neutral oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$wagyu-grilled-asparagus$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$a few drops$m$, $m$finish; choose one$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$wagyu-grilled-asparagus$m$ and i.name=$m$lemon juice or sesame oil$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$wagyu-shishito-peppers$m$,$m$Blistered Shishito Peppers$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Japanese$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Shishito peppers grilled over high heat until blistered and finished with flaky salt.$m$,$m$## 4️⃣ Blistered Shishito Peppers
**Ingredients**
- 150–200g shishito peppers
- Neutral oil
- Flaky salt
- Optional lemon wedge
**Method**
1. Toss peppers lightly with oil.
2. Grill over high heat until blistered and lightly charred.
3. Finish with flaky salt (+ optional lemon).$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380c0ba1bc5bef49dbc6d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 150, $m$g$m$, $m$150–200g$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$wagyu-shishito-peppers$m$ and i.name=$m$shishito pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$wagyu-shishito-peppers$m$ and i.name=$m$neutral oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$wagyu-shishito-peppers$m$ and i.name=$m$flaky salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, true, 4
from public.dish d, public.ingredient i where d.slug=$m$wagyu-shishito-peppers$m$ and i.name=$m$lemon wedge$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$wagyu-cucumber-salad$m$,$m$Light Japanese Cucumber Salad (Cold Reset)$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],array[$m$Japanese$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Thinly sliced salted Japanese cucumber tossed with rice vinegar and chilled — a cold reset for the meal.$m$,$m$## 5️⃣ Light Japanese Cucumber Salad (Cold Reset)
**Ingredients**
- 1 large Japanese cucumber
- ½ tsp fine salt
- 1 tsp rice vinegar
- Optional: pinch sugar
- Optional garnish: sesame seeds
**Method**
1. Slice cucumber thin.
2. Toss with salt; rest 5 min.
3. Gently squeeze out excess water.
4. Toss with vinegar (+ pinch sugar if needed).
5. Chill until serving.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380c0ba1bc5bef49dbc6d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$large, sliced thin$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$wagyu-cucumber-salad$m$ and i.name=$m$japanese cucumber$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$wagyu-cucumber-salad$m$ and i.name=$m$fine salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$wagyu-cucumber-salad$m$ and i.name=$m$rice vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, null, null, false, true, 4
from public.dish d, public.ingredient i where d.slug=$m$wagyu-cucumber-salad$m$ and i.name=$m$sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$garnish$m$, false, true, 5
from public.dish d, public.ingredient i where d.slug=$m$wagyu-cucumber-salad$m$ and i.name=$m$sesame seed$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$binchotan-wagyu-dinner$m$ and d.slug=$m$wagyu-binchotan-sirloin$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$binchotan-wagyu-dinner$m$ and d.slug=$m$wagyu-garlic-rice$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$binchotan-wagyu-dinner$m$ and d.slug=$m$wagyu-grilled-asparagus$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$binchotan-wagyu-dinner$m$ and d.slug=$m$wagyu-shishito-peppers$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 5 from public.meal m, public.dish d where m.slug=$m$binchotan-wagyu-dinner$m$ and d.slug=$m$wagyu-cucumber-salad$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2025-12-21$m$::date, 9, 8.5, $m$yes$m$::repeat_verdict, $m$Binchotan timing is unforgiving — fully white-hot coals are non-negotiable. Pull at 49°C is correct; any longer risks losing the delicate fat render. Garlic rice benefits from resting covered for 5+ min after folding. Shishitos need high heat and no crowding to blister properly.$m$, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$binchotan-wagyu-dinner$m$;
commit;
