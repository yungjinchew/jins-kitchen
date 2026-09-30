begin;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$lamb-shoulder-sunday$m$,$m$Lamb Shoulder Sunday$m$,$m$2026-02-22$m$,$m$cooked$m$::meal_status,3,null,null,null,null);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$lamb-shoulder-slow-roasted-bone-in$m$,$m$Slow-Roasted Bone-In Lamb Shoulder$m$,$m$Lamb$m$,array[$m$Main$m$]::text[],array[$m$Modern$m$]::text[],$m$Medium$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$chatgpt$m$,null,$m$Slow-roasted bone-in lamb shoulder, mature Bordeaux–optimised: dry-brined with a cumin, coriander, fennel, lemon zest, garlic and anchovy rub, braised covered at 150°C for 3 hours over an aromatic bed, browned at 230°C to 92–94°C internal, served with a reduced pan jus.$m$,$m$# 🥩 Slow-Roasted Bone-In Lamb Shoulder
*Mature Bordeaux–Optimised Version*
**Serves:** 3 + light leftovers
**Total Cook Time:** \~5 hours
**Active Time:** \~30 minutes
**Target Internal Temp:** 92–94°C / 198–201°F
---
## 🛒 Ingredients
### Lamb
- 1.2–1.3 kg bone-in lamb shoulder
- 14 g kosher salt *(10 g if using fine sea salt)*
- 1 tsp ground cumin
- 1 tsp ground coriander
- ½ tsp dried thyme
- ½ tsp fennel seed, lightly crushed
- ½ tsp freshly ground black pepper
- Zest of ½ lemon (no juice)
- 4 cloves garlic, finely grated
- 1 anchovy fillet, mashed to paste
- 2 tbsp olive oil (30 ml)
---
### Braising Bed
- 1 large onion, thick slices
- 1 carrot, large chunks
- 1 celery stalk, chunks
- ½ bulb garlic, halved crosswise
- 1 bay leaf
- 120 ml / ½ cup dry white wine
- 200 ml / \~¾ cup low-sodium chicken stock
---
### Pan Jus
- Fine sea salt (small pinch only)
---
# 📅 Day Before — Dry Brine
## ☐ Prepare the Rub
Mix:
- Salt
- Cumin
- Coriander
- Thyme
- Fennel
- Black pepper
- Lemon zest
- Garlic
- Anchovy
- Olive oil
## ☐ Season Lamb
- Pat lamb completely dry.
- Rub thoroughly over entire surface.
- Place uncovered on rack in fridge for 12–24 hours.
---
# 🔥 Cooking Day
## 1️⃣ Temper the Lamb
- Remove from fridge 45–60 minutes before cooking.
---
## 2️⃣ Collagen Conversion Phase
**Oven:** 150°C / 300°F
### ☐ Build Braising Tray
- Scatter onion, carrot, celery, garlic halves, bay leaf.
- Add wine + stock.
- Place lamb fat-side up on top.
- Cover tightly with foil.
### ☐ Roast Covered
- Roast 3 hours.
- Do not open oven.
---
## 3️⃣ Browning Phase
**Oven:** 230°C / 445°F
### ☐ Uncover and Roast
- Remove foil.
- Roast 10–30 minutes (monitor closely).
- Stop once surface is deep golden brown.
**Target Internal Temp:** 92–94°C / 198–201°F
---
## 4️⃣ Rest
### ☐ Rest Uncovered
- Remove from oven.
- Rest at least 30 minutes.
- Tent loosely with foil (do not seal tightly).
---
# 🍲 Pan Jus
### ☐ Strain
- Pour braising liquid into saucepan.
- Discard solids.
### ☐ Reduce
- Simmer over medium heat.
- Reduce to spoon-coating (nappe consistency).
### ☐ Season
- Add a small pinch of fine sea salt.
- No butter.
- No added wine.
- No acid.
---
# 🔪 Carving & Serving
### ☐ Slice or Pull
- Slice thickly across grain
	**or**
