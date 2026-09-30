# Vault → jins-kitchen transformation spec

Input: `../vault_export/<page_id>.md` — each is the verbatim Notion fetch result: a JSON object whose `text` field contains `<properties>{...}</properties>` (the Vault row: Name, Protein, Category, Cuisine, Difficulty, Tags, Occasion, Rating, Execution Rating, Repeat?, Times Made, Cook Notes, Source, Wine / Drink Pairing, date:Last Made :start) and `<content>...</content>` (the page body in Notion markdown).

Output: one file per assignment at `./out/<assignment_key>.json` matching the schema below. Write valid JSON only. Do not invent facts: every value must come from the properties or the body. Leave a field null / [] when the source does not say.

## Output schema

```json
{
  "assignment_key": "string",
  "source_page_ids": ["..."],
  "meal": null | {
    "slug": "kebab-case, unique",
    "name": "human name",
    "planned_date": "YYYY-MM-DD or null",
    "status": "backlog" | "planned" | "cooked",
    "pax": 3,
    "workflow_md": "Meal Workflow / T-minus timeline / holding chain sections verbatim as markdown, or null",
    "shared_prep_md": "Shared Prep section verbatim or null",
    "wine_pairing": "from the Wine / Drink Pairing property or body, or null",
    "legacy_notion_id": "page id the meal came from, or null",
    "components": [ { "dish_slug": "...", "role": "main|side|sauce|dessert|soup|bread|starter|salad", "service_order": 1 } ]
  },
  "dishes": [ {
    "slug": "kebab-case, unique across the whole migration — prefix with a short meal token when generic (e.g. maafe-steamed-rice, not steamed-rice)",
    "name": "...",
    "protein": "Beef|Pork|Lamb|Chicken|Duck|Fish|Shellfish|Seafood|Veg|null",
    "category": ["Main"|"Side"|"Sauce"|"Dessert"|"Soup"|"Bread"|"Salad"],
    "cuisine": [], "difficulty": "Easy|Medium|Special|null", "tags": [], "occasion": [],
    "status": "designed|cooked|retired",
    "source": "Source property text or null",
    "governance_version": "e.g. v3.5 if stated, else null",
    "summary": "one sentence describing the dish, from the body's overview if present; otherwise write a neutral one-liner from the title only",
    "method_md": "the dish's full recipe body as markdown (ingredients + method + CCPs + notes), verbatim from the page; for a multi-component page, only that component's section; null if the page has no body",
    "servings": 3 or the stated number, else null,
    "equipment": ["narrow Le Creuset", "konro", ...] only if the body names it, else [],
    "designed_unvalidated": [ {"param": "...", "designed_value": "...", "note": "..."} ] from any 'designed — not yet validated' / 'designed-but-unvalidated' list, else [],
    "nutrition_estimate": {"kcal":..,"protein_g":..,"carbs_g":..,"fat_g":..,"per":"serving"} only if the body states one, else null,
    "legacy_notion_id": "page id or null",
    "ingredients": [ { "name": "canonical lower-case singular, no quantities (e.g. 'chicken thigh, bone-in')", "department": "Protein|Produce|Dairy|Pantry|Bread|Oils & Liquids|Seasoning|Frozen|Alcohol", "qty": 250, "unit": "g|ml|tsp|tbsp|piece|clove|bunch|sprig|slice|cup|lb|oz|pinch|null", "qty_alt": "the other unit as written, e.g. '9 oz'", "prep_note": "diced / trimmed / etc or null", "pantry_check": true if marked pantry, "optional": false } ]
  } ],
  "cooks": [ {
    "owner": "meal" | "dish",
    "dish_slug": "required when owner=dish, else null",
    "cooked_on": "YYYY-MM-DD",
    "rating": 9.5 or null, "execution_rating": null or number,
    "repeat": "yes|with_modifications|no|null",
    "cook_notes": "Cook Notes text (property) plus any dated cook-record text from the body for that date; verbatim",
    "deviations": [ "free text items" ],
    "parameter_confirmations": [ {"param": "...", "designed": "...", "observed": "...", "verdict": "confirmed|diverged|unresolved"} ],
    "household_split": "or null", "wine_outcome": "or null"
  } ]
}
```

## Rules

1. Menu page (kind = meal): create ONE meal (status cooked unless told otherwise, planned_date = Last Made) + one dish per component. The Vault row's Rating / Execution Rating / Repeat? go on a meal-level cook (owner = meal). Component dishes get status cooked, NO dish-level cook row (they were never rated separately), and their Protein / Cuisine / Tags / Occasion copied from the row where sensible (protein only on the protein-bearing component; sides get "Veg" or null).
2. Single-dish page: create one dish; the row's ratings go on a dish-level cook (owner = dish) dated Last Made.
3. Groups (given per assignment) create a meal whose components are those dishes; the meal gets a meal-level cook with rating null (never rated as a meal) but cooked_on set; each dish keeps its own dish-level cook.
4. Rows with Times Made null still get exactly one cook dated Last Made (rating from row, execution null).
5. Ingredients: parse every ingredient line you can find in the body. Split quantity, unit, name, prep note. Where metric and imperial are both given, put the metric in qty/unit and the other in qty_alt. Mark "(pantry check)" items pantry_check true. If a page has no ingredient list, ingredients = [].
6. Keep method_md verbatim — do not summarise or rewrite recipe text. Strip only the Notion property echo and the post-cook template scaffolding.
7. Dates: use the Last Made property for cooked_on unless the body gives a more specific dated cook record. Multiple dated cook records = multiple cook rows.
8. Slugs: ASCII kebab-case, ≤ 60 chars, unique. Meals end with a context word (e.g. -dinner, -sunday). Dish slugs for components carry a meal prefix (e.g. `maafe-`, `zaatar-`).
9. Never write to Notion or Supabase. Output files only.
