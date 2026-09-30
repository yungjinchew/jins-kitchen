begin;
insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ($m$zaatar-chicken-dinner$m$,$m$Za’atar Chicken Menu (3 pax)$m$,$m$2026-04-26$m$,$m$cooked$m$::meal_status,3,$m$## ⏱️ Master Timeline
- **T-24h**: Dry brine chicken.
- **T-1:15**: Parboil potatoes → Stage 1 roast.
- **T-0:50**: Prep salad (hold at room temp).
- **T-0:40**: Chicken into oven.
- **T-0:15**: Remove potatoes.
- **T-0:10**: Make yogurt sauce.
- **T+25**: Apply butter.
- **T+30**: Start probing.
- **T+32–36**: Broil chicken.
- **T+36–42**: Chicken out → rest. Potatoes back in.
- **T+38–45**: Cook beans.
- **T+45–50**: Plate + serve.
---
## ⚠️ Critical Control Points
- **Chicken**: Broil at temp, not time. Don’t apply butter early.
- **Potatoes**: Don’t overcook Stage 1. Don’t cover while holding.
- **Salad**: Onion must be soaked. Salt last.
- **Yogurt**: Sauce = cold. Serve = cool.$m$,null,null,$m$34ee0391ce63801db50ef690f0697248$m$);
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$zaatar-spatchcock-chicken$m$,$m$Spatchcock Chicken (Aleppo + Za’atar Butter)$m$,$m$Chicken$m$,array[$m$Main$m$]::text[],array[$m$Modern$m$]::text[],$m$Medium$m$,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt / alton brown$m$,null,$m$Dry-brined spatchcock chicken roasted at high heat, brushed with Aleppo and za’atar butter and finished under the broiler.$m$,$m$## 🐔 Spatchcock Chicken (Aleppo + Za’atar Butter)
### Ingredients
- 1 whole chicken (\~1.9 kg), spatchcocked
- 2–2¼ tsp kosher salt (Diamond Crystal)
- ½ tsp black pepper
- 1 tbsp olive oil
**Butter**
- 30 g unsalted butter (\~2 tbsp)
- 1 tsp Aleppo pepper
- 1–1½ tbsp za’atar
### Prep (T-24h)
- Salt both sides (70% skin / 30% underside).
- Refrigerate uncovered for 12–24h.
- Ensure fully flattened.
### Cooking
- Oven: 220°C / 425°F.
- Pat dry, rub with oil + pepper.
- Roast (skin side up) — 25 min.
- Melt butter (low heat), add spices.
- Brush at T+25 min.
- Continue roasting 10–15 min.
- At 66–68°C (151–154°F) → switch to broil high.
- Broil 4–6 min (watch closely).
- Pull at 68°C / 155°F.
- Rest 10 min.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$34ee0391ce63801db50ef690f0697248$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, $m$~1.9 kg$m$, $m$spatchcocked$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$zaatar-spatchcock-chicken$m$ and i.name=$m$whole chicken$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tsp$m$, $m$2–2¼ tsp$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$zaatar-spatchcock-chicken$m$ and i.name=$m$kosher salt, diamond crystal$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$zaatar-spatchcock-chicken$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$zaatar-spatchcock-chicken$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 30, $m$g$m$, $m$~2 tbsp$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$zaatar-spatchcock-chicken$m$ and i.name=$m$unsalted butter$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$zaatar-spatchcock-chicken$m$ and i.name=$m$aleppo pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, $m$1–1½ tbsp$m$, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$zaatar-spatchcock-chicken$m$ and i.name=$m$za’atar$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$zaatar-roast-potatoes$m$,$m$Roast Potatoes (Two-Stage)$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Modern$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt / alton brown$m$,null,$m$Parboiled Yukon Gold potatoes roasted in two stages with garlic and finished with lemon zest and juice.$m$,$m$## 🥔 Roast Potatoes (Two-Stage)
### Ingredients
- 800 g Yukon Gold potatoes (skin on)
- 2 tbsp olive oil
- 1 tsp kosher salt
- Black pepper
- Optional: ½ tsp paprika
**Stage 2**
- 2–3 garlic cloves (sliced)
- Optional: thyme
**Finish**
- Lemon zest (½–1 lemon)
- 1–2 tsp lemon juice
- Optional: ½–1 tsp za’atar
### Method
1. **Parboil**: 8–10 min simmer. Drain + shake to rough edges.
2. **Season**: Toss with oil, salt, pepper.
3. **Stage 1 roast**: 220°C / 425°F for 25–30 min → light golden. Remove → hold uncovered.
4. **Stage 2 roast**: After chicken comes out, 230°C / 445°F. Add garlic + herbs. Roast 10–15 min.
5. **Finish**: Add lemon zest + juice. Optional light za’atar.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$34ee0391ce63801db50ef690f0697248$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 800, $m$g$m$, null, $m$skin on$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$yukon gold potato$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, null, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$black pepper$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, true, 5
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$paprika$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, $m$2–3 cloves$m$, $m$sliced$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, true, 7
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$thyme$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$½–1 lemon$m$, null, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tsp$m$, $m$1–2 tsp$m$, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, $m$½–1 tsp$m$, null, false, true, 10
from public.dish d, public.ingredient i where d.slug=$m$zaatar-roast-potatoes$m$ and i.name=$m$za’atar$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$zaatar-green-beans$m$,$m$Green Beans (Garlic + Lemon)$m$,$m$Veg$m$,array[$m$Side$m$]::text[],array[$m$Modern$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt / alton brown$m$,null,$m$Blanched green beans tossed in a hot pan with sliced garlic and finished with lemon.$m$,$m$## 🥬 Green Beans (Garlic + Lemon)
### Ingredients
- 300 g green beans
- 1 tbsp olive oil
- 2 garlic cloves (sliced)
- Zest ½ lemon
- 1 tbsp lemon juice
- Salt
### Method
- Blanch 2–3 min → ice bath.
- Heat pan (medium).
- Oil → garlic (light golden).
- Add beans → toss 2–3 min.
- Finish with lemon + salt.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$34ee0391ce63801db50ef690f0697248$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 300, $m$g$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$zaatar-green-beans$m$ and i.name=$m$green bean$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$zaatar-green-beans$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$clove$m$, null, $m$sliced$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$zaatar-green-beans$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$zest ½ lemon$m$, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$zaatar-green-beans$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$zaatar-green-beans$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$zaatar-green-beans$m$ and i.name=$m$salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$zaatar-fennel-citrus-salad$m$,$m$Fennel & Citrus Salad (Yellow Onion + Kalamata)$m$,$m$Veg$m$,array[$m$Salad$m$]::text[],array[$m$Modern$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt / alton brown$m$,null,$m$Thinly sliced fennel and soaked yellow onion with orange and grapefruit segments, Kalamata olives and a lemon–olive oil dressing.$m$,$m$## 🥗 Fennel & Citrus Salad (Yellow Onion + Kalamata)
### Ingredients
- 1 fennel bulb (very thinly sliced)
- ⅓ small yellow onion (thinly sliced)
**Citrus**
- 1 orange + ½ grapefruit (segmented)
**Dressing**
- Zest ½ lemon
- 1½ tbsp lemon juice
- 3 tbsp olive oil
**Other**
- 25 g Kalamata olives (sliced)
- ¼–½ tsp kosher salt
- Black pepper
### Method
- Soak onion 15–20 min, drain.
- Combine fennel + onion.
- Add lemon zest, juice, olive oil.
- Add citrus (gently).
- Add olives.
**Balance**
- Adjust acid/oil first.
- Salt last.
**Rest**
- 10–15 min at room temp.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$34ee0391ce63801db50ef690f0697248$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$very thinly sliced$m$, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$fennel bulb$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.33, $m$piece$m$, $m$⅓ small onion$m$, $m$small, thinly sliced$m$, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$yellow onion$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$piece$m$, null, $m$segmented$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$orange$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$piece$m$, null, $m$segmented$m$, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$grapefruit$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$zest ½ lemon$m$, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$lemon zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1.5, $m$tbsp$m$, null, null, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 3, $m$tbsp$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 25, $m$g$m$, null, $m$sliced$m$, false, false, 8
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$kalamata olive$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.25, $m$tsp$m$, $m$¼–½ tsp$m$, null, false, false, 9
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$kosher salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, null, null, false, false, 10
from public.dish d, public.ingredient i where d.slug=$m$zaatar-fennel-citrus-salad$m$ and i.name=$m$black pepper$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$zaatar-yogurt-sauce$m$,$m$Yogurt Sauce$m$,null,array[$m$Sauce$m$]::text[],array[$m$Modern$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt / alton brown$m$,null,$m$Cold Greek yogurt sauce with olive oil, grated garlic and lemon juice.$m$,$m$## 🥣 Yogurt Sauce
### Ingredients
- 200 g Greek yogurt
- 1 tbsp olive oil
- 1 garlic clove (grated)
- 1 tbsp lemon juice
- ½ tsp salt
### Method
- Mix.
- Refrigerate.
- Bring out 10–15 min before serving.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$34ee0391ce63801db50ef690f0697248$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 200, $m$g$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$zaatar-yogurt-sauce$m$ and i.name=$m$greek yogurt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$zaatar-yogurt-sauce$m$ and i.name=$m$olive oil$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$clove$m$, null, $m$grated$m$, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$zaatar-yogurt-sauce$m$ and i.name=$m$garlic$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 1, $m$tbsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$zaatar-yogurt-sauce$m$ and i.name=$m$lemon juice$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$zaatar-yogurt-sauce$m$ and i.name=$m$salt$m$;
insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ($m$zaatar-orange-yogurt-dessert$m$,$m$Yogurt Dessert (Orange)$m$,null,array[$m$Dessert$m$]::text[],array[$m$Modern$m$]::text[],null,'{}'::text[],array[$m$Family$m$,$m$Guests$m$]::text[],$m$cooked$m$::dish_status,$m$Chatgpt / alton brown$m$,null,$m$Chilled honey–vanilla Greek yogurt layered with segmented oranges and toasted nuts.$m$,$m$## 🍊 Yogurt Dessert (Orange)
### Ingredients
- 300 g Greek yogurt
- 2–3 tbsp honey
- Zest ½ orange
- ½ tsp vanilla
- Pinch salt
**Fruit**
- 2 oranges (segmented)
**Toppings**
- 40 g toasted nuts
### Method
1. **Oranges**: Segment cleanly. Toss with 1 tsp honey + pinch salt. Rest 10–15 min.
2. **Yogurt**: Mix base. Chill 30–60 min.
3. **Assemble**: Yogurt → oranges → nuts → honey drizzle.$m$,3,'{}'::text[],$m$[]$m$::jsonb,null,$m$34ee0391ce63801db50ef690f0697248$m$);
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 300, $m$g$m$, null, null, false, false, 1
from public.dish d, public.ingredient i where d.slug=$m$zaatar-orange-yogurt-dessert$m$ and i.name=$m$greek yogurt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$tbsp$m$, $m$2–3 tbsp$m$, null, false, false, 2
from public.dish d, public.ingredient i where d.slug=$m$zaatar-orange-yogurt-dessert$m$ and i.name=$m$honey$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, null, $m$zest ½ orange$m$, null, false, false, 3
from public.dish d, public.ingredient i where d.slug=$m$zaatar-orange-yogurt-dessert$m$ and i.name=$m$orange zest$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 0.5, $m$tsp$m$, null, null, false, false, 4
from public.dish d, public.ingredient i where d.slug=$m$zaatar-orange-yogurt-dessert$m$ and i.name=$m$vanilla$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, null, $m$pinch$m$, null, null, false, false, 5
from public.dish d, public.ingredient i where d.slug=$m$zaatar-orange-yogurt-dessert$m$ and i.name=$m$salt$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 2, $m$piece$m$, null, $m$segmented$m$, false, false, 6
from public.dish d, public.ingredient i where d.slug=$m$zaatar-orange-yogurt-dessert$m$ and i.name=$m$orange$m$;
insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, 40, $m$g$m$, null, null, false, false, 7
from public.dish d, public.ingredient i where d.slug=$m$zaatar-orange-yogurt-dessert$m$ and i.name=$m$toasted nut$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$main$m$::dish_role, 1 from public.meal m, public.dish d where m.slug=$m$zaatar-chicken-dinner$m$ and d.slug=$m$zaatar-spatchcock-chicken$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 2 from public.meal m, public.dish d where m.slug=$m$zaatar-chicken-dinner$m$ and d.slug=$m$zaatar-roast-potatoes$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$side$m$::dish_role, 3 from public.meal m, public.dish d where m.slug=$m$zaatar-chicken-dinner$m$ and d.slug=$m$zaatar-green-beans$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$salad$m$::dish_role, 4 from public.meal m, public.dish d where m.slug=$m$zaatar-chicken-dinner$m$ and d.slug=$m$zaatar-fennel-citrus-salad$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$sauce$m$::dish_role, 5 from public.meal m, public.dish d where m.slug=$m$zaatar-chicken-dinner$m$ and d.slug=$m$zaatar-yogurt-sauce$m$;
insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, $m$dessert$m$::dish_role, 6 from public.meal m, public.dish d where m.slug=$m$zaatar-chicken-dinner$m$ and d.slug=$m$zaatar-orange-yogurt-dessert$m$;
insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
select m.id, null::uuid, $m$2026-04-26$m$::date, 9.5, null, null, null, $m$[]$m$::jsonb, $m$[]$m$::jsonb, null, null from public.meal m where m.slug=$m$zaatar-chicken-dinner$m$;
commit;
