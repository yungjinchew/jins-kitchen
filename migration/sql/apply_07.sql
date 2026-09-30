begin;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$maiale-al-latte-dinner$m$,$m$Maiale al Latte (Pork Shoulder Braised in Milk)$m$,$m$2026-06-28$m$,$m$cooked$m$::meal_status,3,null,null,$m$2021 Jean-Marie Fourrier Bourgogne (Pinot Noir) — paired perfectly per cook. Bridge bottle, satisfied both drinkers; brightness matched the lemon, low tannin stayed clear of the dairy.$m$,$m$38de0391ce6381898654cbfbb1902614$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maiale-al-latte$m$,$m$Maiale al Latte (Pork Shoulder Braised in Milk)$m$,$m$Pork$m$,array[$m$Main$m$]::text[],array[$m$Italian$m$]::text[],$m$Medium$m$,array[$m$Low Carb$m$,$m$One-Pan$m$]::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$Claude-generated, dual-model review (Claude + GPT). Adapted from classic Maiale al Latte / Marcella Hazan lineage, simplified.$m$,null,$m$Pork shoulder browned to deep mahogany and braised in milk with sage, garlic and lemon zest until fork-soft, the milk concentrating into a savory, curd-flecked sauce.$m$,$m$> **Version note.** The first cook (28 Jun 2026, 8/10) was v1. This v4 recipe folds in every fix from that cook and the dual-model review that followed. Changes from v1: narrow deep pot instead of the wide Creuset; milk 850→720 ml with **no** initial water; sage 10→14 leaves; overnight salt 1¼→1½ tsp; deep-mahogany sear + full deglaze enforced as hard CCPs; lid-off final 45 min for in-oven concentration; strain-and-reduce added as a thin-sauce backstop; braise restated as \~2¾–3 hr expected. The optional white-wine deglaze is **held for a v5 single-variable test** — not in v4, so pot geometry isn't confounded with wine. Sides and the Fourrier Bourgogne pairing were unchanged from v1 (all worked).

