-- jins-kitchen migration 0009 (2026-10-29): review loop v1.1
-- Audit of 26 GPT rounds (3-29 Oct 2026). Changes:
--  * governance read from the refs/heads/main raw URL (the short /main/ form can serve a cached copy)
--  * every request records the Git blob SHA of the Core text the reviewer saw, and whether it loaded (HTTP status checked)
--  * reviewer brief read from recipe_review_protocol.md §4 between markers; config copy used only if that fetch fails
--  * actual model and token usage captured from the OpenAI response
--  * meal/dish slug on every round; confirmation pass as round max+1 (p_confirm)
--  * kitchen_review_close stores the final decision log and open disagreements; kitchen_review_log_fallback records Claude-critic rounds

alter table public.recipe_review
  add column if not exists meal_slug text,
  add column if not exists reviewer text not null default 'gpt',
  add column if not exists is_confirmation boolean not null default false,
  add column if not exists governance_sha text,
  add column if not exists framework_loaded boolean,
  add column if not exists brief_source text,
  add column if not exists response_model text,
  add column if not exists usage jsonb,
  add column if not exists final_decision_log_md text,
  add column if not exists open_disagreements_md text,
  add column if not exists closed_at timestamptz;

update public.kitchen_config
   set value = 'https://raw.githubusercontent.com/yungjinchew/jins-cooking-governance/refs/heads/main/', updated_at = now()
 where key = 'governance_base';

insert into public.kitchen_config (key, value, updated_at)
values ('review_brief_fallback', $brief$You are the independent second reviewer of a home-cooking recipe or multi-component menu written for Jin, who lives in Singapore. Household: 3 adults; 2 induction hobs, one Bosch built-in oven, Tiger rice cooker, butane torch; outdoors a 3-burner gas stove and a binchotan grill; conservative salt and sugar; moderate carbohydrates. Where the draft states another location, party or equipment, judge against what the draft states. Review the DRAFT against the governance framework supplied in the input and against sound culinary science and food-safety practice. You are read-only: critique, do not rewrite the recipe.

Report only findings that would change the result on the plate, the safety of the food, or whether the timeline can actually be executed with the stated equipment and one cook. Check arithmetic: quantities, timings, T-minus timelines at both ends of every time band, oven and burner conflicts, holding limits, carryover. Check buying: every ingredient whose result depends on a variety, cut, grade, size or brand must state what to buy, and name what not to buy where the common substitute on the shelf would fail, on the ingredient line and on the shopping-list row itself, not only in the method or a sourcing note. A missing or contradictory buying spec that would lead the shopper to buy the wrong thing is MATERIAL.

Judge safety against the diner profile the draft states. Unless the profile declares a vulnerable diner (pregnant, immunocompromised, elderly or a young child), do not ask for a safer-endpoint alternative or a vulnerable-diner branch: a one-line statement of the trade-off is enough.

Do not raise terminology, formatting, naming or documentation points; under framework Section XIV those are not material.

If a PRIOR DECISION LOG is supplied, first check that every adopted change, and every branch, fallback or alternative it created, is carried through each place the component appears (ingredient line, shopping row, method, timeline at both ends of every band, holding chain, CCPs, storage) and closes in the timeline; report any failure there before other findings. Do not re-raise a point that was declined with a stated reason unless that reason is factually wrong, and if so say exactly why.

If the input is marked CONFIRMATION PASS, check only that the changes adopted after the previous round are implemented and close in the timeline. Raise nothing else unless one of those changes caused it.

Output format, plain text: numbered findings, most important first, at most 8. Each finding: [MATERIAL] or [MINOR] · where (dish / section / step) · the problem and its mechanism · the specific change you propose, with numbers. Then a line starting "What is sound:" with one to three short points. The final line must be exactly "VERDICT: MATERIAL ISSUES" or "VERDICT: NO MATERIAL ISSUES". Use NO MATERIAL ISSUES when every remaining point is minor.$brief$, now())
on conflict (key) do update set value = excluded.value, updated_at = now();

drop function if exists public.kitchen_review_request(text, integer, text, text, boolean);

create function public.kitchen_review_request(
  p_subject text,
  p_round integer,
  p_draft text,
  p_decision_log text default null,
  p_multi_component boolean default false,
  p_meal_slug text default null,
  p_confirm boolean default false
) returns jsonb
language plpgsql
set search_path to 'public', 'extensions'
as $function$
declare
  v_key text; v_model text; v_timeout integer; v_base text; v_max integer;
  v_status integer; v_body text;
  v_version text; v_core text := ''; v_workflow text := ''; v_proto text := '';
  v_sha text; v_loaded boolean := false;
  v_brief text; v_brief_source text := 'github';
  v_input text; v_req bigint; v_id uuid; v_warn text;
