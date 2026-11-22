# Step check (6 Nov 2026)

Core v3.16 §III "Method steps stand alone": every numbered method step opens with a bold lead that is the whole
instruction (action, amount on first use, vessel, setting, stop cue). After the lead come only reasons, checks,
"If …" branches and "Do not …" constraints. The app's step-by-step shows the lead as the step, so anything else
hides.

- **In the app:** More → Step check (`#/stepcheck`) lists every saved step that still hides an action. Target: none.
- **Before saving a draft:** write the draft's method to a file and run `node stepcheck.js draft.md` (this folder;
  it reads the parser from `site/index.html`, so it matches the app). Exit 0 = nothing hidden.
- **Wording-only edits to saved methods:** `makesql.py` builds a guarded, server-side save that sends only the
  changed lines (see its header). The 70-dish conversion on 6 Nov used it; record such passes in `Cooking/MEMORY.md`.

Baseline 6 Nov 2026: 158 dishes · 1,360 steps · 0 hiding an action · 1,007 without a bold lead (those are shown whole
and get a lead when the dish is next revised).

**Step budget (22 Nov 2026, Core 3.17):** the checker and the app's Step check also flag a step whose bold lead runs past 30 words or holds two or more semicolons, or that runs past 70 words in all (LONG lines; exit 1). Steps without a bold lead are not measured: they are shown whole and get a lead, and the budget, when the dish is next revised. `makesql.py` refuses a changed line count, so a revision that splits steps is saved as the full method with an md5-guarded `kitchen_save_dish` (the 22 Nov pot pie save). Baseline 22 Nov: 163 dishes · 1,568 steps · 1 hiding an action · 292 over budget in 73 dishes.