## MAIALE AL LATTE (PORK SHOULDER BRAISED IN MILK)
**Yield & Timing:** 3 adults · Total \~3–3½ hr (plus overnight salt) · Active \~50 min · Oven 300°F / 150°C
**Dish Overview.** Pork shoulder browned to deep mahogany and braised in milk with sage, garlic, and lemon zest until fork-soft, the milk concentrating into a savory, curd-flecked sauce with real body — meltingly soft meat against lightly granular, ricotta-like solids.
### Ingredients
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Amount</td>
</tr>
<tr>
<td>Boneless pork shoulder, tied</td>
<td>2 lb / 900 g</td>
</tr>
<tr>
<td>Diamond Crystal kosher salt (overnight brine; plus assertive finishing salt)</td>
<td>1½ tsp</td>
</tr>
<tr>
<td>Black pepper, plus fresh grinds to finish</td>
<td>½ tsp</td>
</tr>
<tr>
<td>Unsalted butter</td>
<td>1 tbsp / 14 g</td>
</tr>
<tr>
<td>Olive oil</td>
<td>1 tbsp / 15 ml</td>
</tr>
<tr>
<td>Whole milk (no initial water — see pot note)</td>
<td>3 cups / 720 ml</td>
</tr>
<tr>
<td>Garlic, lightly smashed</td>
<td>5 cloves</td>
</tr>
<tr>
<td>Fresh sage, whole leaves</td>
<td>14</td>
</tr>
<tr>
<td>Lemon zest, wide strips (no pith)</td>
<td>from 1 lemon</td>
</tr>
<tr>
<td>Bay leaf</td>
<td>1</td>
</tr>
<tr>
<td>Hot water, only if needed mid-braise</td>
<td>up to \~120 ml</td>
</tr>
<tr>
<td>Lemon juice, to taste (finish)</td>
<td>1–2 tsp</td>
</tr>
<tr>
<td>Flaky salt (seasoned assertively, finish)</td>
<td>to taste</td>
</tr>
</table>
### Flavor Architecture
- **Base:** butter + olive oil; garlic and sage bloomed in the rendered fat.
- **Primary driver:** pork, deepened by long milk braising and — critically — a dark, fully deglazed fond. On a dish this minimal the fond carries the flavor; a pale sear underdelivers with no recovery downstream.
- **Acid:** lemon — zest strips staged into the braise; 1–2 tsp juice off-heat at finish.
- **Aromatic/finish:** sage and lemon zest through the braise; final lemon juice + fresh black pepper off-heat.
### Prep Phase
1. **Salt ahead (preferred):** pat dry, season all over with 1½ tsp salt + ½ tsp pepper, refrigerate uncovered overnight (up to 24 hr) on a rack. Out 45–60 min before browning; pat dry again. *(If not: season, rest at room temp 30–45 min.)*
2. **Pot selection (design variable):** use a Dutch oven that fits the shoulder with \~2–3 cm / ¾–1¼ in clearance — **the narrow, deep Creuset, not the wide one.** 720 ml milk should then reach halfway up the shoulder with no added water; if it sits well below halfway, the pot is too wide — switch pots rather than dilute. *(Pot width was the confirmed root cause of the thin sauce on the first cook.)*
3. Truss at 1-in intervals if needed. Smash 5 garlic cloves. Pull 14 whole sage leaves — leave whole, do not chop. Peel 1 lemon into wide zest strips, no pith.
### Active Cooking
1. **Brown to deep mahogany.** In the narrow pot over medium-high (induction), heat butter + oil until foam subsides. Brown all sides 12–15 min to a genuinely dark mahogany crust on every face — not golden, not medium-brown. *(This is the dish's entire flavor base.)* Lower heat if the base threatens to blacken. Transfer out.
2. **Bloom aromatics.** Lower to medium. Add garlic + 14 sage; 60–90 sec until fragrant and garlic pale gold — not browned.
3. **Build + fully deglaze.** Add 720 ml milk, zest strips, bay. Scrape every bit of fond off the base until clean *(undeglazed fond is flavor lost)*. Return pork + juices. Milk should reach halfway up the shoulder with no added water; if well short, the pot is too wide — switch, don't dilute.
4. **Braise, lid ajar.** Gentle simmer, cover lid-ajar, into oven. \~1 hr 30 min, turning every 45 min. **90-min check:** add 60–120 ml hot water only if level drops below ⅓ meat height. *(Milk separates into golden curds in thin whey — correct.)*
5. **Final phase, lid off.** Last **45 min lid off** so the sauce concentrates in steady oven heat, not a late stovetop boil *(primary body-builder; avoids graining the curds)*. Done when a fork twists with no resistance (secondary cue 195–203°F / 90–95°C at the thickest part). Plan \~2¾–3 hr total; go by the fork, not the clock.
6. **Rest + remove aromatics + concentrate if needed.** Lift pork out, tent. Discard bay + zest. If still thin: mash 2 soft garlic cloves + a spoonful of curds into the liquid for body; **or** strain, press to recover curds, reduce the whey hard separately, stir curds back in off-heat. Stovetop-reduce only if still loose after that.
### Holding & Assembly
- Pork rests tented \~15 min while the sauce finishes.
- Off-heat, stir in 1–2 tsp lemon juice. **Then season assertively** — add flaky salt with more confidence than feels natural; the reduction concentrates but can't create seasoning depth, and the conservative default reads flat here. *(The one point in the dish to lean into salt.)*
- Slice against the grain, thick slices (soft meat — sharp knife, gentle hand). Spoon curd sauce over; finish with fresh black pepper.
### Critical Control Points
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure Mode</td>
<td>Sensory Cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Major</td>
<td>Sear too pale → flat flavor *(confirmed, cook 1)*</td>
<td>Crust golden/medium-brown, not dark mahogany</td>
<td>Largely unrecoverable once braising begins. Prevent: full 12–15 min, dark every face, deglaze completely</td>
</tr>
<tr>
<td>Major</td>
<td>Thin sauce, no body *(confirmed, cook 1)*</td>
<td>Milk watery; curds stay suspended</td>
<td>Prevent: narrow pot, 720 ml, no initial water. Backstops: lid off final 45 min; strain & reduce whey; mash garlic + curds</td>
</tr>
<tr>
<td>Major</td>
<td>Fond/aromatics scorched</td>
<td>Base blackens or garlic past gold; bitter edge</td>
<td>Unrecoverable if bad; wipe pot, re-bloom fresh aromatics before milk. Lower heat as base threatens to blacken</td>
</tr>
<tr>
<td>Major</td>
<td>Pork under-braised</td>
<td>Fork meets resistance</td>
<td>Return covered 20–30 min; recoverable with time</td>
</tr>
<tr>
<td>Minor</td>
<td>Sauce broken too far / dry curds</td>
<td>Over-reduced, curds grainy-dry</td>
<td>Loosen with warm milk or water off-heat</td>
</tr>
</table>
### Adjustment Notes
<table header-row="true">
<tr>
<td>Adjustment</td>
<td>Guidance</td>
</tr>
<tr>
<td>Salt</td>
<td>Season finished sauce assertively — takes more than household default; reads flat if underseasoned. Flaky salt at table too</td>
</tr>
<tr>
<td>Acid</td>
<td>Off-heat lemon juice is the lever; ½ tsp at a time if flat or heavy</td>
</tr>
<tr>
<td>Richness</td>
<td>More lemon cuts heaviness; a knob of butter rounds out a lean sauce</td>
</tr>
<tr>
<td>Body</td>
<td>Mash garlic + curds into the sauce before resorting to reduction</td>
</tr>
</table>
### Scaling Notes
No material change at 2 lb / 900 g in one pot. If doubling, use a wider pot so milk still reaches halfway and the meat browns evenly — and note the wider pot is exactly the case to raise milk toward 850 ml.$m$,3,array[$m$narrow deep Le Creuset$m$,$m$induction$m$]::text[],$m$[{"param": "White-wine deglaze", "designed_value": "75–100 ml white wine, reduced near-dry before the milk", "note": "Optional; HELD for v5 as an isolated single-variable test — not added to v4, so pot geometry isn't confounded with wine. Becomes the clean v5 experiment if v4 fixes sauce body and seasoning but flavour depth is still delicate."}, {"param": "Pot geometry and milk volume", "designed_value": "Narrow deep Le Creuset; 720 ml milk; no initial water", "note": "v4 correction from cook 1 (wide Creuset + added water gave a thin sauce); v4 not yet cooked."}, {"param": "Sage and salt", "designed_value": "14 sage leaves; 1½ tsp overnight salt", "note": "v4 increase from 10 leaves / 1¼ tsp; not yet cooked."}, {"param": "Lid-off final phase", "designed_value": "Last 45 min lid off for in-oven concentration", "note": "v4 addition as primary body-builder; not yet cooked."}, {"param": "Braise duration", "designed_value": "~2¾–3 hr total, go by the fork", "note": "Restated from 2¼ hr after cook 1 ran ~30 min past plan; v4 not yet cooked."}]$m$::jsonb,null,$m$38de0391ce6381898654cbfbb1902614$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 900, $m$g$m$, $m$2 lb$m$, $m$tied$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$pork shoulder, boneless$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tsp$m$, null, $m$overnight brine; plus assertive finishing salt$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, $m$plus fresh grinds to finish$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 14, $m$g$m$, $m$1 tbsp$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$unsalted butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$ml$m$, $m$1 tbsp$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 720, $m$ml$m$, $m$3 cups$m$, $m$no initial water — see pot note$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$whole milk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 5, $m$clove$m$, null, $m$lightly smashed$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 14, $m$piece$m$, $m$14 whole leaves$m$, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$sage, fresh$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$from 1 lemon$m$, $m$wide strips, no pith$m$, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, null, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$bay leaf$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 120, $m$ml$m$, $m$up to ~120 ml$m$, $m$only if needed mid-braise$m$, false, true, 11
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$hot water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, $m$1–2 tsp$m$, $m$to taste, finish$m$, false, false, 12
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$to taste$m$, $m$seasoned assertively, finish$m$, false, false, 13
from public.dish d, public.ingredient i where d.slug=$m$maiale-al-latte$m$ and i.name=$m$flaky salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maiale-creamy-cannellini-beans$m$,$m$Creamy Cannellini Beans with Braising Liquor & Parsley$m$,null,array[$m$Side$m$]::text[],array[$m$Italian$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$Claude-generated, dual-model review (Claude + GPT). Adapted from classic Maiale al Latte / Marcella Hazan lineage, simplified.$m$,null,$m$Tinned cannellini simmered with garlic, shallot and a spoonful of the pork's milk liquor, partly mashed to a creamy spoonable base finished with parsley and olive oil.$m$,$m$## CREAMY CANNELLINI BEANS WITH BRAISING LIQUOR & PARSLEY
**Yield & Timing:** 3 as a side · Total \~20 min · Active \~15 min
**Dish Overview.** Tinned cannellini simmered with garlic, shallot, and a spoonful of the pork's milk liquor, partly mashed to a creamy, spoonable base finished with parsley and olive oil — the carb-light alternative to mash. *Meal-level texture exemption: intentionally soft; contrast from the broccolini and pork.*
### Ingredients
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Amount</td>
</tr>
<tr>
<td>Cannellini beans, drained and rinsed</td>
<td>2 × 400 g tins (≈480 g)</td>
</tr>
<tr>
<td>Garlic, thinly sliced</td>
<td>2 cloves</td>
</tr>
<tr>
<td>Shallot, finely diced</td>
<td>1 small</td>
</tr>
<tr>
<td>Olive oil, plus EVOO to finish</td>
<td>2 tbsp / 30 ml</td>
</tr>
<tr>
<td>Reserved pork braising liquor (before reduction)</td>
<td>\~3 tbsp</td>
</tr>
<tr>
<td>Water, plus more as needed</td>
<td>\~60 ml / ¼ cup</td>
</tr>
<tr>
<td>Flat-leaf parsley, chopped</td>
<td>¼ cup / 15–20 g</td>
</tr>
<tr>
<td>Diamond Crystal kosher salt & black pepper</td>
<td>to taste</td>
</tr>
</table>
### Flavor Architecture
Base: olive oil, shallot + garlic sweated. Primary: cannellini enriched by pork liquor. Acid: none added directly — *single-stage carve-out: low-acid by design; brightness from broccolini + pork's lemon.* Finish: parsley + EVOO off-heat.
### Prep Phase
1. Drain and rinse beans. Slice 2 garlic; dice 1 shallot; chop ¼ cup parsley.
2. **Reserve \~3 tbsp pork liquor before the pork sauce is reduced** (pork step 6 / T−0:30) — reserving after reduction skews the beans' seasoning.
### Active Cooking
1. Warm 2 tbsp olive oil, medium (induction). Sweat shallot + pinch salt 2–3 min until soft, not browned. Add garlic; 60 sec to fragrant and pale.
2. Add beans, \~60 ml water, reserved liquor. Gentle simmer 10–12 min, stirring, until creamy and heated through.
3. Mash \~20–25% of the beans against the pot for a loose creamy base — leave the rest whole. Stir in parsley off-heat; finish with EVOO + black pepper. Season to taste.
### Holding & Assembly
Hold covered on lowest heat up to \~30 min. Beans tighten as they sit; loosen with hot water or more liquor to spoonable before serving.
### Critical Control Points
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure Mode</td>
<td>Sensory Cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Minor</td>
<td>Beans too tight / pasty</td>
<td>Gluey, not creamy</td>
<td>Loosen off-heat with water or liquor a tbsp at a time</td>
</tr>
<tr>
<td>Minor</td>
<td>Garlic scorched</td>
<td>Sliced garlic browns, bitter</td>
<td>Keep heat medium, add garlic after shallot softens; if scorched, restart aromatics</td>
</tr>
</table>
### Adjustment Notes
<table header-row="true">
<tr>
<td>Adjustment</td>
<td>Guidance</td>
</tr>
<tr>
<td>Salt</td>
<td>Liquor is already seasoned — salt last and lightly</td>
</tr>
<tr>
<td>Richness</td>
<td>More liquor deepens; water lightens if too heavy</td>
</tr>
<tr>
<td>Texture</td>
<td>Mash more for creamier, less for more intact beans</td>
</tr>
</table>
### Scaling Notes
Not applicable at this scale. If doubling, wider pan so beans simmer in a shallow layer, not stacked.$m$,3,array[$m$induction$m$]::text[],$m$[]$m$::jsonb,null,$m$38de0391ce6381898654cbfbb1902614$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 480, $m$g$m$, $m$2 × 400 g tins (≈480 g)$m$, $m$drained and rinsed$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$cannellini beans, tinned$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, null, $m$thinly sliced$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$1 small$m$, $m$finely diced$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$shallot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 30, $m$ml$m$, $m$2 tbsp$m$, $m$plus EVOO to finish$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$tbsp$m$, $m$~3 tbsp$m$, $m$before reduction$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$pork braising liquor, reserved$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 60, $m$ml$m$, $m$¼ cup$m$, $m$plus more as needed$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$g$m$, $m$¼ cup / 15–20 g$m$, $m$chopped$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$parsley, flat-leaf$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$to taste$m$, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$to taste$m$, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$maiale-creamy-cannellini-beans$m$ and i.name=$m$black pepper$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$maiale-charred-broccolini-lemon-zest$m$,$m$Charred Broccolini with Lemon Zest$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Italian$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$Claude-generated, dual-model review (Claude + GPT). Adapted from classic Maiale al Latte / Marcella Hazan lineage, simplified.$m$,null,$m$Broccolini blanched briefly then charred in a hot pan until blistered and tender-crisp, dressed with lemon zest, a squeeze of juice and olive oil.$m$,$m$## CHARRED BROCCOLINI WITH LEMON ZEST
**Yield & Timing:** 3 as a side · Total \~12 min · Active \~10 min
**Dish Overview.** Broccolini blanched briefly, then charred in a hot pan until blistered and tender-crisp, dressed with grated lemon zest, a squeeze of juice, and olive oil — the bright, firm, charred counterpoint to two soft, rich components.
### Ingredients
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Amount</td>
</tr>
<tr>
<td>Broccolini, trimmed (woody ends off; thick stalks halved lengthwise)</td>
<td>2 bunches / \~350 g</td>
</tr>
<tr>
<td>Olive oil, plus a little to finish</td>
<td>1 tbsp / 15 ml</td>
</tr>
<tr>
<td>Lemon zest, finely grated</td>
<td>from shared lemon</td>
</tr>
<tr>
<td>Lemon juice</td>
<td>a squeeze</td>
</tr>
<tr>
<td>Diamond Crystal kosher salt</td>
<td>to taste</td>
</tr>
<tr>
<td>Chili flakes, optional</td>
<td>a pinch</td>
</tr>
</table>
### Flavor Architecture
Base: olive oil + the char itself. Primary: broccolini, bitterness tamed and sweetened by blistering. Acid: lemon zest + squeeze off-heat — *single-stage acceptable: no-cook dressing on a charred vegetable; earlier staging lost to the high heat.* Finish: zest + optional chili at plating.
### Prep Phase
Trim woody ends; halve thick stalks lengthwise for even cooking. Finely grate the lemon zest.
### Active Cooking
1. **Blanch:** 90 sec in well-salted boiling water, just until stalks lose their raw snap. Drain, pat thoroughly dry. *(The blanch lets a fast hot pan-sear blister the surface without leaving stalks raw — a flat pan has no indirect zone to finish them gently.)* Toss with 1 tbsp olive oil + pinch salt.
2. **Char:** hot cast-iron / heavy stainless pan, medium-high (outdoor gas burner preferred for heat and splatter, or induction indoors). Single layer, don't crowd; char 3–4 min, turning, until blistered and lightly blackened in spots and stalks tender-crisp. *(Blistered and spotted, not ashed grey — pull while there's still bite.)* Two batches if crowded.
### Holding & Assembly
Do not hold — plate-last. Off heat, dress immediately with grated zest, a squeeze of juice, a thread of olive oil, salt, optional chili. Serve at once.
### Critical Control Points
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure Mode</td>
<td>Sensory Cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Major</td>
<td>Overcooked / limp (unrecoverable for texture; dish serviceable)</td>
<td>Stalks floppy, no snap</td>
<td>None — texture lost once gone. Prevent: char to just-tender, serve immediately (this is why it's plated last)</td>
</tr>
<tr>
<td>Minor</td>
<td>Undercooked stalk</td>
<td>Char looks done but thick stalk raw-firm inside</td>
<td>Return to pan briefly; prevented by the blanch + halving thick stalks</td>
</tr>
</table>
### Adjustment Notes
<table header-row="true">
<tr>
<td>Adjustment</td>
<td>Guidance</td>
</tr>
<tr>
<td>Salt</td>
<td>Dress and taste at the end — char concentrates flavor, season lightly</td>
</tr>
<tr>
<td>Acid</td>
<td>Zest first, then juice a little at a time</td>
</tr>
<tr>
<td>Heat</td>
<td>Chili flakes optional, at plating</td>
</tr>
</table>
### Scaling Notes
Not applicable. Larger quantity → char in batches, don't crowd the pan.$m$,3,array[$m$cast-iron or heavy stainless pan$m$,$m$outdoor gas burner$m$]::text[],$m$[]$m$::jsonb,null,$m$38de0391ce6381898654cbfbb1902614$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 350, $m$g$m$, $m$2 bunches / ~350 g$m$, $m$trimmed (woody ends off; thick stalks halved lengthwise)$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$maiale-charred-broccolini-lemon-zest$m$ and i.name=$m$broccolini$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$ml$m$, $m$1 tbsp$m$, $m$plus a little to finish$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$maiale-charred-broccolini-lemon-zest$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$from shared lemon$m$, $m$finely grated$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$maiale-charred-broccolini-lemon-zest$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$a squeeze$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$maiale-charred-broccolini-lemon-zest$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$to taste$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$maiale-charred-broccolini-lemon-zest$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$a pinch$m$, null, false, true, 6
from public.dish d, public.ingredient i where d.slug=$m$maiale-charred-broccolini-lemon-zest$m$ and i.name=$m$chilli flakes$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$maiale-al-latte-dinner$m$ and d.slug=$m$maiale-al-latte$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$maiale-al-latte-dinner$m$ and d.slug=$m$maiale-creamy-cannellini-beans$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$maiale-al-latte-dinner$m$ and d.slug=$m$maiale-charred-broccolini-lemon-zest$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-06-28$m$::date, 8, 6.5, $m$with_modifications$m$::repeat_verdict, $m$First cook, 8/10, execution 6.5. Pork texture excellent — went \~30 min past planned braise time to very soft; fork-twist cue worked as intended (treat \~2¾–3 hr total as expected braise, not 2¼ hr). Execution scored 6.5 not lower: the recipe under-specified pot geometry (a specification gap, not a technique error), but the sear also stopped short of the deep mahogany the recipe did call for and the fond was not fully deglazed (genuine technique misses) — so the flavour/execution gap is real and preserved as signal. Two issues, both traced to controllable causes, one underlying hypothesis: the braise was too dilute and too conservatively seasoned. (1) SAUCE TOO THIN — ROOT CAUSE: used the WIDE Le Creuset and had to add water to bring liquid halfway up the roast. Wide pot + added water is worst-case geometry — max evaporative surface, min concentration around the meat, plus extra water to shed. GENERAL LESSON (transferable): do not compensate for an oversized pot by adding water at the start of a braise unless the recipe explicitly calls for dilution — choose a smaller/narrower vessel first. FIX: narrower Creuset, 720 ml milk (not 850), no initial water — should reach halfway and concentrate properly, likely removing any need for end-stage rescue. Backstops: lid off final 45 min; or strain liquid, reduce whey hard, recombine pressed curds off-heat; or mash garlic + curds in for body. (2) UNDER-FLAVOURED: on this minimal dish the fond is the whole flavour base — sear short of mahogany and/or incomplete deglaze. FIX: genuinely dark sear on every face, full deglaze; sage 10→14; overnight salt 1¼→1½ tsp; season finished sauce assertively (household salt-conservative, dish reads flat if underseasoned). Optional white-wine deglaze (75–100 ml reduced near-dry before milk) HELD for v5 as an isolated test — not added to v4, so pot geometry isn't confounded with wine. Both fixes execution-level, architecture sound. Sides (cannellini beans, charred broccolini) and wine pairing all worked; no changes. Pairing: 2021 Fourrier Bourgogne — perfect; bridge bottle, both drinkers, brightness matched the lemon, low tannin clear of the dairy. NEXT: cook v4 with narrow pot; evaluate (a) sauce body, (b) seasoning, (c) flavour depth — if a/b fixed but c still delicate, wine deglaze becomes the clean v5 experiment.$m$, $m$["Page body is the v4 redesign written after the cook; the cooked version was v1 (wide Le Creuset + added water)", "Used the wide Le Creuset and added water at the start to bring liquid halfway up the roast — root cause of the thin sauce", "Braise ran ~30 min past the planned 2¼ hr to very soft (~2¾–3 hr total)", "Sear stopped short of the deep mahogany the recipe called for; fond not fully deglazed"]$m$::jsonb, $m$[{"param": "Braise time", "designed": "2¼ hr", "observed": "~2¾–3 hr total to very soft", "verdict": "diverged"}, {"param": "Fork-twist doneness cue", "designed": "Fork twists with no resistance", "observed": "Worked as intended; pork texture excellent", "verdict": "confirmed"}, {"param": "Sauce body", "designed": "Milk concentrates into a curd-flecked sauce with real body", "observed": "Sauce too thin — wide pot + added water", "verdict": "diverged"}, {"param": "Seasoning / flavour depth", "designed": "Deep fond as the flavour base", "observed": "Under-flavoured — pale sear, incomplete deglaze, conservative seasoning", "verdict": "diverged"}]$m$::jsonb, null, $m$2021 Fourrier Bourgogne — perfect; bridge bottle, both drinkers, brightness matched the lemon, low tannin clear of the dairy.$m$ from public.meal m where m.slug=$m$maiale-al-latte-dinner$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$nordic-salmon-dinner$m$,$m$Nordic Oven-Roasted Salmon with Dill Potatoes & Pickled Cucumber$m$,$m$2025-12-30$m$,$m$cooked$m$::meal_status,3,$m$### 🕒 TIMING
Prep: 10 min
Cook: 15 min
Total: 25 min$m$,null,$m$Chablis, Grüner Veltliner, or Junmai Ginjo sake.$m$,$m$2d9e0391ce6380a5a4e2c1d758c47e46$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$nordic-oven-roasted-salmon$m$,$m$Nordic Oven-Roasted Salmon$m$,$m$Fish$m$,array[$m$Main$m$]::text[],array[$m$Nordic$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Clean, buttery Nordic-style salmon fillets seasoned with lemon zest and roasted to 48–50°C.$m$,$m$### 🍽 DESCRIPTION
Clean, buttery Nordic-style salmon with fresh dill potatoes and bright cucumber pickle. Elegant but effortless.
---
### 🥕 INGREDIENTS
**Salmon**
- 2 × 160 g salmon fillets
- 1 tbsp olive oil
- ¾ tsp **fine sea salt**
- ¼ tsp freshly ground black pepper
- Zest of ½ lemon
---
### 🔥 METHOD
**Salmon**
1. Heat oven to **190°C / 375°F**.
2. Season salmon with oil, salt, pepper, lemon zest.
3. Roast 9–11 min until internal temp hits **48–50°C / 118–122°F**.
4. Rest 2 minutes before serving.$m$,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380a5a4e2c1d758c47e46$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, $m$2 × 160 g$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$nordic-oven-roasted-salmon$m$ and i.name=$m$salmon fillet$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$nordic-oven-roasted-salmon$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.75, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$nordic-oven-roasted-salmon$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, $m$freshly ground$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$nordic-oven-roasted-salmon$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$zest of ½ lemon$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$nordic-oven-roasted-salmon$m$ and i.name=$m$lemon zest$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$nordic-dill-potatoes$m$,$m$Dill Potatoes$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Nordic$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Boiled baby potatoes tossed with butter, olive oil and fresh dill.$m$,$m$### 🥕 INGREDIENTS
**Dill Potatoes**
- 500 g baby potatoes
- ¾ tsp **kosher salt**
- 1 tbsp butter
- 1 tbsp olive oil
- 1½ tbsp fresh dill, finely chopped
---
### 🔥 METHOD
**Potatoes**
1. Boil in salted water until just tender.
2. Toss with butter, oil, dill, salt.$m$,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380a5a4e2c1d758c47e46$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 500, $m$g$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$nordic-dill-potatoes$m$ and i.name=$m$baby potato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.75, $m$tsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$nordic-dill-potatoes$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$nordic-dill-potatoes$m$ and i.name=$m$butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$nordic-dill-potatoes$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tbsp$m$, null, $m$finely chopped$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$nordic-dill-potatoes$m$ and i.name=$m$fresh dill$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$nordic-pickled-cucumber$m$,$m$Pickled Cucumber$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],array[$m$Nordic$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Bright quick-pickled English cucumber with rice vinegar, sugar and dill.$m$,$m$### 🥕 INGREDIENTS
**Pickled Cucumber**
- 1 English cucumber, thinly sliced
- ½ tsp **fine sea salt**
- 3 tbsp rice vinegar
- 1½ tbsp sugar
- 2 tbsp chopped dill
---
### 🔥 METHOD
**Cucumber**
1. Massage cucumber with salt 10 min.
2. Drain, then toss with vinegar, sugar, dill. Chill 15 min.$m$,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380a5a4e2c1d758c47e46$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$thinly sliced$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$nordic-pickled-cucumber$m$ and i.name=$m$english cucumber$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$nordic-pickled-cucumber$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$tbsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$nordic-pickled-cucumber$m$ and i.name=$m$rice vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$nordic-pickled-cucumber$m$ and i.name=$m$sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$chopped$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$nordic-pickled-cucumber$m$ and i.name=$m$dill$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$nordic-salmon-dinner$m$ and d.slug=$m$nordic-oven-roasted-salmon$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$nordic-salmon-dinner$m$ and d.slug=$m$nordic-dill-potatoes$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$nordic-salmon-dinner$m$ and d.slug=$m$nordic-pickled-cucumber$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2025-12-30$m$::date, 8, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$nordic-salmon-dinner$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$brazilian-picanha-dinner$m$,$m$Brazilian Picanha Dinner (3 Pax)$m$,$m$2026-03-08$m$,$m$cooked$m$::meal_status,3,null,null,null,$m$31de0391ce63804e86f1c762b6823ce2$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$picanha-reverse-seared$m$,$m$Reverse-Seared Picanha$m$,$m$Beef$m$,array[$m$Main$m$]::text[],array[$m$Latin$m$]::text[],$m$Medium$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt$m$,null,$m$Dry-brined picanha (rump cap) slow-roasted at 120°C, rested, then seared hard in cast iron and sliced thin against the grain.$m$,$m$**Reverse-Seared Picanha**<br><br>**Ingredients**
	- 1.5 kg picanha (rump cap)<br> 15–18 g kosher salt<br> 1 tbsp neutral oil<br> Flaky sea salt for finishing
	**Day Before**<br>1. Score fat cap lightly in a crosshatch pattern.<br>2. Salt evenly.<br>3. Place uncovered in refrigerator for 12–24 hours.<br><br>**Cooking**<br><br>*Low Roast*<br>1. Preheat oven to 120°C / 250°F.<br>2. Place meat on rack, fat cap up.<br>3. Roast until internal temp reaches 48–50°C / 118–122°F (approximately 45–70 minutes).<br>4. Rest 15 minutes.<br><br>*Final Sear*<br>1. Preheat cast iron on high heat for 4–6 minutes.<br>2. Add oil and sear:<br>   • Fat cap — 60–90 sec<br>   • First side — 60 sec<br>   • Second side — 45–60 sec<br>   • Edges — \~20 sec<br>3. Remove at 52–54°C / 125–130°F.<br>4. Rest 8–10 minutes.<br><br>*Slice*<br>1. Cut roast into thick steaks with the grain.<br>2. Rotate steaks 90°.<br>3. Slice thin against the grain.<br>4. Finish with flaky salt.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$31de0391ce63804e86f1c762b6823ce2$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1500, $m$g$m$, $m$1.5 kg$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$picanha-reverse-seared$m$ and i.name=$m$picanha (rump cap)$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$g$m$, $m$15–18 g$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$picanha-reverse-seared$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$picanha-reverse-seared$m$ and i.name=$m$neutral oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$for finishing$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$picanha-reverse-seared$m$ and i.name=$m$flaky sea salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$picanha-chimichurri$m$,$m$Chimichurri$m$,null,array[$m$Sauce$m$]::text[],array[$m$Latin$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt$m$,null,$m$Parsley, garlic and oregano chimichurri with red wine vinegar and olive oil, rested before serving.$m$,$m$**Chimichurri**<br><br>**Ingredients**
	- 1 cup flat-leaf parsley, finely chopped<br> 2 cloves garlic, minced<br> 1 tsp dried oregano<br> 2 tbsp red wine vinegar<br> ½ cup extra virgin olive oil<br> ¾ tsp fine sea salt<br> ½ tsp black pepper<br> Pinch chili flakes (optional)
	**Method**<br>1. Combine all ingredients in a bowl and stir well.<br>2. Rest 1–2 hours before serving.<br>3. Storage: keeps 3–4 days refrigerated.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$31de0391ce63804e86f1c762b6823ce2$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$cup$m$, null, $m$finely chopped$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$picanha-chimichurri$m$ and i.name=$m$flat-leaf parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, null, $m$minced$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$picanha-chimichurri$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$picanha-chimichurri$m$ and i.name=$m$dried oregano$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$picanha-chimichurri$m$ and i.name=$m$red wine vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$cup$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$picanha-chimichurri$m$ and i.name=$m$extra virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.75, $m$tsp$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$picanha-chimichurri$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$picanha-chimichurri$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, null, null, false, true, 8
from public.dish d, public.ingredient i where d.slug=$m$picanha-chimichurri$m$ and i.name=$m$chili flake$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$picanha-tomato-vinaigrette$m$,$m$Brazilian Tomato Vinaigrette$m$,null,array[$m$Sauce$m$]::text[],array[$m$Latin$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt$m$,null,$m$Brazilian-style diced tomato and red onion vinaigrette with parsley, red wine vinegar and olive oil, served at room temperature.$m$,$m$**Brazilian Tomato Vinaigrette**<br><br>**Ingredients**
	- 2 tomatoes, small dice<br> ¼ small red onion, very finely diced<br> 1 tbsp parsley, chopped<br> 1 tbsp red wine vinegar<br> 1 tbsp olive oil<br> ¼ tsp fine sea salt<br> Black pepper
	**Method**<br>1. Salt diced onion lightly and rest 10 minutes.<br>2. Combine all ingredients.<br>3. Rest 30–60 minutes before serving.<br>4. Serve at room temperature.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$31de0391ce63804e86f1c762b6823ce2$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$small dice$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$picanha-tomato-vinaigrette$m$ and i.name=$m$tomato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$piece$m$, $m$¼ small onion$m$, $m$small, very finely diced$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$picanha-tomato-vinaigrette$m$ and i.name=$m$red onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$chopped$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$picanha-tomato-vinaigrette$m$ and i.name=$m$parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$picanha-tomato-vinaigrette$m$ and i.name=$m$red wine vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$picanha-tomato-vinaigrette$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$picanha-tomato-vinaigrette$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$picanha-tomato-vinaigrette$m$ and i.name=$m$black pepper$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$picanha-panko-farofa$m$,$m$Panko Farofa$m$,null,array[$m$Side$m$]::text[],array[$m$Latin$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt$m$,null,$m$Panko toasted in rendered bacon fat and butter with onion, garlic, orange zest and parsley — a dry, crumbly farofa.$m$,$m$**Panko Farofa**<br><br>**Ingredients**
	- ¾ cup panko breadcrumbs<br> 40 g bacon, diced<br> ½ tbsp unsalted butter<br> ½ small onion or shallot, diced<br> ½ clove garlic, minced<br> ¼ tsp orange zest<br> ¼ tsp kosher salt<br> Black pepper<br> 2 tsp parsley, chopped
	*Optional:* 15 g toasted nuts (almonds or cashews)<br><br>**Method**<br>1. Render bacon on medium heat (\~5 min).<br>2. Add butter and onion. Cook 3 minutes.<br>3. Add garlic for 30 seconds.<br>4. Add panko and toast 3–4 minutes until golden.<br>5. Stir in orange zest and parsley.<br>6. Texture goal: dry and crumbly.<br>7. Serve warm.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$31de0391ce63804e86f1c762b6823ce2$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.75, $m$cup$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$panko breadcrumb$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 40, $m$g$m$, null, $m$diced$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$bacon$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tbsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$unsalted butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$piece$m$, $m$½ small onion$m$, $m$small, diced$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$onion or shallot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$clove$m$, null, $m$minced$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$orange zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tsp$m$, null, $m$chopped$m$, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 15, $m$g$m$, null, $m$almonds or cashews$m$, false, true, 10
from public.dish d, public.ingredient i where d.slug=$m$picanha-panko-farofa$m$ and i.name=$m$toasted nut$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$picanha-pan-seared-broccolini$m$,$m$Pan-Seared Broccolini$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Latin$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt$m$,null,$m$Broccolini seared in the steak pan's beef fat until blistered, finished with lemon and salt.$m$,$m$**Pan-Seared Broccolini**<br><br>**Ingredients**
	- 200–250 g broccolini<br> 1 tsp olive oil (if needed)<br> ¼ tsp kosher salt<br> Black pepper<br> Lemon wedge
	**Method**<br>1. Cook after searing the steak, using the same pan.<br>2. Reduce heat to medium.<br>3. Add broccolini in a single layer.<br>4. Cook 3–4 minutes, turning occasionally, until lightly blistered with tender stems.<br>5. Finish with lemon juice and salt.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$31de0391ce63804e86f1c762b6823ce2$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 200, $m$g$m$, $m$200–250 g$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$picanha-pan-seared-broccolini$m$ and i.name=$m$broccolini$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, $m$if needed$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$picanha-pan-seared-broccolini$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$picanha-pan-seared-broccolini$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$picanha-pan-seared-broccolini$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$picanha-pan-seared-broccolini$m$ and i.name=$m$lemon wedge$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$brazilian-picanha-dinner$m$ and d.slug=$m$picanha-reverse-seared$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$brazilian-picanha-dinner$m$ and d.slug=$m$picanha-chimichurri$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$brazilian-picanha-dinner$m$ and d.slug=$m$picanha-tomato-vinaigrette$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$brazilian-picanha-dinner$m$ and d.slug=$m$picanha-panko-farofa$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 5 from public.meal m, public.dish d where m.slug=$m$brazilian-picanha-dinner$m$ and d.slug=$m$picanha-pan-seared-broccolini$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-03-08$m$::date, 9.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$brazilian-picanha-dinner$m$;
commit;
