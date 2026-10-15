# 2026-10-12 · migrations `kitchen_ctx_review`, `kitchen_ctx_review_hide_retired`, `kitchen_meal_context` (APPLIED via Supabase connector)

Purpose: ChatGPT and Claude chat could not read the kitchen app (it renders in the browser; a non-JS reader sees "Loading…"). The kitchen now rides on the same read-only mirror and ChatGPT plugin as the trip plans (jins-trips `/ctx/<read token>/…`, code in `Travel/Resources/ctx-site/netlify/lib/kitchen.js`), and assistants file review comments on meals the same way they do on trips.

Creates:

- schema `kctx_private` with `tokens` (SHA-256 of the mirror's read token — the same token as jins-restaurants `ctx_private.tokens`, kind `token`; rotate both together) and `ok(p_token)`
- `public.kitchen_comment` — one row per filed point: meal and/or dish, section, category (correction, technique, timing, omission, risk, suggestion, question, pairing), comment, source, surface, status (open, needs-jin, applied, rejected, noted, withdrawn), Cowork's response. RLS on, no policies.
- read, token-checked, callable with the publishable key: `kctx_index(token)`, `kctx_meal(token, slug)`, `kctx_comments(token)`
- write, token-checked, append-only: `kctx_comment_file(token, meal, dish, section, category, comment, source, surface)` — de-duplicates, caps 150 a day
- Cowork side, NOT callable with the publishable key: `kitchen_comment_queue()`, `kitchen_meal_context(slug)` (the same bundle the assistants read), `kitchen_comment_respond(id, status, reason)`

Pickup: the daily "Kitchen inbox drain and audit" scheduled task, STEP 4B. It records rejected / noted / needs-jin and never changes a recipe; `applied` is set only in a cooking session with Jin once an approved change is saved.

Comment #1 is the setup test (withdrawn, parked on the retired ZZ-TEST spinach dish so it shows nowhere).
