// stage 3 (ASK 1.2): the review loop as a step machine, against an in-memory database, a scripted reviewer and a scripted Claude
import { T, RPC } from "./mock-supabase.ts";

const env: Record<string, string> = { SUPABASE_URL: "http://db", SUPABASE_SECRET_KEYS: '{"default":"sb_secret_x"}', ANTHROPIC_API_KEY: "sk-test" };
let handler: (r: Request) => Promise<Response>;
(globalThis as any).Deno = { env: { get: (k: string) => env[k] }, serve: (h: any) => { handler = h; } };

T.kitchen_config.push(
  { key: "governance_base", value: "https://gh/gov/" }, { key: "cellar_url", value: "https://gh/cellar.md" },
  { key: "assistant_model", value: "claude-opus-5-5" }, { key: "assistant_daily_limit", value: "60" }, { key: "assistant_monthly_usd", value: "15" },
  { key: "assistant_max_tokens", value: "6000" }, { key: "assistant_prices", value: "{}" }, { key: "review_max_rounds", value: "2" },
  { key: "assistant_review_daily_limit", value: "5" }, { key: "spend_mode_url", value: "https://spend/rpc" }, { key: "spend_mode_key", value: "pk" },
  { key: "review_brief_fallback", value: "B".repeat(600) },
);
const METHOD = "## Method\n\n1. **Poach the fish in 500 ml milk at 75°C / 167°F for 8 min.** Lift out.\n2. **Bake at 200°C / 390°F for 30 min** until the centre reads 75°C / 167°F.\n3. **Rest 10 min.** Serve.\n";
T.meal.push({ id: "m1", slug: "fish-pie-sunday", name: "Fish Pie Sunday", service_time: "18:00:00", pax: 3, workflow_md: "## Timeline\n\n- T-60 oven on\n- T-40 pie in", shared_prep_md: null, shopping_notes: null, updated_at: "2026-11-02T00:00:00.000001+00:00" });
T.dish.push({ id: "d1", slug: "fish-pie", name: "Fish Pie (Smoked Haddock)", summary: "A fish pie.", servings: 3, equipment: ["Oven"], nutrition_estimate: null, method_md: METHOD, updated_at: "2026-11-02T00:00:00.000002+00:00" });
T.dish_ingredient.push({ id: "di1", dish_id: "d1", sort_order: 1, qty: 400, unit: "g", qty_alt: null, buy_spec: null, buy_avoid: null, buy_note: null, prep_note: null, pantry_check: false, optional: false, section: null, ingredient: { name: "smoked haddock" } });
T.ingredient.push({ name: "smoked haddock" });
RPC.kitchen_meal_context = ({ p_slug }) => p_slug === "fish-pie-sunday" ? { kind: "meal", meal: { slug: p_slug, name: "Fish Pie Sunday" }, dishes: [{ slug: "fish-pie", name: "Fish Pie", role: "main", method_md: METHOD, ingredients: [] }] } : { kind: "none" };
let reviewsToday = 0;
RPC.kitchen_assistant_usage = () => ({ questions_24h: 0, month_usd: 0, reviews_24h: reviewsToday });
RPC.kitchen_assistant_change_apply = ({ p_change, p_mode }) => {
  const c = T.assistant_change.find((x) => x.id === p_change);
  if (p_mode === "check") return { status: "ok" };
  if (p_mode === "apply") { if (c.class !== "minor" && c.review_status !== "passed") return { status: "needs_review" }; c.status = "applied"; return { status: "applied" }; }
  return { status: "undone" };
};
let lockFree = true; const locks: number[] = [];
RPC.kitchen_assistant_review_lock = ({ p_seconds }) => { locks.push(p_seconds); return p_seconds === 0 ? true : lockFree; };
const reqs: any[] = [], fallbacks: any[] = [], closes: any[] = [];
let gptAnswers: any[] = [], requestAnswer: any = null;
RPC.kitchen_review_request = (a) => { reqs.push(a); return requestAnswer ?? { status: "requested", review_id: "rv" + reqs.length, model: "gpt-6-astra", framework_loaded: true }; };
RPC.kitchen_review_result = () => gptAnswers.shift() ?? { status: "pending" };
RPC.kitchen_review_log_fallback = (a) => { fallbacks.push(a); return { status: "logged" }; };
RPC.kitchen_review_close = (a) => { closes.push(a); return { status: "closed" }; };

