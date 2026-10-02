# 2026-10-02 · migration `recipe_review_service` (APPLIED via Supabase connector)

Recorded in the project's Supabase migration history under the name `recipe_review_service`. Creates:

- extensions `pg_net` and `http` (schema `extensions`)
- `public.kitchen_config` (review_model, review_max_rounds, review_timeout_ms, governance_base) — RLS on, no policies
- `public.recipe_review` (one row per review round: draft, decision log, model, critique, verdict) — RLS on, no policies
- `public.kitchen_review_request(p_subject, p_round, p_draft, p_decision_log, p_multi_component)` — reads the OpenAI key from Vault secret `openai_api_key`, fetches the current framework from GitHub, posts to `https://api.openai.com/v1/responses` through pg_net, returns a review id
- `public.kitchen_review_result(p_review_id)` — returns pending / done (verdict + critique) / error

Execute is revoked from public, anon and authenticated on both functions.

To change the reviewer model: `update public.kitchen_config set value = '<model id>' where key = 'review_model';`
To read the full source: `select pg_get_functiondef('public.kitchen_review_request'::regproc);`

`2026-10-02-0003-replace-dish-ingredients.sql` is still NOT applied (the connector holds statements containing DELETE for confirmation).
