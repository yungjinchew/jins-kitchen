begin;
insert into public.ingredient (name,department,pantry_default) values ($m$bay leaf$m$,$m$Seasoning$m$,false),($m$black pepper$m$,$m$Seasoning$m$,false),($m$chicken stock$m$,$m$Pantry$m$,false),($m$diamond crystal kosher salt$m$,$m$Seasoning$m$,false),($m$duck breast, muscovy or barbary$m$,$m$Protein$m$,false),($m$duck fat$m$,$m$Oils & Liquids$m$,false),($m$flaky salt$m$,$m$Seasoning$m$,false),($m$hazelnut, blanched$m$,$m$Pantry$m$,false),($m$noilly prat dry vermouth$m$,$m$Alcohol$m$,false),($m$olive oil$m$,$m$Oils & Liquids$m$,false),($m$potato, floury (russet or maris piper)$m$,$m$Produce$m$,false),($m$radicchio$m$,$m$Produce$m$,false),($m$red wine vinegar$m$,$m$Oils & Liquids$m$,false),($m$shallot$m$,$m$Produce$m$,false),($m$thyme$m$,$m$Produce$m$,false),($m$unsalted butter$m$,$m$Dairy$m$,false) on conflict (name) do nothing;
update public.meal set workflow_md=$m$> **Note on versions.** The docx `duck-magret-sunday.docx` was generated 2026-09-11 for 2 × 400 g French Moulard magret with a sour cherry and red wine jus. Two sets of in-chat revisions superseded it before the cook: the protein changed to Malaysian Muscovy/Barbary at 2 × 348 g, with salt, render band and thaw method revised; and the jus was rebuilt as a savoury vermouth reduction after cherries, blackberries and red wine all proved unavailable. The sections below carry the FINAL reconciled state. The docx was not regenerated after these revisions.

**Critical path and anchors.** The duck governs. Three anchors: **D0** = duck into the cold pan, with a fixed clock before it. **E** = the flip, called on the skin cue. **P** = the probe reads 130°F / 54°C and the duck leaves the pan. Service is P+10. Radicchio is anchored to E and stays there; only the duck's own downstream events move with P.

**Failure prioritization.** Do not delay the duck. The potatoes yield. If they run to the top of their band they arrive at the table up to seven minutes behind the duck, and that is the accepted sacrifice, stated in advance. Never hold carved duck.

**Oven sequencing.** One temperature all evening, 425°F / 220°C, owned by the potatoes from D0−32 to their exit. Hazelnuts and radicchio are guests in that cavity and take it at the potatoes' convenience. No transitions to sequence. The door opens three extra times, so plan the potatoes at 48–55 minutes rather than 45.

**Parallel and sequential.** Potato parboil and jus reduction run on induction 2 before D0; the duck owns induction 1 from D0 to P. The only true pinch point is the pour-off at D0+12, which must happen before you touch anything else. No component depends on the render yield — the potato fat is bought, not rendered.

**Heat resource allocation.**
<table header-row="true">
<tr>
<td>Phase</td>
<td>Induction 1</td>
<td>Induction 2</td>
<td>Oven</td>
</tr>
<tr>
<td>D0−40 to D0−15</td>
<td>—</td>
<td>Potato parboil</td>
<td>Preheat, then fat tray</td>
</tr>
<tr>
<td>D0−10 to D0</td>
<td>—</td>
<td>Jus reduction</td>
<td>Potatoes</td>
</tr>
<tr>
<td>D0 to E</td>
<td>Duck render</td>
<td>Jus reduction, then held</td>
<td>Potatoes, hazelnuts</td>
</tr>
<tr>
<td>E to P</td>
<td>Duck meat-side finish</td>
<td>Jus held off heat</td>
<td>Potatoes, radicchio</td>
</tr>
<tr>
<td>P to P+10</td>
<td>—</td>
<td>Fond deglaze, then mounting off heat</td>
<td>Radicchio, then plates warming</td>
</tr>
</table>

**Fixed-clock phase — D0 = duck into the cold pan.** Clock times are for a 6:00 pm service.
<table header-row="true">
<tr>
<td>Anchor</td>
<td>Clock</td>
<td>Action</td>
</tr>
<tr>
<td>D0−40</td>
<td>4:25</td>
<td>Oven on, 425°F / 220°C</td>
</tr>
<tr>
<td>D0−35</td>
<td>4:30</td>
<td>Salt the duck — meat sides only, plus coarse pepper. Reserve the skin portion in a ramekin. Back on the rack, skin up</td>
</tr>
<tr>
<td>D0−32</td>
<td>4:50</td>
<td>90 ml bought duck fat into the roasting tray; tray into the oven</td>
</tr>
<tr>
<td>D0−30</td>
<td>4:45</td>
<td>Potatoes into cold salted water, induction 2 — simmer 8–10 min</td>
</tr>
<tr>
<td>D0−17</td>
<td>5:02</td>
<td>Drained, steamed off 3 min, shaken rough</td>
</tr>
<tr>
<td>D0−15</td>
<td>5:05</td>
<td>Potatoes into the hot fat — roast 48–55 min, out 5:53–6:00</td>
</tr>
<tr>
<td>D0−10</td>
<td>5:20</td>
<td>Jus started, induction 2 — reduce ~25 min</td>
</tr>
<tr>
<td>D0−1</td>
<td>5:29</td>
<td>Seat the probe. Reserved salt onto the skin</td>
</tr>
<tr>
<td>D0</td>
<td>5:30</td>
<td>Duck skin-down into the cold dry skillet, induction 1, medium-low</td>
</tr>
<tr>
<td>D0+2</td>
<td>5:32</td>
<td>Hazelnuts into the oven — 8 min</td>
</tr>
<tr>
<td>D0+10</td>
<td>5:40</td>
<td>Hazelnuts out; cool, chop coarse</td>
</tr>
<tr>
<td>D0+12</td>
<td>5:42</td>
<td>First fat pour-off — record Gate A</td>
</tr>
<tr>
<td>D0+15</td>
<td>5:45</td>
<td>Jus strained, held off heat</td>
</tr>
<tr>
<td>D0+18 on</td>
<td>—</td>
<td>Pour off every 6–8 min; steer the heat per Active Cooking step 9</td>
</tr>
</table>