begin
  if coalesce(length(trim(p_draft)), 0) < 200 then
    raise exception 'draft is empty or too short to review';
  end if;
  select value into v_model from public.kitchen_config where key = 'review_model';
  select value::integer into v_timeout from public.kitchen_config where key = 'review_timeout_ms';
  select value::integer into v_max from public.kitchen_config where key = 'review_max_rounds';
  select value into v_base from public.kitchen_config where key = 'governance_base';
  v_max := coalesce(v_max, 3);

  if p_confirm and p_round <> v_max + 1 then
    return jsonb_build_object('status', 'round_limit', 'message', format('The confirmation pass is round %s, after round %s. Use p_confirm := true only then.', v_max + 1, v_max));
  end if;
  if p_round > v_max and not p_confirm then
    return jsonb_build_object('status', 'round_limit', 'message', format('Round %s was the last review round. If a MATERIAL finding from it was adopted, run the confirmation pass (p_round := %s, p_confirm := true); otherwise finalise and list open disagreements.', v_max, v_max + 1));
  end if;

  select decrypted_secret into v_key from vault.decrypted_secrets where name = 'openai_api_key' limit 1;
  if v_key is null or length(trim(v_key)) = 0 then
    insert into public.recipe_review (subject, round, draft_md, decision_log_md, model, status, error_detail, completed_at, meal_slug, is_confirmation)
    values (p_subject, p_round, p_draft, p_decision_log, v_model, 'no_key', 'No secret named openai_api_key in Supabase Vault', now(), p_meal_slug, p_confirm)
    returning id into v_id;
    return jsonb_build_object('status', 'no_key', 'review_id', v_id,
      'message', 'GPT review is not configured (no openai_api_key in Supabase Vault). Use the Claude critic fallback, log it with kitchen_review_log_fallback, and say so.');
  end if;

  begin
    perform extensions.http_set_curlopt('CURLOPT_TIMEOUT', '12');
    select status, content into v_status, v_body from extensions.http_get(v_base || 'manifest.json');
    if v_status = 200 then v_version := (v_body::jsonb) ->> 'framework_version'; end if;
    select status, content into v_status, v_body from extensions.http_get(v_base || 'recipe_governance_core.md');
    if v_status = 200 and length(v_body) > 1000 then
      v_core := v_body;
      v_loaded := true;
      v_sha := encode(extensions.digest(convert_to('blob ' || octet_length(convert_to(v_core, 'UTF8')), 'UTF8') || '\x00'::bytea || convert_to(v_core, 'UTF8'), 'sha1'), 'hex');
    end if;
    if p_multi_component then
      select status, content into v_status, v_body from extensions.http_get(v_base || 'recipe_governance_meal_workflow.md');
      if v_status = 200 then v_workflow := v_body; else v_loaded := false; end if;
    end if;
  exception when others then
    v_loaded := false;
  end;

  begin
    select status, content into v_status, v_body from extensions.http_get(v_base || 'recipe_review_protocol.md');
    if v_status = 200 then v_proto := v_body; end if;
  exception when others then
    v_proto := '';
  end;

  v_brief := btrim(substring(coalesce(v_proto, '') from '<!-- reviewer-brief:start -->(.*)<!-- reviewer-brief:end -->'), E' \n\r\t');
  if v_brief is null or length(v_brief) < 500 then
    select value into v_brief from public.kitchen_config where key = 'review_brief_fallback';
    v_brief_source := 'config';
  end if;

  if not v_loaded then
    v_warn := 'The governance framework could not be loaded in full; the reviewer is judging on culinary merits only. Say so in the Review log.';
  end if;

  v_input :=
    case when p_confirm then 'CONFIRMATION PASS (round ' || p_round || ')' else 'REVIEW ROUND ' || p_round end
    || E'\nSUBJECT: ' || p_subject || E'\n\n'
    || '=== GOVERNANCE FRAMEWORK (Core' || coalesce(' v' || v_version, '') || E') ===\n' || coalesce(nullif(v_core, ''), '(could not be fetched; review on culinary merits)') || E'\n\n'
    || case when p_multi_component and v_workflow <> '' then E'=== MEAL WORKFLOW MODULE ===\n' || v_workflow || E'\n\n' else '' end
    || case when p_decision_log is not null and length(trim(p_decision_log)) > 0 then E'=== PRIOR DECISION LOG (what the author did with earlier findings) ===\n' || p_decision_log || E'\n\n' else '' end
    || E'=== DRAFT TO REVIEW ===\n' || p_draft;

  select net.http_post(
    url := 'https://api.openai.com/v1/responses',
    body := jsonb_build_object('model', v_model, 'instructions', v_brief, 'input', v_input),
    headers := jsonb_build_object('Content-Type', 'application/json', 'Authorization', 'Bearer ' || v_key),
    timeout_milliseconds := coalesce(v_timeout, 180000)
  ) into v_req;

  insert into public.recipe_review (subject, round, draft_md, decision_log_md, model, governance_version, request_id, status,
                                    meal_slug, is_confirmation, governance_sha, framework_loaded, brief_source)
  values (p_subject, p_round, p_draft, p_decision_log, v_model, v_version, v_req, 'requested',
          p_meal_slug, p_confirm, v_sha, v_loaded, v_brief_source)
  returning id into v_id;

  return jsonb_strip_nulls(jsonb_build_object('status', 'requested', 'review_id', v_id, 'round', p_round, 'model', v_model,
    'confirmation_pass', p_confirm, 'governance_version', v_version, 'governance_sha', v_sha,
    'framework_loaded', v_loaded, 'brief_source', v_brief_source, 'warning', v_warn,
    'next', 'Run: select public.kitchen_review_result(''' || v_id || '''); — if it returns pending, run it again.'));
end;
$function$;

create or replace function public.kitchen_review_result(p_review_id uuid)
returns jsonb
language plpgsql
set search_path to 'public', 'extensions'
as $function$
declare
  r public.recipe_review%rowtype;
  v_code integer; v_content text; v_timed_out boolean; v_err text; v_found boolean := false;
  v_json jsonb; v_text text; v_verdict text;
begin
  select * into r from public.recipe_review where id = p_review_id;
  if not found then
    raise exception 'review % not found', p_review_id;
  end if;
  if r.status in ('done', 'error', 'no_key') then
    return jsonb_build_object('status', r.status, 'round', r.round, 'verdict', r.verdict, 'critique', r.critique_md, 'error', r.error_detail,
                              'model', coalesce(r.response_model, r.model));
  end if;

  select status_code, content, timed_out, error_msg, true
    into v_code, v_content, v_timed_out, v_err, v_found
  from net._http_response where id = r.request_id;

  if not coalesce(v_found, false) then
    return jsonb_build_object('status', 'pending', 'round', r.round,
      'waited_seconds', round(extract(epoch from (now() - r.created_at))),
      'message', 'Reviewer has not answered yet. Call again in a few seconds. If still pending after 4 minutes, use the Claude critic fallback.');
  end if;

  if v_code = 200 then
    v_json := v_content::jsonb;
    select string_agg(c ->> 'text', E'\n')
      into v_text
    from jsonb_array_elements(coalesce(v_json -> 'output', '[]'::jsonb)) o,
         jsonb_array_elements(coalesce(o -> 'content', '[]'::jsonb)) c
    where c ? 'text';
    v_verdict := case
      when v_text ~* 'VERDICT:\s*NO MATERIAL ISSUES' then 'no_material_issues'
      when v_text ~* 'VERDICT:\s*MATERIAL ISSUES' then 'material_issues'
      else 'unclear' end;
    update public.recipe_review
       set status = 'done', critique_md = v_text, verdict = v_verdict, completed_at = now(),
           response_model = v_json ->> 'model', usage = v_json -> 'usage'
     where id = p_review_id;
    return jsonb_build_object('status', 'done', 'round', r.round, 'model', coalesce(v_json ->> 'model', r.model), 'verdict', v_verdict, 'critique', v_text);
  else
    update public.recipe_review
       set status = 'error', error_detail = left(coalesce(v_err, '') || ' ' || coalesce(v_content, ''), 800), completed_at = now()
     where id = p_review_id;
    return jsonb_build_object('status', 'error', 'http_status', v_code, 'timed_out', v_timed_out,
      'error', left(coalesce(v_err, '') || ' ' || coalesce(v_content, ''), 800),
      'message', case when coalesce(v_content, '') ~* '(credit|billing|quota)'
        then 'GPT review failed: the OpenAI account is out of credit. Tell Jin to top it up, then use the Claude critic fallback and log it with kitchen_review_log_fallback.'
        else 'GPT review failed. Use the Claude critic fallback, log it with kitchen_review_log_fallback, and say so.' end);
  end if;
end;
$function$;

create or replace function public.kitchen_review_close(
  p_subject text,
  p_final_decision_log text,
  p_open_disagreements text default null,
  p_meal_slug text default null
) returns jsonb
language plpgsql
set search_path to 'public'
as $function$
declare
  v_id uuid; v_rounds integer;
begin
  if coalesce(length(trim(p_final_decision_log)), 0) < 20 then
    raise exception 'final decision log is empty';
  end if;
  select id into v_id from public.recipe_review
   where subject = p_subject and status = 'done'
   order by created_at desc limit 1;
  if v_id is null then
    raise exception 'no completed review round found for subject %', p_subject;
  end if;
  update public.recipe_review
     set final_decision_log_md = p_final_decision_log,
         open_disagreements_md = nullif(trim(coalesce(p_open_disagreements, '')), ''),
         closed_at = now(),
         meal_slug = coalesce(p_meal_slug, meal_slug)
   where id = v_id;
  if p_meal_slug is not null then
    update public.recipe_review set meal_slug = p_meal_slug where subject = p_subject and meal_slug is null;
  end if;
  select count(*) into v_rounds from public.recipe_review where subject = p_subject and status = 'done';
  return jsonb_build_object('status', 'closed', 'review_id', v_id, 'subject', p_subject, 'meal_slug', p_meal_slug,
                            'completed_rounds_on_record', v_rounds,
                            'open_disagreements', p_open_disagreements is not null and length(trim(p_open_disagreements)) > 0);
end;
$function$;

create or replace function public.kitchen_review_log_fallback(
  p_subject text,
  p_round integer,
  p_draft text,
  p_critique text,
  p_decision_log text default null,
  p_meal_slug text default null,
  p_reason text default null
) returns jsonb
language plpgsql
set search_path to 'public'
as $function$
declare
  v_id uuid; v_verdict text;
begin
  if coalesce(length(trim(p_critique)), 0) < 20 then
    raise exception 'critique is empty';
  end if;
  v_verdict := case
    when p_critique ~* 'VERDICT:\s*NO MATERIAL ISSUES' then 'no_material_issues'
    when p_critique ~* 'VERDICT:\s*MATERIAL ISSUES' then 'material_issues'
    else 'unclear' end;
  insert into public.recipe_review (subject, round, draft_md, decision_log_md, model, status, critique_md, verdict,
                                    error_detail, completed_at, meal_slug, reviewer)
  values (p_subject, p_round, p_draft, p_decision_log, 'claude (fallback critic)', 'done', p_critique, v_verdict,
          'fallback: ' || coalesce(p_reason, 'not stated'), now(), p_meal_slug, 'claude-critic')
  returning id into v_id;
  return jsonb_build_object('status', 'logged', 'review_id', v_id, 'round', p_round, 'verdict', v_verdict);
end;
$function$;

revoke all on function public.kitchen_review_request(text, integer, text, text, boolean, text, boolean) from public, anon, authenticated;
revoke all on function public.kitchen_review_result(uuid) from public, anon, authenticated;
revoke all on function public.kitchen_review_close(text, text, text, text) from public, anon, authenticated;
revoke all on function public.kitchen_review_log_fallback(text, integer, text, text, text, text, text) from public, anon, authenticated;
grant execute on function public.kitchen_review_request(text, integer, text, text, boolean, text, boolean) to service_role;
grant execute on function public.kitchen_review_result(uuid) to service_role;
grant execute on function public.kitchen_review_close(text, text, text, text) to service_role;
grant execute on function public.kitchen_review_log_fallback(text, integer, text, text, text, text, text) to service_role;

-- backfill: link existing rounds to their saved records
update public.recipe_review set meal_slug = 'dry-aged-wagyu-bone-in-sirloin-binchotan' where subject = 'Reverse-Seared Dry-Aged Wagyu Bone-In Sirloin, Binchotan Finish' and meal_slug is null;
update public.recipe_review set meal_slug = 'lukas-birthday-roast-chicken-sunday' where subject = 'Birthday Roast Chicken Menu — 11 Oct 2026' and meal_slug is null;
update public.recipe_review set meal_slug = 'short-ribs-dinner' where subject like 'Red Wine Braised Short Ribs Dinner%' and meal_slug is null;
update public.recipe_review set meal_slug = 'white-bean-turkey-soup-supper' where subject = 'Lemony White Bean Soup Supper' and meal_slug is null;
update public.recipe_review set meal_slug = 'jongny-christmas-eve-dinner' where subject = 'Christmas Eve Rib-Eye Roast Dinner (Jongny, 24 Dec 2026)' and meal_slug is null;
update public.recipe_review set meal_slug = 'jongny-christmas-day-raclette-dinner' where subject = 'Christmas Day Raclette Dinner (Jongny, 25 Dec 2026)' and meal_slug is null;
update public.recipe_review set meal_slug = 'mb5-ribeye-binchotan-dinner' where subject = 'Binchotan MB5+ Ribeye Dinner (Western)' and meal_slug is null;
update public.recipe_review set meal_slug = 'slow-cooked-bolognese-pappardelle' where subject = 'Slow-Cooked Bolognese with Pappardelle (Household Batch)' and meal_slug is null;
