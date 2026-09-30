begin;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$baharat-lamb-shoulder-dinner$m$,$m$Baharat Sealed-Roasted Lamb Shoulder Menu (3 pax + reserve)$m$,$m$2026-08-16$m$,$m$cooked$m$::meal_status,3,null,null,$m$Not recorded. 2021 Château Mont-Redon Châteauneuf-du-Pape was the recommendation (primary), with 2019 La Rioja Alta Viña Ardanza Reserva as backup. Confirm on next cook.$m$,$m$3bee0391ce63817b80c5cc7c4b57020c$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$baharat-lamb-shoulder-onion-bed$m$,$m$Baharat Sealed-Roasted Bone-In Lamb Shoulder with Jammy Onion Bed$m$,$m$Lamb$m$,array[$m$Main$m$]::text[],'{}'::text[],$m$Medium$m$,'{}'::text[],'{}'::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; dual-model review loop (Claude + GPT, 3 rounds to stability); baharat-lamb-shoulder-dinner-2piece.docx (15 Aug 2026 build)$m$,$m$v3.5$m$,$m$Two bone-in lamb shoulders dry-brined overnight, rubbed with baharat and sealed-roasted over an onion bed at 300°F / 150°C with no added liquid.$m$,null,null,array[$m$roasting tray$m$,$m$heavy-duty foil$m$,$m$Bosch single oven$m$]::text[],$m$[{"param": "Sealed-roast band", "designed_value": "2½–3½ hr at 1.3 kg per piece", "note": "Unconfirmed at cook 1 (16 Aug 2026) — actual elapsed time and the gap between pieces not recorded. Record elapsed time to endpoint per piece next cook."}, {"param": "Sealed hold", "designed_value": "90 min at 170°F / 75°C", "note": "Not exercised / unrecorded at cook 1."}, {"param": "Reserve reheat in unfinished jus", "designed_value": "Reheat the reserve piece in the unfinished jus", "note": "Pending — reheat had not occurred at time of logging."}]$m$::jsonb,null,$m$3bee0391ce63817b80c5cc7c4b57020c$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, $m$2 × 1.316 kg$m$, $m$White Pyrenees, Butcher Box SG; 1% dry brine overnight uncovered$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$baharat-lamb-shoulder-onion-bed$m$ and i.name=$m$lamb shoulder, bone-in$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 13, $m$g$m$, $m$13 g per piece (1% dry brine)$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$baharat-lamb-shoulder-onion-bed$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$piece$m$, $m$3 large$m$, $m$onion bed$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$baharat-lamb-shoulder-onion-bed$m$ and i.name=$m$brown onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$strained, on the onion bed$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$baharat-lamb-shoulder-onion-bed$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$rub$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$baharat-lamb-shoulder-onion-bed$m$ and i.name=$m$baharat$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$baharat-pomegranate-lemon-jus$m$,$m$Pomegranate–Lemon Jus$m$,null,array[$m$Sauce$m$]::text[],'{}'::text[],null,'{}'::text[],'{}'::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; dual-model review loop (Claude + GPT, 3 rounds to stability); baharat-lamb-shoulder-dinner-2piece.docx (15 Aug 2026 build)$m$,null,$m$Sour-sweet jus built from the lamb roasting juices with pomegranate and lemon.$m$,null,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$3bee0391ce63817b80c5cc7c4b57020c$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tsp$m$, null, $m$cook 1: substituted with a homemade reduction from ~100 ml pomegranate juice to ~30 ml, lemon at the end$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$baharat-pomegranate-lemon-jus$m$ and i.name=$m$pomegranate molasses$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$baharat-pomegranate-lemon-jus$m$ and i.name=$m$lemon$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$from the sealed roast$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$baharat-pomegranate-lemon-jus$m$ and i.name=$m$lamb roasting juices$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$baharat-lemon-parsley-couscous$m$,$m$Lemon-Parsley Couscous$m$,null,array[$m$Side$m$]::text[],'{}'::text[],null,'{}'::text[],'{}'::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; dual-model review loop (Claude + GPT, 3 rounds to stability); baharat-lamb-shoulder-dinner-2piece.docx (15 Aug 2026 build)$m$,null,$m$Couscous dressed with lemon zest and parsley (swapped in for the designed lemon-parsley bulgur).$m$,null,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$3bee0391ce63817b80c5cc7c4b57020c$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$baharat-lemon-parsley-couscous$m$ and i.name=$m$couscous$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$baharat-lemon-parsley-couscous$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$baharat-lemon-parsley-couscous$m$ and i.name=$m$parsley$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$baharat-fattoush$m$,$m$Cucumber, Tomato and Radish Fattoush$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],'{}'::text[],null,'{}'::text[],'{}'::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; dual-model review loop (Claude + GPT, 3 rounds to stability); baharat-lamb-shoulder-dinner-2piece.docx (15 Aug 2026 build)$m$,null,$m$Cucumber, tomato and radish fattoush with vinegar and sumac.$m$,null,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$3bee0391ce63817b80c5cc7c4b57020c$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$baharat-fattoush$m$ and i.name=$m$cucumber$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$baharat-fattoush$m$ and i.name=$m$tomato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$baharat-fattoush$m$ and i.name=$m$radish$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$baharat-fattoush$m$ and i.name=$m$sumac$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$baharat-fattoush$m$ and i.name=$m$vinegar$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$baharat-tahini-yogurt-sauce$m$,$m$Tahini-Yogurt Sauce$m$,null,array[$m$Sauce$m$]::text[],'{}'::text[],null,'{}'::text[],'{}'::text[],$m$cooked$m$::dish_status,$m$Claude / Jin — governance framework v3.5; dual-model review loop (Claude + GPT, 3 rounds to stability); baharat-lamb-shoulder-dinner-2piece.docx (15 Aug 2026 build)$m$,null,$m$Tahini-yogurt sauce, passed at the table.$m$,null,null,'{}'::text[],$m$[]$m$::jsonb,null,$m$3bee0391ce63817b80c5cc7c4b57020c$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$baharat-tahini-yogurt-sauce$m$ and i.name=$m$tahini$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$baharat-tahini-yogurt-sauce$m$ and i.name=$m$yogurt$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$baharat-lamb-shoulder-dinner$m$ and d.slug=$m$baharat-lamb-shoulder-onion-bed$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$baharat-lamb-shoulder-dinner$m$ and d.slug=$m$baharat-pomegranate-lemon-jus$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$baharat-lamb-shoulder-dinner$m$ and d.slug=$m$baharat-lemon-parsley-couscous$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$baharat-lamb-shoulder-dinner$m$ and d.slug=$m$baharat-fattoush$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 5 from public.meal m, public.dish d where m.slug=$m$baharat-lamb-shoulder-dinner$m$ and d.slug=$m$baharat-tahini-yogurt-sauce$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-08-16$m$::date, 8.5, 7, $m$with_modifications$m$::repeat_verdict, $m$First cook. Flavour 8.5, execution 7. Two 1.3 kg bone-in shoulders sealed-roasted over an onion bed at 300F/150C, no added liquid; Sunday's piece blasted at 425F/220C, reserve piece pulled unblasted. Two execution failures: (1) foil seal on the roasting tray failed and juices escaped — a foil crimp will not hold the liquid volume from 2.6 kg of lamb over three hours; next cook requires a lidded vessel, either a roasting pan with a fitted lid or the two Le Creusets split one piece each. (2) Lamb read less tender than the Feb 2026 slow-roasted shoulder. Root cause is the endpoint target, not the technique: this recipe deliberately specified sliceable (probe resistance, shoulder holding together) and explicitly excluded the fork-twist/shreddable test. Jin prefers the softer endpoint — next cook targets shreddable. Deviations: full prep executed in the afternoon rather than the designed morning make-ahead; pomegranate molasses substituted with a homemade reduction from pomegranate juice (\~100 ml to \~30 ml, lemon at the end). Bulgur swapped for couscous pre-cook. Schema gap: no Middle Eastern / Levantine option in Cuisine — left blank rather than force-fit to Modern.