**E-anchored — radicchio only.**
<table header-row="true">
<tr>
<td>Anchor</td>
<td>Expected clock</td>
<td>Action</td>
</tr>
<tr>
<td>E−10</td>
<td>5:35–5:42</td>
<td>Small tray into the oven empty — trigger: skin lifting freely but not yet fully amber</td>
</tr>
<tr>
<td>E−5</td>
<td>5:40–5:47</td>
<td>Radicchio cut-side down onto the hot tray — 15 min</td>
</tr>
<tr>
<td>E</td>
<td>5:45–5:52</td>
<td>Flip, on the skin cue. Record Gate B. Meat side down, medium</td>
</tr>
<tr>
<td>E+10</td>
<td>5:55–6:02</td>
<td>Radicchio out — vinegar and hazelnuts on immediately. Full 15 minutes regardless of how the finish runs</td>
</tr>
</table>

**P-anchored — everything after the pull.**
<table header-row="true">
<tr>
<td>Anchor</td>
<td>Expected clock</td>
<td>Action</td>
</tr>
<tr>
<td>P</td>
<td>5:47–5:56</td>
<td>Probe reads 130°F / 54°C — duck out. Record Gate C. Rack, skin up, uncovered. Rest 8 min, probe left in</td>
</tr>
<tr>
<td>P+2</td>
<td>—</td>
<td>Duck pan poured clean, fond lifted with a splash of jus, strained back in</td>
</tr>
<tr>
<td>P+4</td>
<td>—</td>
<td>Plates into the cooling oven to warm</td>
</tr>
<tr>
<td>P→P+8</td>
<td>—</td>
<td>Watch the probe through the rest — record Gate D: the observed peak and the time after P at which it occurs</td>
</tr>
<tr>
<td>P+8</td>
<td>—</td>
<td>Butter mounted into the jus off heat; closing vinegar to taste against a slice; flash re-crisp if the tap sounds dull</td>
</tr>
<tr>
<td>P+9</td>
<td>—</td>
<td>Carve</td>
</tr>
<tr>
<td>P+10</td>
<td>5:57–6:06</td>
<td>Plate: potatoes, radicchio, duck, jus beside</td>
</tr>
</table>

**Timeline arithmetic — service band.** With the Muscovy revision, a 15–22 min render band puts E at D0+15 to D0+22, a 2–4 minute meat-side finish puts P at D0+17 to D0+26, and service between D0+27 and D0+36. Both band edges close, neither to the minute. The original magret figures were a 22–28 min render with service at D0+34 to D0+42, a longest potato hold of 9 minutes against the 15-minute ceiling, and a worst-case potato trail of 7 minutes.

**Holding chain.**
<table header-row="true">
<tr>
<td>Component</td>
<td>Hold</td>
<td>Max</td>
<td>Drift</td>
<td>Corrective</td>
</tr>
<tr>
<td>Duck, post-rest</td>
<td>Do not hold</td>
<td>0</td>
<td>Cools fast once carved</td>
<td>Carve at service</td>
</tr>
<tr>
<td>Potatoes</td>
<td>Tray on the stovetop, uncovered — the oven stays hot for the radicchio, so the switched-off-oven instruction in the docx does not apply</td>
<td>15 min</td>
<td>Shell softens</td>
<td>None — they yield first</td>
</tr>
<tr>
<td>Radicchio</td>
<td>Switched-off oven, undressed</td>
<td>5 min</td>
<td>Cores keep softening</td>
<td>Dress at the plate, not the tray</td>
</tr>
<tr>
<td>Jus</td>
<td>Off heat, unmounted</td>
<td>30 min</td>
<td>Skins over</td>
<td>Warm gently before mounting</td>
</tr>
</table>

**Plating window.** Radicchio exits at E+10, which falls at P+6 to P+8 depending on whether the meat-side finish took two minutes or four. Either lands inside service at P+10. If plating slips, the potato shell fails first — it softens within about five minutes of leaving the oven.

**Meal balance audit.** Richness sits on one axis — rendered duck fat, carried by the duck and the potatoes only; the radicchio is dressed in olive oil deliberately, to keep the fat axis to two of four components. Bitterness is the primary reliever. Acid appears at two points, functionally distinct: vinegar on the radicchio resets the palate between bites, the closing vinegar in the jus brightens the duck itself. In the final vermouth version no sugar is added anywhere in the menu and there is no fruit at all. Texture runs crisp skin, crisp potato shell, yielding radicchio with browned cut faces, and hazelnut: two crunch sources, distinct in kind. No accumulation gap.