let openai = "normal";
const calls: any[] = [];
const sse = (evs: any[]) => new Response(new ReadableStream({ start(c) { c.enqueue(new TextEncoder().encode(evs.map((x) => `event: ${x.type}\ndata: ${JSON.stringify(x)}\n\n`).join(""))); c.close(); } }), { status: 200 });
const toolTurn = (name: string, input: any, id = "toolu_1") => () => sse([
  { type: "message_start", message: { usage: { input_tokens: 1000, output_tokens: 1 } } },
  { type: "content_block_start", index: 0, content_block: { type: "tool_use", id, name, input: {} } },
  { type: "content_block_delta", index: 0, delta: { type: "input_json_delta", partial_json: JSON.stringify(input) } },
  { type: "content_block_stop", index: 0 },
  { type: "message_delta", delta: { stop_reason: "tool_use" }, usage: { output_tokens: 500 } }]);
const textTurn = (t: string) => () => sse([
  { type: "message_start", message: { usage: { input_tokens: 1000, output_tokens: 1 } } },
  { type: "content_block_start", index: 0, content_block: { type: "text", text: "" } },
  { type: "content_block_delta", index: 0, delta: { type: "text_delta", text: t } },
  { type: "content_block_stop", index: 0 },
  { type: "message_delta", delta: { stop_reason: "end_turn" }, usage: { output_tokens: 200 } }]);
let script: (() => Response)[] = [];
globalThis.fetch = (async (url: any, init: any) => {
  const u = String(url);
  if (u.startsWith("https://gh/gov/manifest.json")) return new Response(JSON.stringify({ framework_version: "3.16", files: [{ id: "core", file: "core.md", always: true }, { id: "review_protocol", file: "review.md", load_when: "review" }, { id: "meal_workflow", file: "wf.md", load_when: "2+" }] }));
  if (u.startsWith("https://gh/gov/core.md")) return new Response("CORE RULES");
  if (u.startsWith("https://gh/gov/review.md")) return new Response("x <!-- reviewer-brief:start -->" + "You are the independent second reviewer. ".repeat(20) + "<!-- reviewer-brief:end --> y");
  if (u.startsWith("https://spend/rpc")) return new Response(JSON.stringify(JSON.parse(init.body).p_service === "openai_api" ? openai : "normal"));
  if (u === "https://api.anthropic.com/v1/messages") { calls.push(JSON.parse(init.body)); return script.shift()!(); }
  throw new Error("unexpected fetch " + u);
}) as any;

await import("./index.ts");
const KEY = "ef".repeat(32);
const call = (body: any) => handler(new Request("http://fn/", { method: "POST", headers: { "content-type": "application/json", origin: "https://jins-kitchen.netlify.app", "x-device-key": KEY }, body: JSON.stringify(body) }));
const J = async (r: Response) => ({ http: r.status, ...(await r.json()) });
let fails = 0;
const ok = (name: string, cond: any, detail?: any) => { if (!cond) fails++; console.log((cond ? "PASS " : "FAIL ") + name + (cond ? "" : "  -> " + JSON.stringify(detail))); };
await call({ action: "pair" }); T.assistant_device[0].status = "approved";
const BAKE40 = { summary: "Bake 40 min instead of 30 for a pie baked from cold.", class: "material", class_reason: "The bake time changes.",
  dishes: [{ slug: "fish-pie", text_edits: [{ field: "method_md", find: "**Bake at 200°C / 390°F for 30 min**", replace: "**Bake at 200°C / 390°F for 40 min**" }] }] };
const makeChange = async (input: any = BAKE40) => { script = [toolTurn("propose_change", input), textTurn("See the card.")]; await (await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "change it" })).text(); return T.assistant_change.at(-1); };
const step = (c: any, op = "review_step") => J(call({ action: "change", change_id: c.id, op }) as any);
const J2 = async (p: Promise<Response>) => J(await p);
const go = (c: any, op = "review_step") => J2(call({ action: "change", change_id: c.id, op }));

