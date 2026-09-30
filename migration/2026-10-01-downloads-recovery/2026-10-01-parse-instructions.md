# Recovery parse — instructions for one document

You are converting a recovered recipe document (markdown extracted from Jin's docx/HTML cooking sheet) into structured JSON for the `jins-kitchen` Supabase database. Read the WHOLE markdown file; the document is the authoritative "stable" recipe. Do not invent content; do not drop content.

## Output
Write ONE JSON file at the path given in your task. Schema:

{
 "assignment_key": "<given>",
 "source_file": "<given repo path>",
 "meal": {                       // null if the document is a single standalone dish
   "slug": "<given>", "name": "<menu title as in doc, no emoji>",
   "planned_date": "YYYY-MM-DD" | null, "status": "<given>", "pax": <int>,
   "workflow_md": "<markdown: critical path, failure prioritisation, oven sequencing, heat allocation, T-minus timeline table, holding chain, plating window, variance notes — everything in the doc's Meal Workflow section, verbatim content reformatted as markdown; tables as HTML <table header-row=\"true\"><tr><td>..</td></tr></table> exactly like this>",
   "shared_prep_md": "<markdown of Shared Prep section, or null>",
   "wine_pairing": "<text or null>",
   "components": [ {"dish_slug": "...", "role": "main|side|sauce|salad|soup|bread|starter|dessert", "service_order": 1} ]
 },
 "dishes": [
  {
   "slug": "<use the EXISTING slug when the task lists one for this component; otherwise new slug = <meal-prefix>-<kebab-name>, ASCII, <=60 chars>",
   "existing": true|false,
   "name": "<dish title as in doc>",
   "protein": "Beef|Pork|Lamb|Chicken|Duck|Fish|Shellfish|Seafood|Veg|null",   // only the component carrying it; Veg for vegetable-led sides; null for starches/sauces/desserts
   "category": ["Main"|"Side"|"Sauce"|"Salad"|"Soup"|"Bread"|"Dessert"],
   "cuisine": [], "difficulty": "Easy|Medium|Special|null", "tags": [], "occasion": [],
   "status": "<given>",
   "source": "Recovered from <file name>, generated <date in doc>",
   "governance_version": "<Core version if stated in doc, else null>",
   "summary": "<one sentence>",
   "servings": <int or null>,
   "equipment": ["only equipment the recipe names"],
   "method_md": "<FULL recipe as markdown, sections in this order with ## headings where the doc has them: Dish Overview, Yield & Timing, Flavor Architecture, Prep Phase, Active Cooking, Holding & Assembly, Critical Control Points (table verbatim), Adjustment Notes, Scaling Notes, Nutrition Estimate. Do NOT include the ingredient list (it goes to ingredients[]). Keep every number, temperature, time and instruction. Tables as HTML <table header-row=\"true\"> like workflow_md.>",
   "designed_unvalidated": [ {"param": "...", "designed_value": "...", "note": "..."} ],
   "nutrition_estimate": {"kcal":0,"protein_g":0,"carbs_g":0,"fat_g":0,"per":"serving"} | null,
   "ingredients": [
     {"name": "<canonical lower-case singular, no quantity — REUSE a name from ingredient_names.txt when one matches (e.g. 'unsalted butter', 'diamond crystal kosher salt', 'extra-virgin olive oil', 'flat-leaf parsley', 'yellow onion', 'chicken stock'); otherwise a new canonical name>",
      "department": "Protein|Produce|Dairy|Bread|Frozen|Pantry|Oils & Liquids|Alcohol|Seasoning",
      "qty": <number or null — metric where given; ranges -> lower bound>, "unit": "g|ml|tsp|tbsp|piece|clove|bunch|sprig|slice|cup|pinch|null",
      "qty_alt": "<the other unit exactly as written, or the range, or null>",
      "prep_note": "<'diced', 'zest only', 'for the braise' … or null>",
      "pantry_check": true|false, "optional": true|false}
   ]
  }
 ],
 "notes": "<anything odd: components in the doc not listed in the task, mismatches with existing slugs, content you could not place>"
}

## Rules
- One dish per menu component that has its own recipe in the doc. Every ingredient line of the doc → exactly one ingredients[] entry (none invented, none dropped). A dish's ingredient list is often a table; read it carefully.
- Shopping list sections are NOT stored (derived at read time) — skip them, but use them to set pantry_check=true for items marked pantry/pantry check.
- Escape properly: the output must be valid JSON (use json.dump from Python rather than hand-writing if you like). Write the file with Python or the Write tool, then validate with `python3 -c "import json;json.load(open(PATH))"`.
- Keep method_md faithful and complete — this is the governance record; a cooking-sheet HTML is compressed but still copy everything present.
- If the document's menu includes components that the task did not list as existing slugs, create them as new dishes (existing:false) and say so in notes.
- If the task says a dish already has a recipe in the DB, still output it fully (we compare) and set "existing": true.
- Do not modify anything outside your output file. Do not touch the database.