**Method naming.** This is roasted radicchio, not charred. A 425°F oven browns the cut faces; it does not char them. Actual char would need the binchotan and its own heat-resource schedule.$m$, shared_prep_md=$m$- **Duck fat: 105 ml / 7 tbsp total** — 90 ml to Potatoes (bought, into the tray at D0−32), 15 ml to Jus. Rendered fat from the breasts replenishes the jar afterwards; no component waits on render yield.
- **Red wine vinegar: 25 ml / 1⅔ tbsp total** — 15 ml to Radicchio (off heat), 5 ml to Jus (into the reduction), 5 ml to Jus (off heat at service).
- **Diamond Crystal kosher salt for the duck: 5.6 g total, about 2 tsp** — about 1½ tsp to the meat sides one hour ahead, a scant ½ tsp reserved in a ramekin for the skin at the pan. Weigh both; do not sprinkle. The docx figure of 6.4 g applied to 800 g of magret and was superseded.

Nothing else is shared across two or more components. Thyme and bay appear in the jus alone.$m$, wine_pairing=$m$2022 Domaine du Vieux Télégraphe Châteauneuf-du-Pape Télégramme — drunk on the night, worked well. Chosen for moderate tannin against the radicchio's bitterness and two staged vinegar points, and as a bridge between Hui Fong's Châteauneuf preference and Jin's preference for plush reds. Backup not used: 2022 Burn Cottage Pinot Noir Moonlight Race.$m$ where slug='duck-magret-sunday';
update public.dish set method_md=$m$## Dish Overview
Duck breast rendered skin-down from a cold pan in a single continuous pass, flipped on a skin endpoint, and finished meat-side to a probe trigger. Textures: brittle fat cap against dense, close-grained meat. This cook is a baseline: the method is the familiar one, and the purpose is to establish how this duck, this pan and this hob actually behave.

## Yield & Timing
Serves 3 with leftovers · Thaw 24–36 hr fridge, or 40–50 min cold-water submersion with water changed every 30 min · Air-dry 12–24 hr · Active ~40 min · Render 15–22 min for Muscovy, 22–28 min for magret · No designed hold.

## Flavor Architecture
Base: the duck's own rendered fat, no added fat at any stage. Primary driver: rendered skin and the Maillard crust on the meat side. Acid: none in this component; carried by the jus and the radicchio. Aromatic/finish: coarse pepper on the meat side, flaky salt on the carved faces. No acid by design, so the single-stage constraint does not apply.

## Prep Phase
1. **Thaw, 24–36 hr ahead.** Fridge, in packaging, on a rack over a tray. Never on the counter. Discard all purge liquid. If buying the day before, cold-water thaw instead: sealed pack fully submerged, water changed every 30 minutes, about 40–50 minutes for a 348 g breast. Do not use warm water.
2. **Dry and score, 12–24 hr ahead.** Pat both faces very dry. Crosshatch the fat at ~1 cm intervals, cutting to roughly two-thirds of the cap depth, stopping short of the meat.
3. **Air-dry.** Uncovered on a rack in the fridge, skin up, 12–24 hr. No salt at this stage. Snap-frozen duck carries extra free moisture from ice damage, so this step matters more here than on fresh. Do not skip it to buy back time.
4. **Salt, 1 hr before the pan.** Weigh 5.6 g, about 2 tsp. Apply ~1½ tsp to the meat sides, plus coarse pepper. Set the remaining scant ½ tsp aside in a ramekin — it is the skin portion and does not go on now. Back onto the rack, skin up. Pre-cook surface condition: skin dry and slightly tacky, no visible moisture in the score lines.
5. **Probe placement.** Insert the leave-in probe horizontally from the side of the thickest breast, tip centred in the meat, before the pan goes on. The probe is the instrument for this cook, not a backup.
6. **Salt the skin at the pan.** The reserved scant ½ tsp, applied immediately before the breasts go in. Measured, not sprinkled — total salt is 0.8% and stays 0.8%.

## Active Cooking
1. **Render.** Both breasts skin-down in a cold, dry, heavy skillet on induction 1. Turn to medium-low. Do not preheat and do not add fat. Planned band 15–22 minutes for Muscovy. The fat should whisper, not crackle.
2. **Pour off progressively.** First pour-off at ~12 minutes, then every 6–8 minutes, into a heatproof bowl. Fat pooling above the score lines poaches the skin instead of rendering it. This fat replenishes the jar; nothing in the menu waits on it.
3. **Steering.** The render band is managed, not observed. If the internal climb is outpacing the skin — probe rising while the cap is still soft — drop to low and lift the pan briefly off the hob. If the skin is lagging with the internal still low, nudge up within medium-low. Do not go above medium at any point. Steering toward the middle of the band is the only lever that moves service without compromising anything.
4. **Flip trigger (Primary cue).** The fat cap is reduced to a thin shell, the skin is deep amber, the breast lifts free with no tug, and a knife tip meets a brittle crust rather than yielding fat. Flip on that, not on the clock and not on a number. This moment is E.
5. **Contingency branch.** If the internal reaches 118°F / 48°C while the skin is still visibly far from its endpoint, lift the breasts onto a rack, skin up, and let the gradient relax until the probe falls ~10°F, then return skin-down to finish the render. This is a rescue, not a plan. Reaching 118°F is not a reason to flip — the skin cue still governs the flip. If this triggers, log it: that is the evidence for making the split-render the designed path on cook #2.
6. **Meat-side finish.** Pour the pan clean, medium, meat-side down. Pull at 130°F / 54°C — the probe is the trigger. Expect 2–4 minutes; the range is an expectation, not a schedule. The moment of pull is P.
7. **Secondary doneness cue.** Press the thickest part: if it yields softly and the dent lingers, continue; if it rebounds promptly against light resistance, read the probe. This tells you when to read, not what to do instead of reading.
8. **Rest.** 8 minutes from P, skin up, on a rack, uncovered, probe left in. Rack so no steam collects under the skin; uncovered so the crust does not soften in its own humidity. Planned carryover +3 to +5°F / +2 to +3°C to 133–135°F / 56–57°C — a planned band, recorded at Gate D, not relied upon.
9. **Flash re-crisp (conditional).** If a knuckle-tap sounds dull after the rest, 45–60 seconds skin-down in the dry hot pan.
10. **Carve.** Against the grain, slight bias, ~5 mm. Flaky salt on the cut faces.