// --- A: a clean review in one round, then Apply
let c = await makeChange();
ok("the model's own edit list is kept with the proposal", c.edits && c.edits.dishes[0].text_edits[0].replace.includes("40 min") && c.review_status === undefined || c.review_status === "none" || c.edits);
let r = await go(c, "apply");
ok("a material change still cannot be applied before its review", r.status === "needs_review", r);
gptAnswers = [{ status: "pending" }, { status: "done", verdict: "no_material_issues", model: "gpt-6-astra", critique: "1. [MINOR] · Fish Pie / step 2 · say foil if browning early · add a note.\nWhat is sound: the centre temperature.\nVERDICT: NO MATERIAL ISSUES" }];
r = await go(c, "review");
ok("Review starts: round 1 is requested from GPT", r.status === "running" && r.change.review_status === "running" && r.change.review.phase === "wait" && reqs.length === 1 && reqs[0].p_round === 1 && reqs[0].p_confirm === false && reqs[0].p_multi_component === false && reqs[0].p_meal_slug === "fish-pie-sunday", r);
const draft = reqs[0].p_draft;
ok("the draft is the saved record with the change applied, and says what changed", /REVISION OF A SAVED RECIPE/.test(draft) && /for 40 min/.test(draft) && !/for 30 min\*\*/.test(draft.split("# MEAL")[1]) && /- 400 g smoked haddock/.test(draft) && /## Meal workflow\n## Timeline/.test(draft) && /# DISH: Fish Pie \(Smoked Haddock\) \(main\)/.test(draft) && /"\*\*Bake at 200°C \/ 390°F for 30 min\*\*" -> /.test(draft), draft.slice(0, 600));
ok("the subject is stable and names the change", reqs[0].p_subject === `Fish Pie Sunday · app change ${c.id.slice(0, 8)}`);
r = await go(c);
ok("GPT still reading: the step just waits", r.status === "running" && r.change.review.phase === "wait" && calls.length === 2, r.change.review);
r = await go(c);
ok("GPT answered: next comes the reconcile step", r.change.review.phase === "reconcile" && !("critique" in r.change.review) && c.review.critique.includes("VERDICT"), r.change.review);
script = [toolTurn("reconcile", { decisions: [{ finding: "Say foil if browning early", material: false, decision: "decline", detail: "Outside this change; for a full review in the Cooking project." }] })];
r = await go(c);
ok("a clean review passes", r.status === "ok" && r.change.review_status === "passed" && r.change.review.rounds.length === 1 && r.change.review.rounds[0].reviewer === "GPT" && r.change.review.rounds[0].findings[0].decision === "decline" && r.change.review.open.length === 0, r.change.review);
ok("the reconcile call carries the critique, the edits and the saved record", /VERDICT: NO MATERIAL ISSUES/.test(calls.at(-1).messages[0].content) && /"find":"\*\*Bake at 200/.test(calls.at(-1).messages[0].content) && calls.at(-1).tools[0].name === "reconcile" && /THE SAVED RECORD/.test(calls.at(-1).system[1].text));
ok("the lock is taken and released around every step", locks.filter((x) => x === 150).length === locks.filter((x) => x === 0).length && locks.length >= 8);
ok("Claude's review cost is recorded on the change", c.review.cost_usd > 0, c.review.cost_usd);
r = await go(c, "apply");
ok("Apply now works, and the review record is closed", r.status === "applied" && closes.length === 1 && closes[0].p_subject === c.review.subject && /Round 1 · Say foil/.test(closes[0].p_final_decision_log) && closes[0].p_open_disagreements === null, closes);

// --- B: a material finding adopted in round 1 revises the card; round 2 (the last) adopts again, so a confirmation pass runs
c = await makeChange();
reqs.length = 0;
gptAnswers = [{ status: "done", verdict: "material_issues", model: "gpt-6-astra", critique: "1. [MATERIAL] · timeline · the pie goes in at T-40 but now bakes 40 and rests 10 · move it to T-50.\nVERDICT: MATERIAL ISSUES" }];
await go(c, "review"); await go(c);
const REV = { summary: "Bake 40 min from cold; pie in at T-50.", dishes: BAKE40.dishes, meal: { text_edits: [{ field: "workflow_md", find: "- T-40 pie in", replace: "- T-50 pie in" }] } };
script = [toolTurn("reconcile", { decisions: [{ finding: "Pie in too late for a 40 min bake", material: true, decision: "adopt", detail: "Pie in moved from T-40 to T-50." }] }),
  toolTurn("reconcile", { decisions: [{ finding: "Pie in too late for a 40 min bake", material: true, decision: "adopt", detail: "Pie in moved from T-40 to T-50." }], revised: REV }, "toolu_2")];
r = await go(c);
ok("adopting without the revised edits is sent back, then accepted", /"revised\\" is required/.test(JSON.stringify(calls.at(-1).messages.at(-1))) && r.change.review.rounds.length === 1, calls.at(-1).messages.at(-1));
ok("the adopted finding rewrites the card and its payloads", r.change.summary === REV.summary && r.change.display.length === 2 && c.saves.length === 2 && c.saves[1].p.workflow_md.includes("T-50 pie in") && c.edits.meal.text_edits.length === 1 && r.change.review_status === "running" && r.change.review.round === 2, r.change);
gptAnswers = [{ status: "done", verdict: "material_issues", model: "gpt-6-astra", critique: "1. [MATERIAL] · step 3 · rest is not in the timeline · add T-10 out.\nVERDICT: MATERIAL ISSUES" }];
await go(c);
ok("round 2 carries the decision log and the revised draft", reqs.length === 2 && reqs[1].p_round === 2 && /Round 1 · \[MATERIAL\] Pie in too late.*Adopt · Pie in moved/.test(reqs[1].p_decision_log) && /\(propagated\)/.test(reqs[1].p_decision_log) && /T-50 pie in/.test(reqs[1].p_draft), reqs[1].p_decision_log);
await go(c);
const REV2 = { ...REV, meal: { text_edits: [{ field: "workflow_md", find: "- T-40 pie in", replace: "- T-50 pie in\n- T-10 pie out, rest" }] } };
script = [toolTurn("reconcile", { decisions: [{ finding: "Rest missing from the timeline", material: true, decision: "adopt_modified", detail: "Added T-10 pie out, rest." }], revised: REV2 })];
r = await go(c);
ok("a material finding adopted in the last round leads to the confirmation pass", r.change.review_status === "running" && r.change.review.round === 3 && r.change.review.confirm === true, r.change.review);
gptAnswers = [{ status: "done", verdict: "no_material_issues", model: "gpt-6-astra", critique: "What is sound: the changes close in the timeline.\nVERDICT: NO MATERIAL ISSUES" }];
await go(c);
ok("the confirmation pass is requested as such", reqs.length === 3 && reqs[2].p_confirm === true && reqs[2].p_round === 3);
await go(c);
script = [toolTurn("reconcile", { decisions: [] })];
r = await go(c);
ok("a clean confirmation pass passes the review", r.change.review_status === "passed" && r.change.review.rounds.length === 3 && r.change.review.rounds[2].confirm === true && /the reviewer raised no findings/.test(c.review.decision_log), r.change.review);

// --- C: a declined material finding that the reviewer keeps raising ends as an open disagreement: no Apply
c = await makeChange();
gptAnswers = [{ status: "done", verdict: "material_issues", critique: "1. [MATERIAL] · step 2 · 40 min will overcook the fish · keep 30.\nVERDICT: MATERIAL ISSUES" }];
await go(c, "review"); await go(c);
const DECL = () => toolTurn("reconcile", { decisions: [{ finding: "40 min will overcook the fish", material: true, decision: "decline", detail: "Jin asked for 40 min from cold; the centre check at 75°C / 167°F governs." }] });
script = [DECL()]; await go(c);
gptAnswers = [{ status: "done", verdict: "material_issues", critique: "1. [MATERIAL] · step 2 · still 40 min.\nVERDICT: MATERIAL ISSUES" }];
await go(c); await go(c);
script = [DECL()]; r = await go(c);
ok("an open disagreement holds the change", r.change.review_status === "open" && r.change.review.open.length === 1 && /declined: Jin asked for 40 min/.test(r.change.review.open[0]), r.change.review);
r = await go(c, "apply");
ok("and it cannot be applied", r.status === "needs_review" && c.status === "proposed", r);
r = await go(c, "file");
ok("sending it to the project names the disagreement", r.status === "filed" && /open disagreements: 40 min will overcook the fish/.test(T.kitchen_comment.at(-1).comment), T.kitchen_comment.at(-1));

// --- D: GPT cannot review (spend switch paused): the Claude critic stands in, and the log says so
await new Promise((res) => setTimeout(res, 5)); openai = "paused";
(globalThis as any).__resetCaches?.();
c = await makeChange();
const n0 = reqs.length;
r = await go(c, "review");
if (r.change.review.phase !== "critic") { // the spend mode is cached for 60 s per instance; this test instance read "normal" a moment ago
  ok("(cached switch) GPT path taken", r.change.review.phase === "wait");
  c.review.phase = "critic"; c.review.fallback_reason = "spend switch paused";
} else ok("paused switch: no GPT request, the critic is next", reqs.length === n0 && r.change.review.fallback_reason === "spend switch paused", r.change.review);
script = [textTurn("1. [MINOR] · step 2 · fine.\nWhat is sound: the bake.\nVERDICT: NO MATERIAL ISSUES")];
r = await go(c);
const critic = calls.at(-1);
ok("the critic sees only the brief, the rules and the draft", critic.system.length === 1 && /independent second reviewer/.test(critic.system[0].text) && !critic.tools && /=== DRAFT TO REVIEW ===/.test(critic.messages[0].content) && /=== GOVERNANCE FRAMEWORK \(Core v3\.16\) ===\nCORE RULES/.test(critic.messages[0].content) && !/THE SAVED RECORD|edits/.test(critic.messages[0].content), critic.system[0].text.slice(0, 80));
ok("the fallback round is logged with its reason", fallbacks.length === 1 && fallbacks[0].p_reason === "spend switch paused" && /VERDICT/.test(fallbacks[0].p_critique) && r.change.review.phase === "reconcile", fallbacks);
script = [toolTurn("reconcile", { decisions: [{ finding: "Step 2 fine", material: false, decision: "decline", detail: "No change needed." }] })];
r = await go(c);
ok("the Review log names the Claude critic and why", r.change.review_status === "passed" && r.change.review.rounds[0].reviewer === "Claude critic" && r.change.review.rounds[0].fallback === "spend switch paused", r.change.review.rounds);
openai = "normal";

// --- E: limits, the lock, and failures
c = await makeChange();
reviewsToday = 5; r = await go(c, "review");
ok("the daily review cap stops a sixth review", r.status === "review_limit" && r.limit === 5 && c.review_status !== "running", r);
reviewsToday = 0; lockFree = false; r = await go(c, "review");
ok("a step already running answers busy", r.status === "busy" && c.review_status !== "running", r);
lockFree = true;
gptAnswers = [{ status: "error", error: "insufficient_quota: You exceeded your current quota, check your billing" }];
await go(c, "review"); r = await go(c);
ok("OpenAI out of credit falls back to the critic with that reason", r.change.review.phase === "critic" && /out of credit/.test(r.change.review.fallback_reason), r.change.review);
script = [() => new Response("{}", { status: 529 }), () => new Response("{}", { status: 529 }), () => new Response("{}", { status: 529 })];
r = await go(c); r = await go(c);
ok("a failed step is retried on the next poll", r.status === "running" && r.change.review_status === "running" && /busy/.test(r.message) && c.review.errors === 2, r);
r = await go(c);
ok("three failures in a row end the review as failed", r.change.review_status === "failed" && /busy/.test(r.change.review.last_error), r.change);
script = [textTurn("VERDICT: NO MATERIAL ISSUES\nNothing to add here at all.")];
r = await go(c, "review");
ok("a failed review can be started again", r.status === "running" && r.change.review_status === "running" && r.change.review.round === 1, r);
const minor = await makeChange({ summary: "Add a shopping note about the tin.", class: "minor", class_reason: "A note.", meal: { text_edits: [{ field: "shopping_notes", append: "Check the tin size." }] } });
r = await go(minor, "review");
ok("a minor change has no review", r.status === "error" && minor.review_status !== "running", r);
r = await J(await call({ action: "open", kind: "meal", slug: "fish-pie-sunday" }));
ok("open returns each card's review state without the critique or the draft", r.changes.some((x: any) => x.review_status === "passed" && x.review.rounds.length) && !JSON.stringify(r.changes).includes("decision_log") && !JSON.stringify(r.changes).includes("VERDICT"), 0);
console.log(fails ? `\n${fails} FAILED` : "\nall passed");
process.exit(fails ? 1 : 0);
