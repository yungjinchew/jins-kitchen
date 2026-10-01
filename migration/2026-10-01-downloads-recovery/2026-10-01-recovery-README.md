# Downloads recovery — 1 Oct 2026

Source: recipe documents (docx / HTML cooking sheets) recovered from C:\Users\yjche\Downloads, copied to `site/docs/<owner-slug>/v1/` and registered in `public.document` (storage_path is site-relative; the PWA serves them same-origin).

- `parsed/*.json` — structured parse of each document (dishes, ingredients, meal workflow) in the migration transform format.
- `sql/*.json` — the exact statement lists executed against Supabase (loaded via `extensions.http_get` from the temporarily deployed `site/_recovery/` folder, since supabase.co is unreachable from the Cowork sandboxes). `meal_status` has no `designed`; the two never-cooked sheets (mb3-ribeye, white-bean-soup) were loaded as `backlog`.
- Decisions: 21 empty dishes filled; 16 missing components added; 7 thin recipes upgraded (bbq ribs main, roast chicken ×4, chicken-stew sourdough + fennel salad); Aegean ×4, Maiale ×3, Maafe ×6, chicken-stew main + cake kept from the Vault migration. `ribeye-yogurt-mustard-cream` renamed to the designed Horseradish Cream (cook log records the yogurt–mustard substitution).
- Still without a recipe after this load: duck-magret-sunday ×4, brisket-main-unfiled, mussels sides ×4, short-ribs gremolata + arugula salad.

## Addendum — Notion Recipe Recovery, Duck Magret Sunday (1 Oct 2026)
Source: Recipe Recovery page https://app.notion.com/p/3ece0391ce638106a461e96d2b706073 (final reconciled Muscovy / vermouth state; the 11 Sep docx was never regenerated and is not on disk). Loaded via `sql/duck-magret.sql`: method_md + ingredients for the four duck dishes, meal workflow + shared prep, 8 measurement-gate rows (all "not captured" — no leave-in probe) attached to the 20 Sep duck-breast cook. Jus protein corrected to null. Notion row marked Ingested.
