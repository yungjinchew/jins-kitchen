begin;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$aegean-salmon-dinner$m$,$m$Aegean Roasted Salmon with Pearl Barley, Broccolini & Cucumber Salad$m$,$m$2026-08-02$m$,$m$cooked$m$::meal_status,3,$m$## Meal workflow
**Critical path: the oven, specifically the salmon's exit.** Barley is a secondary path that must clear before T-15.
**Failure prioritisation:** protect the salmon. Barley holds covered and loosens with reserved cooking water, broccolini holds uncovered, the salad is not dressed until T-3. Nothing waits on the fish.
**Oven sequencing:** single state throughout — 425°F / 218°C conventional, lower-middle rack, no transitions. One half-sheet carries both roasted components, staggered: broccolini enters at T-20, the tray comes out briefly at T-15 to receive the salmon, then returns. Work with the tray on the stovetop, not on the open door. Oven on at T-40; the Bosch needs roughly 15 minutes from cold, and anything later puts the broccolini into a cavity near 300°F where it steams rather than blisters. On convection, drop to 400°F / 205°C and expect the salmon at the short end of its band.
**Heat resources:** electric kettle boils the barley water. One induction hob owns the barley pot from T-65 to T-22, plus a brief garlic infusion at T-45. The Bosch owns both roasted components from T-20. Second hob, outdoor gas and binchotan idle. No conflict at any point.
## T-minus timeline
<table header-row="true">
<tr>
<td>T-minus</td>
<td>Action</td>
</tr>
<tr>
<td>T-65 (4:25)</td>
<td>Kettle on. Shared prep: zest both lemons, juice one, wedge the other. Chop parsley and dill.</td>
</tr>
<tr>
<td>T-63</td>
<td>Kettle water into a large pot, 1 tbsp salt, induction on high to return to a rolling boil.</td>
</tr>
<tr>
<td>T-60 (4:30)</td>
<td>Barley in. Simmer uncovered 32–40 min. Start tasting at 28, then every 2–3 min.</td>
</tr>
<tr>
<td>T-48</td>
<td>Slice cucumbers, halve tomatoes. Into the fridge undressed.</td>
</tr>
<tr>
<td>T-45</td>
<td>Warm the olive oil with the grated garlic 60–90 sec on very low heat, just until fragrant, then strain the solids out. Stir zest, oregano and pepper into the strained oil. Rinse capers, pat dry, chop.</td>
</tr>
<tr>
<td>T-40 (4:50)</td>
<td>Oven to 425°F / 218°C, rack lower-middle. \~15 min to temperature.</td>
</tr>
<tr>
<td>T-38</td>
<td>Line half-sheet with parchment. Trim and toss broccolini; spread across one end only, leaving the other clear.</td>
</tr>
<tr>
<td>T-28 to T-20</td>
<td>Barley done. Drain, reserving 3 tbsp cooking water. Dress with oil, zest, pepper, parsley while hot. Cover.</td>
</tr>
<tr>
<td>T-25 (5:05)</td>
<td>Salmon out of fridge, pat both faces dry, brush with the oil. Salt the flesh now if not already salted earlier today.</td>
</tr>
<tr>
<td>T-20 (5:10)</td>
<td>Tray into oven.</td>
</tr>
<tr>
<td>T-15 (5:15)</td>
<td>Tray out onto stovetop. Salmon skin-down on the clear end. Straight back in. Salmon 9–11 min.</td>
</tr>
<tr>
<td>T-6 to T-4</td>
<td>Tray out. Salmon at 122°F / 50°C onto warm plates. Broccolini into a warm bowl, 1 tsp lemon juice through it.</td>
</tr>
<tr>
<td>T-6 to T-4</td>
<td>Salmon rests uncovered, 3–4 min.</td>
</tr>
<tr>
<td>T-3</td>
<td>Dress the salad. Loosen the barley if tight. Crumble feta into a small bowl.</td>
</tr>
<tr>
<td>T-0</td>
<td>Lift each portion off its skin with a fish slice. Capers and dill over. Lemon wedges and feta to the table.</td>
</tr>
</table>
**Variance-band closure.** Salmon earliest finish T-6 gives a 4-minute rest, plating at T-2 and a 2-minute hold — inside the designed 5–8 minute window. Latest finish T-4 gives a 4-minute rest to T-0 and immediate plating; realistic service 5:32 with no plating buffer. The late edge has no slack, which is why every other component absorbs slip and the salmon never does. Barley at T-60 finishes T-28 to T-20, clearing the board before the oven sequence begins — this is the correction from cook 1, where a T-52 start put completion at T-14, inside the salmon window.
## Holding chain
<table header-row="true">
<tr>
<td>Component</td>
<td>Hold</td>
<td>Designed max</td>
<td>Drift</td>
<td>Corrective</td>
</tr>
<tr>
<td>Barley</td>
<td>Covered pot or bowl, off heat</td>
<td>\~25 min</td>
<td>Tightens and clumps as it cools</td>
<td>Loosen with the reserved cooking water; hot plain water also works but carries no seasoning</td>
</tr>
<tr>
<td>Broccolini</td>
<td>Warm bowl, uncovered</td>
<td>\~15–20 min</td>
<td>Softens if covered</td>
<td>Never cover</td>
</tr>
<tr>
<td>Salad</td>
<td>Components sealed in fridge, undressed</td>
<td>\~2 hr</td>
<td>Low risk, not zero — cut tomatoes weep a little</td>
<td>Pour off pooled liquid before dressing at T-3</td>
</tr>
<tr>
<td>Salmon</td>
<td>Warm plate, uncovered</td>
<td>\~5–8 min</td>
<td>Surface dries, flesh firms</td>
<td>None — plate it</td>
</tr>
</table>
Hold windows remain designed, not validated. Cook 1 observed no drift but measured none.$m$,$m$## Shopping list
<table header-row="true">
<tr>
<td>Ingredient</td>
<td>Total</td>
<td>Salmon</td>
<td>Broccolini</td>
<td>Barley</td>
<td>Salad</td>
</tr>
<tr>
<td>Salmon, centre section of a side, skin-on</td>
<td>1¼ lb / 570 g purchased</td>
<td>✓</td>
<td>—</td>
<td>—</td>
<td>—</td>
</tr>
<tr>
<td>Broccolini</td>
<td>12 oz / 340 g</td>
<td>—</td>
<td>12 oz / 340 g</td>
<td>—</td>
<td>—</td>
</tr>
<tr>
<td>Cucumbers, Japanese or Persian</td>
<td>2</td>
<td>—</td>
<td>—</td>
<td>—</td>
<td>2</td>
</tr>
<tr>
<td>Dill, fresh</td>
<td>1 tbsp chopped</td>
<td>1 tbsp</td>
<td>—</td>
<td>—</td>
<td>—</td>
</tr>
<tr>
<td>Garlic</td>
<td>1 small clove</td>
<td>1 clove</td>
<td>—</td>
<td>—</td>
<td>—</td>
</tr>
<tr>
<td>Lemons</td>
<td>2</td>
<td>1 tsp zest + wedges</td>
<td>1 tsp juice</td>
<td>1 tsp zest</td>
<td>—</td>
</tr>
<tr>
<td>Parsley, flat-leaf</td>
<td>2 tbsp chopped</td>
<td>—</td>
<td>—</td>
<td>1 tbsp</td>
<td>1 tbsp</td>
</tr>
<tr>
<td>Tomatoes, cherry</td>
<td>200 g</td>
<td>—</td>
<td>—</td>
<td>—</td>
<td>200 g</td>
</tr>
<tr>
<td>Barley, pearl</td>
<td>¾ cup / 135 g dry</td>
<td>—</td>
<td>—</td>
<td>✓</td>
<td>—</td>
</tr>
<tr>
<td>Capers, in brine</td>
<td>1 tbsp</td>
<td>1 tbsp</td>
<td>—</td>
<td>—</td>
<td>—</td>
</tr>
<tr>
<td>Oregano, dried Greek</td>
<td>¾ tsp</td>
<td>¾ tsp</td>
<td>—</td>
<td>—</td>
<td>—</td>
</tr>
<tr>
<td>Pepper, black</td>
<td>½ tsp</td>
<td>¼ tsp</td>
<td>—</td>
<td>¼ tsp</td>
<td>—</td>
</tr>
<tr>
<td>Feta</td>
<td>1 oz / 30 g</td>
<td>—</td>
<td>1 oz (table)</td>
<td>—</td>
<td>—</td>
</tr>
<tr>
<td>Olive oil, extra-virgin</td>
<td>3 tbsp / \~40 g</td>
<td>2 tsp</td>
<td>1 tbsp</td>
<td>1 tbsp</td>
<td>1 tsp</td>
</tr>
<tr>
<td>Vinegar, red wine</td>
<td>1 tbsp</td>
<td>—</td>
<td>—</td>
<td>—</td>
<td>1 tbsp</td>
</tr>
<tr>
<td>Salt, Diamond Crystal kosher</td>
<td>1¼ tsp + 1 tbsp for barley water</td>
<td>½ tsp</td>
<td>½ tsp</td>
<td>1 tbsp (water)</td>
<td>¼ tsp</td>
</tr>
</table>
**Shared prep.** Lemons: zest both (1 tsp → Salmon, 1 tsp → Barley), then juice one (1 tsp → Broccolini) and wedge the second. Zest before juicing or cutting. Parsley: chop 2 tbsp total — 1 tbsp → Barley, 1 tbsp → Salad.
**Sourcing.** Buy the centre section of a side, not pre-cut fillets — counters routinely portion across the whole side, so one of three pre-cut pieces is often quietly a tail, and cut selection is the single biggest lever on richness. Ask for roughly 1¼ lb / 570 g off the middle, skin on; expect 450–510 g after trimming the belly and squaring the geometry. Skin-on strongly preferred for handling and clean release. Buy pearl barley, not pot or hulled — pot barley runs 50+ minutes and breaks the timeline. Feta as a small block. Japanese or Persian cucumbers only.$m$,$m$2023 Famille Grossot Chablis — paired well. Cool-climate acidity and minerality held against lemon, capers, feta and vinegar. Household finding: the Chardonnay aversion is style-specific (ripe/oaky/warm-climate), not varietal; lean unoaked Chablis was well received. No sparkling for household-only meals.$m$,$m$3b0e0391ce638127bff5fc133f4ad901$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$aegean-roasted-salmon$m$,$m$Aegean Roasted Salmon$m$,$m$Fish$m$,array[$m$Main$m$]::text[],array[$m$European$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; sunday-aegean-salmon-dinner.docx (1 Aug 2026 build)$m$,$m$v3.5$m$,$m$Centre-cut salmon under a thin lemon-and-oregano garlic oil, roasted hot and fast at 425°F / 218°C and finished off-heat with capers and dill.$m$,$m$## Ahead of the day
Portion the salmon the night before or Sunday morning, not at 4:30. Cut the trimmed centre section into three portions of **equal thickness rather than equal weight** — a side tapers, so cut narrower from the thick end and wider from the thin end so all three finish at the same height. Thickness, not weight, drives the cooking band and the probe reading. Pull the pin bones with tweezers, following the direction they lean. Trim the belly flap and square the geometry.
**Do not salt at this stage.** Lay the portions skin-down on a rack over a tray, uncovered, in the fridge, unsalted. The overnight air-dry sets up the surface for the oil, and airflow does that without salt.
## Salting — Sunday, not the night before
Salt on the day, any point from about an hour before the cook: ½ tsp Diamond Crystal kosher, **on the flesh only — the top face and the cut sides. Nothing on the skin side**, which comes off at plating and which salt barely crosses in any case.
At ½ tsp on roughly 480 g of trimmed fish (\~0.3% by weight) this is well below curing territory, so an overnight rest would not turn the fish into gravlax. But over 12–18 hours even a light salt firms the outer few millimetres, and on the thin tapered edges of a portioned side that reads dense rather than silky — with no compensating gain, since at this dose salt does not penetrate meaningfully further in sixteen hours than in one. Overnight salting earns its keep on a thick roast where salt must migrate through centimetres of muscle; a 3 cm salmon portion is not that problem.
# 1 · Aegean roasted salmon
Yield 3 · Total \~40 min · Active \~12 min · Oven 425°F / 218°C
Centre-cut salmon under a thin lemon-and-oregano oil, roasted hot and fast, finished off-heat with capers and dill. Saline, herbal and sharp rather than sweet — the fish is the only rich thing on the plate and everything else is built to cut it.
**Flavour architecture.** Base: garlic-infused olive oil. Primary driver: lemon zest and dried oregano. Acid: staged — zest is aromatic, not acid; the only acid is lemon juice squeezed at the table, a per-diner brightness control. Finish: capers, dill.
**Ingredients**
- Salmon, centre-cut, skin-on, cut to equal thickness — 3 portions, 5–6 oz / 140–170 g each
- Salt, Diamond Crystal kosher, on the flesh only — ½ tsp
- Extra-virgin olive oil — 2 tsp / 10 g
- Garlic, finely grated, infused and strained out — 1 small clove
- Lemon zest, finely grated — 1 tsp
- Dried Greek oregano — ¾ tsp
- Black pepper — ¼ tsp
- Capers in brine, rinsed, patted dry, roughly chopped — 1 tbsp
- Dill, chopped — 1 tbsp
- Lemon wedges — from 1 lemon
**Prep**
1. Salt lightly — ½ tsp on the flesh: the top face and the cut sides. Nothing on the skin side, which is discarded at plating. The capers carry the remaining salt load; do not add more.
2. Garlic oil. Warm the olive oil with the grated garlic over very low heat for 60–90 seconds, just until fragrant and not coloured — longer heating suppresses the oil's bright grassy notes, and the oil carries finished flavour here rather than acting as a cooking medium. Strain the solids out and discard them: no garlic particle should reach the fish. Stir the zest, oregano and pepper into the strained oil. *Confirmed at cook 1 — sufficient garlic presence, no scorching. Retain this method; the ¼ tsp garlic-powder fallback is not required.*
3. Rinse the capers and pat dry. Brine-wet capers stack salt against the fish, and the brine flavour is coarser than the caper itself.
4. Line the sheet pan with parchment.
**Active cooking**
1. Blot both faces dry. The surface must read matte, not beaded.
2. Brush the oil thinly over top and sides. Do not add lemon juice — it wets the surface and turns the flesh prematurely opaque.
3. At T-15, lay skin-down on the clear end of the tray alongside the broccolini. Roast 9–11 minutes.
4. **Pull at 122°F / 50°C** at the thickest point, probed horizontally into the centre of the thickest portion. **This is the finished temperature, not a pull point to be adjusted downward.** Cook 1 measured a net loss of 5–7°F / 3–4°C across a 2-minute rest on room-temperature plates — the portion cools rather than carries. A thin, low-mass, high-moisture portion out of a short roast holds no meaningful thermal reserve.
*Corroborative only:* the portion gives slightly under light pressure without separating. Do not pull it open — translucency varies with species and fat.
**Holding and assembly**
1. Rest uncovered, 3–4 minutes. The rest does no thermal work; its job is letting the surface set and giving a clean release from the skin.
2. Slide a fish slice between flesh and skin and lift. Scatter the capers and dill over the flesh — both go on after roasting: exposed capers dry and turn harsh in the oven, and roasting dulls dill's fresh aroma. Lemon wedges to the table.
**Critical control points**
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure mode</td>
<td>Sensory cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Major (b)</td>
<td>Garlic scorches — any solid particle sitting proud of the oil film blackens at 425°F</td>
<td>Dark specks on the surface; sharp burnt-bitter smell distinct from the oregano</td>
<td>Unrecoverable for those portions. Prevent: strain the infusion. Oil suspension alone does not shield garlic at this temperature</td>
</tr>
<tr>
<td>Major (b)</td>
<td>Overcooked — pulled past 122°F / 50°C</td>
<td>White albumin beading heavily across the surface</td>
<td>Unrecoverable for texture; dish remains serviceable. Lemon compensates for lost moisture perception</td>
</tr>
<tr>
<td>Major</td>
<td>Portion tears on lift — flesh grips the pan</td>
<td>Fish slice meets resistance and the flesh shears rather than releases</td>
<td>Prevented by parchment. Without it, serve the torn portion to yourself</td>
</tr>
</table>
*Adjust: if the plated fish reads flat, lemon first — the capers already carry the salt. If it reads too saline, more lemon and skip the feta on that plate.*$m$,3,array[$m$half-sheet pan$m$,$m$parchment$m$,$m$fish slice$m$,$m$Bosch oven$m$]::text[],$m$[{"param": "Salmon hold window", "designed_value": "Warm plate, uncovered, ~5–8 min", "note": "Remains designed, not validated — cook 1 observed no drift but measured none. Open question for cook 2: repeat the two-reading probe on warm plates to isolate plate mass."}]$m$::jsonb,null,$m$3b0e0391ce638127bff5fc133f4ad901$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$piece$m$, $m$3 portions, 5–6 oz / 140–170 g each$m$, $m$cut to equal thickness; pin bones pulled, belly flap trimmed$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$salmon, centre-cut, skin-on$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, $m$on the flesh only$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 10, $m$g$m$, $m$2 tsp$m$, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$clove$m$, $m$1 small clove$m$, $m$finely grated, infused and strained out$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, $m$finely grated$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.75, $m$tsp$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$dried greek oregano$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$rinsed, patted dry, roughly chopped$m$, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$capers in brine$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$chopped$m$, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$dill, fresh$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$cut into wedges$m$, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-salmon$m$ and i.name=$m$lemon$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$aegean-roasted-broccolini$m$,$m$Roasted Broccolini, Lemon$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$European$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; sunday-aegean-salmon-dinner.docx (1 Aug 2026 build)$m$,$m$v3.5$m$,$m$Blistered broccolini with charred floret tips, lifted with lemon juice off-heat; feta passed at the table.$m$,$m$# 2 · Roasted broccolini, lemon
Yield 3 · Total \~18 min · Active \~5 min · Oven 425°F / 218°C
Blistered stems with charred floret tips — the firm counterweight to the soft salmon and the chewy barley.
**Flavour architecture.** Base: olive oil, salt. Primary driver: char. Acid: lemon juice off-heat, lifting against the char. Finish: feta, passed at the table rather than tossed through, so richness stays a per-diner choice.
**Ingredients**
- Broccolini, unpeeled, ½ in / 1 cm of woody stem trimmed — 12 oz / 340 g
- Extra-virgin olive oil — 1 tbsp / 14 g
- Salt, Diamond Crystal kosher — ½ tsp
- Lemon juice — 1 tsp
- Feta, crumbled, in a separate bowl — 1 oz / 30 g
**Method**
1. Trim the woody ends. Leave unpeeled — the skins are tender at this thickness and hold the char. Halve any stem thicker than ½ in / 1 cm lengthwise.
2. Toss with oil and salt on the parchment-lined half-sheet. Spread across one end in as close to a single layer as the space allows, leaving the other end clear for the salmon. Parchment is the default: it costs a little contact char and buys much easier cleanup and no stuck florets. For maximum char, use a second bare pan.
3. In at T-20. Total 14–16 minutes, including the brief T-15 tray-out.
4. *Primary cue:* the thickest stem can be pierced easily with the tip of a knife while still holding slight resistance, and floret tips are blackened at the edges. Still rigid at 16 minutes means the end was crowded — give it 3 more.
5. Into a warm bowl, lemon juice through it while hot. Hold uncovered, \~15–20 minutes. Covering steams the char away. Feta to the table in its own bowl, never tossed through.
**CCP — Major:** crowded end, broccolini steams rather than roasts. Cue: reads wet and dull green rather than blistered at 12 minutes. Recoverable: spread onto a second pan and continue 4 minutes.
*Adjust: if under-seasoned, a pinch of salt while hot — but taste after the feta is on, since it carries salt of its own.*$m$,3,array[$m$half-sheet pan$m$,$m$parchment$m$]::text[],$m$[{"param": "Broccolini hold window", "designed_value": "Warm bowl, uncovered, ~15–20 min", "note": "Remains designed, not validated — cook 1 observed no drift but measured none."}]$m$::jsonb,null,$m$3b0e0391ce638127bff5fc133f4ad901$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 340, $m$g$m$, $m$12 oz$m$, $m$unpeeled, ½ in / 1 cm of woody stem trimmed$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-broccolini$m$ and i.name=$m$broccolini$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 14, $m$g$m$, $m$1 tbsp$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-broccolini$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-broccolini$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-broccolini$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 30, $m$g$m$, $m$1 oz$m$, $m$crumbled, in a separate bowl$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$aegean-roasted-broccolini$m$ and i.name=$m$feta$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$aegean-pearl-barley$m$,$m$Pearl Barley, Olive Oil and Lemon$m$,null,array[$m$Side$m$]::text[],array[$m$European$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; sunday-aegean-salmon-dinner.docx (1 Aug 2026 build)$m$,$m$v3.5$m$,$m$Firm, nutty pearl barley boiled like pasta and dressed hot with olive oil, lemon zest, pepper and parsley.$m$,$m$# 3 · Pearl barley, olive oil and lemon
Yield 3 with minimal surplus · Total \~45 min · Active \~5 min
Firm, nutty grains with distinct chew — dressed rather than plain, so it works as a component instead of a filler. Chosen over rice because it holds its texture against oil and lemon without going soft or sticky.
**Flavour architecture.** Base: barley, olive oil. Primary driver: the grain's own nuttiness. Acid: none — zest is aromatic only. Finish: parsley, cracked pepper.
**Ingredients**
- Barley, pearl — ¾ cup / 135 g dry
- Water, kettle-boiled — \~2 L
- Salt, Diamond Crystal kosher, for the water — 1 tbsp
- Extra-virgin olive oil — 1 tbsp / 14 g
- Lemon zest, finely grated — 1 tsp
- Black pepper, cracked — ¼ tsp
- Parsley, chopped — 1 tbsp
**Method**
1. Fill the pot from the electric kettle at T-63 and return it to a rolling boil on high. This removes an unvalidated stovetop boil time from the schedule. Salt the water.
2. Boil the barley in plenty of water like pasta, uncovered. Absorption cooking is unreliable with pearl barley; the drained method gives a far more consistent grain. **In at T-60**, 32–40 minutes.
3. **Start tasting at 28 minutes, then every 2–3 minutes.** Pearl barley varies by brand and age. Primary cue: tender with a distinct chew at the centre, grains still separate. Done at the first point it stops being chalky. *Cook 1 ran \~38 minutes — expect the long end of the band.*
4. Drain, reserving 3 tbsp of the cooking water. Toss immediately with the oil, zest, pepper and parsley while hot, so the grains absorb the oil rather than sit in it.
5. Hold covered, off heat, \~25 minutes. It tightens as it cools; loosen with the reserved water at T-3.
**Critical control points**
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure mode</td>
<td>Sensory cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Major</td>
<td>Overcooked to porridge — pearl barley goes from chewy to blown in about five minutes past done</td>
<td>Grains split open, the water turns cloudy and thick, grains stop separating</td>
<td>Unrecoverable for texture. Prevent: taste from 28 minutes</td>
</tr>
<tr>
<td>Minor</td>
<td>Under-salted water — no amount of finishing oil fixes it</td>
<td>The grain reads bland against a dressed, seasoned plate</td>
<td>Recoverable: salt while hot and toss, though it seasons the surface rather than the grain</td>
</tr>
</table>
*Adjust: if it reads oily, more lemon zest and pepper rather than less oil — the fault is usually flatness, not fat.*$m$,3,array[$m$electric kettle$m$,$m$induction hob$m$]::text[],$m$[{"param": "Barley start time", "designed_value": "Barley in at T-60, water on at T-65 (kettle on), pot back to a rolling boil at T-63", "note": "Correction from cook 1 (2 Aug 2026), where a T-52 to T-50 start with a ~38 min cook put completion at T-14 to T-12 — inside the salmon window. Designed so barley finishes T-28 to T-20 and clears the board before the oven sequence; not yet validated by a cook."}, {"param": "Barley cook band", "designed_value": "32–40 min, taste from 28 then every 2–3 min", "note": "Revised upward from the designed 30–35 min after cook 1 ran ~38 min; the revised band has not yet been validated by a cook."}, {"param": "Barley hold window", "designed_value": "Covered pot or bowl, off heat, ~25 min", "note": "Remains designed, not validated — cook 1 observed no drift but measured none."}]$m$::jsonb,null,$m$3b0e0391ce638127bff5fc133f4ad901$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 135, $m$g$m$, $m$¾ cup dry$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$aegean-pearl-barley$m$ and i.name=$m$pearl barley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2000, $m$ml$m$, $m$~2 L$m$, $m$kettle-boiled$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$aegean-pearl-barley$m$ and i.name=$m$water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$for the water$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$aegean-pearl-barley$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 14, $m$g$m$, $m$1 tbsp$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$aegean-pearl-barley$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, $m$finely grated$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$aegean-pearl-barley$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, $m$cracked$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$aegean-pearl-barley$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$chopped$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$aegean-pearl-barley$m$ and i.name=$m$parsley, flat-leaf$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$aegean-cucumber-tomato-salad$m$,$m$Cucumber and Tomato Salad$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],array[$m$European$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Healthy$m$]::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; sunday-aegean-salmon-dinner.docx (1 Aug 2026 build)$m$,$m$v3.5$m$,$m$Cold, sharp, crisp cucumber and cherry tomato salad dressed at the last minute with red wine vinegar — the plate's palate reset.$m$,$m$# 4 · Cucumber and tomato salad
Yield 3 · Total \~10 min · Active \~5 min · No heat
Cold, sharp, crisp — the palate reset, and the only component that resets between rich mouthfuls. Not optional.
**Flavour architecture.** Base: none. Primary driver: red wine vinegar. Acid: single-stage — a no-cook preparation where the acid is the dressing. Finish: parsley.
**Ingredients**
- Cucumbers, Japanese or Persian, unpeeled, sliced 3 mm — 2
- Tomatoes, cherry, halved — 200 g
- Red wine vinegar — 1 tbsp
- Extra-virgin olive oil — 1 tsp
- Salt, Diamond Crystal kosher — ¼ tsp
- Parsley, chopped — 1 tbsp
**Method**
1. Slice the cucumbers 3 mm, unpeeled — the thin skin supplies the snap and colour. Halve the tomatoes.
2. Hold the components sealed in the fridge, undressed. This is a deliberate departure from a salted-and-drained sunomono, which needs a squeeze, a timed hold and a mandatory drain. Dressing at the table's edge removes every one of those failure modes.
3. At T-3, pour off any pooled liquid, then dress with the vinegar, oil, salt and parsley and toss once. Serve within a few minutes.
**Validated substitution — no cherry tomatoes.** Use 3 cucumbers in place of 2 cucumbers plus the tomatoes, and dissolve **½ tsp sugar** into the red wine vinegar before dressing. The tomatoes are the only source of sweetness on the entire plate; without compensation the salad reads flat-sharp against a menu already built on lemon, capers and vinegar. Hold the salt at ¼ tsp despite the greater volume. Confirmed at cook 1 with no adverse effect. **Do not substitute tinned tomatoes** — soft, wet and cooked-tasting, they remove the cold raw crunch that is the salad's whole purpose here. Olives are thematically apt but push the plate over on salt, which is this menu's accumulation risk.
*CCPs: not applicable — no heat, no irreversible step. The one drift risk, weeping, is designed out by dressing at T-3.*
*Adjust: if flat, salt before more vinegar — under-salted tomato reads sour rather than sharp.*$m$,3,'{}'::text[],$m$[{"param": "Salad hold window", "designed_value": "Components sealed in fridge, undressed, ~2 hr", "note": "Remains designed, not validated — cook 1 observed no drift but measured none."}]$m$::jsonb,null,$m$3b0e0391ce638127bff5fc133f4ad901$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$unpeeled, sliced 3 mm$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$aegean-cucumber-tomato-salad$m$ and i.name=$m$cucumber, japanese or persian$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 200, $m$g$m$, null, $m$halved$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$aegean-cucumber-tomato-salad$m$ and i.name=$m$cherry tomato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$aegean-cucumber-tomato-salad$m$ and i.name=$m$red wine vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$aegean-cucumber-tomato-salad$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$aegean-cucumber-tomato-salad$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, $m$chopped$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$aegean-cucumber-tomato-salad$m$ and i.name=$m$parsley, flat-leaf$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$aegean-salmon-dinner$m$ and d.slug=$m$aegean-roasted-salmon$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$aegean-salmon-dinner$m$ and d.slug=$m$aegean-roasted-broccolini$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$aegean-salmon-dinner$m$ and d.slug=$m$aegean-pearl-barley$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$aegean-salmon-dinner$m$ and d.slug=$m$aegean-cucumber-tomato-salad$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-08-02$m$::date, 9, 10, $m$yes$m$::repeat_verdict, $m$Cook 1, 2 Aug 2026. Flavour 9, execution 10, no recovery actions required; the menu ran as written under a 4:30 arrival. One deviation: cherry tomatoes were not purchased, substituted a third cucumber plus 1/2 tsp sugar dissolved into the red wine vinegar to replace the plate's only source of sweetness — no adverse effect, treat as a validated fallback. Two designed parameters resolved against the cook: the salmon showed no carryover and instead lost 5-7F/3-4C on room-temperature plates (pulled 122F, read 115-117F at \~2 min), so 122F/50C is the finished temperature and must not be adjusted downward; and pearl barley ran \~38 min against a designed 30-35 band, which places completion inside the salmon window — start barley at T-60, not T-52. Strained garlic oil confirmed; retain the infusion, do not test the powder fallback.

## Cook 1 — 2 August 2026
**Recipe source:** Governance framework v3.5 · `sunday-aegean-salmon-dinner.docx`, 1 Aug 2026 build (post-salting-correction, post-Post-Cook-Logging relocation)
**Serves:** 3 (Jin, Hui Fong — moderate carb; Lukas — full portion) · Arrival 4:15–4:30, service 5:30
**Rating:** 9 · **Execution:** 10 · **Repeat?** Yes
### Menu as cooked
- Aegean roasted salmon — lemon zest, oregano, strained garlic oil, capers, dill
- Roasted broccolini, lemon; feta passed at the table
- Pearl barley with olive oil, lemon zest and parsley
- Cucumber salad, red wine vinegar *(deviation — see below)*
### Actual deviations
**Cherry tomatoes omitted — not purchased.** Substituted a third cucumber (3 total, unchanged method) plus ½ tsp sugar dissolved into the red wine vinegar. The sugar was added because the tomatoes were the only source of sweetness on the entire plate; without compensation the salad would have read flat-sharp against a menu already built on lemon, capers and vinegar. Salt held at ¼ tsp despite the increased volume, since capers and feta already carry the plate's salt load. The substitution effectively reverts the salad toward the sunomono of the earlier miso menu, which performed the same relieving function. Outcome: no adverse effect recorded; execution rated 10 with the substitution in place.
No other deviations. Tinned tomatoes were considered and rejected — soft, wet and cooked-tasting, they would have removed the cold raw crunch that is the salad's entire purpose on this plate.
### Designed-parameter confirmation
**1. Salmon carryover — FAILED. Designed figure falsified; direction reversed.**
<table header-row="true">
<tr>
<td></td>
<td></td>
</tr>
<tr>
<td>Designed</td>
<td>Pull 122°F / 50°C, carries **+3°F / +2°C** to a finished 125°F / 52°C</td>
</tr>
<tr>
<td>Observed</td>
<td>Pulled 122°F / 50°C; **115–117°F / 46–47°C** at \~2 minutes. Net **loss of 5–7°F / 3–4°C**</td>
</tr>
<tr>
<td>Verdict</td>
<td>No carryover occurred. The portion cooled throughout the rest.</td>
</tr>
</table>
**Observed configuration (the finding is valid only for these conditions):** 5–6 oz / 140–170 g centre-cut salmon portion cut to uniform thickness (\~3 cm); 425°F / 218°C conventional, lower-middle rack, parchment-lined half-sheet shared with broccolini; rested uncovered on **room-temperature** plates; reading taken \~2 minutes after removal.
**Interpretation.** The room-temperature plate was a deliberate experimental control, adopted so plate mass would not contaminate the measurement — and it is very likely amplifying the loss. A warm plate would reduce it, possibly to near zero, but would not plausibly turn it positive. The underlying cause is mass: a thin, low-mass, high-moisture portion out of a short roast holds no meaningful thermal reserve, and applying steak-derived carryover reasoning to it was the original error.
**Consequence for the next cook — do not pull below 122°F expecting carryover.** The fish was recorded as perfectly cooked, which means 122°F / 50°C is functioning as the *finished* temperature, not as a pre-carryover pull point. Treat the rest as thermally neutral-to-negative. Its stated job — letting the surface set and giving clean release from the skin — is unchanged and was confirmed by a clean lift.
**Open question for cook 2:** repeat on warm plates and record both readings. That isolates plate mass as the single variable and establishes whether the practical loss is 5–7°F or closer to zero under normal service conditions.
**2. Pearl barley timing — DRIFTED. Band revised upward.**
<table header-row="true">
<tr>
<td></td>
<td></td>
</tr>
<tr>
<td>Designed</td>
<td>30–35 min, taste from 25, then every 2–3 min</td>
</tr>
<tr>
<td>Observed</td>
<td>**\~38 min** to done</td>
</tr>
<tr>
<td>Revised</td>
<td>**32–40 min**, continue tasting from 28</td>
</tr>
</table>
**Workflow consequence, and the more important half of this finding.** The timeline placed barley in the pot at T-52 to T-50. At 38 minutes that puts completion at T-14 to T-12 — inside the salmon window, and after the T-15 tray-out that the schedule assumes is clear. It did not bite this time (execution 10), but the margin was consumed rather than held. **Next cook: barley in at T-60, water on at T-65.** The barley then finishes at T-22 and clears the board before the oven sequence begins, which is what the design intended.
**3. Strained garlic oil — CONFIRMED.** 60–90 seconds on very low heat, solids strained out. Sufficient garlic presence; no scorching, no dark specks. Retain the infusion method. The ¼ tsp garlic-powder fallback is not required and should not be tested.
**4. Hold windows — no drift reported.** Barley (covered, \~25 min ceiling), broccolini (uncovered), salad (undressed to T-3), salmon (\~5–8 min). All remain designed rather than validated; nothing was observed to contradict them, but nothing was measured either.
### Wine pairing outcome
**2023 Famille Grossot Chablis** — paired well. Cool-climate acidity and minerality held against lemon, capers, feta and the vinegar salad, which is the pairing predicted throughout the design conversation but blocked until the day of the cook by the standing Chardonnay exclusion.
**Household finding, and the reason this matters beyond one dinner:** the Chardonnay aversion is style-specific, not varietal. Ripe, oaky, warm-climate Chardonnay remains the thing being avoided; lean unoaked Chablis is not that wine and was well received. This is the evidence behind the governance change loosening the exclusion for bottles held in the cellar. Buying guidance is unaffected — Chardonnay stays low-priority against Chenin Blanc, Riesling and Sauvignon/Sémillon when advising purchases.
Sparkling remains excluded for household-only meals: no Coravin for sparkling means the bottle must be finished.
### Key success
Menu architecture and one-tray oven sequence both held under a 4:30 arrival; execution 10 with no recovery actions required.
### Key failure
None at the dish level. The failures were in the *documented parameters*, not the cooking: carryover falsified, barley band short, and the barley start time consequently too late.
### Next time
1. Barley in at T-60 (water on at T-65), not T-52 to T-50.
2. Revise barley band to 32–40 min; keep tasting from 28.
3. Pull salmon at 122°F / 50°C and treat that as final — no downward adjustment for carryover.
4. Repeat the two-reading probe on **warm** plates to isolate plate mass.
5. Buy the cherry tomatoes — but the 3-cucumber-plus-sugar salad is a validated fallback, not a compromise.
### Schema gap
No Greek / Mediterranean option under Cuisine; tagged European, which is accurate but low-signal. Tags left blank deliberately: One-Pan is misleading (a half-sheet plus a barley pot plus a no-cook salad), 30 Min is wrong (\~60 min door to table), and Make-Ahead overstates what is genuinely only an ahead-of-day protein prep. Worth adding a Mediterranean cuisine option and possibly a "Weeknight-Fast" or "Under 60 Min" tag.$m$, $m$["Cherry tomatoes omitted — not purchased. Substituted a third cucumber (3 total, unchanged method) plus ½ tsp sugar dissolved into the red wine vinegar; salt held at ¼ tsp. No adverse effect — treat as a validated fallback."]$m$::jsonb, $m$[{"param": "Salmon carryover", "designed": "Pull 122°F / 50°C, carries +3°F / +2°C to a finished 125°F / 52°C", "observed": "Pulled 122°F / 50°C; 115–117°F / 46–47°C at ~2 minutes on room-temperature plates — net loss of 5–7°F / 3–4°C; no carryover occurred", "verdict": "diverged"}, {"param": "Pearl barley timing", "designed": "30–35 min, taste from 25, then every 2–3 min", "observed": "~38 min to done; band revised to 32–40 min, tasting from 28; start moved to T-60", "verdict": "diverged"}, {"param": "Strained garlic oil", "designed": "60–90 seconds on very low heat, solids strained out", "observed": "Sufficient garlic presence; no scorching, no dark specks — retain the infusion; garlic-powder fallback not required", "verdict": "confirmed"}, {"param": "Hold windows (barley ~25 min covered; broccolini uncovered; salad undressed to T-3; salmon ~5–8 min)", "designed": "As designed", "observed": "No drift reported; nothing measured", "verdict": "unresolved"}]$m$::jsonb, $m$Serves 3 (Jin, Hui Fong — moderate carb; Lukas — full portion). Household finding: the Chardonnay aversion is style-specific (ripe/oaky/warm-climate), not varietal — lean unoaked Chablis was well received.$m$, $m$**2023 Famille Grossot Chablis** — paired well. Cool-climate acidity and minerality held against lemon, capers, feta and the vinegar salad, which is the pairing predicted throughout the design conversation but blocked until the day of the cook by the standing Chardonnay exclusion.
**Household finding, and the reason this matters beyond one dinner:** the Chardonnay aversion is style-specific, not varietal. Ripe, oaky, warm-climate Chardonnay remains the thing being avoided; lean unoaked Chablis is not that wine and was well received. This is the evidence behind the governance change loosening the exclusion for bottles held in the cellar. Buying guidance is unaffected — Chardonnay stays low-priority against Chenin Blanc, Riesling and Sauvignon/Sémillon when advising purchases.
Sparkling remains excluded for household-only meals: no Coravin for sparkling means the bottle must be finished.$m$ from public.meal m where m.slug=$m$aegean-salmon-dinner$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$avgolemono-supper$m$,$m$Greek Lemon Chicken Avgolemono Soup with Toasted Pita$m$,$m$2026-05-10$m$,$m$cooked$m$::meal_status,3,$m$## Meal Workflow
### Critical Path
The avgolemono finish governs service timing. Once the egg-lemon mixture is added, the soup must not boil and should be served immediately.
### Timeline
- T-75 min — Start broth and chicken
- T-45 min — Prep greens, herbs, lemon, eggs, pita
- T-35 min — Preheat oven to 375°F / 190°C
- T-20 min — Remove chicken; shred
- T-15 min — Bake pita
- T-10 min — Return chicken and greens
- T-5 min — Temper avgolemono
- T-0 — Serve immediately
### Holding Chain
- Soup before avgolemono: hold covered over very low heat up to 30 minutes.
- Soup after avgolemono: hold off heat up to 10 minutes. Do not boil.
- Reheating after avgolemono: low heat only; stop before simmering.
- Pita: hold uncovered at room temperature.$m$,null,$m$2024 Hans Greyl Sauvignon Blanc Marlborough$m$,$m$35ce0391ce6381e89a6ef797f0f5ccf9$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$avgolemono-soup$m$,$m$Greek Lemon Chicken Avgolemono Soup$m$,$m$Chicken$m$,array[$m$Soup$m$]::text[],array[$m$European$m$]::text[],$m$Easy$m$,array[$m$One-Pan$m$]::text[],array[$m$Healthy$m$,$m$Family$m$,$m$Weeknight$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT / Cooking Project$m$,null,$m$A bright, restorative Greek lemon chicken soup built around silky avgolemono broth, tender shredded chicken, greens, dill, and parsley — intentionally soft throughout, with toasted pita for crisp contrast.$m$,$m$# Dish 1: Greek Lemon Chicken Avgolemono Soup
## Dish Overview
A bright, restorative Greek lemon chicken soup built around silky avgolemono broth, tender shredded chicken, greens, dill, and parsley. The soup is intentionally soft throughout; toasted pita provides the required crisp contrast.
## Yield & Timing
Serves: 4
Total time: 55–65 minutes
Active time: 20–25 minutes
## Ingredient List
### Soup Base
- 900 g / 2 lb bone-in, skin-on chicken thighs
- 1.5 L / 6¼ cups chicken stock
- 240 ml / 1 cup water
- 1 medium onion, halved
- 1 large carrot, diced
- 1 celery rib, diced
- 2 garlic cloves, lightly crushed
- 1 bay leaf
- 1½ tsp Diamond Crystal kosher salt
- ½ tsp black pepper
### Greens & Finish
- 100–150 g spinach, kale, or Swiss chard
- 2 tbsp chopped fresh dill
- 2 tbsp chopped fresh parsley
### Avgolemono
- 3 large eggs
- 60 ml / ¼ cup fresh lemon juice
## Flavor Architecture
<table header-row="true">
<tr>
<td>Element</td>
<td>Function</td>
</tr>
<tr>
<td>Base</td>
<td>Chicken stock, chicken thighs, onion, carrot, celery, garlic</td>
</tr>
<tr>
<td>Primary flavor driver</td>
<td>Lemon-chicken broth</td>
</tr>
<tr>
<td>Acid component</td>
<td>Lemon juice added through avgolemono finish; single-stage acid is intentional because the egg-lemon emulsion should not boil</td>
</tr>
<tr>
<td>Aromatic / finish</td>
<td>Dill and parsley off heat</td>
</tr>
</table>
## Texture Architecture
This soup is intentionally broth-forward and soft: silky broth, tender chicken, wilted greens. Toasted pita provides the required crisp contrast.
## Prep Phase
1. Rinse and prep greens.
2. Juice lemons.
3. Whisk eggs separately.
4. Chop dill and parsley.
5. Cut pita into wedges.
## Active Cooking
### 1. Build Broth
1. Combine chicken, stock, water, onion, carrot, celery, garlic, bay, salt, and pepper.
2. Bring to gentle simmer over medium-high heat.
3. Reduce to low / medium-low.
4. Simmer:
	- Bone-in thighs: 35–45 minutes
	- Boneless thighs: 22–28 minutes
### Doneness Rule — Chicken
Stop when the thickest part reaches 175–185°F / 79–85°C and the meat pulls cleanly from the bone with no resistance.
1. Remove chicken to plate. Rest uncovered 10 minutes.
2. Discard skin, bones, onion, garlic, and bay.
3. Shred chicken.
### 2. Add Chicken and Greens
1. Bring broth back to simmer.
2. Return chicken.
3. Add greens.
4. Simmer until greens are tender but still visibly green.
### 3. Temper Avgolemono
1. Whisk eggs and lemon juice.
2. Slowly whisk in 480 ml / 2 cups hot broth.
3. Turn heat off.
4. Stir tempered mixture into soup.
5. Do not boil.
## Holding & Assembly
1. Hold off heat up to 10 minutes after avgolemono.
2. Reheat only over low heat if necessary.
3. Stir in dill and parsley immediately before serving.
4. Serve with toasted pita alongside.
## Critical Control Points
<table header-row="true">
<tr>
<td>Severity</td>
<td>Failure Mode</td>
<td>Cue</td>
<td>Recovery</td>
<td>Outcome</td>
</tr>
<tr>
<td>Critical</td>
<td>Avgolemono curdles</td>
<td>Grainy texture or egg strands</td>
<td>Unrecoverable</td>
<td>Loss of silky texture</td>
</tr>
<tr>
<td>Major</td>
<td>Hard broth boil</td>
<td>Cloudy broth, tightened chicken</td>
<td>Reduce heat immediately</td>
<td>Tougher chicken</td>
</tr>
<tr>
<td>Major</td>
<td>Greens overcook</td>
<td>Olive-colored greens</td>
<td>Stop earlier next time</td>
<td>Dull flavor and appearance</td>
</tr>
</table>
## Adjustment Notes
<table header-row="true">
<tr>
<td>Adjustment</td>
<td>Guidance</td>
</tr>
<tr>
<td>Salt</td>
<td>Adjust after avgolemono incorporation</td>
</tr>
<tr>
<td>Acid</td>
<td>Add small extra lemon only bowl-by-bowl if needed</td>
</tr>
<tr>
<td>Texture</td>
<td>Loosen with hot stock if broth thickens</td>
</tr>
</table>
## Scaling Notes
For 6–8 servings, use a wider pot and add greens in batches.$m$,4,'{}'::text[],$m$[]$m$::jsonb,null,$m$35ce0391ce6381e89a6ef797f0f5ccf9$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 900, $m$g$m$, $m$2 lb$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$chicken thigh, bone-in, skin-on$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1500, $m$ml$m$, $m$6¼ cups$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$chicken stock$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 240, $m$ml$m$, $m$1 cup$m$, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$medium, halved$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$large, diced$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$carrot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$diced$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$celery rib$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, null, $m$lightly crushed$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$bay leaf$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tsp$m$, null, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$kosher salt, diamond crystal$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 100, $m$g$m$, $m$100–150 g$m$, null, false, false, 11
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$spinach, kale, or swiss chard$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$chopped$m$, false, false, 12
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$fresh dill$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$chopped$m$, false, false, 13
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$fresh parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$piece$m$, null, $m$large$m$, false, false, 14
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$egg$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 60, $m$ml$m$, $m$¼ cup$m$, null, false, false, 15
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-soup$m$ and i.name=$m$fresh lemon juice$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$avgolemono-toasted-pita$m$,$m$Toasted Pita Wedges$m$,null,array[$m$Bread$m$]::text[],array[$m$European$m$]::text[],null,'{}'::text[],array[$m$Healthy$m$,$m$Family$m$,$m$Weeknight$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT / Cooking Project$m$,null,$m$Light crisp pita wedges providing dry crunch contrast to the soft soup.$m$,$m$# Dish 2: Toasted Pita Wedges
## Dish Overview
Light crisp pita wedges providing dry crunch contrast to the soft soup.
## Yield & Timing
Serves: 4
Total time: 8–10 minutes
## Ingredient List
- 2 pita rounds
- 10 ml / 2 tsp olive oil
- Fine sea salt
## Active Cooking
1. Heat oven to 375°F / 190°C.
2. Brush pita lightly with olive oil.
3. Bake 6–8 minutes, flipping once.
### Doneness Rule
Stop when edges are crisp and lightly golden. Continue if still flexible.
## Holding & Assembly
Hold uncovered at room temperature.
## Critical Control Points
<table header-row="true">
<tr>
<td>Severity</td>
<td>Failure Mode</td>
<td>Cue</td>
<td>Recovery</td>
<td>Outcome</td>
</tr>
<tr>
<td>Major</td>
<td>Under-toasted pita</td>
<td>Flexible throughout</td>
<td>Return to oven briefly</td>
<td>Weak texture contrast</td>
</tr>
</table>$m$,4,'{}'::text[],$m$[]$m$::jsonb,null,$m$35ce0391ce6381e89a6ef797f0f5ccf9$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-toasted-pita$m$ and i.name=$m$pita round$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 10, $m$ml$m$, $m$2 tsp$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-toasted-pita$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$avgolemono-toasted-pita$m$ and i.name=$m$fine sea salt$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$soup$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$avgolemono-supper$m$ and d.slug=$m$avgolemono-soup$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$bread$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$avgolemono-supper$m$ and d.slug=$m$avgolemono-toasted-pita$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-05-10$m$::date, 9.5, 9, $m$yes$m$::repeat_verdict, $m$Avgolemono temper is the single critical execution point — remove from heat fully before adding the mixture. Bone-in thighs at 35 min was correct. Greens added at end retained colour well. Pita needs to be watched; 6 min was sufficient in this oven.$m$, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$avgolemono-supper$m$;
commit;
