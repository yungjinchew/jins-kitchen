begin;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$west-african-peanut-stew-dinner$m$,$m$West African Peanut Stew Dinner (Maafe)$m$,$m$2026-09-13$m$,$m$cooked$m$::meal_status,3,$m$## Meal Workflow
**Critical Path:** Final 10 minutes of stew — spinach → lime → cilantro → seasoning → immediate service. Everything else complete or holding before T-10.
**Heat:** Burner 1 → Stew \| Burner 2 → Rice. No oven required.
**Failure priority:** Stew texture → Rice texture → Salad freshness → Condiments → Pineapple. Do not delay stew service for any other component.
### Holding Chain
<table header-row="true">
<tr>
<td>Component</td>
<td>Hold</td>
<td>Max</td>
<td>Drift Fix</td>
</tr>
<tr>
<td>Stew</td>
<td>Very low heat, uncovered</td>
<td>15 min</td>
<td>Hot water 50 ml increments</td>
</tr>
<tr>
<td>Rice</td>
<td>Covered, off heat</td>
<td>25 min</td>
<td>15 ml water, re-cover, re-fluff</td>
</tr>
<tr>
<td>Salad</td>
<td>Room temp</td>
<td>30 min</td>
<td>Drain; re-season lime + salt</td>
</tr>
<tr>
<td>Chilli paste</td>
<td>Ambient, covered</td>
<td>4 hrs</td>
<td>None</td>
</tr>
<tr>
<td>Peanuts</td>
<td>Dry bowl</td>
<td>Stable</td>
<td>None</td>
</tr>
<tr>
<td>Pineapple</td>
<td>Chilled</td>
<td>2 hrs</td>
<td>Re-dress with lime before serving</td>
</tr>
</table>
### T-Minus Timeline
<table header-row="true">
<tr>
<td>Time</td>
<td>Task</td>
</tr>
<tr>
<td>T-65</td>
<td>Chicken sear begins</td>
</tr>
<tr>
<td>T-55</td>
<td>Aromatic base</td>
</tr>
<tr>
<td>T-46</td>
<td>Tomato development</td>
</tr>
<tr>
<td>T-40</td>
<td>Peanut emulsification + braise begins; start rice</td>
</tr>
<tr>
<td>T-30</td>
<td>Salad, chilli paste, peanuts, pineapple</td>
</tr>
<tr>
<td>T-15</td>
<td>Rice holding; check sweet potato doneness</td>
</tr>
<tr>
<td>T-10</td>
<td>Final stew finish — uninterrupted</td>
</tr>
<tr>
<td>T-2</td>
<td>Plate rice</td>
</tr>
<tr>
<td>T-0</td>
<td>Stew over rice; garnish; serve</td>
</tr>
</table>
**Plating window:** Rice → stew over rice → peanuts + cilantro. 3–4 min from first plate to service. First failure: stew temperature drops, spinach overtenders, rice surface dries.
**Salad note:** Interleave with stew bites — within reach at every place setting, not a separate course.$m$,null,$m$Cook 2: Alheit Vineyards Hereafter Here Chenin Blanc 2022 (opened — paired well). Cook 1: Felton Road Bannockburn Pinot Noir 2022 (opened — went well). Chenin Blanc confirmed across both as the stronger style match.$m$,$m$362e0391ce6381dbb0fadf943507132d$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maafe-chicken-peanut-stew$m$,$m$Chicken Peanut Stew (Maafe)$m$,$m$Chicken$m$,array[$m$Main$m$]::text[],'{}'::text[],$m$Medium$m$,array[$m$Make-Ahead$m$,$m$Freezer Friendly$m$]::text[],array[$m$Family$m$,$m$Weeknight$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Cooking Project — May 2026$m$,$m$v3.5$m$,$m$Rich peanut-tomato braise of bone-in chicken thighs with sweet potato, staged acidity and a fresh cilantro finish.$m$,$m$## Dish 1 — Chicken Peanut Stew (Maafe)
Rich peanut-tomato braise with staged acidity and fresh cilantro finish. Texture targets: tender chicken, intact sweet potato, glossy sauce, crunchy peanut garnish.
**Trade-off:** Deep fond development requires aggressive searing and additional time.
**Yield:** 4–5 servings \| **Active:** 30 min \| **Total:** 65 min \| **Hold:** 15 min max
### Ingredients
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Amount</td>
</tr>
<tr>
<td>Bone-in chicken thighs, skin-on</td>
<td>600–700 g</td>
</tr>
<tr>
<td>Neutral oil</td>
<td>28 ml / 2 tbsp</td>
</tr>
<tr>
<td>Onion, diced</td>
<td>1 large</td>
</tr>
<tr>
<td>Garlic cloves, minced</td>
<td>4</td>
</tr>
<tr>
<td>Fresh ginger, grated</td>
<td>15 ml / 1 tbsp</td>
</tr>
<tr>
<td>Tomato paste</td>
<td>30 g / 2 tbsp</td>
</tr>
<tr>
<td>Crushed tomatoes</td>
<td>400 g</td>
</tr>
<tr>
<td>Ground cumin</td>
<td>5 g / 1 tsp</td>
</tr>
<tr>
<td>Ground coriander</td>
<td>4 g / 1 tsp</td>
</tr>
<tr>
<td>Chilli flakes</td>
<td>1–2 g / ½–1 tsp</td>
</tr>
<tr>
<td>Natural peanut butter, unsweetened</td>
<td>130–160 g / 8–10 tbsp</td>
</tr>
<tr>
<td>Chicken stock</td>
<td>900 ml / 3¾ cups</td>
</tr>
<tr>
<td>Sweet potato, 3 cm chunks</td>
<td>260–330 g</td>
</tr>
<tr>
<td>Baby spinach</td>
<td>60 g / 2 packed cups</td>
</tr>
<tr>
<td>Fresh cilantro</td>
<td>8–10 g / ¼ cup loosely packed</td>
</tr>
<tr>
<td>Diamond Crystal kosher salt</td>
<td>5–7 g / 1–1½ tsp</td>
</tr>
<tr>
<td>Lime juice</td>
<td>30–45 ml / 2–3 tbsp</td>
</tr>
</table>
### Flavor Architecture
<table header-row="true">
<tr>
<td>Element</td>
<td>Definition</td>
</tr>
<tr>
<td>Base</td>
<td>Neutral oil + onion + garlic + ginger</td>
</tr>
<tr>
<td>Primary driver</td>
<td>Peanut butter</td>
</tr>
<tr>
<td>Acid</td>
<td>Tomato during reduction (Stage 1); lime off heat (Stage 2)</td>
</tr>
<tr>
<td>Finish</td>
<td>Cilantro off heat; crushed peanuts at plating</td>
</tr>
</table>
### Method
**Prep:** Pat chicken completely dry. Dice onion; mince garlic; grate ginger. Cut sweet potato into uniform 3 cm chunks. Measure peanut butter separately.
**Step 1 — Sear (high):** Heat oil until shimmering. Sear skin-side down 4–5 min until deeply browned. Flip; 2 min. Remove. Remove skin before braising and discard. Do not leave skin in stew.
**Step 2 — Aromatic base (medium):** Onion + 2 g / ½ tsp salt. Cook 6–8 min until softened with light golden edges. Add garlic + ginger → 1 min.
**Step 3 — Tomato development (medium):** Tomato paste → 2–3 min until darkened. Add cumin, coriander, chilli flakes → bloom 30 sec. Add tomatoes → 3–4 min, scraping fond.
**Step 4 — Peanut emulsification:** Add stock; bring to low simmer. Ladle 120 ml / ½ cup hot liquid into peanut butter; whisk smooth. Return slowly while stirring.
**Step 5 — Braise (low):** Return chicken. Add sweet potato. Gentle simmer 25–30 min, partially covered. Chicken remains submerged to service — no formal rest. **Doneness:** Flesh alongside bone separates cleanly under firm thumb pressure → stop. Resists or tears → continue 5 min.
**Step 6 — Finish (low → off heat):** Spinach → 2–3 min until wilted. Lime juice; adjust incrementally. Cilantro off heat. Reserve some for plating.
### Critical Control Points
**Critical — Sweet potato collapse:** Cue: edges rounding and splitting. Outcome: muddy texture. Recovery: unrecoverable.
**Critical — Broken emulsion:** Cue: oil pooling after stirring. Outcome: greasy grainy sauce. Recovery: whisk fresh peanut butter with cooler liquid separately; reintegrate.
**Major — Weak fond:** Cue: pale chicken, clean pan base. Outcome: flat stew. Recovery: 5–10 ml fish sauce or soy sauce off heat.
### Adjustment Notes
<table header-row="true">
<tr>
<td>Adjustment</td>
<td>Guidance</td>
</tr>
<tr>
<td>Salt</td>
<td>Stew body only</td>
</tr>
<tr>
<td>Acid</td>
<td>Lime in 5 ml / 1 tsp increments</td>
</tr>
<tr>
<td>Texture</td>
<td>Thin with hot water</td>
</tr>
<tr>
<td>Ginger / spice</td>
<td>If spice-forward rather than peanut-forward: add 15–30 ml stock + 1 tbsp peanut butter over low heat</td>
</tr>
</table>
**Scaling:** Sear in batches. Larger batches extend braise \~5–8 min. Add peanut butter incrementally, not by formula.$m$,4,'{}'::text[],$m$[{"param": "Kabocha time from entry to doneness cue", "designed_value": "Not specified — designed for the 2x kabocha + okra variant", "note": "Cook 2 (13 Sep 2026): not captured. Remains designed; carries forward to cook 3."}, {"param": "Okra exposure, active and residual; acceptability of firm-at-service", "designed_value": "Whole small pods, cap trimmed without breaching the pod, added late", "note": "Cook 2 (13 Sep 2026): not captured. All okra was consumed with no adverse comment on texture; firm-at-service evidently acceptable, though the okra was not separately assessed. Remains designed; carries forward to cook 3."}, {"param": "2x evaporation in the wide vessel; reserved stock add-back", "designed_value": "Reserved stock held back as a correction reserve", "note": "Cook 2 (13 Sep 2026): not captured. Remains designed; carries forward to cook 3."}, {"param": "Freezer hold for a vegetable-free reserve", "designed_value": "Diversion of half the batch before vegetables/finish", "note": "RETIRED. Never tested; diversion removed from the design at Jin's direction, 14 Sep 2026. Does not carry forward."}, {"param": "Skin-on sear value versus skin-off-first", "designed_value": "Sear skin-on, remove skin before braising", "note": "Cook 2 (13 Sep 2026): not captured. Remains designed; carries forward to cook 3."}, {"param": "Lime multiplicity — coherent or repetitive across four components", "designed_value": "Lime in stew, salad, chilli paste and pineapple", "note": "Cook 2 (13 Sep 2026): not captured. Remains designed; carries forward to cook 3."}]$m$::jsonb,null,$m$362e0391ce6381dbb0fadf943507132d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 600, $m$g$m$, $m$600–700 g$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$chicken thigh, bone-in, skin-on$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 28, $m$ml$m$, $m$2 tbsp$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$neutral oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$1 large$m$, $m$diced$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$clove$m$, null, $m$minced$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$ml$m$, $m$1 tbsp$m$, $m$grated$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$ginger, fresh$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 30, $m$g$m$, $m$2 tbsp$m$, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$tomato paste$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 400, $m$g$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$crushed tomatoes, tinned$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 5, $m$g$m$, $m$1 tsp$m$, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$ground cumin$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$g$m$, $m$1 tsp$m$, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$ground coriander$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$g$m$, $m$1–2 g / ½–1 tsp$m$, null, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$chilli flakes$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 130, $m$g$m$, $m$130–160 g / 8–10 tbsp$m$, null, false, false, 11
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$peanut butter, natural unsweetened$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 900, $m$ml$m$, $m$3¾ cups$m$, null, false, false, 12
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$chicken stock$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 260, $m$g$m$, $m$260–330 g$m$, $m$3 cm chunks$m$, false, false, 13
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$sweet potato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 60, $m$g$m$, $m$2 packed cups$m$, null, false, false, 14
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$baby spinach$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 8, $m$g$m$, $m$8–10 g / ¼ cup loosely packed$m$, null, false, false, 15
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$cilantro, fresh$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 5, $m$g$m$, $m$5–7 g / 1–1½ tsp$m$, null, false, false, 16
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 30, $m$ml$m$, $m$30–45 ml / 2–3 tbsp$m$, null, false, false, 17
from public.dish d, public.ingredient i where d.slug=$m$maafe-chicken-peanut-stew$m$ and i.name=$m$lime juice$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maafe-steamed-rice$m$,$m$Steamed Rice$m$,null,array[$m$Side$m$]::text[],'{}'::text[],null,'{}'::text[],array[$m$Family$m$,$m$Weeknight$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Cooking Project — May 2026$m$,null,$m$Neutral fluffy long-grain rice as the soft starch carrier under the stew.$m$,$m$## Dish 2 — Steamed Rice
Neutral fluffy starch carrier. Meal carve-out: soft neutral contrast against rich stew.
**Yield:** 4 servings \| **Active:** 5 min \| **Total:** 25 min \| **Hold:** 25 min covered off heat
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Amount</td>
</tr>
<tr>
<td>Long-grain white rice</td>
<td>200 g</td>
</tr>
<tr>
<td>Water</td>
<td>240 ml / 1 cup</td>
</tr>
<tr>
<td>Diamond Crystal kosher salt</td>
<td>1 g / ¼ tsp</td>
</tr>
</table>
**Method:** Rinse until mostly clear. Combine rice, water, salt. Boil (high). Cover → very low, 12–15 min. Rest covered 10 min. Do not lift lid during rest. Fluff before serving.
**Doneness:** Chalky center → continue. Fully tender grain → stop.
**CCPs:** Lifting lid early (steam breaks → uneven texture; re-cover immediately). Insufficient rinsing (sticky texture; unrecoverable).
**Scaling:** At 800 g+, increase water ratio slightly; extend low-heat phase 3–5 min.$m$,4,'{}'::text[],$m$[]$m$::jsonb,null,$m$362e0391ce6381dbb0fadf943507132d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 200, $m$g$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maafe-steamed-rice$m$ and i.name=$m$long-grain white rice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 240, $m$ml$m$, $m$1 cup$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$maafe-steamed-rice$m$ and i.name=$m$water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$g$m$, $m$¼ tsp$m$, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$maafe-steamed-rice$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maafe-tomato-cucumber-lime-salad$m$,$m$Tomato–Cucumber Lime Salad$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],'{}'::text[],null,'{}'::text[],array[$m$Family$m$,$m$Weeknight$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Cooking Project — May 2026$m$,null,$m$Fresh acidic palate reset of soft tomato and crisp cucumber dressed with lime.$m$,$m$## Dish 3 — Tomato–Cucumber Lime Salad
Fresh acidic palate reset. Textures: soft tomato + crisp cucumber.
**Yield:** 4 servings \| **Active:** 15 min \| **Total:** 25 min \| **Hold:** 30 min room temp
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Amount</td>
</tr>
<tr>
<td>Tomatoes</td>
<td>2 medium</td>
</tr>
<tr>
<td>Cucumber</td>
<td>1 medium</td>
</tr>
<tr>
<td>Red onion</td>
<td>¼</td>
</tr>
<tr>
<td>Lime juice</td>
<td>22 ml / 1½ tbsp</td>
</tr>
<tr>
<td>Diamond Crystal kosher salt</td>
<td>2–3 g / ½–¾ tsp</td>
</tr>
<tr>
<td>Olive oil (optional)</td>
<td>15 ml / 1 tbsp</td>
</tr>
</table>
**Method:** Cut tomatoes into wedges. Slice cucumber and onion thinly. Toss. Rest 10–15 min. Drain pooled liquid; re-season with lime and salt before serving.$m$,4,'{}'::text[],$m$[]$m$::jsonb,null,$m$362e0391ce6381dbb0fadf943507132d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, $m$2 medium$m$, $m$cut into wedges$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maafe-tomato-cucumber-lime-salad$m$ and i.name=$m$tomato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$1 medium$m$, $m$sliced thinly$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$maafe-tomato-cucumber-lime-salad$m$ and i.name=$m$cucumber$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$piece$m$, $m$¼$m$, $m$sliced thinly$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$maafe-tomato-cucumber-lime-salad$m$ and i.name=$m$red onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 22, $m$ml$m$, $m$1½ tbsp$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$maafe-tomato-cucumber-lime-salad$m$ and i.name=$m$lime juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$g$m$, $m$2–3 g / ½–¾ tsp$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$maafe-tomato-cucumber-lime-salad$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$ml$m$, $m$1 tbsp$m$, null, false, true, 6
from public.dish d, public.ingredient i where d.slug=$m$maafe-tomato-cucumber-lime-salad$m$ and i.name=$m$olive oil$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maafe-birds-eye-chilli-paste$m$,$m$Bird's Eye Chilli Paste$m$,$m$Veg$m$,array[$m$Sauce$m$]::text[],'{}'::text[],null,'{}'::text[],array[$m$Family$m$,$m$Weeknight$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Cooking Project — May 2026$m$,null,$m$Coarse pounded bird's eye chilli paste for external heat control against the smooth stew.$m$,$m$## Dish 4 — Bird's Eye Chilli Paste
Coarse-textured external heat control. Meal carve-out: heat + texture contrast against smooth stew.
**Yield:** \~60 ml \| **Active:** 5 min \| **Hold:** 4 hrs ambient
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Amount</td>
</tr>
<tr>
<td>Bird's eye chillies</td>
<td>4–6</td>
</tr>
<tr>
<td>Shallot</td>
<td>1 small</td>
</tr>
<tr>
<td>Garlic clove</td>
<td>1</td>
</tr>
<tr>
<td>Diamond Crystal kosher salt</td>
<td>1–2 g / ¼–½ tsp</td>
</tr>
<tr>
<td>Neutral oil</td>
<td>15 ml / 1 tbsp</td>
</tr>
<tr>
<td>Lime juice</td>
<td>10–15 ml / 2–3 tsp</td>
</tr>
</table>
**Method:** Remove stems; rough chop shallot and garlic. Pound into coarse paste. Stir in oil + lime. Do not blend smooth.$m$,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$362e0391ce6381dbb0fadf943507132d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$piece$m$, $m$4–6$m$, $m$stems removed$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maafe-birds-eye-chilli-paste$m$ and i.name=$m$bird's eye chilli$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$1 small$m$, $m$rough chopped$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$maafe-birds-eye-chilli-paste$m$ and i.name=$m$shallot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$clove$m$, null, $m$rough chopped$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$maafe-birds-eye-chilli-paste$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$g$m$, $m$1–2 g / ¼–½ tsp$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$maafe-birds-eye-chilli-paste$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$ml$m$, $m$1 tbsp$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$maafe-birds-eye-chilli-paste$m$ and i.name=$m$neutral oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 10, $m$ml$m$, $m$10–15 ml / 2–3 tsp$m$, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$maafe-birds-eye-chilli-paste$m$ and i.name=$m$lime juice$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maafe-crushed-roasted-peanuts$m$,$m$Crushed Roasted Peanuts$m$,null,array[$m$Side$m$]::text[],'{}'::text[],null,'{}'::text[],array[$m$Family$m$,$m$Weeknight$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Cooking Project — May 2026$m$,null,$m$Crushed roasted peanut garnish — the meal's primary crunch axis.$m$,$m$## Dish 5 — Crushed Roasted Peanuts
Crunch garnish. Meal carve-out: primary crunch axis for the meal.
**Yield:** 80–100 g \| **Active:** 2 min \| **Hold:** Stable
- Roasted unsalted peanuts: 80–100 g
**Method:** Crush into rough irregular pieces. Do not pulverize. Apply immediately before serving — moisture softens within 2–3 min of plating.$m$,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$362e0391ce6381dbb0fadf943507132d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 80, $m$g$m$, $m$80–100 g$m$, $m$crushed into rough irregular pieces$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maafe-crushed-roasted-peanuts$m$ and i.name=$m$roasted unsalted peanuts$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maafe-chilled-pineapple-lime-flaky-salt$m$,$m$Chilled Pineapple with Lime & Flaky Salt$m$,null,array[$m$Dessert$m$]::text[],'{}'::text[],null,'{}'::text[],array[$m$Family$m$,$m$Weeknight$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Cooking Project — May 2026$m$,null,$m$Cold acidic finish of chilled pineapple with lime and flaky salt, functioning as a palate cleanse.$m$,$m$## Dish 6 — Chilled Pineapple with Lime & Flaky Salt
Cold acidic finish. Textures: cold yielding fruit + crystalline flaky salt crunch. Functions as palate cleanse, not richness escalation.
**Yield:** 4 servings \| **Active:** 10 min \| **Chill:** 20–30 min \| **Hold:** 2 hrs chilled
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Amount</td>
</tr>
<tr>
<td>Ripe pineapple</td>
<td>1</td>
</tr>
<tr>
<td>Lime juice</td>
<td>15–22 ml / 1–1½ tbsp</td>
</tr>
<tr>
<td>Flaky sea salt</td>
<td>Small pinch</td>
</tr>
<tr>
<td>Chilli flakes (optional)</td>
<td>Micro pinch</td>
</tr>
</table>
**Method:** Peel fully; remove eyes; cut into spears or chunks. Toss with lime juice. Chill 20–30 min. Remove 10 min before serving if over-chilled. Flaky salt immediately before serving.
**CCP:** Over-chilling (muted aroma → flat dessert; rest 10–15 min at room temp).$m$,4,'{}'::text[],$m$[]$m$::jsonb,null,$m$362e0391ce6381dbb0fadf943507132d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$peeled, eyes removed, cut into spears or chunks$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maafe-chilled-pineapple-lime-flaky-salt$m$ and i.name=$m$pineapple, ripe$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$ml$m$, $m$15–22 ml / 1–1½ tbsp$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$maafe-chilled-pineapple-lime-flaky-salt$m$ and i.name=$m$lime juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$small pinch$m$, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$maafe-chilled-pineapple-lime-flaky-salt$m$ and i.name=$m$flaky sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$micro pinch$m$, null, false, true, 4
from public.dish d, public.ingredient i where d.slug=$m$maafe-chilled-pineapple-lime-flaky-salt$m$ and i.name=$m$chilli flakes$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$west-african-peanut-stew-dinner$m$ and d.slug=$m$maafe-chicken-peanut-stew$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$west-african-peanut-stew-dinner$m$ and d.slug=$m$maafe-steamed-rice$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$west-african-peanut-stew-dinner$m$ and d.slug=$m$maafe-tomato-cucumber-lime-salad$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$west-african-peanut-stew-dinner$m$ and d.slug=$m$maafe-birds-eye-chilli-paste$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 5 from public.meal m, public.dish d where m.slug=$m$west-african-peanut-stew-dinner$m$ and d.slug=$m$maafe-crushed-roasted-peanuts$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$dessert$m$::dish_role, 6 from public.meal m, public.dish d where m.slug=$m$west-african-peanut-stew-dinner$m$ and d.slug=$m$maafe-chilled-pineapple-lime-flaky-salt$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-05-17$m$::date, null, null, null, $m$## Post-Cook Update — 17 May 2026
- **Last Made:** 17 May 2026
- **Rating:** 9.5 / 10
- **Execution Rating:** 9 / 10
- **Repeat?:** Yes
- **Cook Notes:** All family liked it. Chilli paste quite spicy but adds a nice kick to the stew. Chicken skin crisping adds complexity without sufficient depth payoff — eliminated; discard only. Rice portion too large given how filling the stew is — reduced to 200g / 4 servings. Opened Felton Road Bannockburn Pinot Noir 2022 — went quite well.
- **Wine pairing outcome:** Felton Road Bannockburn Pinot Noir 2022 — went quite well with the meal.
- **Household split:** None — unanimous$m$, $m$["Chicken skin crisping eliminated — skin discarded after sear rather than crisped", "Rice portion reduced to 200 g / 4 servings"]$m$::jsonb, $m$[]$m$::jsonb, $m$None — unanimous$m$, $m$Felton Road Bannockburn Pinot Noir 2022 — went quite well with the meal.$m$ from public.meal m where m.slug=$m$west-african-peanut-stew-dinner$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-09-13$m$::date, 9.5, 8.5, $m$yes$m$::repeat_verdict, $m$Cook 2 (13 Sep 2026) — 2x batch, kabocha (Beibei mini-kabocha) replacing sweet potato, whole okra added. Rating 9.5/10, matching cook 1. Noted as slightly less filling than the sweet potato version. Alheit Hereafter Here Chenin Blanc 2022 paired well. Primary execution defect: the Step 5 chicken doneness cue (firm thumb pressure on flesh alongside the bone) is not performable — the thigh is too hot to touch straight from the braise. Cue requires replacement with a tool-based test. Cook 1 (17 May 2026) — Rating 9.5/10, Execution 9/10, unanimous. Chicken skin crisping eliminated; rice reduced to 200 g / 4 servings. See dated Post-Cook Update sections for full evidence.

## Post-Cook Update — 13 September 2026
**Recipe version used:** Claude / Cooking Project — Sep 2026 reconciled build (2x batch, kabocha + okra variant). Governance snapshot v3.5 / 2026-07-20. Distinct from the cook 1 recipe above; this variant replaces sweet potato with kabocha and adds whole okra.
- **Last Made:** 13 September 2026
- **Times Made:** 2
- **Rating:** 9.5 / 10
- **Execution Rating:** 8.5 / 10 (down from 9.0 at cook 1 — attributable to the unperformable doneness cue)
- **Repeat?:** Yes
### Cook Notes
Second rendition rated 9.5/10, matching cook 1 despite a materially different vegetable architecture. Noted as slightly less filling than the sweet potato version — kabocha is lighter in the bowl than sweet potato at comparable volume, which is a point in the variant's favour given the cook 1 finding that the stew was over-filling relative to its rice portion. The kabocha-and-okra variant is therefore not merely an equal substitute but a plausible improvement on the meal's overall weight.
Principal execution defect was the Step 5 chicken doneness cue. Retained from cook 1, it directs firm thumb pressure on the flesh alongside the bone. In practice the thigh comes straight out of a simmering braise and is too hot to touch, making the cue unperformable as written. This is a recipe defect rather than a cook error: the cue was never validated against the physical conditions in which it must be executed. Replacement cue proposed below.
### Actual Deviations
- **Squash:** Beibei mini-kabocha (贝贝南瓜) in place of standard kabocha. Denser, sweeter, drier flesh than ordinary kabocha. Portion of skin carried brown corky patching and was pared off; flesh beneath confirmed firm and sound. Peeled chunks cut larger to compensate for lost structural binding.
- **Tomatoes:** canned whole peeled, hand-crushed, in place of canned crushed. Tomato development step extended to compensate for higher free-water content.
- **Peanuts:** blanched raw peanuts roasted in-house at 160°C rather than bought pre-roasted.
- **Rice:** Japanese short-grain in the Tiger rice cooker, cooked without salt, replacing stovetop long-grain. Removed rice from the critical path entirely — the cooker's hold function eliminates the timing window that could previously be missed.
- **Spinach:** frozen chopped, thawed and squeezed, in place of fresh baby spinach.
- **Okra:** whole small pods, cap trimmed without breaching the pod, added late.
### Wine Pairing Outcome
Alheit Vineyards Hereafter Here Chenin Blanc 2022 — paired well. Confirms the cook 1 finding that high-acid Chenin is the stronger style match for this dish than a red: the acid cuts peanut fat without the tannin penalty that lime and squash sweetness impose on structured reds. Chenin Blanc should be treated as the default pairing for this dish going forward.
### Designed-Parameter Confirmation
Six parameters were carried into this cook labelled designed rather than validated. Measurements were not captured during service and remain outstanding:
<table header-row="true">
<tr>
<td>#</td>
<td>Parameter</td>
<td>Status</td>
</tr>
<tr>
<td>1</td>
<td>Kabocha time from entry to doneness cue</td>
<td>Not captured</td>
</tr>
<tr>
<td>2</td>
<td>Okra exposure, active and residual; acceptability of firm-at-service</td>
<td>Not captured</td>
</tr>
<tr>
<td>3</td>
<td>2x evaporation in the wide vessel; reserved stock add-back</td>
<td>Not captured</td>
</tr>
<tr>
<td>4</td>
<td>Freezer hold for a vegetable-free reserve — RETIRED. Never tested; diversion removed from the design at Jin's direction, 14 Sep 2026. Does not carry forward.</td>
<td>Not captured</td>
</tr>
<tr>
<td>5</td>
<td>Skin-on sear value versus skin-off-first</td>
<td>Not captured</td>
</tr>
<tr>
<td>6</td>
<td>Lime multiplicity — coherent or repetitive across four components</td>
<td>Not captured</td>
</tr>
</table>
Per governance, a designed parameter not checked against a real cook stays designed. Parameters 1, 2, 3, 5 and 6 remain designed and carry forward to cook 3. Parameter 4 is retired rather than carried — see below.
### Recipe Defects Identified — Carried to Governance Change Queue
1. **Chicken doneness cue unperformable.** Thumb-pressure test cannot be executed on braise-hot protein. Replacement: tongs-based bone-twist as primary cue, skewer-resistance as confirmation.
2. **Body salt never placed in the method.** The ingredient table splits salt between the aromatic base and the stew body, but no step directs when the body salt is added. Fix: place it at the stock addition, with the balance held back for a final off-heat taste before lime.
3. **Reserve cooling instruction self-contradictory.** The standing household rule against cooling to room temperature invited sealing hot stew into containers. Fix: separate the cooling trajectory requirement from the covering instruction.
4. **Salt given in grams only.** Unusable without a scale. Fix: dual units with an explicit brand caveat, as lime already carries.
5. **Squash skin condition assumed uniform.** No triage instruction for corky or damaged skin, and no adjustment for peeled chunks. Fix: add skin triage plus a larger chunk size and earlier check for any chunk peeled.
6. **Reserved stock purpose unstated.** Held-back stock appears in the ingredient table with no explanation of its role as a correction reserve rather than a scheduled addition.
7. **Cilantro preparation unspecified.** No chop instruction, and no split between the portion cooked into the stew and the portion reserved for plating.
8. **Crushed tomatoes assumed available.** Frequently out of stock. Hand-crushed whole peeled should become the stated default rather than a substitution.
9. **Peanut roasting not addressed.** Self-roasting from blanched raw is better than bought pre-roasted and is a day-before task that should sit outside the cook-day timeline.
10. **Rice method superseded.** Rice cooker is better than stovetop for this meal and removes a component from the critical path.
### Reserve Diversion — Not Performed, Then Retired
No reserve was diverted. The full 2x batch was finished in one pot with kabocha, okra, spinach, lime, and cilantro applied to the whole volume.
**Retired from the design, 14 Sep 2026, at Jin's direction.** The diversion architecture is removed from this recipe and is not carried forward to cook 3. The dish scored 9.5 cooked as a single pot, matching cook 1, so the architecture cannot be shown to have been necessary. The record below is retained as evidence of what was designed and what happened; it is no longer a prescription.
What the cook establishes, and what it does not:
- The diversion architecture was never exercised, so nothing is known about whether it would have worked. It is retired unvalidated rather than rejected on evidence.
- Leftovers therefore carried finished vegetables and herbs, which degrade in storage. Kabocha softens, okra deteriorates within a day, lime brightness fades. With the diversion retired, this becomes the expected leftover profile for this dish rather than a shortfall against a better alternative — the finish is rebuilt fresh at reheat instead.
- Kabocha and spinach quantities were specified for a diverted half and were therefore proportionally light against the full volume. This may have contributed to the dish reading less filling than the sweet potato version — the observation could be a vegetable-density effect rather than a kabocha-versus-sweet-potato effect. Not separable from this cook's evidence. **Action for cook 3: specify kabocha and spinach against the full batch volume, since there is no longer a diverted half to size for.**
### Portion Consumption — First Recorded Split
Batch built on 9 bone-in thighs. Consumption at the served meal:
<table header-row="true">
<tr>
<td>Diner</td>
<td>Thighs</td>
</tr>
<tr>
<td>Lukas</td>
<td>3</td>
</tr>
<tr>
<td>Hui Fong</td>
<td>1</td>
</tr>
<tr>
<td>Jin</td>
<td>1</td>
</tr>
<tr>
<td>**Consumed**</td>
<td>**5 of 9**</td>
</tr>
<tr>
<td>**Left over**</td>
<td>**4**</td>
</tr>
</table>
All okra was consumed — no portion returned to the pot, and no adverse comment on texture. Firm-at-service was evidently acceptable, though the okra was not separately assessed.
**Scaling implication.** The 2x batch was sized on an implicit assumption of roughly equal adult-scale portions across three diners. Actual intake is strongly asymmetric: Lukas consumed three times either adult's share and is the volume driver for this dish. At 9 thighs the batch yields one family dinner plus roughly a Lukas portion and one adult portion — a modest remainder, not the substantial reserve the 2x scale was designed to produce. With the diversion retired, batch size is the only lever left: 9 thighs for one dinner with light leftovers, 12–14 for a genuine second meal.
This is the first cook at which per-diner consumption has been recorded. Treat as a single data point until confirmed at cook 3 — a growing child's intake is not a stable parameter.
### Leftover Handling — 14 September 2026
Remainder refrigerated promptly after service; cooling requirement met. Reheated as finished stew. The diversion architecture was not used and has since been retired, so this is the standing leftover method for the dish.
- Reheated low, lid off, loosened with hot stock in 50 ml increments — the stew tightens materially overnight as the peanut emulsion and kabocha starch both set cold.
- Finish rebuilt at reheat: fresh lime off heat, fresh cilantro, fresh crushed peanuts at the bowl. Overnight storage dulls lime brightness noticeably, and this version already ran at the upper end of the lime range.
- Spinach flat on reheat — no corrective available.
- Kabocha expected at or past the collapse point after overnight storage. With the diversion retired, this is simply the accepted leftover profile for the dish — softened squash in a reheated stew, with the finish rebuilt fresh at the bowl.
### Household Split
None on the dish itself — unanimous, as at cook 1. Portion split recorded above is appetite, not preference.$m$, $m$["Squash: Beibei mini-kabocha (贝贝南瓜) in place of standard kabocha; corky skin pared off, peeled chunks cut larger", "Tomatoes: canned whole peeled, hand-crushed, in place of canned crushed; tomato development step extended", "Peanuts: blanched raw peanuts roasted in-house at 160°C rather than bought pre-roasted", "Rice: Japanese short-grain in the Tiger rice cooker, cooked without salt, replacing stovetop long-grain", "Spinach: frozen chopped, thawed and squeezed, in place of fresh baby spinach", "Okra: whole small pods, cap trimmed without breaching the pod, added late", "2x batch; kabocha replacing sweet potato; whole okra added (Sep 2026 reconciled build variant)", "Reserve diversion designed but not performed — full 2x batch finished in one pot; diversion retired 14 Sep 2026"]$m$::jsonb, $m$[{"param": "Kabocha time from entry to doneness cue", "designed": "Designed, not validated", "observed": "Not captured", "verdict": "unresolved"}, {"param": "Okra exposure, active and residual; acceptability of firm-at-service", "designed": "Designed, not validated", "observed": "Not captured; all okra consumed, no adverse comment", "verdict": "unresolved"}, {"param": "2x evaporation in the wide vessel; reserved stock add-back", "designed": "Designed, not validated", "observed": "Not captured", "verdict": "unresolved"}, {"param": "Freezer hold for a vegetable-free reserve", "designed": "Designed, not validated", "observed": "Not captured — retired 14 Sep 2026, never tested", "verdict": "unresolved"}, {"param": "Skin-on sear value versus skin-off-first", "designed": "Designed, not validated", "observed": "Not captured", "verdict": "unresolved"}, {"param": "Lime multiplicity — coherent or repetitive across four components", "designed": "Designed, not validated", "observed": "Not captured", "verdict": "unresolved"}, {"param": "Step 5 chicken doneness cue (firm thumb pressure on flesh alongside the bone)", "designed": "Performable at braise end", "observed": "Not performable — thigh too hot to touch straight from the braise", "verdict": "diverged"}]$m$::jsonb, $m$None on the dish itself — unanimous, as at cook 1. Portion split recorded above is appetite, not preference. (Thighs consumed: Lukas 3, Hui Fong 1, Jin 1 — 5 of 9; 4 left over.)$m$, $m$Alheit Vineyards Hereafter Here Chenin Blanc 2022 — paired well. Confirms the cook 1 finding that high-acid Chenin is the stronger style match for this dish than a red; Chenin Blanc should be treated as the default pairing going forward.$m$ from public.meal m where m.slug=$m$west-african-peanut-stew-dinner$m$;
commit;
