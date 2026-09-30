begin;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$plum-galette$m$,$m$Plum Galette$m$,null,array[$m$Dessert$m$]::text[],array[$m$French$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$NYTimes / ChatGPT$m$,null,$m$A free-form plum galette on a sweet tart crust, finished with an apricot jam glaze.$m$,$m$**Best With:** Duck, pork belly, braised beef, lamb shanks

---
## Ingredients
- 1 disk **sweet tart crust**, chilled
- **5–6 medium plums** (≈450–500 g), ripe but firm
- **¼ cup (50 g) sugar**, plus more for sprinkling
- **1/16 tsp ground nutmeg** *(small pinch)*
- **1–1½ tsp cornstarch**
- **2 tbsp cold salted butter**, diced
- **2 tbsp heavy cream**
- **2 tbsp apricot jam**
- Flour, for rolling
---
## Method
1. **Preheat oven to 200°C / 400°F.**
2. Halve and pit plums. Cut into **thick wedges**.
3. In a bowl, toss plums with:
	- sugar
	- nutmeg
	- cornstarch
4. Roll dough on a lightly floured surface into an **11-inch circle**. Transfer to a parchment-lined baking tray.
5. Arrange plums on dough, cut-side up, leaving a **2-inch border**.
6. Dot fruit with butter.
7. Fold edges up over fruit. Brush crust with cream and sprinkle lightly with sugar.
8. Bake **35–40 minutes**, until crust is deeply golden and juices are bubbling.
9. Warm apricot jam and strain. Brush lightly over fruit.
10. Cool **15 minutes** before slicing.
---
## Serving
- Serve **warm or room temperature**
- Best with **crème fraîche** or lightly whipped cream
- Avoid ice cream (too heavy for this style)
---
## Notes
- Add **orange zest** if you want a brighter finish
- Keeps well refrigerated for **2 days**
- Reheat briefly at 160°C / 325°F
$m$,null,array[$m$parchment-lined baking tray$m$]::text[],$m$[]$m$::jsonb,null,$m$2dbe0391ce63804f9755fa6a9721427f$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$1 disk, chilled$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$sweet tart crust$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 5, $m$piece$m$, $m$≈450–500 g$m$, $m$5–6 medium, ripe but firm; halved, pitted, cut into thick wedges$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$plum$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 50, $m$g$m$, $m$¼ cup$m$, $m$plus more for sprinkling$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.0625, $m$tsp$m$, null, $m$1/16 tsp, small pinch$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$ground nutmeg$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, $m$1–1½ tsp$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$cornstarch$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$cold, diced$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$salted butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$heavy cream$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$apricot jam$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$for rolling$m$, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$plum-galette$m$ and i.name=$m$flour$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-01-01$m$::date, 9, null, null, null, $m$["cook date unknown — page creation date used"]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$plum-galette$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$pork-rack-chop-sunday$m$,$m$Pork Rack Chop Sunday$m$,$m$2026-08-30$m$,$m$cooked$m$::meal_status,3,null,null,$m$2021 Château Mont-Redon Châteauneuf-du-Pape — worked well. Note: recommended against pre-cook, see cook record.$m$,null);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$pork-rack-chop-reverse-seared$m$,$m$Reverse-Seared Bone-In Pork Rack Chop$m$,$m$Pork$m$,array[$m$Main$m$]::text[],array[$m$European$m$]::text[],$m$Special$m$,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Governance Framework v3.5 — generated 2026-08-30. Butcher Box Singapore, Gooralie Free Range Pork Cutlets.$m$,$m$v3.5$m$,$m$Reverse-seared Gooralie free-range bone-in pork rack chop (7 cm), same-day 3 hr dry brine at 0.8%, low-roasted to 133°F/56°C at 225°F/107°C then seared, served with mustard-thyme pan sauce, braised red cabbage, crushed potatoes and charred tenderstem broccoli.$m$,null,3,array[$m$Bosch single oven$m$,$m$rack over tray$m$,$m$outdoor gas$m$]::text[],$m$[{"param": "Sear gain from 133°F/56°C", "designed_value": "not measured", "note": "Temperature entering the pan, reading at the stop and total contact time not captured. Remains designed rather than validated; carries forward to the next pork cook."}, {"param": "Carryover across the 7-minute post-sear rest onto warmed plates", "designed_value": "not measured", "note": "Direction and magnitude not recorded. Remains designed rather than validated."}, {"param": "Potato crisping window in fat over outdoor gas", "designed_value": "24 min", "note": "Too long at this quantity and heat level; revise downward or specify a lower flame."}]$m$::jsonb,null,$m$3cce0391ce63819f9e7ec05979bd0ed6$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$pork-rack-chop-braised-red-cabbage$m$,$m$Braised Red Cabbage with Apple and Juniper$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$European$m$]::text[],$m$Easy$m$,array[$m$Make-Ahead$m$]::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Governance Framework v3.5 — generated 2026-08-30, as the acid-relief component of the pork chop menu.$m$,$m$v3.5$m$,$m$Braised red cabbage with apple and juniper, built on staged red wine vinegar (30 ml opening / 15 ml reserved), brown sugar, bay and butter in a narrow Le Creuset, as the acid-relief component of the pork chop menu.$m$,null,3,array[$m$narrow Le Creuset$m$]::text[],$m$[{"param": "Hold ceiling for a chilled-then-reheated batch", "designed_value": "45 minutes covered off heat", "note": "Should stand for the chilled-then-reheated case until separately tested; the afternoon-braise warm hold is a different configuration."}, {"param": "Day-ahead braise as a quality requirement", "designed_value": "day-ahead braise, cooled, refrigerated, 15-minute induction reheat at E+2", "note": "Same-day braise with an extended warm hold rated 9.5; worth one more cook before treating as settled."}]$m$::jsonb,null,$m$3cce0391ce63818ebbd6e0fddb15f13a$m$);
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$pork-rack-chop-sunday$m$ and d.slug=$m$pork-rack-chop-reverse-seared$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$pork-rack-chop-sunday$m$ and d.slug=$m$pork-rack-chop-braised-red-cabbage$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-08-30$m$::date, null, null, null, $m$Menu: chop, mustard-thyme pan sauce, braised red cabbage, crushed potatoes, charred tenderstem broccoli. Crackling omitted — cutlets arrived without rind. Served to 3.$m$, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, $m$2021 Château Mont-Redon Châteauneuf-du-Pape — worked well. Recommended against pre-cook; see the chop cook record.$m$ from public.meal m where m.slug=$m$pork-rack-chop-sunday$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-08-30$m$::date, 9.5, 8.5, $m$yes$m$::repeat_verdict, $m$First cook. Chop measured 7 cm, well outside the 4 cm design assumption; low roast to 133°F/56°C took approx. 90 min at 225°F/107°C from fridge-cold. Same-day 3 hr dry brine at 0.8% produced even seasoning through the cut. Sear produced full crust with no adjustment. Potatoes pulled ahead of the 24 min spec to avoid scorching. Sear gain and carryover not measured — both remain untested.