## Food Safety
Stated separately from the culinary target. There is no designed ambient hold in this method, so no ambient-time control applies to the planned path. Where the contingency branch at step 11 is invoked, the controlling requirement is cumulative time between 40°F / 4°C and 140°F / 60°C across the whole preparation, not a per-step allowance. This is whole-muscle duck: the interior is the low-risk zone and the surface is addressed by the render and the final sear. Keep any contingency hold under an hour and count it toward the cumulative total. This is a safety statement; it is not the culinary limit and has no bearing on when the duck tastes best.

## Holding & Assembly
Carved slices onto warmed plates immediately. Carve at service, not ahead — a previous cook showed room-temperature plates pulling 5–7°F out of a rested protein, so warm the plates. Jus beside the slices, never over the skin.

## Critical Control Points
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure Mode</td>
<td>Sensory Cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Critical</td>
<td>Meat taken past medium during the finish</td>
<td>Probe above 135°F / 57°C before the rest</td>
<td>Unrecoverable. Turns grey and livery; the reason to buy the cut is gone</td>
</tr>
<tr>
<td>Major</td>
<td>Heat too high in the first 5 minutes, skin browns before the fat renders</td>
<td>Aggressive crackle and visible browning inside 5 minutes</td>
<td>Drop the heat; the render continues. Unrecoverable for skin colour; dish remains serviceable</td>
</tr>
<tr>
<td>Major</td>
<td>Flipped on time rather than on the skin, thick fat layer under crisp skin</td>
<td>Knife tip meets soft yielding fat; breast resists lifting</td>
<td>Recoverable — return skin-down and continue</td>
</tr>
<tr>
<td>Major</td>
<td>Scoring cut into the meat, juices bleed through the cuts across a long render</td>
<td>Pink weeping at the score lines before any heat is applied</td>
<td>Unrecoverable for that breast's moisture; dish remains serviceable</td>
</tr>
<tr>
<td>Minor</td>
<td>Probe tip sitting in fat rather than muscle, every reading in the cook is wrong</td>
<td>Internal reads implausibly high in the first 10 minutes</td>
<td>Reseat the probe; discard the readings taken before</td>
</tr>
</table>

## Adjustment Notes
Flaky salt goes on the carved faces where it reads immediately — it will not adhere to rendered skin. If the duck eats heavy, more radicchio per plate is the correction, not less jus.

## Scaling Notes
A third breast crowds one skillet, and crowding traps fat above the score lines. Two pans across both hobs, which then costs you the jus hob — at three breasts, reduce the jus ahead and reheat.

