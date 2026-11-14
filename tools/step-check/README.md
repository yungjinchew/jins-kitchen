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