## Cook record — 2026-08-30
**Recipe version:** Governance Framework v3.5, docx generated 2026-08-30 (single-cutlet variant of the two-chop plan).
**Ratings:** Flavour 9.5 · Execution 8.5 · Repeat: Yes
### What was actually cooked
Gooralie Free Range pork cutlets, Butcher Box Singapore. Pack of 2, 1.530 kg gross, S\$39.90/kg, S\$61.05. **One cutlet cooked, measured 7 cm thick.** Second cutlet (approx. 5 cm) held raw, unsalted, use-by 2 September.
Served to 3. Menu: chop, mustard-thyme pan sauce, braised red cabbage, crushed potatoes, charred tenderstem broccoli. Crackling omitted — cutlets arrived without rind.
### Material deviations from the written plan
<table header-row="true">
<tr>
<td>Deviation</td>
<td>Detail</td>
</tr>
<tr>
<td>Chop geometry</td>
<td>7 cm actual vs 4 cm designed. Single cutlet rather than two.</td>
</tr>
<tr>
<td>Low-roast duration</td>
<td>Approx. 90 min vs 55–80 min band.</td>
</tr>
<tr>
<td>Shallot</td>
<td>Omitted from the sauce — none in the house. Pre-reduction run without it.</td>
</tr>
<tr>
<td>Potato fat</td>
<td>Duck fat or olive oil substituted; no rind, so no rendered pork fat.</td>
</tr>
<tr>
<td>Potato crisping</td>
<td>Pulled ahead of the 24 min spec to prevent scorching.</td>
</tr>
<tr>
<td>Cabbage</td>
<td>Afternoon braise, held on the stove rather than chilled and reheated. Reheat step not used.</td>
</tr>
<tr>
<td>Wine</td>
<td>2021 Mont-Redon CdP, contrary to the pre-cook recommendation.</td>
</tr>
</table>
### Designed-parameter confirmation
**Confirmed for this configuration** (7 cm bone-in loin cutlet, single piece, fridge-cold, rack over tray, Bosch single oven at 225°F/107°C):
- **Low-roast duration to 133°F/56°C: approx. 90 min.** The design table projected 160 min+ at 7 cm. Actual came in far shorter, indicating the thickness-to-duration scaling used in planning was too aggressive. Valid only for this geometry and equipment state.
- **Same-day dry brine, approx. 3 hr at 0.8% of gross weight, uncovered on a rack in the fridge.** Produced seasoning that read through the cut rather than surface-weighted. The concern that a 3 hr window would under-season is not supported by this cook.
- **8-minute pre-sear rest followed by a colour-led sear.** Crust formed without difficulty. The rest dried the surface sufficiently.
- **Exit-anchored convergence architecture.** The last phase keyed to oven exit rather than clock time executed without a timing failure.
**Failed or revised:**
- **Potato crisping window, 24 min in fat over outdoor gas.** Too long at this quantity and heat level; scorching was imminent and the pan was pulled early. Revise downward or specify a lower flame on the next cook.
**Still untested — not measured this cook:**
- **Sear gain from 133°F/56°C.** The endpoint was reached and the crust formed, but the temperature entering the pan, the reading at the stop, and total contact time were not captured. The good outcome does not establish the magnitude of the rise.
- **Carryover direction and magnitude across the 7-minute post-sear rest onto warmed plates.** Not recorded. The salmon finding of negative carryover onto room-temperature plates remains unresolved for pork.
Both remain designed rather than validated and carry forward to the next pork cook.
### Wine pairing outcome
**2021 Château Mont-Redon Châteauneuf-du-Pape — worked well.**
This was recommended *against* before the cook, on the grounds that it would be warm and broad where the plate needed lift. That reasoning was wrong. The screen over-weighted the red cabbage's vinegar as a tannin problem and under-weighted that a Grenache-led CdP is soft-tannin — which was the actual criterion. Soft tannin plus moderate acid handled the sweet-sour cabbage without the metallic clash that was predicted.
**Pairing principle to carry forward:** for a vinegar-forward side, screen on tannin structure rather than on body or weight. A broad, warm red with resolved soft tannins is not disqualified.
### Cellar data failure
The pre-cook recommendation drew from the live cellar export at `jins-cellar-data/main/cellar.md`, snapshot dated 2026-08-30. Two bottles recommended from it — 2023 Marcel Lapierre Morgon and 2019 La Rioja Alta Viña Ardanza Reserva — were not in the rack. CellarTracker was confirmed current, so the fault is in the Supabase-to-markdown sync, not refresh timing. **The export cannot be treated as authoritative until this is resolved.**
### Next time
1. **Measure the sear.** Temperature entering the pan, temperature at the stop, total contact time. This is the single most valuable number outstanding.
2. **Measure carryover** across the post-sear rest, and record plate temperature alongside it.
3. **Shorten or cool the potato crisping stage.** 24 min at that heat is too long.
4. **The 5 cm leftover cutlet is a free second data point.** Cooking it gives a second thickness against the same method and equipment, which would let the low-roast band be modelled rather than guessed.
5. Reconfirm chop thickness at the counter before planning — 7 cm against a 4 cm assumption moved the oven load by roughly half an hour and was only absorbed because service was designed to float.
## Cross-reference — 2026-09-27
**Scope limit on the validated pre-sear rest.** The 8-minute pre-sear rest confirmed above applies to the 7 cm configuration only. On a 3.5 cm dry-aged loin at the same oven setting, the loin *lost* 8–14°F over the same rest (130°F pull → 115.9°F and 122°F), and the subsequent sear overshot. For loin ≤4 cm, sear straight from the oven. Full record: <mention-page url="https://app.notion.com/p/3e8e0391ce6381bda0aac8b72a48748f"/>$m$, $m$["Chop geometry: 7 cm actual vs 4 cm designed. Single cutlet rather than two.", "Low-roast duration: Approx. 90 min vs 55–80 min band.", "Shallot: Omitted from the sauce — none in the house. Pre-reduction run without it.", "Potato fat: Duck fat or olive oil substituted; no rind, so no rendered pork fat.", "Potato crisping: Pulled ahead of the 24 min spec to prevent scorching.", "Cabbage: Afternoon braise, held on the stove rather than chilled and reheated. Reheat step not used.", "Wine: 2021 Mont-Redon CdP, contrary to the pre-cook recommendation.", "Crackling omitted — cutlets arrived without rind."]$m$::jsonb, $m$[{"param": "Low-roast duration to 133°F/56°C (7 cm bone-in loin cutlet, single piece, fridge-cold, 225°F/107°C)", "designed": "design table projected 160 min+ at 7 cm (55–80 min band at 4 cm)", "observed": "approx. 90 min — thickness-to-duration scaling too aggressive", "verdict": "diverged"}, {"param": "Same-day dry brine, approx. 3 hr at 0.8% of gross weight, uncovered on a rack in the fridge", "designed": "even seasoning", "observed": "seasoning read through the cut rather than surface-weighted", "verdict": "confirmed"}, {"param": "8-minute pre-sear rest followed by a colour-led sear", "designed": "crust forms; rest dries the surface", "observed": "crust formed without difficulty", "verdict": "confirmed"}, {"param": "Exit-anchored convergence architecture", "designed": "last phase keyed to oven exit rather than clock time", "observed": "executed without a timing failure", "verdict": "confirmed"}, {"param": "Potato crisping window, 24 min in fat over outdoor gas", "designed": "24 min", "observed": "scorching imminent; pan pulled early", "verdict": "diverged"}, {"param": "Sear gain from 133°F/56°C", "designed": "not stated", "observed": "not captured", "verdict": "unresolved"}, {"param": "Carryover across the 7-minute post-sear rest onto warmed plates", "designed": "not stated", "observed": "not recorded", "verdict": "unresolved"}]$m$::jsonb, null, $m$2021 Château Mont-Redon Châteauneuf-du-Pape — worked well. This was recommended against before the cook, on the grounds that it would be warm and broad where the plate needed lift. That reasoning was wrong. The screen over-weighted the red cabbage's vinegar as a tannin problem and under-weighted that a Grenache-led CdP is soft-tannin — which was the actual criterion. Soft tannin plus moderate acid handled the sweet-sour cabbage without the metallic clash that was predicted. Pairing principle to carry forward: for a vinegar-forward side, screen on tannin structure rather than on body or weight.$m$ from public.dish d where d.slug=$m$pork-rack-chop-reverse-seared$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-08-30$m$::date, 9.5, 9, $m$yes$m$::repeat_verdict, $m$Made same-day in the afternoon rather than the designed day-ahead, held on the stove without chilling, and served without the reheat step. Result was strong — the extended warm hold appears to substitute for overnight rest. Staged vinegar (30 ml opening, 15 ml at finish) held. Narrow Le Creuset confirmed as the correct vessel.