## Cook record — 16 August 2026
**Recipe version:** governance v3.5; `baharat-lamb-shoulder-dinner-2piece.docx`, 15 Aug 2026 build.
**Configuration:** 2 × 1.316 kg bone-in shoulder (White Pyrenees, Butcher Box SG), 1% dry brine (13 g Diamond Crystal per piece) overnight uncovered. Roasting tray, double-sealed with heavy foil, onion bed of 3 large brown onions plus strained garlic. Bosch single oven.
**Rating:** 8.5 flavour · **Execution:** 7 · **Repeat?** With Modifications — vessel change and softer endpoint required.
### Deviations from the designed recipe
<table header-row="true">
<tr>
<td>Designed</td>
<td>Actual</td>
</tr>
<tr>
<td>Morning make-ahead: rub, tray assembly, sauce; tray refrigerated</td>
<td>All prep executed in the afternoon</td>
</tr>
<tr>
<td>Pomegranate molasses, 2 tsp</td>
<td>Homemade reduction from pomegranate juice (\~100 ml → \~30 ml, lemon at the end)</td>
</tr>
<tr>
<td>Lemon-parsley bulgur</td>
<td>Lemon-parsley couscous (swapped pre-cook)</td>
</tr>
</table>
### What performed as intended
Flavour architecture held at 8.5. The warm baharat spice set over lamb, with the pomegranate-lemon jus as sour-sweet counterweight, produced no palate fatigue across the meal. The homemade pomegranate reduction was an adequate substitute; no flavour deficit attributed to it. Differentiated acid registers (pomegranate-lemon in the jus, lemon zest in the couscous, vinegar and sumac in the fattoush) worked as designed.
### Failure 1 — foil seal breach (Critical CCP fired)
Juices escaped the foil seal during the roast. The recipe's Critical CCP for seal failure was written for the case of a dry tray; the observed failure was the inverse — liquid volume exceeding what a crimped foil edge can retain.
**Root cause:** 2.6 kg of lamb over roughly three hours generates more liquid than a foil crimp will hold. The tray was specified because two pieces would not seal in a single Le Creuset; foil was accepted as the sealing mechanism without accounting for the liquid load at this weight.
**Correction for next cook:** a vessel with a mechanical lid. Either a roasting pan with a fitted lid, or the wide and narrow Le Creusets split one piece each — the latter also resolves per-piece skewer checks and gives independent control over the two divergent paths.
### Failure 2 — endpoint target, not execution
Lamb read less tender than the Slow-Roasted Bone-In Lamb Shoulder (22 Feb 2026, 9.5).
**This is a design decision surfacing, not a cooking error.** The recipe deliberately targeted *sliceable* — probe entering the thickest muscle with very little resistance while the shoulder retains enough structure to carve into thick irregular slices — and explicitly excluded the fork-twist/shreddable test as pushing the endpoint too far. The cook landed where it was aimed.
**Jin's stated preference: target softer on the next cook.** This changes the recipe's endpoint specification, not the method. Next build should specify the shreddable endpoint and accept the presentation consequence (pulled or chunked rather than sliced).
**Comparison limitation:** the February entry carries no cook notes, no execution rating and no times made, so there is no recorded parameter set to quantify how much further it was taken. The gap is noted; this entry exists partly to avoid repeating it.
### Designed parameters — confirmation status
Three parameters carried the *designed, not validated* label. All three remain unconfirmed from this cook; timings and hold behaviour were not recorded on the night.
<table header-row="true">
<tr>
<td>Parameter</td>
<td>Status</td>
</tr>
<tr>
<td>Sealed-roast band 2½–3½ hr at 1.3 kg per piece</td>
<td>**Unconfirmed** — actual elapsed time and the gap between pieces not recorded</td>
</tr>
<tr>
<td>90-min sealed hold at 170°F / 75°C</td>
<td>**Not exercised / unrecorded**</td>
</tr>
<tr>
<td>Reserve reheat in unfinished jus</td>
<td>**Pending** — reheat had not occurred at time of logging</td>
</tr>
</table>
Note for the next cook: record elapsed time to endpoint for each piece, and the gap between them. Without it the band stays designed indefinitely.
### Household
No split recorded. Served 3 (Jin, Hui Fong, Lukas); reserve piece banked as two meals for 2.
### Wine
Not recorded. 2021 Château Mont-Redon Châteauneuf-du-Pape was the recommendation (primary), with 2019 La Rioja Alta Viña Ardanza Reserva as backup. Confirm on next cook.
---
## Next-time changes
1. **Lidded vessel, not foil.** Roasting pan with a fitted lid, or split across the two Le Creusets, one piece each.
2. **Target the shreddable endpoint.** Revise the endpoint specification and the associated CCP; accept pulled or chunked presentation.
3. **Record elapsed time to endpoint per piece** so the 2½–3½ hr band can move from designed to validated.
4. Morning make-ahead remains available but was not required — the afternoon sequence worked.
## Schema gap
Cuisine has no Middle Eastern or Levantine option. Left blank rather than force-fit to Modern (the Za'atar Chicken Menu precedent). Same gap class as the West African Peanut Stew entry.
## Governance note
One change may meet the codification threshold on a second occurrence: *sealing mechanism must be matched to expected liquid volume, not only to vessel geometry*. This is adjacent to the existing v3.3 vessel-geometry rule but distinct — geometry governs depth, sealing mechanism governs retention. Single occurrence; deferred, not proposed.$m$, $m$["Morning make-ahead (rub, tray assembly, sauce; tray refrigerated) → all prep executed in the afternoon", "Pomegranate molasses, 2 tsp → homemade reduction from pomegranate juice (~100 ml → ~30 ml, lemon at the end)", "Lemon-parsley bulgur → lemon-parsley couscous (swapped pre-cook)", "Foil seal on the roasting tray failed and juices escaped — a foil crimp will not hold the liquid volume from 2.6 kg of lamb over three hours"]$m$::jsonb, $m$[{"param": "Sealed-roast band 2½–3½ hr at 1.3 kg per piece", "designed": "2½–3½ hr", "observed": "Actual elapsed time and the gap between pieces not recorded", "verdict": "unresolved"}, {"param": "90-min sealed hold at 170°F / 75°C", "designed": "90 min at 170°F / 75°C", "observed": "Not exercised / unrecorded", "verdict": "unresolved"}, {"param": "Reserve reheat in unfinished jus", "designed": "Reheat in unfinished jus", "observed": "Pending — reheat had not occurred at time of logging", "verdict": "unresolved"}, {"param": "Endpoint texture", "designed": "Sliceable — probe resistance, shoulder holding together; fork-twist/shreddable test excluded", "observed": "Landed sliceable as aimed, but read less tender than the Feb 2026 slow-roasted shoulder; Jin prefers the softer endpoint — next cook targets shreddable", "verdict": "diverged"}]$m$::jsonb, $m$No split recorded. Served 3 (Jin, Hui Fong, Lukas); reserve piece banked as two meals for 2.$m$, $m$Not recorded. 2021 Château Mont-Redon Châteauneuf-du-Pape was the recommendation (primary), with 2019 La Rioja Alta Viña Ardanza Reserva as backup. Confirm on next cook.$m$ from public.meal m where m.slug=$m$baharat-lamb-shoulder-dinner$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$bbq-ribs-dinner$m$,$m$St. Louis Ribs, Sealed-Roasted in Foil with Vinegar-Forward BBQ Sauce$m$,$m$2026-07-19$m$,$m$cooked$m$::meal_status,3,null,null,$m$Beer preferred over wine for this dish - amber ale, Vienna lager, or Marzen. Malt meets the glaze, carbonation cuts the fat, moderate hopping avoids amplifying chilli heat and vinegar sharpness. Avoid hop-forward IPAs. If wine: fruit-forward, low tannin, moderate alcohol - Zinfandel, Grenache, Cotes du Rhone, Beaujolais cru, or dry rose. Avoid mature claret and high-tannin reds, which turn metallic against the vinegar-forward glaze.$m$,$m$3a2e0391ce63816080effe24adcef838$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$,$m$St. Louis Ribs, Sealed-Roasted in Foil with Vinegar-Forward BBQ Sauce$m$,$m$Pork$m$,array[$m$Main$m$]::text[],array[$m$Modern$m$]::text[],$m$Medium$m$,array[$m$Make-Ahead$m$]::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Adapted from NYT Cooking - Balsamic-Glazed Oven-Baked Ribs (recipe from Animal, adapted by Steven Raichlen). Balsamic glaze replaced with vinegar-forward BBQ sauce; method restructured to governance standard.$m$,null,$m$Dry-brined, dry-rubbed St. Louis ribs sealed-roasted in foil at 300°F / 150°C to probe-tender clean-bite texture, then lacquered meat-side under the broiler with a vinegar-forward tomato-based BBQ sauce.$m$,$m$# Method summary
Dry-brine 8–24 hr (7 g Diamond Crystal per rack) → smoky dry rub (smoked + sweet paprika, garlic/onion powder, cumin, pepper, optional cayenne) → double-wrap each rack in heavy-duty foil, packets side by side → sealed-roast 300°F / 150°C, 2 hr 30 min–3 hr 30 min to probe-tender → hold sealed at 170–180°F / 75–80°C → open, bank rack 2 un-glazed, switch oven to broil → taste and adjust sauce against the pork → dry surface 5–10 min → two thin meat-side glaze coats under the broiler → rest 5 min uncovered → slice.
Doneness governed by probe tenderness, not internal temperature. Target texture is clean-bite, not fall-apart.$m$,3,array[$m$heavy-duty foil$m$,$m$broiler$m$]::text[],$m$[{"param": "Banked rack: un-glazed storage plus fresh re-lacquer", "designed_value": "Reheat 300°F / 150°C covered, then broil 2–3 min", "note": "Second rack was banked un-broiled for leftovers; the un-glazed storage and fresh re-lacquer path remains unconfirmed. Confirm on reheat."}]$m$::jsonb,null,$m$3a2e0391ce63816080effe24adcef838$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, $m$2 racks$m$, $m$dry-brined 8–24 hr; double-wrapped in heavy-duty foil$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$st. louis pork ribs$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 7, $m$g$m$, $m$7 g per rack$m$, $m$dry brine$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$dry rub$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$smoked paprika$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$dry rub$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$sweet paprika$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$dry rub$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$garlic powder$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$dry rub$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$onion powder$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$dry rub$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$ground cumin$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$dry rub$m$, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$dry rub$m$, false, true, 9
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$cayenne$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tsp$m$, null, $m$BBQ sauce; cook 1 substituted dark soy sauce 2 tsp$m$, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$molasses$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$BBQ sauce; cook 1 used Tabasco$m$, false, false, 11
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$hot sauce$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$BBQ sauce; Lea & Perrins as specified$m$, false, false, 12
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$worcestershire sauce$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$BBQ sauce, staged into reduced and finishing portions$m$, false, false, 13
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$tomato base for the BBQ sauce$m$, false, false, 14
from public.dish d, public.ingredient i where d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$ and i.name=$m$tomato$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$bbq-cabbage-carrot-slaw$m$,$m$Lightly Creamy Cabbage-Carrot Slaw$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],array[$m$Modern$m$]::text[],null,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Adapted from NYT Cooking - Balsamic-Glazed Oven-Baked Ribs (recipe from Animal, adapted by Steven Raichlen). Balsamic glaze replaced with vinegar-forward BBQ sauce; method restructured to governance standard.$m$,null,$m$Lightly creamy cabbage-carrot slaw, made ahead and served cold as the relieving component.$m$,null,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$3a2e0391ce63816080effe24adcef838$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$bbq-cabbage-carrot-slaw$m$ and i.name=$m$cabbage$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$bbq-cabbage-carrot-slaw$m$ and i.name=$m$carrot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, $m$slaw dressing; cook 1 substituted Greek yogurt thinned with milk$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$bbq-cabbage-carrot-slaw$m$ and i.name=$m$buttermilk$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$bbq-charred-corn$m$,$m$Stovetop Charred Corn with Butter and Lime$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Modern$m$]::text[],null,'{}'::text[],array[$m$Family$m$]::text[],$m$cooked$m$::dish_status,$m$Adapted from NYT Cooking - Balsamic-Glazed Oven-Baked Ribs (recipe from Animal, adapted by Steven Raichlen). Balsamic glaze replaced with vinegar-forward BBQ sauce; method restructured to governance standard.$m$,null,$m$Stovetop charred corn with butter and lime — the selective carb (full portion for Lukas, spoonful or none for adults).$m$,null,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$3a2e0391ce63816080effe24adcef838$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$bbq-charred-corn$m$ and i.name=$m$corn$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$bbq-charred-corn$m$ and i.name=$m$butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$bbq-charred-corn$m$ and i.name=$m$lime$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$bbq-ribs-dinner$m$ and d.slug=$m$bbq-st-louis-ribs-vinegar-bbq-sauce$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$bbq-ribs-dinner$m$ and d.slug=$m$bbq-cabbage-carrot-slaw$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$bbq-ribs-dinner$m$ and d.slug=$m$bbq-charred-corn$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-07-19$m$::date, 8.5, 9.5, $m$yes$m$::repeat_verdict, $m$Rated 8.5 flavour / 9.5 execution on first cook. Sealed-roast held clean-bite texture as targeted; the two-coat meat-side broil produced the intended lacquer and supplied the plate's only textural contrast. Three substitutions were made and all performed: dark soy sauce for molasses (matched the dark, viscous, faintly bitter quality but contributes salt — season the sauce last), Greek yogurt thinned with milk for buttermilk in the slaw dressing, and Tabasco as the hot sauce. The reduced sauce read too vinegar-forward before service; corrected by extending the reduction rather than adding sugar, and by withholding part of the reserved finishing vinegar. Next time, reduce the sauce 5 minutes longer by default. Two designed parameters were confirmed by this cook: the 60-minute sealed hold at 170-180F/75-80C performed as intended with no drift toward fall-apart, and the broiler-transition-from-warm-cavity approach (gate the glaze on visible element heat, dry the surface in parallel) held up in execution. Both may be relabelled validated. Second rack was banked un-broiled for leftovers; the un-glazed storage and fresh re-lacquer path remains unconfirmed.