- Gently pull into large chunks.
### ☐ Plate
- Spoon jus lightly over lamb.
- Avoid flooding plate.
---
# ⏱ Holding Strategy (If Done Early)
- Rest 30 minutes.
- Hold in 70–80°C / 160–175°F oven (up to 60 minutes).
- Keep loosely tented.
---
# 🧠 Key Notes
- Do not chase darker browning once internal temp is reached.
- Shoulder is forgiving — slight overshoot to 203–205°F is acceptable.
- Do not slice early.
- Whole roast retains heat better than sliced meat.$m$,3,array[$m$rack$m$,$m$braising tray$m$,$m$foil$m$,$m$saucepan$m$]::text[],$m$[]$m$::jsonb,null,$m$30fe0391ce638047a3b3ccdb9cd24eb8$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1200, $m$g$m$, $m$1.2–1.3 kg$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$lamb shoulder, bone-in$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 14, $m$g$m$, null, $m$10 g if using fine sea salt$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$ground cumin$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$ground coriander$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$dried thyme$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, $m$lightly crushed$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$fennel seed$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, $m$freshly ground$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$piece$m$, null, $m$zest only (no juice)$m$, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$lemon$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$clove$m$, null, $m$finely grated$m$, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$mashed to paste$m$, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$anchovy fillet$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 30, $m$ml$m$, $m$2 tbsp$m$, null, false, false, 11
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$large, thick slices (braising bed)$m$, false, false, 12
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$large chunks (braising bed)$m$, false, false, 13
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$carrot$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$chunks (braising bed)$m$, false, false, 14
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$celery stalk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$piece$m$, null, $m$halved crosswise (braising bed)$m$, false, false, 15
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$garlic bulb$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$braising bed$m$, false, false, 16
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$bay leaf$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 120, $m$ml$m$, $m$½ cup$m$, $m$braising bed$m$, false, false, 17
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$dry white wine$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 200, $m$ml$m$, $m$~¾ cup$m$, $m$braising bed$m$, false, false, 18
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$chicken stock, low-sodium$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$pinch$m$, null, $m$small pinch only (pan jus)$m$, false, false, 19
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$,$m$Anchovy–Garlic Roast Potatoes$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$European$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$chatgpt$m$,null,$m$High-heat roast potatoes with a crisp exterior and fluffy interior: parboiled, steam-dried and roughed up, then roasted at 220°C with olive oil, anchovy paste and crushed garlic.$m$,$m$# 🥔 Anchovy–Garlic Roast Potatoes
*High-Heat, Crisp Exterior / Fluffy Interior*
**Serves:** 3
**Oven Temp:** 220°C / 430°F
**Total Time:** \~50–60 minutes
---
## 🛒 Ingredients
- 750 g potatoes *(Holland / Yukon-type preferred; Russet acceptable)*
- 2 anchovy fillets, mashed to paste
- 3 cloves garlic, lightly crushed
- 3 tbsp olive oil (45 ml)
- Kosher salt (moderate amount for boiling water)
- Freshly ground black pepper
---
# 🔪 Prep
## ☐ Wash (and Peel if Needed)
- Scrub well.
- Leave skin on for Holland/Yukon.
- Peel Russet if skin is thick.
## ☐ Cut
- Cut into 4–5 cm chunks.
- Irregular edges are good (better crisping).
---
# 🔥 Step 1 — Parboil
## ☐ Start in Cold Water
- Place potatoes in pot.
- Cover with cold water.
- Add moderate kosher salt (not pasta-level).
## ☐ Simmer
- Bring to gentle boil.
- Simmer 10–12 minutes (Holland).
- 12–14 minutes (Russet).
- Stop when knife just enters easily.
---
# 💨 Step 2 — Steam Dry & Rough
## ☐ Drain
- Drain completely.
## ☐ Steam Dry
- Leave uncovered 5 minutes.
## ☐ Rough Up
- Shake pot firmly.
- Edges should look fuzzy and starchy.
- This creates crisp crust later.
---
# 🔥 Step 3 — Roast
**Oven:** 220°C / 430°F
## ☐ Season
- Toss with olive oil.
- Mix in anchovy paste evenly.
- Add crushed garlic.
## ☐ Arrange
- Spread in single layer.
- Do not crowd.
- Use heavy sheet pan if possible.
## ☐ Roast
- 35–45 minutes total.
- Turn once halfway.
- Roast until deep golden and crisp.
---
# 🧂 Finish
## ☐ Season
- Freshly ground black pepper.
- Salt only if needed (anchovies already salty).
---
# ⏱ Holding Instructions (If Needed)
- Hold in 80°C / 175°F oven.
- Keep uncovered.
- Maximum 20–25 minutes.
- For best crisp, re-blast at 230°C / 445°F for 5 minutes before serving.
---
# 🧠 Key Notes
<empty-block/>
- Do not cover while holding.
- Do not overcrowd pan.
- Proper steam-dry is critical for crust.$m$,3,array[$m$heavy sheet pan$m$]::text[],$m$[]$m$::jsonb,null,$m$30fe0391ce63805493b8f91569db09c6$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 750, $m$g$m$, null, $m$Holland / Yukon-type preferred; Russet acceptable$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$ and i.name=$m$potato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$mashed to paste$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$ and i.name=$m$anchovy fillet$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$clove$m$, null, $m$lightly crushed$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 45, $m$ml$m$, $m$3 tbsp$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$moderate amount for boiling water$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$freshly ground$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$ and i.name=$m$black pepper$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$lamb-shoulder-creme-caramel$m$,$m$Crème Caramel (Reduced-Sugar, Deep Amber)$m$,null,array[$m$Dessert$m$]::text[],array[$m$French$m$]::text[],$m$Medium$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$chatgpt$m$,null,$m$Reduced-sugar crème caramel with a deep amber, bittersweet caramel, baked in a water bath at 150°C to 80–82°C internal and chilled 6–24 hours before unmolding.$m$,$m$# 🍮 Crème Caramel (Reduced-Sugar, Deep Amber)
*Balanced, Bittersweet Finish*
**Yield:** 6 ramekins (150–180 ml each)
**Bake Temp:** 150°C / 300°F
**Make Ahead:** 6–24 hours preferred
**Target Internal Temp:** 80–82°C / 176–180°F
---
## 🛒 Ingredients
### Caramel
- 120 g granulated sugar
- 30 ml water (2 tbsp)
### Custard
- 500 ml whole milk (2 cups)
- 120 ml heavy cream (½ cup)
- 4 large eggs
- 2 egg yolks
- 70 g granulated sugar (\~⅓ cup)
- 1 tsp vanilla extract
- Pinch fine sea salt
---
# 🔥 Step 1 — Make the Caramel
## ☐ Combine
- Add sugar + water to saucepan.
## ☐ Cook
- Heat over **medium**.
- Do not stir once dissolved.
- Cook until **deep amber** (dark honey color).
## ☐ Portion
- Immediately divide among ramekins.
- Tilt to coat bottoms evenly.
- Let set at room temperature.
---
# 🥛 Step 2 — Heat Dairy
## ☐ Warm Milk & Cream
- Combine milk + cream.
- Heat over **medium-low**.
- Bring to steaming (70–80°C / 160–175°F).
- Do not boil.
Remove from heat.
---
# 🥚 Step 3 — Make Custard
## ☐ Whisk
- Eggs + yolks + sugar + salt.
- Whisk gently (do not aerate heavily).
## ☐ Temper
- Slowly stream warm dairy into egg mixture while whisking gently.
## ☐ Finish
- Stir in vanilla.
- Strain through fine sieve into jug.
---
# 🔥 Step 4 — Bake (Water Bath)
## ☐ Fill
- Pour custard into ramekins over set caramel.
## ☐ Prepare Water Bath
- Place ramekins in baking dish.
- Add **hot (not boiling) water** halfway up sides.
## ☐ Bake
- 150°C / 300°F
- 35–45 minutes.
### Done When:
- Edges set.
- Center jiggles like soft gelatin.
- Internal temp 80–82°C / 176–180°F.
- No bubbling or puffing.
---
# ❄ Step 5 — Cool & Chill
## ☐ Remove From Water Bath
- Let sit in bath 2–3 minutes only.
- Lift onto rack.
## ☐ Cool
- Cool uncovered 30–45 minutes at room temperature.
## ☐ Cover & Refrigerate
- Cover loosely once fully cool.
- Chill minimum 6 hours.
- Ideal: overnight.
---
# 🍽 Step 6 — Unmold (Before Serving)
## ☐ Loosen
- Run thin knife around edge.
## ☐ Warm Base
- Dip ramekin bottom in warm water 5–10 seconds.
## ☐ Invert
- Place plate on top.
- Flip confidently.
- Let caramel flow naturally.
Optional: tiny pinch flaky salt.
---
# ⏱ Storage
- Best within 24–48 hours.
- Maximum 72 hours refrigerated.
- Do not unmold until serving.
---
# 🧠 Key Notes
- Do not use boiling water in bath.
- Do not cool in water bath.
- Do not cover while warm.
- Sugar reduced for balance after savoury meal.
- Caramel provides bitterness + sweetness.$m$,6,array[$m$6 ramekins (150–180 ml each)$m$,$m$saucepan$m$,$m$fine sieve$m$,$m$jug$m$,$m$baking dish (water bath)$m$]::text[],$m$[]$m$::jsonb,null,$m$30fe0391ce6380ed8c94fcb96ccbeca5$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 120, $m$g$m$, null, $m$for caramel$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$granulated sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 30, $m$ml$m$, $m$2 tbsp$m$, $m$for caramel$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$water$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 500, $m$ml$m$, $m$2 cups$m$, $m$for custard$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$whole milk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 120, $m$ml$m$, $m$½ cup$m$, $m$for custard$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$heavy cream$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 4, $m$piece$m$, null, $m$large (for custard)$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$egg$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$for custard$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$egg yolk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 70, $m$g$m$, $m$~⅓ cup$m$, $m$for custard$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$granulated sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, $m$for custard$m$, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$vanilla extract$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$pinch$m$, null, $m$for custard$m$, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$lamb-shoulder-creme-caramel$m$ and i.name=$m$fine sea salt$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$lamb-shoulder-sunday$m$ and d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$lamb-shoulder-sunday$m$ and d.slug=$m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$dessert$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$lamb-shoulder-sunday$m$ and d.slug=$m$lamb-shoulder-creme-caramel$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-02-22$m$::date, null, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$lamb-shoulder-sunday$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-02-22$m$::date, 9.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$lamb-shoulder-slow-roasted-bone-in$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-02-22$m$::date, 9.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$lamb-shoulder-anchovy-garlic-roast-potatoes$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-02-22$m$::date, 9, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$lamb-shoulder-creme-caramel$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$lemon-olive-oil-cake-18cm$m$,$m$Lemon Olive Oil Cake (7-Inch / 18 cm)$m$,null,array[$m$Dessert$m$]::text[],array[$m$Modern$m$]::text[],$m$Easy$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt$m$,null,$m$A lemon olive oil cake baked in a 7-inch / 18 cm tin, yielding 4–6 servings, optionally brushed with lemon syrup.$m$,$m$# 🍋 Lemon Olive Oil Cake (7-Inch / 18 cm)