## Cook record — 2026-08-30
**Recipe version:** Governance Framework v3.5, docx generated 2026-08-30.
**Ratings:** Flavour 9.5 · Execution 9 · Repeat: Yes
### What was actually cooked
400 g red cabbage, 1 apple, butter, staged red wine vinegar (30 ml opening / 15 ml reserved), brown sugar, bay, juniper. Narrow Le Creuset. Served to 3 alongside a reverse-seared pork chop.
### Material deviations from the written plan
The recipe specified a day-ahead braise, cooled and refrigerated, with a 15-minute induction reheat at E+2. **Cooked the same afternoon instead** — the plan was written on the assumption of a Saturday braise and the cook fell on a Sunday.
**Held on the stove for an extended period without chilling.** The cool, refrigerate and reheat sequence was not used at all.
### Designed-parameter confirmation
**Confirmed:**
- **Staged vinegar, 30 ml opening and 15 ml at the finish.** Colour held and the finish read bright. The staging rationale survives even without the reheat step it was originally written around.
- **Narrow Le Creuset.** No premature evaporation; cabbage reached full yield. The vessel-geometry constraint holds.
**Revised — hold ceiling:**
The written ceiling was 45 minutes covered off heat. The actual hold was several hours on the stove without chilling, and quality did not degrade. **For an afternoon braise that is never refrigerated, the hold window is materially longer than 45 minutes.** This is confirmed only for that configuration — a chilled-then-reheated batch is a different case and the 45-minute figure should stand there until separately tested.
**New finding:**
The day-ahead braise was justified on flavour integration. A same-day braise with an extended warm hold produced a result rated 9.5, which suggests **the warm hold substitutes for a substantial part of the overnight rest.** Day-ahead is a scheduling convenience more than a quality requirement. Worth one more cook before treating as settled.
### Next time
1. Same-day afternoon braise with a long warm hold is a valid path — do not treat day-ahead as mandatory.
2. Yield was generous by design and leftovers were expected. Cold cabbage is the intended partner for leftover cold pork.
3. Reusable beyond pork. The acid profile suits duck, goose and rich poultry equally.$m$, $m$["Cooked the same afternoon instead of the specified day-ahead braise — the plan was written on the assumption of a Saturday braise and the cook fell on a Sunday.", "Held on the stove for an extended period without chilling. The cool, refrigerate and reheat sequence was not used at all."]$m$::jsonb, $m$[{"param": "Staged vinegar", "designed": "30 ml opening and 15 ml at the finish", "observed": "colour held and the finish read bright", "verdict": "confirmed"}, {"param": "Vessel: narrow Le Creuset", "designed": "no premature evaporation", "observed": "cabbage reached full yield; vessel-geometry constraint holds", "verdict": "confirmed"}, {"param": "Hold ceiling (afternoon braise, never refrigerated)", "designed": "45 minutes covered off heat", "observed": "several hours on the stove without chilling; quality did not degrade", "verdict": "diverged"}, {"param": "Day-ahead braise for flavour integration", "designed": "day-ahead braise, chilled and reheated", "observed": "same-day braise with extended warm hold rated 9.5 — warm hold appears to substitute for a substantial part of the overnight rest", "verdict": "diverged"}]$m$::jsonb, null, null from public.dish d where d.slug=$m$pork-rack-chop-braised-red-cabbage$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$pork-fennel-lemon-ragu-pappardelle$m$,$m$Pork, Fennel & Lemon Ragù with Pappardelle$m$,$m$Pork$m$,array[$m$Main$m$]::text[],array[$m$Italian$m$]::text[],$m$Special$m$,'{}'::text[],'{}'::text[],$m$cooked$m$::dish_status,$m$ATK (heavily modified — white wine, moderate pork sear, longer lower braise, finish-stage cream, split Pecorino, reserved lemon zest)$m$,null,$m$Pork shoulder, fennel and lemon ragù served with pappardelle.$m$,null,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$37fe0391ce6381a88a56e79d20cd84f3$m$);
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-06-14$m$::date, 9, 8.5, $m$yes$m$::repeat_verdict, $m$Pork shoulder was extremely tender after 2½ hours at 300°F / 150°C. All modifications to the ATK original performed as expected — white wine layered acidity earlier in the cook, finish-stage cream gave better richness control, and the pre-pasta consistency check was critical. Sauce tightened quickly once pasta entered; reserved pasta water used aggressively. Reserved lemon zest at plating noticeably lifted the aromatic finish. No adjustments required post-cook.$m$, $m$[]$m$::jsonb, $m$[{"param": "Pork shoulder braise", "designed": "2½ hours at 300°F / 150°C", "observed": "Extremely tender", "verdict": "confirmed"}, {"param": "Pre-pasta consistency check", "designed": "Check sauce consistency before pasta enters", "observed": "Critical — sauce tightened quickly once pasta entered; reserved pasta water used aggressively", "verdict": "confirmed"}]$m$::jsonb, null, $m$Ca' Marcanda (Gaja) Promis Toscana IGT 2022 — worked well. Merlot/Syrah/Sangiovese bridge suits the lemon-forward acidity and pork richness.$m$ from public.dish d where d.slug=$m$pork-fennel-lemon-ragu-pappardelle$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$little-joe-bone-in-ribeye$m$,$m$Reverse-Seared Little Joe Bone-In Ribeye$m$,$m$Beef$m$,array[$m$Main$m$]::text[],array[$m$European$m$]::text[],$m$Special$m$,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Governance Framework v3.5 — sunday-ribeye.docx, 2026-09-05. Butcher Box Singapore, Little Joe Grass Fed MB4+ Rib Eye On Bone.$m$,$m$v3.5$m$,$m$Reverse-seared Little Joe grass-fed MB4+ bone-in ribeye (1.160 kg, 5.5 cm), dry-brined overnight, low-roasted at 225°F/107°C and seared, served with salsa verde, pommes purée, sautéed mushrooms and rocket salad.$m$,null,3,array[$m$rack$m$,$m$225°F oven$m$,$m$warmed plates$m$]::text[],$m$[{"param": "Oven pull temperature", "designed_value": "110°F / 43°C (revision hypothesis; was 120°F)", "note": "Derived by working backwards from a +21°F total rise. Rests on a single data point at a single mass — a hypothesis, not a validated specification."}, {"param": "Low-roast thickness-to-duration model", "designed_value": "60–85 min band", "note": "Two data points in opposite directions; model requires rebuilding rather than incremental adjustment."}, {"param": "8-minute pre-sear rest for large pieces", "designed_value": "8 min rack rest", "note": "Consider whether it earns its place now that it is known to add heat rather than shed it at this mass; may be shortened or removed."}]$m$::jsonb,null,$m$3d3e0391ce6381919e93f2cea72d6640$m$);
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-09-06$m$::date, 9, 8, $m$with_modifications$m$::repeat_verdict, $m$First cook, and the primary objective was the four-point measurement series — all four captured. Pre-sear rest added 6°F rather than losing 2–3°F: at 1.160 kg the rack rest continues cooking rather than shedding heat. Total A-to-D rise was +21°F against a predicted +13°F, overshooting to 141°F / 61°C — medium rather than medium-rare. Low-roast band failed badly: approximately 120 min actual against 60–85 min specified. Exit-anchored floating service absorbed the miss without downstream failure. Household preference remains with Tender Valley MB3+ grain-fed over this grass-fed cut.