# Actual deviations
<table header-row="true">
<tr>
<td>Specified</td>
<td>Used</td>
<td>Effect</td>
</tr>
<tr>
<td>Molasses, 2 tsp</td>
<td>Dark soy sauce, 2 tsp</td>
<td>Matched the viscous, dark, faintly bitter quality; added salt, so sauce salting was held back. Successful substitution.</td>
</tr>
<tr>
<td>Buttermilk, 2 tbsp</td>
<td>Greek yogurt thinned with milk</td>
<td>Thicker and more lactic than buttermilk; dressing loosened to pourable before use. Successful.</td>
</tr>
<tr>
<td>Hot sauce, unspecified</td>
<td>Tabasco</td>
<td>Vinegar-forward, no added sugar — correct fit for a low-sweet sauce. Lingham's sweet chilli sauce was considered and rejected on sugar grounds.</td>
</tr>
<tr>
<td>Worcestershire</td>
<td>Lea & Perrins (as specified)</td>
<td>Original ingredient sourced; no compensation needed.</td>
</tr>
</table>
**Sauce correction during the cook:** the reduced sauce read too vinegar-forward before service. Corrected by extending the reduction rather than adding sugar, and by withholding part of the reserved finishing vinegar. Sweetness was not the problem; acidity was.
# Designed-parameter confirmation
Two parameters carried into this cook as *planned* rather than validated (per Core "Designed ≠ tested"):
- **60-minute sealed hold at 170–180°F / 75–80°C** — held sealed roughly as planned and performed as intended. Meat remained at clean-bite; no drift toward fall-apart observed. **Confirmed — may be relabelled validated in the recipe.**
- **Broiler transition from a warm cavity** — the parallel-dry approach (switch to broil at packet-open, dry surface while the element heats, gate the glaze on visible heat rather than a stated duration) held up in execution. No blocking wait observed. **Confirmed in practice.**
# Next time
- Sauce ran vinegar-forward at the reduction stage. Consider reducing 5 minutes longer by default, or holding back a larger share of the finishing vinegar until the taste-against-pork step.
- Dark soy is a viable standing substitute for molasses; note the salt contribution and season the sauce last.
- Banked rack: confirm on reheat whether the un-glazed storage plus fresh re-lacquer performs as designed (300°F / 150°C covered, then broil 2–3 min).$m$, $m$["Molasses, 2 tsp → dark soy sauce, 2 tsp: matched the viscous, dark, faintly bitter quality; added salt, so sauce salting was held back. Successful substitution.", "Buttermilk, 2 tbsp → Greek yogurt thinned with milk: thicker and more lactic; dressing loosened to pourable before use. Successful.", "Hot sauce, unspecified → Tabasco: vinegar-forward, no added sugar — correct fit for a low-sweet sauce.", "Worcestershire → Lea & Perrins (as specified): original ingredient sourced; no compensation needed.", "Sauce correction during the cook: reduced sauce read too vinegar-forward before service; corrected by extending the reduction rather than adding sugar, and by withholding part of the reserved finishing vinegar.", "Second rack banked un-broiled for leftovers."]$m$::jsonb, $m$[{"param": "60-minute sealed hold at 170–180°F / 75–80°C", "designed": "60 min sealed hold, meat stays clean-bite", "observed": "Held sealed roughly as planned; meat remained at clean-bite, no drift toward fall-apart", "verdict": "confirmed"}, {"param": "Broiler transition from a warm cavity (parallel-dry, gate glaze on visible element heat)", "designed": "Switch to broil at packet-open, dry surface while element heats, glaze when element visibly hot", "observed": "Held up in execution; no blocking wait observed", "verdict": "confirmed"}, {"param": "Banked rack: un-glazed storage plus fresh re-lacquer", "designed": "300°F / 150°C covered, then broil 2–3 min", "observed": "Not yet reheated", "verdict": "unresolved"}]$m$::jsonb, $m$3 adults (2 carb-moderate + 1 full portion). Corn: full portion for Lukas, spoonful/none for adults.$m$, null from public.meal m where m.slug=$m$bbq-ribs-dinner$m$;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$bistro-mussels-dinner$m$,$m$Buttered Bistro Mussels + Fries + Salad$m$,$m$2025-12-28$m$,$m$cooked$m$::meal_status,3,$m$## Method (Main Flow)
1. Start fries (220°C fan / 240°C non-fan).
2. Prep salad greens, parsley, garlic, bread.
3. Toast baguette, rub with garlic.
4. Heat oil, add garlic + chilli (20 sec).
5. Add mussels + wine, cover, steam **7–8 min**.
6. Off heat: butter, parsley, zest. Swirl.
7. Toss salad lightly.
8. Serve immediately.$m$,null,$m$Sauvignon Blanc — Cloudy Bay Sauvignon Blanc$m$,$m$2d9e0391ce6380b58ae5f2ce96678c91$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$mussels-buttered-bistro-mussels$m$,$m$Buttered Bistro Mussels$m$,$m$Shellfish$m$,array[$m$Main$m$]::text[],array[$m$French$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Classic French brasserie moules-frites style: Mont-Saint-Michel mussels steamed in Sauvignon Blanc with garlic and chilli, finished with cold butter, parsley and lemon zest.$m$,$m$**Classic French Brasserie Moules-Frites Style**
---
## Ingredients
### Mussels
- **1.4 kg Mont-Saint-Michel mussels**, cleaned
- 1 tbsp extra-virgin olive oil
- ½ garlic clove, minced
- ½ garlic clove, lightly crushed
- Tiny pinch chilli flakes (optional)
- **¼ cup dry white wine (Sauvignon Blanc)**
- **½ tbsp cold unsalted butter**
- ½ cup flat-leaf parsley, chopped
- Small pinch lemon zest
- Fine salt (only if needed)
---
## Method (Main Flow)
1. Start fries (220°C fan / 240°C non-fan).
2. Prep salad greens, parsley, garlic, bread.
3. Toast baguette, rub with garlic.
4. Heat oil, add garlic + chilli (20 sec).
5. Add mussels + wine, cover, steam **7–8 min**.
6. Off heat: butter, parsley, zest. Swirl.
7. Toss salad lightly.
8. Serve immediately.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380b58ae5f2ce96678c91$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1400, $m$g$m$, $m$1.4 kg$m$, $m$cleaned$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$mont-saint-michel mussel$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$clove$m$, null, $m$minced$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$clove$m$, null, $m$lightly crushed$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$tiny pinch$m$, null, false, true, 5
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$chilli flake$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$cup$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$dry white wine (sauvignon blanc)$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tbsp$m$, null, $m$cold$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$unsalted butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$cup$m$, null, $m$chopped$m$, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$flat-leaf parsley$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$small pinch$m$, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$only if needed$m$, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$mussels-buttered-bistro-mussels$m$ and i.name=$m$fine salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$mussels-fries$m$,$m$Fries$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Frozen thin fries baked hot (220°C fan) and salted.$m$,$m$### Fries
- Frozen thin fries
- Neutral oil
- Fine salt$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380b58ae5f2ce96678c91$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$mussels-fries$m$ and i.name=$m$frozen thin fries$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$mussels-fries$m$ and i.name=$m$neutral oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$mussels-fries$m$ and i.name=$m$fine salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$mussels-garlic-baguette$m$,$m$Garlic Baguette$m$,null,array[$m$Bread$m$]::text[],array[$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Toasted half baguette brushed with olive oil and rubbed with a whole garlic clove.$m$,$m$### Garlic Baguette
- ½ baguette
- Olive oil
- 1 whole garlic clove$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380b58ae5f2ce96678c91$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$piece$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$mussels-garlic-baguette$m$ and i.name=$m$baguette$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$mussels-garlic-baguette$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$clove$m$, null, $m$whole$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$mussels-garlic-baguette$m$ and i.name=$m$garlic$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$mussels-bistro-green-salad$m$,$m$Bistro Green Salad$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],array[$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Butter lettuce or baby cos (optional arugula) lightly tossed in an olive oil and rice wine vinegar dressing.$m$,$m$### Bistro Green Salad
- Butter lettuce / baby cos
- Optional arugula
**Dressing**
- 3 tbsp extra-virgin olive oil
- **¾–1 tsp rice wine vinegar**
- Pinch fine salt
- Tiny grind pepper$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380b58ae5f2ce96678c91$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$mussels-bistro-green-salad$m$ and i.name=$m$butter lettuce / baby cos$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, true, 2
from public.dish d, public.ingredient i where d.slug=$m$mussels-bistro-green-salad$m$ and i.name=$m$arugula$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$tbsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$mussels-bistro-green-salad$m$ and i.name=$m$extra-virgin olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.75, $m$tsp$m$, $m$¾–1 tsp$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$mussels-bistro-green-salad$m$ and i.name=$m$rice wine vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$mussels-bistro-green-salad$m$ and i.name=$m$fine salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$tiny grind$m$, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$mussels-bistro-green-salad$m$ and i.name=$m$pepper$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$mussels-broccolini$m$,$m$Broccolini Side (Optional Add-On)$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$French$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$ChatGPT$m$,null,$m$Optional add-on: blanched then sautéed broccolini with garlic, salt and lemon zest.$m$,$m$# 🥗 Broccolini Side (Optional Add-On)
- 1–2 bunches broccolini
- Olive oil
- 1 garlic clove
- Pinch salt
- Tiny pinch lemon zest
Blanch 90 sec → sauté 1–2 min.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$2d9e0391ce6380b58ae5f2ce96678c91$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$bunch$m$, $m$1–2 bunches$m$, null, false, true, 1
from public.dish d, public.ingredient i where d.slug=$m$mussels-broccolini$m$ and i.name=$m$broccolini$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, true, 2
from public.dish d, public.ingredient i where d.slug=$m$mussels-broccolini$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$clove$m$, null, null, false, true, 3
from public.dish d, public.ingredient i where d.slug=$m$mussels-broccolini$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, null, null, false, true, 4
from public.dish d, public.ingredient i where d.slug=$m$mussels-broccolini$m$ and i.name=$m$salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, $m$tiny pinch$m$, null, false, true, 5
from public.dish d, public.ingredient i where d.slug=$m$mussels-broccolini$m$ and i.name=$m$lemon zest$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$bistro-mussels-dinner$m$ and d.slug=$m$mussels-buttered-bistro-mussels$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$bistro-mussels-dinner$m$ and d.slug=$m$mussels-fries$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$bread$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$bistro-mussels-dinner$m$ and d.slug=$m$mussels-garlic-baguette$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$bistro-mussels-dinner$m$ and d.slug=$m$mussels-bistro-green-salad$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 5 from public.meal m, public.dish d where m.slug=$m$bistro-mussels-dinner$m$ and d.slug=$m$mussels-broccolini$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2025-12-28$m$::date, 8.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$bistro-mussels-dinner$m$;
commit;