**Yield:** 4–6 servings
**Bake Time:** 45–50 minutes
**Oven:** 175°C / 350°F

## 🧾 Ingredients

**Dry**
- 150 g (1¼ cups) all-purpose flour
- 1¼ tsp baking powder
- ½ tsp fine sea salt

**Wet**
- 160 g (¾ cup + 1 tbsp) granulated sugar
- Zest of 2 lemons
- 2 large eggs + 1 egg yolk (room temp)
- 100 ml (⅓ cup + 1 tbsp) mild extra-virgin olive oil
- 65 ml (¼ cup) whole milk
- 45 ml (3 tbsp) fresh lemon juice
- ¾ tsp vanilla extract

**Optional Lemon Syrup**
- 25 ml (1½ tbsp) fresh lemon juice
- 20 g (1½ tbsp) granulated sugar

**Optional Garnish**
- Powdered sugar
- Lightly whipped cream (very lightly sweetened)

## 🔧 Equipment
- 7-inch (18 cm) round cake tin
- Parchment paper
- Mixing bowls
- Whisk
- Rubber spatula
- Digital thermometer (recommended)

## 👨‍🍳 Method

**1️⃣ Prep**
- Preheat oven to 175°C / 350°F
- Grease tin lightly
- Line base with parchment
- Lightly flour sides