## Nutrition Estimate
not stated$m$, summary=$m$Duck breast rendered skin-down from a cold pan in a single continuous pass, flipped on a skin endpoint and finished to a probe trigger: brittle fat cap against dense, close-grained meat.$m$, name=$m$Seared Duck Magret$m$, servings=coalesce(servings,3), equipment=array[$m$heavy tri-ply stainless skillet, 28–30 cm (preferred over cast iron for heat responsiveness during the steered render; cast iron on low with the pan lifted off the hob is the fallback if the stainless is thin)$m$,$m$leave-in probe thermometer$m$,$m$wire rack$m$]::text[], designed_unvalidated=$m$[{"param": "Render band, Muscovy", "designed_value": "15–22 min", "note": "Estimated from cap geometry only, no logged cook. The least-evidenced number in the duck recipe"}, {"param": "Carryover during the rest", "designed_value": "+3 to +5°F to 133–135°F / 56–57°C", "note": "Gate D was not captured; remains designed"}, {"param": "Pull temperature", "designed_value": "130°F / 54°C", "note": "Held at 130°F for Muscovy on the grounds that it is leaner than magret and punishes overcooking harder. Not validated against a measured peak"}, {"param": "Contingency threshold", "designed_value": "118°F / 48°C", "note": "Lowered from an earlier 122°F because 122°F left the rescue branch no room to work. Did not fire on cook #1, but monitoring was intermittent"}, {"param": "Split-render versus continuous", "designed_value": "continuous chosen as the cook #1 baseline", "note": "Unresolved. Cannot be settled without a leave-in probe"}]$m$::jsonb, source=$m$Recovered from Notion Recipe Recovery page (Duck Magret Sunday chat, 2026-09-11); final reconciled Muscovy/vermouth state$m$, governance_version='v3.5', protein=$m$Duck$m$, cuisine=case when coalesce(array_length(cuisine,1),0)=0 then array[$m$French$m$]::text[] else cuisine end, difficulty=coalesce(difficulty,$m$Medium$m$) where slug=$m$duck-magret-seared-duck-breast$m$;
delete from public.dish_ingredient where dish_id=(select id from public.dish where slug=$m$duck-magret-seared-duck-breast$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,2,$m$piece$m$,$m$348 g each, 696 g total$m$,$m$frozen; Butcher Box Singapore, Malaysian, S$36.90/kg. Original docx specified 2 × 400 g French Moulard magret$m$,false,false,1 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-seared-duck-breast$m$ and i.name=$m$duck breast, muscovy or barbary$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,5.6,$m$g$m$,$m$about 2 tsp total$m$,$m$0.8% of 696 g: ~1½ tsp to the meat sides 1 hr ahead, a scant ½ tsp reserved for the skin at the pan$m$,true,false,2 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-seared-duck-breast$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,null,null,null,$m$coarse; meat side only, to taste$m$,true,false,3 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-seared-duck-breast$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,null,null,null,$m$carved faces, to finish$m$,true,false,4 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-seared-duck-breast$m$ and i.name=$m$flaky salt$m$;
update public.dish set method_md=$m$## Dish Overview
Crisp-shelled, floury-centred potatoes roasted in duck fat. Contributes the meal's crunch axis.

## Yield & Timing
Serves 3 · Active ~15 min · Roast 48–55 min · Oven 425°F / 220°C.

## Flavor Architecture
Base: duck fat. Primary driver: the roasted potato crust itself. Acid: none, carried by the radicchio. Finish: flaky salt at the tray.

## Prep Phase
1. Cut into ~5 cm chunks. Cold salted water, bring to a boil, simmer 8–10 minutes.
2. **Parboil endpoint (Primary cue).** A knife tip enters the outer centimetre easily but meets clear resistance at the core. If it passes through the centre without resistance, it has gone too far.
3. Drain, rest 3 minutes in the colander to steam off, then shake hard until the surfaces go rough and floury.

## Active Cooking
1. Duck fat into a heavy roasting tray; tray into the oven at D0−32 to preheat.
2. Potatoes into the hot fat at D0−15, turned once to coat. Roast 48–55 minutes, turning once at 25 minutes.

## Holding & Assembly
Maximum 15 minutes, uncovered. The docx specifies a switched-off oven with the door ajar, but the oven stays at 425°F for the radicchio, so in practice the tray holds on the stovetop, uncovered. Covering them is the one thing that destroys the shell.

## Critical Control Points
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure Mode</td>
<td>Sensory Cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Major</td>
<td>Fat not fully preheated, potatoes absorb rather than sear</td>
<td>No immediate sizzle as the first potato meets the tray</td>
<td>Remove, reheat the tray, return — costs 10 minutes</td>
</tr>
<tr>
<td>Major</td>
<td>Parboil taken too far, chunks collapse on shaking</td>
<td>Knife tip passes through the centre without resistance</td>
<td>Unrecoverable for shape; roast anyway, dish remains serviceable</td>
</tr>
<tr>
<td>Minor</td>
<td>Tray crowded, chunks touch and steam</td>
<td>Surfaces stay pale and matte past 30 minutes</td>
<td>Spread across two trays and extend 10 minutes</td>
</tr>
</table>

## Adjustment Notes
Flaky salt straight from the oven, while the surface is still hot enough to hold it.

## Scaling Notes
Above 900 g the chunks touch and steam. Two trays, not one deeper tray — a second tray costs nothing at this oven temperature.

## Nutrition Estimate
not stated$m$, summary=$m$Crisp-shelled and floury-centred, roasted in duck fat: the meal's crunch axis against the yielding radicchio.$m$, name=$m$Duck-Fat Roast Potatoes$m$, servings=coalesce(servings,3), equipment=array[$m$heavy roasting tray$m$]::text[], designed_unvalidated=$m$[{"param": "Roast time", "designed_value": "48–55 min", "note": "Extended from 45–55 because the oven door opens three extra times for the hazelnuts and radicchio. Not separately timed on cook #1"}, {"param": "Stovetop hold", "designed_value": "up to 15 min, uncovered", "note": "Correction made in chat after the oven-conflict was spotted; outcome of the hold not recorded"}]$m$::jsonb, source=$m$Recovered from Notion Recipe Recovery page (Duck Magret Sunday chat, 2026-09-11); final reconciled Muscovy/vermouth state$m$, governance_version='v3.5', protein=$m$Veg$m$, cuisine=case when coalesce(array_length(cuisine,1),0)=0 then array[$m$British$m$]::text[] else cuisine end, difficulty=coalesce(difficulty,$m$Easy$m$) where slug=$m$duck-fat-roast-potatoes$m$;
delete from public.dish_ingredient where dish_id=(select id from public.dish where slug=$m$duck-fat-roast-potatoes$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,900,$m$g$m$,$m$2 lb$m$,$m$peeled — skin holds moisture against the shell and blunts the crust$m$,false,false,1 from public.dish d, public.ingredient i where d.slug=$m$duck-fat-roast-potatoes$m$ and i.name=$m$potato, floury (russet or maris piper)$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,90,$m$ml$m$,$m$6 tbsp$m$,$m$bought, not rendered; into the tray at D0−32 to preheat$m$,true,false,2 from public.dish d, public.ingredient i where d.slug=$m$duck-fat-roast-potatoes$m$ and i.name=$m$duck fat$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,null,null,null,$m$parboil water, to taste$m$,true,false,3 from public.dish d, public.ingredient i where d.slug=$m$duck-fat-roast-potatoes$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,null,null,null,$m$straight from the oven, to finish$m$,true,false,4 from public.dish d, public.ingredient i where d.slug=$m$duck-fat-roast-potatoes$m$ and i.name=$m$flaky salt$m$;
update public.dish set method_md=$m$## Dish Overview
Radicchio wedges roasted cut-side down until the faces brown and the cores soften to a yielding bite, finished off heat with red wine vinegar and toasted hazelnuts. This is the meal's bitter axis and its palate reset; the hazelnuts give it a crunch distinct in kind from the potato shell.

## Yield & Timing
Serves 3 · Active ~10 min · Roast 15 min · Hazelnuts 8 min · Oven 425°F / 220°C.

## Flavor Architecture
Base: olive oil, deliberately not duck fat. Primary driver: the radicchio's own bitterness, concentrated by browning. Acid: red wine vinegar, single-stage off heat. Single-stage constraint invoked: the vinegar's job is to cut bitterness at the moment of eating; adding it before or during roasting boils it off and leaves the leaves limp. Aromatic/finish: toasted hazelnuts, chopped coarse.

## Prep Phase
1. Quarter each head through the root, leaving the core attached so the wedges hold together. Discard any bruised outer leaves.
2. Toss the wedges in olive oil, salt and pepper, working oil into the cut faces.
3. **Hazelnuts.** Small tray, 425°F / 220°C, 8 minutes, shaken once (D0+2 to D0+10). Pull when they smell nutty and have gone pale gold in the centre — they keep darkening off the tray. Cool, then chop coarse.

## Active Cooking
1. Small tray into the oven empty at E−10 to preheat.
2. Radicchio onto the hot tray, cut faces down, at E−5. Roast 15 minutes without turning. It comes out at E+10 regardless of how the duck's meat-side finish runs.
3. **Doneness (Primary cue).** A wedge lifts from the tray with the cut face visibly browned, and a knife tip meets soft flesh at the leaf with light resistance still at the core. The target is yielding with structure — if the wedge slumps when lifted, it has gone too far.
4. Vinegar and hazelnuts on immediately at E+10, off the heat, then to the table.

## Holding & Assembly
Do not hold dressed. If service slips, leave it undressed in the switched-off oven for up to 5 minutes and dress at the plate.

## Critical Control Points
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure Mode</td>
<td>Sensory Cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Major</td>
<td>Vinegar added before or during roasting, leaves steam rather than brown</td>
<td>Visible liquid on the tray within the first 5 minutes</td>
<td>Unrecoverable for texture; dish remains serviceable</td>
</tr>
<tr>
<td>Major</td>
<td>Wedges roasted too long, collapse to limp strands and bitterness turns acrid</td>
<td>Wedge slumps when lifted with tongs</td>
<td>Unrecoverable</td>
</tr>
<tr>
<td>Minor</td>
<td>Cores cut away, wedges fall to loose leaves</td>
<td>Leaves separating during the oil toss</td>
<td>Roast as loose leaves and reduce to 10 minutes</td>
</tr>
</table>

## Adjustment Notes
If bitterness still dominates at the plate, another 5 ml of vinegar over the wedges is the lever. Salt again after the vinegar, lightly — acid makes the first salting read weaker than it is.

## Scaling Notes
A third head needs a second tray. Crowded wedges steam in their own moisture and will not brown regardless of oven temperature.

## Nutrition Estimate
not stated$m$, summary=$m$Radicchio wedges roasted cut-side down until the faces brown and the cores soften to a yielding bite, finished off heat with vinegar and toasted hazelnuts — the meal's bitter axis and its palate reset.$m$, name=$m$Roasted Radicchio with Hazelnuts$m$, servings=coalesce(servings,3), equipment=array[$m$small roasting tray$m$]::text[], designed_unvalidated=$m$[{"param": "Roast time", "designed_value": "15 min at 425°F", "note": "Set from wedge geometry rather than any logged cook. Flagged at design time as the least-evidenced number in this component, and the first candidate cause of its 8.5 rating"}]$m$::jsonb, source=$m$Recovered from Notion Recipe Recovery page (Duck Magret Sunday chat, 2026-09-11); final reconciled Muscovy/vermouth state$m$, governance_version='v3.5', protein=$m$Veg$m$, cuisine=case when coalesce(array_length(cuisine,1),0)=0 then array[$m$Italian$m$]::text[] else cuisine end, difficulty=coalesce(difficulty,$m$Easy$m$) where slug=$m$duck-magret-roasted-radicchio-hazelnuts$m$;
delete from public.dish_ingredient where dish_id=(select id from public.dish where slug=$m$duck-magret-roasted-radicchio-hazelnuts$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,400,$m$g$m$,$m$2 heads / 14 oz$m$,$m$whole heads, quartered through the root with cores attached$m$,false,false,1 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-roasted-radicchio-hazelnuts$m$ and i.name=$m$radicchio$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,30,$m$ml$m$,$m$2 tbsp$m$,$m$deliberately not duck fat, to hold the fat axis to two of four components$m$,true,false,2 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-roasted-radicchio-hazelnuts$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,40,$m$g$m$,$m$⅓ cup$m$,$m$toasted 8 min then chopped coarse. Buy blanched — skinning on the day is work with no return$m$,false,false,3 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-roasted-radicchio-hazelnuts$m$ and i.name=$m$hazelnut, blanched$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,15,$m$ml$m$,$m$1 tbsp$m$,$m$off heat at the finish only$m$,true,false,4 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-roasted-radicchio-hazelnuts$m$ and i.name=$m$red wine vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,2,$m$g$m$,null,$m$plus more after the vinegar$m$,true,false,5 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-roasted-radicchio-hazelnuts$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,null,null,null,$m$to taste$m$,true,false,6 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-roasted-radicchio-hazelnuts$m$ and i.name=$m$black pepper$m$;
update public.dish set method_md=$m$## Dish Overview
A shallot, vermouth and stock reduction carrying no fruit and no added sugar, finished with mounted butter and a reserved closing vinegar. Built independently of the duck pan so its timing is not hostage to the render; the duck's fond is folded in after the duck comes out.

## Yield & Timing
~150 ml, serves 3 · Active ~10 min · Reduction ~25 min · Induction 2, from D0−10.

## Flavor Architecture
Base: duck fat and shallot. Primary driver: reduced stock, with vermouth's botanical bitterness as a supporting layer. Acid: vermouth at the opening, 5 ml vinegar into the reduction, 5 ml off heat at the finish. Finish: mounted butter and the closing vinegar. The opening 5 ml is not there for sharpness — the vermouth's volatile acidity is largely gone by the time the stock goes in, so that vinegar is seasoning the long reduction and giving it a backbone that concentrates. That job is independent of which alcohol was used.

## Active Cooking
1. Shallot in duck fat, medium-low, 4 minutes — translucent without colour.
2. Vermouth in; reduce until the pan is nearly dry.
3. Stock, thyme, bay, and the first 5 ml vinegar. Reduce by roughly two-thirds.
4. **Reduction endpoint (Primary cue).** The sauce coats a spoon and a finger drawn through the back leaves a track that holds its edges. If the track fills in, continue.
5. Strain, return to the pan, hold warm off heat. Reserve the closing 5 ml vinegar and the butter — neither goes in yet.

## Holding & Assembly
At P+2, pour the duck pan clean of fat, lift the fond with a splash of the held jus over low heat, scraping until the browned residue dissolves, and strain it back in. At P+8, off heat, whisk in the cold butter a few cubes at a time, each batch fully incorporated before the next. Taste against a carved slice of duck in front of you and add the closing vinegar in 2 ml steps — tighter than the 2–3 ml the red wine version specifies, because vermouth's botanical bitterness already supplies part of that lift, and it may need none at all. This step cannot move earlier: the duck is the thing being seasoned against, and until it is sliced there is nothing to judge.

## Critical Control Points
<table header-row="true">
<tr>
<td>Class</td>
<td>Failure Mode</td>
<td>Sensory Cue</td>
<td>Recovery</td>
</tr>
<tr>
<td>Major</td>
<td>Butter mounted over direct heat, emulsion breaks</td>
<td>Fat separating at the pan edge as you whisk</td>
<td>Off heat, whisk in a tablespoon of cold stock</td>
</tr>
<tr>
<td>Major</td>
<td>Reduction taken too far, turns salty and tacky as it cools</td>
<td>Coats the spoon like syrup rather than cream</td>
<td>Loosen with stock, not water — water thins the salt but also the body</td>
</tr>
<tr>
<td>Minor</td>
<td>Shallot browned rather than sweated</td>
<td>Sauce reads bitter under the vermouth</td>
<td>Unrecoverable; dish remains serviceable</td>
</tr>
</table>

## Adjustment Notes
Salt only after mounting, and only after tasting against the duck. If it reads heavy next to the duck fat already on the plate, the closing vinegar is the correction, not more butter. If it reads sharp rather than bright, hold the closing vinegar entirely — it is a reserve, not an obligation.

## Scaling Notes
not stated

## Nutrition Estimate
not stated

## Correction to the superseded version
The docx shopping-list note said that with sweeter fruit the opening wine should be cut by 20 ml. That instruction is wrong and should not be followed. Wine is the jus's acid and tannin spine; cutting it makes a sweeter version sweeter. The correct lever for excess sweetness is fruit quantity first, then vinegar.

## Superseded variant — Sour Cherry and Red Wine Jus (never cooked)
The docx version used 150 ml dry red wine and 100 g frozen pitted sour cherries in place of the vermouth, with 10 ml staged vinegar and the same shallot, stock, thyme, bay and butter. Identity check for that version: the cherries stay subordinate to the stock; if it reads as fruit sauce rather than jus, the cherry quantity comes down before anything else moves. In-chat substitution ladder recorded for that version, none of which was used: sweet cherries at 70 g with wine held at 150 ml and vinegar raised to 15 ml; blackberries 80 g; cranberries 60 g with vinegar dropped to 5 ml; redcurrants 80 g. Rejected: blueberries, raspberries, tropical fruit, mixed berry packs, balsamic, cooking wine, white wine.$m$, summary=$m$A shallot, vermouth and stock reduction finished with staged vinegar and mounted butter — dark and savoury, with no fruit and no added sugar.$m$, name=$m$Shallot and Vermouth Jus$m$, servings=coalesce(servings,3), equipment=array[$m$fine strainer$m$]::text[], designed_unvalidated=$m$[{"param": "Vermouth quantity", "designed_value": "120 ml (vs 150 ml red wine)", "note": "Reduced on the reasoning that vermouth is more concentrated and carries residual sugar. Rated 9.5 on first cook, but the 120 ml figure itself was not compared against 150 ml"}, {"param": "Closing vinegar step size", "designed_value": "2 ml (vs 2–3 ml)", "note": "Tightened because vermouth's botanicals supply part of the lift. Whether any closing vinegar was used on cook #1 is not recorded"}, {"param": "Sour cherry version", "designed_value": "100 g cherries, 150 ml red wine", "note": "Never cooked. The vermouth version's 9.5 makes the fruited version the untested variant rather than the default"}]$m$::jsonb, source=$m$Recovered from Notion Recipe Recovery page (Duck Magret Sunday chat, 2026-09-11); final reconciled Muscovy/vermouth state$m$, governance_version='v3.5', protein=null, cuisine=case when coalesce(array_length(cuisine,1),0)=0 then array[$m$French$m$]::text[] else cuisine end, difficulty=coalesce(difficulty,$m$Medium$m$) where slug=$m$duck-magret-shallot-vermouth-jus$m$;
delete from public.dish_ingredient where dish_id=(select id from public.dish where slug=$m$duck-magret-shallot-vermouth-jus$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,1,$m$piece$m$,null,$m$large; minced$m$,false,false,1 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$shallot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,15,$m$g$m$,$m$1 tbsp$m$,null,true,false,2 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$duck fat$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,120,$m$ml$m$,null,$m$Noilly Prat or similar. Replaces 150 ml dry red wine; reduced from 150 to 120 ml because vermouth is more concentrated and carries residual sugar$m$,false,false,3 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$noilly prat dry vermouth$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,300,$m$ml$m$,$m$1¼ cups$m$,$m$or duck stock; unsalted or low-salt — it reduces by more than two-thirds and is salted at the end$m$,false,false,4 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$chicken stock$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,2,$m$sprig$m$,null,null,false,false,5 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$thyme$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,1,$m$piece$m$,null,null,true,false,6 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$bay leaf$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,10,$m$ml$m$,null,$m$staged: 5 ml into the reduction, 5 ml held for the finish$m$,true,false,7 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$red wine vinegar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,25,$m$g$m$,$m$2 tbsp$m$,$m$cold, cubed; mounted off heat$m$,false,false,8 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$unsalted butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,null,null,null,$m$only after mounting, to taste$m$,true,false,9 from public.dish d, public.ingredient i where d.slug=$m$duck-magret-shallot-vermouth-jus$m$ and i.name=$m$diamond crystal kosher salt$m$;
insert into public.measurement (dish_id,cook_id,gate,predicted,observed,probe,sort_order) select c.dish_id, c.id, $m$Gate A — internal at first pour-off, D0+12$m$,$m$not predicted$m$,$m$not captured$m$,null,1 from public.cook c where c.dish_id=(select id from public.dish where slug='duck-magret-seared-duck-breast') and c.cooked_on='2026-09-20';
insert into public.measurement (dish_id,cook_id,gate,predicted,observed,probe,sort_order) select c.dish_id, c.id, $m$Gate B — internal at the flip$m$,$m$not predicted$m$,$m$not captured$m$,null,2 from public.cook c where c.dish_id=(select id from public.dish where slug='duck-magret-seared-duck-breast') and c.cooked_on='2026-09-20';
insert into public.measurement (dish_id,cook_id,gate,predicted,observed,probe,sort_order) select c.dish_id, c.id, $m$Gate C — pull temp and elapsed meat-side time$m$,$m$130°F / 54°C, 2–4 min$m$,$m$not captured$m$,null,3 from public.cook c where c.dish_id=(select id from public.dish where slug='duck-magret-seared-duck-breast') and c.cooked_on='2026-09-20';
insert into public.measurement (dish_id,cook_id,gate,predicted,observed,probe,sort_order) select c.dish_id, c.id, $m$Gate D — observed peak in P→P+8 and time-to-peak$m$,$m$133–135°F / 56–57°C$m$,$m$not captured$m$,null,4 from public.cook c where c.dish_id=(select id from public.dish where slug='duck-magret-seared-duck-breast') and c.cooked_on='2026-09-20';
insert into public.measurement (dish_id,cook_id,gate,predicted,observed,probe,sort_order) select c.dish_id, c.id, $m$Total render minutes$m$,$m$15–22 min$m$,$m$not captured$m$,null,5 from public.cook c where c.dish_id=(select id from public.dish where slug='duck-magret-seared-duck-breast') and c.cooked_on='2026-09-20';
insert into public.measurement (dish_id,cook_id,gate,predicted,observed,probe,sort_order) select c.dish_id, c.id, $m$Total fat yield$m$,$m$70–120 ml expected$m$,$m$"not much" — no figure$m$,null,6 from public.cook c where c.dish_id=(select id from public.dish where slug='duck-magret-seared-duck-breast') and c.cooked_on='2026-09-20';
insert into public.measurement (dish_id,cook_id,gate,predicted,observed,probe,sort_order) select c.dish_id, c.id, $m$Flash re-crisp needed$m$,$m$conditional$m$,$m$no$m$,null,7 from public.cook c where c.dish_id=(select id from public.dish where slug='duck-magret-seared-duck-breast') and c.cooked_on='2026-09-20';
insert into public.measurement (dish_id,cook_id,gate,predicted,observed,probe,sort_order) select c.dish_id, c.id, $m$Contingency fired$m$,$m$conditional$m$,$m$no (intermittent monitoring)$m$,$m$Thermapen, spot checks$m$,8 from public.cook c where c.dish_id=(select id from public.dish where slug='duck-magret-seared-duck-breast') and c.cooked_on='2026-09-20';
commit;