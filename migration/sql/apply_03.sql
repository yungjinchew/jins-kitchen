begin;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$brisket-dinner-new-year$m$,$m$Brisket Dinner (New Year 2026)$m$,$m$2026-01-01$m$,$m$cooked$m$::meal_status,3,null,null,null,null);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$brisket-main-unfiled$m$,$m$Brisket (unfiled)$m$,$m$Beef$m$,array[$m$Main$m$]::text[],'{}'::text[],null,'{}'::text[],'{}'::text[],$m$cooked$m$::dish_status,null,null,$m$The brisket main for the 1 Jan 2026 dinner was never filed in the Vault; placeholder for the menu record$m$,null,null,'{}'::text[],$m$[]$m$::jsonb,null,null);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$brisket-creme-fraiche-dijon-sauce$m$,$m$Crème Fraîche Dijon Brisket Sauce$m$,null,array[$m$Sauce$m$]::text[],array[$m$French$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$A warm crème fraîche and Dijon mustard sauce loosened with brisket jus, served with brisket.$m$,$m$**Ingredients**
3½ tbsp crème fraîche
1¼ tsp Dijon mustard
1–2 tbsp brisket jus (optional but recommended)
1–2 tbsp heavy cream (to loosen, optional)
Freshly cracked black pepper
Fine sea salt, only if needed

**Method**
Combine all ingredients in a small saucepan.
Warm over very low heat, whisking, until silky and pourable—do not boil.
Taste and adjust salt lightly if needed.

**Notes**
Optional brightener: ½ tsp sherry vinegar at the end.
Remove from heat when warm and glossy; overheating will cause the sauce to split.
$m$,null,array[$m$small saucepan$m$]::text[],$m$[]$m$::jsonb,null,$m$2dbe0391ce6380479acee4a414184e51$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3.5, $m$tbsp$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$ and i.name=$m$crème fraîche$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.25, $m$tsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$ and i.name=$m$dijon mustard$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, $m$1–2 tbsp$m$, $m$from the brisket; optional but recommended$m$, false, true, 3
from public.dish d, public.ingredient i where d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$ and i.name=$m$brisket jus$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, $m$1–2 tbsp$m$, $m$to loosen$m$, false, true, 4
from public.dish d, public.ingredient i where d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$ and i.name=$m$heavy cream$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$freshly cracked$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$only if needed$m$, false, true, 6
from public.dish d, public.ingredient i where d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, $m$optional brightener, added at the end$m$, false, true, 7
from public.dish d, public.ingredient i where d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$ and i.name=$m$sherry vinegar$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$brisket-parsley-carrot-celery-slaw$m$,$m$Bright Parsley Carrot–Celery Slaw$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$French$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,null,null,$m$A crunchy raw slaw of grated carrot, bias-cut celery and parsley dressed with olive oil and sherry vinegar.$m$,$m$**Ingredients**
2 medium carrots, grated on the largest holes
2 celery stalks, sliced very thin on the bias (1–2 mm)
2 tbsp Italian parsley, finely chopped
2½ tbsp olive oil
1½ tbsp sherry vinegar (or apple cider vinegar)
¼ tsp fine sea salt
Freshly cracked black pepper

**Method**
Combine carrots, celery, and parsley in a bowl.
Whisk together olive oil, vinegar, salt, and pepper in a separate bowl.
Toss just before serving.
Let rest 5–10 minutes to lightly soften while retaining crunch.

**Notes**
Large-hole grating prevents the carrots from weeping and preserves their crunch.
Thin bias-cut celery avoids fibrous chew.
$m$,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$2dbe0391ce638052897ccef33f07352e$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$medium, grated on the largest holes$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$brisket-parsley-carrot-celery-slaw$m$ and i.name=$m$carrot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$sliced very thin on the bias (1–2 mm)$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$brisket-parsley-carrot-celery-slaw$m$ and i.name=$m$celery stalk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$finely chopped$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$brisket-parsley-carrot-celery-slaw$m$ and i.name=$m$italian parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2.5, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$brisket-parsley-carrot-celery-slaw$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tbsp$m$, null, $m$or apple cider vinegar$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$brisket-parsley-carrot-celery-slaw$m$ and i.name=$m$sherry vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$brisket-parsley-carrot-celery-slaw$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$freshly cracked$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$brisket-parsley-carrot-celery-slaw$m$ and i.name=$m$black pepper$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$brisket-pumpkin-custard-galette$m$,$m$Pumpkin Custard Galette$m$,null,array[$m$Dessert$m$]::text[],array[$m$French$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Date Night$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$NYTimes, ChatGPT$m$,null,$m$A free-form galette with a spiced pumpkin custard filling on a sweet tart crust.$m$,$m$# 🎃 Pumpkin Custard Galette

**Ingredients**
- 1 disk sweet tart crust
- ¾ cup (180 g) pumpkin purée
- 50 g light brown sugar
- 1 large egg
- ¼ cup (60 ml) heavy cream
- ¼ tsp vanilla extract
- ⅛ tsp nutmeg
- Pinch of salt
- Zest of ½ orange
- 1 tbsp melted butter
- ½–1 tsp fine white sugar (for crust)

**Method**
Preheat oven to 190°C / 375°F
Roll crust to 11 in / 28 cm.
Whisk filling until smooth.
Fill centre, leave 2½ in border.
Fold edges. Brush butter. Sprinkle sugar.
Bake 40–45 min until deep golden and just set.
Rest 20 minutes before slicing.

**Serve with**
Crème fraîche or lightly whipped cream.
$m$,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$2dbe0391ce638080980cee332555b009$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$1 disk$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$sweet tart crust$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 180, $m$g$m$, $m$¾ cup$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$pumpkin purée$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 50, $m$g$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$light brown sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$large$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$egg$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 60, $m$ml$m$, $m$¼ cup$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$heavy cream$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$vanilla extract$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.125, $m$tsp$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$nutmeg$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$pinch$m$, null, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$piece$m$, null, $m$zest only$m$, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$orange$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$melted$m$, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, $m$½–1 tsp$m$, $m$for crust$m$, false, false, 11
from public.dish d, public.ingredient i where d.slug=$m$brisket-pumpkin-custard-galette$m$ and i.name=$m$fine white sugar$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$brisket-garlic-mushroom-green-bean-skillet$m$,$m$Charred Garlic Mushroom & Green Bean Skillet$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$French$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Thawed frozen mushrooms and green beans charred in brisket fat with garlic and a splash of sherry vinegar.$m$,$m$**Ingredients**
230 g frozen green beans, fully thawed and patted very dry
180 g frozen mushrooms, fully thawed and patted very dry
2 tbsp brisket fat or unsalted butter
2 cloves garlic, minced
1½ tsp sherry vinegar
Fine sea salt to taste
Freshly cracked black pepper

**Method**
Heat a wide pan over medium-high heat.
Add fat. Add mushrooms in a single layer. Do not move for 2–3 minutes until deeply browned.
Add green beans. Toss occasionally until blistered and lightly charred, 3–4 minutes.
Reduce heat to medium-low. Add garlic and cook for 30 seconds.
Splash with vinegar, season with salt and pepper. Serve immediately.

**Notes**
Drying the vegetables thoroughly is essential for a proper char.
$m$,null,array[$m$wide pan$m$]::text[],$m$[]$m$::jsonb,null,$m$2dbe0391ce63809cbc83e14ddfdf0992$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 230, $m$g$m$, null, $m$fully thawed and patted very dry$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$ and i.name=$m$green bean, frozen$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 180, $m$g$m$, null, $m$fully thawed and patted very dry$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$ and i.name=$m$mushroom, frozen$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$or unsalted butter$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$ and i.name=$m$brisket fat$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, null, $m$minced$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tsp$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$ and i.name=$m$sherry vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$to taste$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$freshly cracked$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$ and i.name=$m$black pepper$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$brisket-dinner-new-year$m$ and d.slug=$m$brisket-main-unfiled$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$brisket-dinner-new-year$m$ and d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$brisket-dinner-new-year$m$ and d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$brisket-dinner-new-year$m$ and d.slug=$m$brisket-parsley-carrot-celery-slaw$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$dessert$m$::dish_role, 5 from public.meal m, public.dish d where m.slug=$m$brisket-dinner-new-year$m$ and d.slug=$m$brisket-pumpkin-custard-galette$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-01-01$m$::date, null, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$brisket-dinner-new-year$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-01-01$m$::date, 9, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$brisket-creme-fraiche-dijon-sauce$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-01-01$m$::date, 8, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$brisket-parsley-carrot-celery-slaw$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-01-01$m$::date, null, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$brisket-pumpkin-custard-galette$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-01-01$m$::date, 8.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$brisket-garlic-mushroom-green-bean-skillet$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$chicken-stew-sunday$m$,$m$Chicken Stew with White Wine, Wings & Gremolata — Sunday Dinner$m$,$m$2026-05-25$m$,$m$cooked$m$::meal_status,3,$m$## ⏱️ T-Minus Timeline
<table header-row="true">
<tr>
<td>Time</td>
<td>Action</td>
</tr>
<tr>
<td>T-5 hr</td>
<td>Bake olive oil cake</td>
</tr>
<tr>
<td>T-3 hr</td>
<td>Prep all vegetables and salad components</td>
</tr>
<tr>
<td>T-2 hr 45 min</td>
<td>Begin stew — render bacon, brown wings</td>
</tr>
<tr>
<td>T-2 hr 05 min</td>
<td>Begin reduction phase</td>
</tr>
<tr>
<td>T-1 hr 35 min</td>
<td>Stew enters oven with wings, potatoes, early carrots</td>
</tr>
<tr>
<td>T-1 hr 05 min</td>
<td>Add thighs and remaining carrots</td>
</tr>
<tr>
<td>T-35 min</td>
<td>Begin raising oven to 400°F / 205°C — stew has \~15 min remaining</td>
</tr>
<tr>
<td>T-20 min</td>
<td>Stew exits oven and holds uncovered</td>
</tr>
<tr>
<td>T-15 min</td>
<td>Toast bread</td>
</tr>
<tr>
<td>T-5 min</td>
<td>Dress salad</td>
</tr>
<tr>
<td>T</td>
<td>Plate and serve</td>
</tr>
</table>
**Critical path:** Wing browning → reduction → final thigh braise. Do not delay stew service for bread or salad.
**Oven sequencing:** Cake (350°F) → Stew (325°F) → Bread (400°F). Raise oven at T-35 while stew finishes. Transition takes \~15–20 min. Bread enters only when oven confirms temperature.$m$,null,$m$Felton Road Bannockburn Pinot Noir 2022 — worked well. Consider Clos des Papes CdP 2018 next time for more body.$m$,$m$368e0391ce6381a3b56be65cc572209e$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$chicken-stew-fennel-celery-herb-salad$m$,$m$Fennel, Celery, and Herb Salad with Lemon Vinaigrette$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],array[$m$Modern$m$,$m$European$m$]::text[],null,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$ATK / Claude$m$,null,$m$Shaved fennel and celery with parsley in a deliberately broken lemon vinaigrette, dressed just before serving.$m$,$m$## 🥗 Fennel, Celery, and Herb Salad
**Serves 6–8 · 20 min active**
### Ingredients
- 2 fennel bulbs, shaved thin
- 3 celery stalks, sliced thinly
- ½ cup parsley leaves
- 2 tbsp lemon juice
- 60 ml / ¼ cup extra-virgin olive oil
- Diamond Crystal kosher salt and black pepper
- Optional: 30 g / 1 oz shaved Parmesan
### Method
1. Shave fennel and slice celery. Refrigerate until service.
2. Whisk lemon juice + olive oil + salt + pepper vigorously. Broken vinaigrette is intentional.
3. Dress immediately before serving. Toss with parsley. Add Parmesan at final toss if using.
### ⚠️ CCPs
- **Major:** Do not dress early — fennel softens and releases water. Unrecoverable for texture; salad remains edible.$m$,6,'{}'::text[],$m$[]$m$::jsonb,null,$m$368e0391ce6381a3b56be65cc572209e$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$shaved thin$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$ and i.name=$m$fennel bulb$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$piece$m$, null, $m$sliced thinly$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$ and i.name=$m$celery stalk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$cup$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$ and i.name=$m$parsley leaves$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 60, $m$ml$m$, $m$¼ cup$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 30, $m$g$m$, $m$1 oz$m$, $m$shaved$m$, false, true, 8
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$ and i.name=$m$parmesan$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$chicken-stew-white-wine-wings-gremolata$m$,$m$Chicken Stew with White Wine, Wings, and Gremolata$m$,$m$Chicken$m$,array[$m$Main$m$]::text[],array[$m$Modern$m$,$m$European$m$]::text[],$m$Medium$m$,array[$m$Make-Ahead$m$]::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$ATK / Claude$m$,null,$m$Chicken thigh stew built on a deep wing-and-bacon fond and a hard white-wine reduction, braised in the oven with potatoes and split-timed carrots, finished with sherry vinegar and gremolata.$m$,$m$## 🍲 Chicken Stew with White Wine, Wings, and Gremolata
**Yield: 6–8 · Total: \~2 hr 45 min · Active: \~50 min · Oven: 325°F / 163°C**
### Ingredients — Stew
- 2 lb boneless skinless chicken thighs, halved crosswise
- 1 lb chicken wings, separated at joints
- 3 slices bacon, chopped
- 1 medium onion, finely chopped
- 1 celery rib, minced
- 2 garlic cloves, minced
- 2 tsp anchovy paste
- ½ tsp dried thyme
- 1 bay leaf · parsley stems from 1 small bunch · 1 thin strip lemon peel
- 5 cups / 1.2 L chicken broth
- 1 cup / 240 ml dry white wine
- 1 tbsp soy sauce
- 57 g / 4 tbsp unsalted butter
- 2½ tbsp all-purpose flour
- 1 lb small red potatoes, quartered
- 4 carrots, cut into ½-inch pieces, **divided**
- ¾ tsp Diamond Crystal kosher salt · black pepper
### Ingredients — Finish & Gremolata
- 1–2 tsp sherry vinegar
- 2 tbsp finely chopped parsley · ½ tsp lemon zest · ¼ small garlic clove, microplaned
### Prep
1. Heat oven to 325°F / 163°C.
2. Pat wings dry thoroughly.
3. Season thighs with ¾ tsp Diamond Crystal kosher salt + pepper. Temper 15–20 min.
4. Divide carrots into two equal portions.
### Phase 1 — Render Bacon and Brown Wings
1. Cook bacon in Dutch oven over medium-low, 6–8 min. Transfer to bowl.
2. Increase to medium. Brown wings deeply, 10–12 min total. **Brown in batches if necessary.**
3. *Cue: deep golden brown, dark fond on pot.* Transfer wings and bacon to bowl. Hold up to 30 min at room temp.
### Phase 2 — Build and Reduce Base
1. Add onion, celery, garlic, anchovy paste, thyme. Cook 3–5 min.
2. Add wine, 1 cup / 240 ml broth, soy sauce. Scrape up all browned bits.
3. Add bay leaf, parsley stems, lemon peel.
4. Boil aggressively until nearly dry, 12–15 min. *Cue: vegetables begin lightly frying again in concentrated fat.*
### Phase 3 — Build Stew
1. Reduce heat to medium-low. Stir in butter.
2. Add flour; cook 1 min.
3. Gradually whisk in remaining 4 cups / 960 ml broth until smooth.
4. Add wings, bacon, potatoes, and **first half of carrots**. Bring to simmer.
5. Transfer uncovered to oven for 30 min.
### Phase 4 — Add Thighs
1. Remove from oven. Scrape fond above liquid line back into stew.
2. Add thighs and **remaining carrots**.
3. Return uncovered to oven for 40–50 min.
4. *Doneness: paring knife slides through thickest thigh with no drag. If resistance remains: 10 more min. Thighs remain submerged to service.*
### Holding & Assembly
1. During final 30 min, make gremolata. Hold uncovered max 30 min — discard and remake if longer.
2. Remove and discard bay leaf, parsley stems, lemon peel.
3. Remove wings, reclaim flat and drumette meat. Discard bones, skin, cartilage. Return meat to stew.
4. Stir in 1–2 tsp sherry vinegar. Taste after first teaspoon.
5. Adjust salt and pepper.
6. Hold uncovered off heat up to 20 min. Loosen with hot broth if it thickens.
7. Serve with \~½ tsp gremolata per bowl.
### ⚠️ CCPs
<table header-row="true">
<tr>
<td>Severity</td>
<td>Failure Mode</td>
<td>Recovery</td>
</tr>
<tr>
<td>**Critical**</td>
<td>Incomplete reduction — vegetables still floating in abundant liquid</td>
<td>Continue until vegetables lightly fry</td>
</tr>
<tr>
<td>**Major**</td>
<td>Pale wings, weak fond — advance to Phase 2 anyway</td>
<td>Continue browning before proceeding</td>
</tr>
<tr>
<td>**Major**</td>
<td>Over-thickened stew</td>
<td>Thin with hot broth</td>
</tr>
<tr>
<td>**Major**</td>
<td>Overcooked late carrots</td>
<td>Unrecoverable for texture; stew remains acceptable</td>
</tr>
<tr>
<td>**Minor**</td>
<td>Excess gremolata</td>
<td>Reduce garnish</td>
</tr>
</table>$m$,6,array[$m$Dutch oven$m$]::text[],$m$[]$m$::jsonb,null,$m$368e0391ce6381a3b56be65cc572209e$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$lb$m$, null, $m$halved crosswise$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$chicken thigh, boneless skinless$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$lb$m$, null, $m$separated at joints$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$chicken wing$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$slice$m$, null, $m$chopped$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$bacon$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$1 medium$m$, $m$finely chopped$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$minced$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$celery rib$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, null, $m$minced$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tsp$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$anchovy paste$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$dried thyme$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$bay leaf$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$bunch$m$, $m$stems from 1 small bunch$m$, null, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$parsley stems$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$1 thin strip$m$, null, false, false, 11
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$lemon peel$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1200, $m$ml$m$, $m$5 cups / 1.2 L$m$, null, false, false, 12
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$chicken broth$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 240, $m$ml$m$, $m$1 cup$m$, null, false, false, 13
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$dry white wine$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 14
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$soy sauce$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 57, $m$g$m$, $m$4 tbsp$m$, null, false, false, 15
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$unsalted butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2.5, $m$tbsp$m$, null, null, false, false, 16
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$all-purpose flour$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$lb$m$, null, $m$quartered$m$, false, false, 17
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$small red potato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$piece$m$, null, $m$cut into ½-inch pieces, divided$m$, false, false, 18
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$carrot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.75, $m$tsp$m$, null, null, false, false, 19
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 20
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, $m$1–2 tsp$m$, $m$finish$m$, false, false, 21
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$sherry vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$finely chopped, gremolata$m$, false, false, 22
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, $m$gremolata$m$, false, false, 23
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$clove$m$, $m$¼ small clove$m$, $m$microplaned, gremolata$m$, false, false, 24
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$ and i.name=$m$garlic$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$chicken-stew-toasted-sourdough$m$,$m$Toasted Country Sourdough$m$,null,array[$m$Bread$m$]::text[],array[$m$Modern$m$,$m$European$m$]::text[],null,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$ATK / Claude$m$,null,$m$Thick-sliced country sourdough brushed with olive oil and toasted at 400°F / 205°C.$m$,$m$## 🍞 Toasted Country Sourdough
**15 min total · 5 min active · Oven: 400°F / 205°C**
### Ingredients
- 1 large sourdough loaf · olive oil · flaky salt
### Method
1. Slice thickly.
2. Raise oven to 400°F / 205°C. Wait for confirmed temperature before bread enters.
3. Brush with olive oil. Toast 8–10 min.
4. *Cue: edges crisp and browned; center yields under firm pressure.*
5. Hold on loose rack up to 15 min. Re-toast 3–4 min if crust softens.$m$,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$368e0391ce6381a3b56be65cc572209e$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$1 large$m$, $m$sliced thickly$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-toasted-sourdough$m$ and i.name=$m$sourdough loaf$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-toasted-sourdough$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-toasted-sourdough$m$ and i.name=$m$flaky salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$chicken-stew-orange-olive-oil-cake$m$,$m$Orange Olive Oil Cake$m$,null,array[$m$Dessert$m$]::text[],array[$m$Modern$m$,$m$European$m$]::text[],null,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$ATK / Claude$m$,null,$m$One 9-inch orange-zest olive oil cake, served with a light dusting of powdered sugar.$m$,$m$## 🍊 Orange Olive Oil Cake
**One 9-inch cake · Serves 8 · Total: 1 hr 30 min · Active: 20 min · Oven: 350°F / 177°C**
### Ingredients
- 200 g sugar
- Zest of 2 oranges
- 3 eggs
- 180 ml / ¾ cup extra-virgin olive oil
- 120 ml / ½ cup whole milk
- 60 ml / ¼ cup orange juice
- 210 g all-purpose flour *(weight authoritative)*
- 1½ tsp baking powder
- ½ tsp Diamond Crystal kosher salt
- Powdered sugar for finish
### Method
1. Heat oven to 350°F / 177°C. Grease 9-inch cake pan with butter. Dust with flour and tap out excess. Cut a parchment round to fit the base; place in pan and grease the parchment.
2. Rub orange zest into sugar. Whisk in eggs.
3. Add olive oil, milk, orange juice.
4. Fold in flour, baking powder, salt.
5. Bake 40–50 min. *Cue: center springs back lightly; skewer with moist crumbs, no wet batter.*
6. Cool 20 min before unmolding. If cake resists, return to pan and cool 10 min more.
7. Hold uncovered at room temp up to 8 hr. Serve with light powdered sugar.
### ⚠️ CCPs
- **Major:** Underbaked center (wet batter on skewer) → continue in 5-min increments.
- **Minor:** Overmixing → fold minimally once flour added.$m$,8,array[$m$9-inch cake pan$m$]::text[],$m$[]$m$::jsonb,null,$m$368e0391ce6381a3b56be65cc572209e$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 200, $m$g$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, $m$zest of 2 oranges$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$orange zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$piece$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$egg$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 180, $m$ml$m$, $m$¾ cup$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 120, $m$ml$m$, $m$½ cup$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$whole milk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 60, $m$ml$m$, $m$¼ cup$m$, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$orange juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 210, $m$g$m$, null, $m$weight authoritative$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$all-purpose flour$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tsp$m$, null, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$baking powder$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$for finish$m$, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$chicken-stew-orange-olive-oil-cake$m$ and i.name=$m$powdered sugar$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$chicken-stew-sunday$m$ and d.slug=$m$chicken-stew-fennel-celery-herb-salad$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$chicken-stew-sunday$m$ and d.slug=$m$chicken-stew-white-wine-wings-gremolata$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$bread$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$chicken-stew-sunday$m$ and d.slug=$m$chicken-stew-toasted-sourdough$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$dessert$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$chicken-stew-sunday$m$ and d.slug=$m$chicken-stew-orange-olive-oil-cake$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-05-25$m$::date, 9.5, 8.5, $m$yes$m$::repeat_verdict, $m$Reduction and wing browning both executed correctly — fond was deep, stew had good body. Split carrot timing worked; late carrots retained texture. Gremolata provided meaningful brightness; sherry vinegar finish essential. Minor timing issue with bread: oven transition ran approximately 5 minutes longer than T-15 allows — serve bread just after stew next time rather than simultaneously. Wine: Felton Road Bannockburn 2022 paired well, bright and plush without competing with the gremolata or vinegar finish. Consider Clos des Papes CdP 2018 next time for more body against the collagen-rich broth.$m$, $m$["Oven transition to 400°F for the bread ran approximately 5 minutes longer than T-15 allows — serve bread just after the stew next time rather than simultaneously"]$m$::jsonb, $m$[{"param": "Reduction and wing browning", "designed": "Boil aggressively until nearly dry; deep golden brown wings, dark fond", "observed": "Both executed correctly — fond was deep, stew had good body", "verdict": "confirmed"}, {"param": "Split carrot timing", "designed": "Half the carrots in Phase 3, half with the thighs in Phase 4", "observed": "Worked; late carrots retained texture", "verdict": "confirmed"}, {"param": "Sherry vinegar finish", "designed": "1–2 tsp off heat", "observed": "Essential; gremolata provided meaningful brightness", "verdict": "confirmed"}, {"param": "Oven transition to 400°F for bread", "designed": "~15–20 min from T-35, bread at T-15", "observed": "Ran approximately 5 minutes longer than T-15 allows", "verdict": "diverged"}]$m$::jsonb, null, $m$Felton Road Bannockburn 2022 paired well, bright and plush without competing with the gremolata or vinegar finish. Consider Clos des Papes CdP 2018 next time for more body against the collagen-rich broth.$m$ from public.meal m where m.slug=$m$chicken-stew-sunday$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$noilly-prat-clams-dinner$m$,$m$Noilly Prat Clams with Linguine and Brocollini$m$,$m$2025-12-29$m$,$m$cooked$m$::meal_status,3,null,null,$m$Sauvignon Blanc — Cloudy Bay Sauvignon Blanc$m$,$m$2d9e0391ce6380d49624cf9593d4eb80$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$clams-noilly-prat-linguine$m$,$m$Noilly Prat Clams with Linguine$m$,$m$Shellfish$m$,array[$m$Main$m$]::text[],array[$m$Italian$m$,$m$French$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Light coastal trattoria-style Manila clams steamed in Noilly Prat vermouth with garlic and chilli, tossed with linguine and emulsified with pasta water.$m$,$m$# 🍝 Noilly Prat Clams with Linguine
**Light Coastal Trattoria Style (For 3, lighter eaters)**
---
## Ingredients
### Clams & Pasta
- **1 kg Manila clams**, scrubbed
- **240–260 g linguine or spaghetti**
### Sauce
- 3½ tbsp extra-virgin olive oil
- 2 garlic cloves, thinly sliced
- Tiny pinch chilli flakes
- **½ cup Noilly Prat dry vermouth**
- **3–4 tbsp pasta cooking water**
- Zest of ½ lemon
- ½ cup flat-leaf parsley, chopped
- Fresh black pepper
- Optional: **1 tbsp cold unsalted butter**
---
## Method
1. Bring a large pot of well-salted water to a rolling boil.
2. Cook pasta **2 minutes shy of al dente**.
3. Heat olive oil in a wide pan over medium.
4. Add garlic + chilli; gently sizzle until fragrant (do not brown).
5. Add clams, turn heat to high.
6. Add vermouth, cover immediately.
7. Steam **3–4 minutes** until clams just open.
8. Transfer pasta into the clam pan.
9. Add pasta water and toss hard **30–45 seconds** to emulsify sauce.
10. Off heat: add butter (if using), lemon zest, parsley, and black pepper.
11. Taste, adjust salt only if needed.
12. Serve immediately with plenty of bread.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380d49624cf9593d4eb80$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1000, $m$g$m$, $m$1 kg$m$, $m$scrubbed$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$manila clam$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 240, $m$g$m$, $m$240–260 g$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$linguine or spaghetti$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3.5, $m$tbsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, null, $m$thinly sliced$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$tiny pinch$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$chilli flake$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$cup$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$noilly prat dry vermouth$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$tbsp$m$, $m$3–4 tbsp$m$, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$pasta cooking water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$zest of ½ lemon$m$, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$cup$m$, null, $m$chopped$m$, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$flat-leaf parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$fresh$m$, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$cold$m$, false, true, 11
from public.dish d, public.ingredient i where d.slug=$m$clams-noilly-prat-linguine$m$ and i.name=$m$unsalted butter$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$clams-garlicky-broccolini$m$,$m$Garlicky Broccolini Side$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Italian$m$,$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Blanched broccolini tossed in garlic-infused olive oil and finished with salt and lemon zest.$m$,$m$# 🥬 Garlicky Broccolini Side
## Ingredients
- 2 bunches broccolini
- 1½–2 tbsp olive oil
- 1 garlic clove, thinly sliced
- Pinch fine salt
- Tiny pinch lemon zest
## Method
1. Blanch broccolini in salted boiling water **90 seconds**.
2. Drain very well.
3. Heat olive oil in pan over medium, add garlic 15–20 sec.
4. Add broccolini, toss **1–2 minutes**.
5. Finish with salt and lemon zest.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380d49624cf9593d4eb80$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$bunch$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$clams-garlicky-broccolini$m$ and i.name=$m$broccolini$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tbsp$m$, $m$1½–2 tbsp$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$clams-garlicky-broccolini$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$clove$m$, null, $m$thinly sliced$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$clams-garlicky-broccolini$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$clams-garlicky-broccolini$m$ and i.name=$m$fine salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$tiny pinch$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$clams-garlicky-broccolini$m$ and i.name=$m$lemon zest$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$noilly-prat-clams-dinner$m$ and d.slug=$m$clams-noilly-prat-linguine$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$noilly-prat-clams-dinner$m$ and d.slug=$m$clams-garlicky-broccolini$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2025-12-29$m$::date, 8.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$noilly-prat-clams-dinner$m$;
commit;