**2️⃣ Infuse Sugar**
- Combine sugar and lemon zest
- Rub together with fingers for 60 seconds until fragrant

**3️⃣ Build Wet Base**
- Add eggs and yolk to sugar mixture
- Whisk 1–2 minutes until slightly pale
- Slowly stream in olive oil while whisking
- Add milk, lemon juice, and vanilla
- Mix until smooth and glossy

**4️⃣ Add Dry Ingredients**
- Sift flour, baking powder, and salt
- Fold gently with spatula
- Mix only until flour disappears (20–30 folds)—do not overmix
- Batter should be fluid and smooth, not elastic

**5️⃣ Bake**
- Pour into prepared tin
- Tap gently to remove air bubbles
- Bake 45–50 minutes at 175°C / 350°F
- Done when internal temp reaches 94–96°C / 201–205°F OR skewer comes out clean with moist crumbs

**6️⃣ Remove from Tin**
- Rest in tin 10 minutes
- Run knife around edge
- Invert onto rack
- Remove parchment
- Turn upright

**7️⃣ Lemon Syrup (Optional but Recommended)**
- Heat lemon juice and sugar on very low until dissolved (2–3 minutes)
- Cool 2–3 minutes
- Brush onto warm (not hot) cake in thin layers

**8️⃣ Cool & Store**
- Cool completely at room temperature
- Cover loosely
- Do not refrigerate unless room is very warm
- Best within 24 hours