## Cook record — 2026-09-06
**Recipe version:** Governance Framework v3.5, docx generated 2026-09-05 (`sunday-ribeye.docx`), calibrated to the actual cut.
**Ratings:** Flavour 9 · Execution 8 · Repeat: With Modifications
### What was actually cooked
Little Joe Grass Fed MB4+ Rib Eye On Bone, Butcher Box Singapore. 1.160 kg, 5.5 cm thick, S\$89.90/kg, S\$104.28. Overnight dry brine at 9 g (\~0.8% gross), uncovered on a rack in the fridge, approximately 30 hours.
Served to 3. Menu: ribeye, salsa verde, pommes purée, sautéed mushrooms, rocket salad. Watercress unavailable — rocket substituted with vinegar reduced to 10 ml and served undressed at the table.
### The four-point measurement series — primary objective
This cook existed to close two parameters carried as designed since the salmon cook. All four points were captured.
<table header-row="true">
<tr>
<td>Point</td>
<td>Reading</td>
<td>Description</td>
</tr>
<tr>
<td>A</td>
<td>120°F / 49°C</td>
<td>Oven exit</td>
</tr>
<tr>
<td>B</td>
<td>126°F / 52°C</td>
<td>After 8-minute pre-sear rack rest</td>
</tr>
<tr>
<td>C</td>
<td>131°F / 55°C</td>
<td>Immediately off the pan</td>
</tr>
<tr>
<td>D</td>
<td>141°F / 61°C</td>
<td>After 10-minute post-sear rest, warmed plates</td>
</tr>
</table>
**Three deltas, all against prediction:**
<table header-row="true">
<tr>
<td>Delta</td>
<td>Predicted</td>
<td>Actual</td>
<td>Result</td>
</tr>
<tr>
<td>Pre-sear drift (B−A)</td>
<td>−2 to −3°F</td>
<td>**+6°F**</td>
<td>Wrong direction</td>
</tr>
<tr>
<td>Sear gain (C−B)</td>
<td>+10 to +14°F</td>
<td>**+5°F**</td>
<td>Well under</td>
</tr>
<tr>
<td>Carryover (D−C)</td>
<td>+2 to +4°F</td>
<td>**+10°F**</td>
<td>Well over</td>
</tr>
<tr>
<td>Total A→D</td>
<td>\~+13°F</td>
<td>**+21°F**</td>
<td>8°F over</td>
</tr>
</table>
### Findings
**1. The pre-sear rest is not a rest at this mass — it continues cooking.** The 8-minute rack rest added 6°F rather than losing 2–3°F. At 1.160 kg with a steep gradient out of a 225°F oven, the surface keeps driving heat inward well past eight minutes. This is the most generalisable finding of the cook and it was predicted backwards. Confirmed only for this mass and geometry; smaller pieces should drift less at every stage.
**2. C and D are not independent measurements.** Reading C is taken before the sear's energy has migrated off the surface, so much of the +10°F recorded as carryover is the sear arriving late. The +5°F sear gain understates the pan's actual contribution. **The honest combined figure is that sear plus post-sear rest is worth approximately +15°F**; splitting them at the C boundary is somewhat artificial for a piece this size.
**3. Carryover on beef is strongly positive onto warmed plates.** This resolves, for a seared whole muscle at this mass, the question left open by the salmon cook — where carryover was negative onto room-temperature plates. The two results are not in conflict: mass and plate temperature both differ materially.
**4. Result overshot to 141°F / 61°C — medium, not medium-rare.** Approximately 10°F past target. Still rated 9 for flavour, and the additional rendering was not damaging on a well-marbled cut, but the endpoint was missed.
**Revision hypothesis for the next cook: pull at 110°F / 43°C rather than 120°F.** Derived by working backwards from a +21°F total rise. This rests on a single data point at a single mass and is a hypothesis, not a validated specification.
### Low-roast band — failed badly
**Specified 60–85 min. Actual approximately 120 min** to reach 120°F from fridge-cold at 225°F / 107°C. Intermediate reading: 110°F at 105 minutes, confirming the final 10°F is the slowest stretch.
The allowance was wrong by roughly 40%. Notably this is the **opposite direction** to the pork cook of 2026-08-30, where the projection ran long and was corrected downward. That correction overshot. Two data points now exist in opposite directions, which indicates the thickness-to-duration model requires rebuilding rather than incremental adjustment.
The steak was loaded at 5:00 pm against a plan of 5:15 pm and still ran late. Service moved to approximately 7:40 pm. **The exit-anchored floating-service architecture absorbed a 35-minute miss without any downstream failure** — this is the second consecutive cook where that architecture has held against a materially wrong roast projection, and it is the reason a bad estimate did not become a bad dinner.
### Live compressions applied
Salsa verde tempered 20 min rather than 45. Purée mid-hold check skipped. Mushrooms reduced to 8 min. Rocket served undressed. **The 29-minute convergence sequence was not compressed** — correctly, since every step in it protects the protein or carries a measurement.
### Household verdict — split from the rating
Flavour rated 9, but **Jin stated a continued preference for Tender Valley MB3+ grain-fed over this Little Joe MB4+ grass-fed.** This is the substantive outcome for future beef sourcing and should not be read as a criticism of the cook.
The grass-fed experiment is therefore concluded as: technically successful, genuinely enjoyed, not preferred. The additional mineral and savoury character that distinguishes Little Joe is not what this household wants from a ribeye. **Future ribeye purchases should default back to Tender Valley grain-fed**, or trial W. Black MB5+ if a step up is wanted — a richer grain-fed profile rather than a leaner grass-fed one.
Price is relevant context: S\$89.90/kg against Tender Valley at roughly S\$29.70 for a comparable boneless steak.
### Purchase-day reconciliation
Salting was scheduled for Saturday on purchase and completed correctly. A restatement of the salting instruction was issued on Sunday evening in error — the salt was already on. No effect on the cook.
### Next time
1. **Pull at 110°F / 43°C** and re-measure all four points. The revision is a hypothesis from one observation.
2. **Rebuild the low-roast model.** Two data points, opposite directions. Consider treating the final 10°F as a distinct slow phase rather than extrapolating a single curve.
3. **Consider whether the 8-minute pre-sear rest earns its place** now that it is known to add heat rather than shed it at this mass. It may be shortened or removed for large pieces.
4. **Record C and D with a stated caveat** that they are not independent at this mass.
5. Default back to Tender Valley grain-fed for ribeye.$m$, $m$["Watercress unavailable — rocket substituted with vinegar reduced to 10 ml and served undressed at the table.", "Low-roast ran approximately 120 min against a 60–85 min specification; steak loaded at 5:00 pm against a plan of 5:15 pm and still ran late. Service moved to approximately 7:40 pm.", "Live compressions applied: salsa verde tempered 20 min rather than 45; purée mid-hold check skipped; mushrooms reduced to 8 min; rocket served undressed. The 29-minute convergence sequence was not compressed.", "Result overshot to 141°F / 61°C — medium, not medium-rare. Approximately 10°F past target.", "A restatement of the salting instruction was issued on Sunday evening in error — the salt was already on. No effect on the cook."]$m$::jsonb, $m$[{"param": "Pre-sear drift (B−A): 8-minute pre-sear rack rest", "designed": "−2 to −3°F", "observed": "+6°F (A 120°F / 49°C oven exit → B 126°F / 52°C) — wrong direction", "verdict": "diverged"}, {"param": "Sear gain (C−B)", "designed": "+10 to +14°F", "observed": "+5°F (B 126°F / 52°C → C 131°F / 55°C immediately off the pan) — well under", "verdict": "diverged"}, {"param": "Carryover (D−C): 10-minute post-sear rest, warmed plates", "designed": "+2 to +4°F", "observed": "+10°F (C 131°F / 55°C → D 141°F / 61°C) — well over", "verdict": "diverged"}, {"param": "Total A→D rise", "designed": "~+13°F", "observed": "+21°F (120°F → 141°F / 61°C) — 8°F over; medium rather than medium-rare", "verdict": "diverged"}, {"param": "Low-roast band to 120°F from fridge-cold at 225°F / 107°C (1.160 kg, 5.5 cm)", "designed": "60–85 min", "observed": "approximately 120 min (110°F at 105 min) — allowance wrong by roughly 40%", "verdict": "diverged"}, {"param": "Exit-anchored floating-service architecture", "designed": "absorbs roast projection misses", "observed": "absorbed a 35-minute miss without any downstream failure", "verdict": "confirmed"}, {"param": "Overnight dry brine, 9 g (~0.8% gross), uncovered on a rack, approx. 30 hours", "designed": "0.8% dry brine", "observed": "completed correctly on Saturday", "verdict": "confirmed"}]$m$::jsonb, $m$Flavour rated 9, but Jin stated a continued preference for Tender Valley MB3+ grain-fed over this Little Joe MB4+ grass-fed. The grass-fed experiment is concluded as: technically successful, genuinely enjoyed, not preferred. Future ribeye purchases should default back to Tender Valley grain-fed, or trial W. Black MB5+ if a step up is wanted. Price is relevant context: S$89.90/kg against Tender Valley at roughly S$29.70 for a comparable boneless steak.$m$, $m$Cellar record required physical verification before selection; 2018 Château Moulin Riche recommended as primary, 2019 Il Poggione Brunello as fallback.$m$ from public.dish d where d.slug=$m$little-joe-bone-in-ribeye$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$rib-eye-roast-sunday$m$,$m$Rib Eye Roast Sunday (Reverse Sear)$m$,$m$2026-07-12$m$,$m$cooked$m$::meal_status,3,null,null,$m$2004 Château Léoville Barton (primary) — mature Left Bank, restraint flattered the jus. Backup: 2015 Clos Apalta. Cellar VALID at cook.$m$,$m$39be0391ce63813d97cdca2de78cd68c$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$ribeye-reverse-seared-rib-eye-roast$m$,$m$Reverse-Seared Rib Eye Roast$m$,$m$Beef$m$,array[$m$Main$m$]::text[],array[$m$European$m$,$m$French$m$]::text[],$m$Medium$m$,array[$m$Make-Ahead$m$,$m$Low Carb$m$]::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Cooking project — dual-model review loop (7 rounds to stability). MB3+ Tender Valley Black Angus rib eye, Butcher Box SG.$m$,null,$m$Compact tied rib eye roast (MB3+ Tender Valley Black Angus), 24 hr 1% dry-brined, reverse-seared at 250°F / 120°C, pulled at 119–120°F / 48–49°C and finished with a single-blast crust.$m$,null,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$39be0391ce63813d97cdca2de78cd68c$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$ribeye-jus$m$,$m$Jus$m$,null,array[$m$Sauce$m$]::text[],array[$m$European$m$,$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Cooking project — dual-model review loop (7 rounds to stability). MB3+ Tender Valley Black Angus rib eye, Butcher Box SG.$m$,null,$m$Independent shallot-based reduction jus, not built from roast-pan fond.$m$,null,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$39be0391ce63813d97cdca2de78cd68c$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$ribeye-yogurt-mustard-cream$m$,$m$Yogurt-Mustard Cream$m$,null,array[$m$Sauce$m$]::text[],array[$m$European$m$,$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Cooking project — dual-model review loop (7 rounds to stability). MB3+ Tender Valley Black Angus rib eye, Butcher Box SG.$m$,null,$m$Yogurt and mustard cream, a stand-in for the crème fraîche and prepared horseradish sauce.$m$,null,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$39be0391ce63813d97cdca2de78cd68c$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$ribeye-roast-potatoes$m$,$m$Roast Potatoes$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$European$m$,$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Cooking project — dual-model review loop (7 rounds to stability). MB3+ Tender Valley Black Angus rib eye, Butcher Box SG.$m$,null,$m$Roast potatoes with a split pre-roast and recrisp.$m$,null,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$39be0391ce63813d97cdca2de78cd68c$m$);
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$rib-eye-roast-sunday$m$ and d.slug=$m$ribeye-reverse-seared-rib-eye-roast$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$rib-eye-roast-sunday$m$ and d.slug=$m$ribeye-jus$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$rib-eye-roast-sunday$m$ and d.slug=$m$ribeye-yogurt-mustard-cream$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$rib-eye-roast-sunday$m$ and d.slug=$m$ribeye-roast-potatoes$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-07-12$m$::date, 9.5, 8, $m$with_modifications$m$::repeat_verdict, $m$Beef executed to target: 1.18 kg / 12 cm compact tied roast (cut down from 1.566 kg, 500 g frozen raw), 24 hr 1% dry-brine, reverse sear at 250°F / 120°C, pulled 119–120°F / 48–49°C, single-blast crust. Rated very good. Jus (independent shallot-based reduction, not roast-pan fond) and the yogurt+mustard horseradish substitute both performed well — the yogurt/mustard cream was a successful stand-in when crème fraîche and prepared horseradish were unavailable. Primary execution gap: roast potatoes arrived cold at plating despite the split pre-roast/recrisp. Cause: the beef monopolised the single oven through its rest and blast, so the potatoes sat at room temperature after their recrisp with no hot-hold, and their last heat contact was too far from service. Modification for next cook: when a protein holds the oven to near service, time the sides' final heat step to finish after the protein vacates the oven, and/or provide an alternative hot-hold (warmed dish, low covered burner, binchotan, warmed plates). Framework updated (protein-in-oven cold-sides rule added; measurement formatting tightened to mandatory dual units and 5°C oven rounding).$m$, $m$["Roast cut down from 1.566 kg to a 1.18 kg / 12 cm compact tied roast; 500 g frozen raw", "Yogurt + mustard cream substituted for crème fraîche and prepared horseradish (unavailable)", "Roast potatoes arrived cold at plating — sat at room temperature after their recrisp with no hot-hold while the beef monopolised the single oven through rest and blast"]$m$::jsonb, $m$[{"param": "Beef reverse sear", "designed": "24 hr 1% dry-brine; 250°F / 120°C; pull 119–120°F / 48–49°C; single-blast crust", "observed": "Executed to target; rated very good", "verdict": "confirmed"}, {"param": "Sides hot-hold when protein holds the oven to near service", "designed": "Split pre-roast/recrisp for potatoes", "observed": "Potatoes cold at plating — last heat contact too far from service; framework rule added", "verdict": "diverged"}]$m$::jsonb, null, $m$2004 Château Léoville Barton (primary) — mature Left Bank, restraint flattered the jus. Backup: 2015 Clos Apalta. Cellar VALID at cook.$m$ from public.meal m where m.slug=$m$rib-eye-roast-sunday$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$roast-chicken-sunday$m$,$m$Roast Chicken Menu$m$,$m$2026-07-06$m$,$m$cooked$m$::meal_status,3,null,null,$m$Two-way choice from cellar (live-fetched): 2021 Jean-Marie Fourrier Bourgogne (Pinot Noir) as the cleaner food pairing / Hui Fong's preference; 2004 Château Léoville Barton (mature Left Bank Bordeaux, drink-soon) as the plush-preference option, viable given softened vinaigrette and restrained pasta lemon.$m$,$m$394e0391ce63810fb3b7cb97ca3a57c0$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$roast-chicken-keller-method$m$,$m$Roast Chicken (Keller Method, Dry-Brined)$m$,$m$Chicken$m$,array[$m$Main$m$]::text[],array[$m$French$m$]::text[],$m$Medium$m$,array[$m$Make-Ahead$m$]::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Thomas Keller roast chicken (dry-brine adapted); anchovy spaghetti (Bon Appétit, Mar 1990); bitter salad + torched-sugar yogurt pots original to project$m$,null,$m$Keller-method roast chicken: two ~1.07 kg birds dry-brined overnight, roasted at 450°F / 232°C on wire racks and pulled on breast temperature.$m$,$m$## Roast Chicken
Two birds \~1.07 kg each · dry-brine 0.8–1.0% by weight (\~9–10 g/bird), 18–24 hr uncovered · temper 60 min · roast 450°F / 232°C, \~40–55 min · rest 15 min uncovered.
- **Pull gate = breast** 150–152°F / 66–67°C (carries to \~155°F). Thighs 165–175°F by then. This replaced clock/thigh timing and was the single biggest reliability gain.
- Wire rack over tray, birds side by side with a gap for airflow. No basting, no added butter in-roast. Butter and pan jus on the carved meat, not the skin.
- Monitored with the ThermoWorks leave-in probe (breast, alarm \~150°F) plus Thermapen spot-check on the second bird.$m$,3,array[$m$wire rack$m$,$m$ThermoWorks leave-in probe$m$,$m$Thermapen$m$]::text[],$m$[]$m$::jsonb,null,$m$394e0391ce63810fb3b7cb97ca3a57c0$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, $m$2 × ~1.07 kg$m$, $m$Huber's cage-free; dry-brined 18–24 hr uncovered$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-keller-method$m$ and i.name=$m$whole chicken$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 9, $m$g$m$, $m$0.8–1.0% by weight (~9–10 g/bird)$m$, $m$dry brine$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-keller-method$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$on the carved meat, not in-roast$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-keller-method$m$ and i.name=$m$butter$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$roast-chicken-anchovy-spaghetti$m$,$m$Anchovy Spaghetti$m$,null,array[$m$Side$m$]::text[],array[$m$Italian$m$]::text[],null,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Thomas Keller roast chicken (dry-brine adapted); anchovy spaghetti (Bon Appétit, Mar 1990); bitter salad + torched-sugar yogurt pots original to project$m$,null,$m$Spaghetti with garlic, olive oil, anchovy, lemon and doubled parsley, finished in the off-heat anchovy skillet.$m$,$m$## Anchovy Spaghetti
4 tbsp olive oil · 4 garlic cloves · 6–8 anchovy fillets · 12 oz / 340 g spaghetti · 1½ tsp lemon juice + zest of ½ · \~6 tbsp parsley. Finish pasta in the off-heat anchovy skillet; reserve ¼ cup pasta water. No sauce salt, no Parmesan (salt-stacking control against the salted birds).$m$,3,array[$m$skillet$m$]::text[],$m$[]$m$::jsonb,null,$m$394e0391ce63810fb3b7cb97ca3a57c0$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$tbsp$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-anchovy-spaghetti$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$clove$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-anchovy-spaghetti$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 6, $m$piece$m$, $m$6–8 fillets$m$, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-anchovy-spaghetti$m$ and i.name=$m$anchovy fillet$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 340, $m$g$m$, $m$12 oz$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-anchovy-spaghetti$m$ and i.name=$m$spaghetti$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tsp$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-anchovy-spaghetti$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$piece$m$, $m$zest of ½ lemon$m$, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-anchovy-spaghetti$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 6, $m$tbsp$m$, $m$~6 tbsp$m$, $m$doubled$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-anchovy-spaghetti$m$ and i.name=$m$parsley$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$roast-chicken-bitter-leaf-salad$m$,$m$Bitter Leaf Salad$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],'{}'::text[],null,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Thomas Keller roast chicken (dry-brine adapted); anchovy spaghetti (Bon Appétit, Mar 1990); bitter salad + torched-sugar yogurt pots original to project$m$,null,$m$Little gem, frisée and endive with a softened lemon-Dijon vinaigrette, dressed at the table.$m$,$m$## Bitter Leaf Salad
Little gem + frisée + endive (endive as accent, substituted for radicchio). Vinaigrette 1½ tbsp lemon : 4 tbsp EVOO : 1 tbsp Dijon, softened to manage acid-stacking. Dress at the table; reserve a little to spoon beside the chicken.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$394e0391ce63810fb3b7cb97ca3a57c0$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-bitter-leaf-salad$m$ and i.name=$m$little gem lettuce$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-bitter-leaf-salad$m$ and i.name=$m$frisée$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$accent, substituted for radicchio$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-bitter-leaf-salad$m$ and i.name=$m$endive$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tbsp$m$, null, $m$vinaigrette$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-bitter-leaf-salad$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$tbsp$m$, null, $m$vinaigrette$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-bitter-leaf-salad$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$vinaigrette$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-bitter-leaf-salad$m$ and i.name=$m$dijon mustard$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$roast-chicken-torched-sugar-yogurt-pots$m$,$m$Torched-Sugar Yogurt Pots$m$,null,array[$m$Dessert$m$]::text[],'{}'::text[],null,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Thomas Keller roast chicken (dry-brine adapted); anchovy spaghetti (Bon Appétit, Mar 1990); bitter salad + torched-sugar yogurt pots original to project$m$,null,$m$Chilled lightly sweetened Greek yogurt over dark-fruit jam with a brûléed sugar lid cracked at the table.$m$,$m$## Torched-Sugar Yogurt Pots
350 g full-fat Greek yogurt lightly sweetened, over 2 tsp jam per pot, \~1 tsp caster sugar torched to amber per pot. Assemble and chill up to 4 hr ahead; torch to order (crust weeps within \~15 min). A cool tart-sweet reset after the rich savoury meal.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$394e0391ce63810fb3b7cb97ca3a57c0$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 350, $m$g$m$, null, $m$lightly sweetened$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-torched-sugar-yogurt-pots$m$ and i.name=$m$greek yogurt, full-fat$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tsp$m$, $m$2 tsp per pot$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-torched-sugar-yogurt-pots$m$ and i.name=$m$dark-fruit jam$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, $m$~1 tsp per pot$m$, $m$torched to amber$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$roast-chicken-torched-sugar-yogurt-pots$m$ and i.name=$m$caster sugar$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$roast-chicken-sunday$m$ and d.slug=$m$roast-chicken-keller-method$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$roast-chicken-sunday$m$ and d.slug=$m$roast-chicken-anchovy-spaghetti$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$roast-chicken-sunday$m$ and d.slug=$m$roast-chicken-bitter-leaf-salad$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$dessert$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$roast-chicken-sunday$m$ and d.slug=$m$roast-chicken-torched-sugar-yogurt-pots$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-07-06$m$::date, 9.5, 9, $m$yes$m$::repeat_verdict, $m$Four-component menu: Keller-method roast chicken (two \~1.07 kg Huber's birds, overnight dry-brine at 0.8–1.0%, breast-temp pull 150–152°F), anchovy spaghetti finished in the skillet, bitter leaf salad (little gem/frisée/endive, lemon-Dijon vinaigrette), torched-sugar yogurt pots over jam. Breast-temp pull replaced clock/thigh timing as the key reliability improvement. Salt-stacking managed across the salted birds, anchovy, and light pasta water; acid-stacking managed by softening the vinaigrette. Endive substituted for radicchio (gentler, easier alongside the chicken). Two birds roasted side by side on wire racks over trays with an airflow gap; one carved for dinner, one reserved for next-day lunch.

## Post-Cook Notes
- **Rating:** 9.5 · **Execution:** 9 · **Repeat:** Yes · **Times Made:** 1 · **Last Made:** 6 Jul 2026
- Breast-temp pull is the method's key reliability lever; keep it as the gate on any repeat.
- Salt-stacking and acid-stacking were the two managed risks — light pasta water, no sauce salt, no Parmesan, softened vinaigrette. Held up well.
- Endive worked as a cleaner accent than radicchio; retain.
- Two-bird side-by-side roast on racks over trays worked; one bird carried next-day lunch.$m$, $m$["Endive substituted for radicchio in the bitter leaf salad (gentler, easier alongside the chicken)"]$m$::jsonb, $m$[{"param": "Breast-temp pull gate", "designed": "Pull at breast 150–152°F / 66–67°C (carries to ~155°F)", "observed": "Replaced clock/thigh timing; the single biggest reliability gain — keep as the gate on any repeat", "verdict": "confirmed"}, {"param": "Salt-stacking and acid-stacking controls", "designed": "Light pasta water, no sauce salt, no Parmesan, softened vinaigrette", "observed": "Held up well", "verdict": "confirmed"}, {"param": "Two-bird side-by-side roast on racks over trays with airflow gap", "designed": "Two birds, one for dinner, one for next-day lunch", "observed": "Worked; one bird carried next-day lunch", "verdict": "confirmed"}]$m$::jsonb, null, null from public.meal m where m.slug=$m$roast-chicken-sunday$m$;
commit;