## ⚠️ Notes
- Use mild olive oil—peppery oil causes bitterness
- Do not overmix
- Do not overbake
- Cake improves after 2–3 hours rest
$m$,4,array[$m$7-inch (18 cm) round cake tin$m$,$m$parchment paper$m$,$m$mixing bowls$m$,$m$whisk$m$,$m$rubber spatula$m$,$m$digital thermometer$m$]::text[],$m$[]$m$::jsonb,null,$m$308e0391ce6380588fd8e79092da2a7d$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 150, $m$g$m$, $m$1¼ cups$m$, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$all-purpose flour$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.25, $m$tsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$baking powder$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$fine sea salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 160, $m$g$m$, $m$¾ cup + 1 tbsp$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$granulated sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$zest only$m$, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$lemon$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$large, room temp$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$egg$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$room temp$m$, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$egg yolk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 100, $m$ml$m$, $m$⅓ cup + 1 tbsp$m$, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$extra-virgin olive oil, mild$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 65, $m$ml$m$, $m$¼ cup$m$, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$whole milk$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 45, $m$ml$m$, $m$3 tbsp$m$, null, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$lemon juice, fresh$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.75, $m$tsp$m$, null, null, false, false, 11
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$vanilla extract$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 25, $m$ml$m$, $m$1½ tbsp$m$, $m$for optional lemon syrup$m$, false, true, 12
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$lemon juice, fresh$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 20, $m$g$m$, $m$1½ tbsp$m$, $m$for optional lemon syrup$m$, false, true, 13
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$granulated sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$optional garnish, for dusting$m$, false, true, 14
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$powdered sugar$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, $m$optional garnish; lightly whipped, very lightly sweetened$m$, false, true, 15
from public.dish d, public.ingredient i where d.slug=$m$lemon-olive-oil-cake-18cm$m$ and i.name=$m$heavy cream$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select null::uuid, d.id, $m$2026-02-15$m$::date, 9.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.dish d where d.slug=$m$lemon-olive-oil-cake-18cm$m$;
commit;
