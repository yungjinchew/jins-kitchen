// stage 2 (ASK 1.1): proposals, the Apply / Send for review split, and the card actions, against an in-memory database
import { T, RPC } from "./mock-supabase.ts";

const env: Record<string, string> = { SUPABASE_URL: "http://db", SUPABASE_SECRET_KEYS: '{"default":"sb_secret_x"}', ANTHROPIC_API_KEY: "sk-test" };
let handler: (r: Request) => Promise<Response>;
(globalThis as any).Deno = { env: { get: (k: string) => env[k] }, serve: (h: any) => { handler = h; } };

T.kitchen_config.push(
  { key: "governance_base", value: "https://gh/gov/" }, { key: "cellar_url", value: "https://gh/cellar.md" },
  { key: "assistant_model", value: "claude-opus-5-5" }, { key: "assistant_daily_limit", value: "60" }, { key: "assistant_monthly_usd", value: "15" },
  { key: "assistant_max_tokens", value: "6000" }, { key: "assistant_prices", value: "{}" },
);
const METHOD = "## Method\n\n1. **Poach the fish in 500 ml milk at 75°C / 167°F for 8 min.** Lift out.\n2. **Bake at 200°C / 390°F for 30 min** until the centre reads 75°C / 167°F.\n3. **Rest 10 min.** Serve.\n";
T.meal.push({ id: "m1", slug: "fish-pie-sunday", name: "Fish Pie Sunday", service_time: "18:00:00", pax: 3, workflow_md: "## Timeline\n\n- T-60 oven on\n- T-40 pie in", shared_prep_md: null, shopping_notes: null, updated_at: "2026-11-02T00:00:00.000001+00:00" });
T.dish.push({ id: "d1", slug: "fish-pie", name: "Fish Pie (Smoked Haddock)", summary: "A fish pie.", servings: 3, equipment: ["Oven"], nutrition_estimate: null, method_md: METHOD, updated_at: "2026-11-02T00:00:00.000002+00:00" },
  { id: "d9", slug: "other-dish", name: "Other", summary: null, servings: 2, equipment: null, nutrition_estimate: null, method_md: "x", updated_at: "2026-11-01T00:00:00+00:00" });
const ing = (o: any, name: string, i: number) => ({ id: "di" + i, dish_id: "d1", sort_order: i, qty: null, unit: null, qty_alt: null, buy_spec: null, buy_avoid: null, buy_note: null, prep_note: null, pantry_check: false, optional: false, section: null, ...o, ingredient: { name } });
T.dish_ingredient.push(ing({ qty: 400, unit: "g" }, "smoked haddock", 1), ing({ qty: 500, unit: "ml", qty_alt: "2 cups" }, "whole milk", 2), ing({ qty: 60, unit: "g" }, "unsalted butter", 3));
T.ingredient.push({ name: "smoked haddock" }, { name: "whole milk" }, { name: "unsalted butter" }, { name: "flat-leaf parsley" });
RPC.kitchen_meal_context = ({ p_slug }) => p_slug === "fish-pie-sunday" ? { kind: "meal", meal: { slug: p_slug, name: "Fish Pie Sunday" }, dishes: [{ slug: "fish-pie", name: "Fish Pie", method_md: METHOD, ingredients: [] }] }
  : p_slug === "fish-pie" ? { kind: "dish", dish: { slug: "fish-pie", method_md: METHOD, ingredients: [] } } : { kind: "none" };
RPC.kitchen_assistant_usage = () => ({ questions_24h: 0, month_usd: 0 });
const applyCalls: any[] = [];
let checkAnswer: any = { status: "ok" };
RPC.kitchen_assistant_change_apply = ({ p_change, p_mode }) => {
  applyCalls.push({ p_change, p_mode });
  const c = T.assistant_change.find((x) => x.id === p_change);
  if (p_mode === "check") return checkAnswer;
  if (p_mode === "apply") { if (c.class !== "minor") return { status: "needs_review" }; c.status = "applied"; return { status: "applied" }; }
  c.status = "undone"; return { status: "undone" };
};

const calls: any[] = [];
const sse = (evs: any[]) => new Response(new ReadableStream({ start(c) { c.enqueue(new TextEncoder().encode(evs.map((x) => `event: ${x.type}\ndata: ${JSON.stringify(x)}\n\n`).join(""))); c.close(); } }), { status: 200 });
const toolTurn = (input: any, id = "toolu_1") => () => sse([
  { type: "message_start", message: { usage: { input_tokens: 10, output_tokens: 1 } } },
  { type: "content_block_start", index: 0, content_block: { type: "tool_use", id, name: "propose_change", input: {} } },
  { type: "content_block_delta", index: 0, delta: { type: "input_json_delta", partial_json: JSON.stringify(input) } },
  { type: "content_block_stop", index: 0 },
  { type: "message_delta", delta: { stop_reason: "tool_use" }, usage: { output_tokens: 50 } }]);
const textTurn = (t: string) => () => sse([
  { type: "message_start", message: { usage: { input_tokens: 10, output_tokens: 1 } } },
  { type: "content_block_start", index: 0, content_block: { type: "text", text: "" } },
  { type: "content_block_delta", index: 0, delta: { type: "text_delta", text: t } },
  { type: "content_block_stop", index: 0 },
  { type: "message_delta", delta: { stop_reason: "end_turn" }, usage: { output_tokens: 20 } }]);
let script: (() => Response)[] = [];
globalThis.fetch = (async (url: any, init: any) => {
  const u = String(url);
  if (u.startsWith("https://gh/gov/manifest.json")) return new Response(JSON.stringify({ framework_version: "3.16", files: [{ id: "core", file: "core.md", always: true }, { id: "wine_pairing", file: "wine.md", load_when: "Wine" }] }));
  if (u.startsWith("https://gh/gov/core.md")) return new Response("CORE");
  if (u === "https://api.anthropic.com/v1/messages") { calls.push(JSON.parse(init.body)); return script.shift()!(); }
  throw new Error("unexpected fetch " + u);
}) as any;

await import("./index.ts");
const KEY = "cd".repeat(32);
const call = (body: any) => handler(new Request("http://fn/", { method: "POST", headers: { "content-type": "application/json", origin: "https://jins-kitchen.netlify.app", "x-device-key": KEY }, body: JSON.stringify(body) }));
const J = async (r: Response) => ({ http: r.status, ...(await r.json()) });
const readSse = async (r: Response) => (await r.text()).split("\n\n").filter(Boolean).map((l) => JSON.parse(l.replace(/^data: /, "")));
let fails = 0;
const ok = (name: string, cond: any, detail?: any) => { if (!cond) fails++; console.log((cond ? "PASS " : "FAIL ") + name + (cond ? "" : "  -> " + JSON.stringify(detail))); };
await call({ action: "pair" }); T.assistant_device[0].status = "approved";

// --- the record the model sees carries numbered ingredient lines
script = [textTurn("ok")];
await readSse(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "hello" }));
const recText = calls[0].system[1].text;
ok("record has numbered ingredient lines, shopping notes and nutrition", /"line":2,"name":"whole milk","qty":500,"unit":"ml","qty_alt":"2 cups"/.test(recText) && /"shopping_notes":null/.test(recText) && /"nutrition_estimate":null/.test(recText), recText.slice(0, 400));
ok("propose_change is offered as the 4th tool", calls[0].tools.length === 4 && calls[0].tools[3].name === "propose_change");

// --- a minor change: a shopping note and a buying note
script = [toolTurn({ summary: "Note to buy the haddock on Saturday and to choose undyed fillets.", class: "minor", class_reason: "Buying notes only.",
  dishes: [{ slug: "fish-pie", ingredient_changes: [{ op: "update", line: 1, name: "smoked haddock", set: { buy_spec: "undyed, skinless" } }] }],
  meal: { text_edits: [{ field: "shopping_notes", append: "Buy the haddock on Saturday morning." }] } }), textTurn("The card adds two buying notes. Tap Apply to save them.")];
let ev = await readSse(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "Add a note to buy undyed haddock on Saturday" }));
const ce = ev.find((e) => e.t === "change");
const c1 = T.assistant_change[0];
ok("minor proposal: a change event with the card", ce && ce.change.class === "minor" && ce.change.status === "proposed" && ce.change.display.length === 2 && !("saves" in ce.change), ce);
ok("card shows before and after in plain words", c1.display[0].where === "Fish Pie · Ingredients" && c1.display[0].was === "400 · g · smoked haddock".replace(/ · /g, " ") && /buy: undyed, skinless/.test(c1.display[0].now) && c1.display[1].where === "Meal · Before you shop" && c1.display[1].now === "Buy the haddock on Saturday morning.", c1.display);
ok("save payloads: full ingredient list and the note; undo holds the old values", c1.saves.length === 2 && c1.saves[0].entity === "dish" && c1.saves[0].p.ingredients.length === 3 && c1.saves[0].p.ingredients[0].buy_spec === "undyed, skinless" && c1.saves[0].p.ingredients[1].qty === 500 && c1.undo[0].p.ingredients[0].buy_spec === null && c1.saves[1].p.shopping_notes === "Buy the haddock on Saturday morning." && c1.undo[1].p.shopping_notes === null, c1.saves);
ok("guards carry each record's updated_at", c1.guards.length === 2 && c1.guards[0].updated_at === "2026-11-02T00:00:00.000002+00:00" && c1.guards[1].entity === "meal");
ok("dry run was made, nothing applied", applyCalls.length === 1 && applyCalls[0].p_mode === "check" && c1.status === "proposed");
ok("tool result tells the model it is not saved", /NOT saved until he taps Apply/.test(calls.at(-1).messages.at(-1).content[0].content));
ok("card is linked to the answer", c1.message_id && c1.message_id === T.assistant_message.at(-1).id);

// --- a wrong edit is sent back to the model, which fixes it; a moved number makes it material
script = [toolTurn({ summary: "Bake 40 min instead of 30 for a pie baked from cold.", class: "minor", class_reason: "Timing tweak.",
  dishes: [{ slug: "fish-pie", text_edits: [{ field: "method_md", find: "Bake at 200C for 30 min", replace: "Bake at 200°C / 390°F for 40 min" }] }] }),
  toolTurn({ summary: "Bake 40 min instead of 30 for a pie baked from cold.", class: "minor", class_reason: "Timing tweak.",
    dishes: [{ slug: "fish-pie", text_edits: [{ field: "method_md", find: "**Bake at 200°C / 390°F for 30 min**", replace: "**Bake at 200°C / 390°F for 40 min**" }] }],
    meal: { text_edits: [{ field: "workflow_md", find: "- T-40 pie in", replace: "- T-50 pie in" }] } }, "toolu_2"),
  textTurn("This moves the bake to 40 min, so it goes for review.")];
ev = await readSse(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "Make the bake 40 min" }));
const retry = calls.at(-2).messages.at(-1).content[0];
ok("bad find comes back as a tool error naming the problem", retry.is_error === true && /not in the record/.test(retry.content) && T.assistant_change.length === 2, retry);
const c2 = T.assistant_change[1];
ok("a moved number is material whatever the model said", c2.class === "material" && /Marked for review by the app: a number changes in the method of Fish Pie; a number changes in the workflow/.test(c2.class_reason), c2.class_reason);
ok("method text is edited in place, nothing else lost", c2.saves[0].p.method_md === METHOD.replace("for 30 min", "for 40 min") && c2.undo[0].p.method_md === METHOD);
ok("the earlier open card is replaced", c1.status === "discarded" && /newer proposal/.test(c1.note));
ok("material tool result names the review route", /MATERIAL/.test(calls.at(-1).messages.at(-1).content[0].content) && /Review with GPT/.test(calls.at(-1).messages.at(-1).content[0].content));
ok("only one change event for the accepted proposal", ev.filter((e) => e.t === "change").length === 1 && ev.find((e) => e.t === "change").change.id === c2.id);

// --- guards on what a page may touch, and on the ingredient list
const tryOne = async (input: any, kind = "meal", slug = "fish-pie-sunday") => { script = [toolTurn(input), textTurn("x")]; const n = T.assistant_change.length; await readSse(await call({ action: "ask", kind, slug, message: "q" })); return { made: T.assistant_change.length - n, res: calls.at(-1).messages.at(-1).content[0] }; };
let t = await tryOne({ summary: "Touch another dish entirely.", class: "minor", class_reason: "x", dishes: [{ slug: "other-dish", text_edits: [{ field: "method_md", find: "x", replace: "y" }] }] });
ok("a dish that is not on the page is refused", t.made === 0 && /not on this page/.test(t.res.content), t.res);
t = await tryOne({ summary: "Change the workflow from a dish page.", class: "minor", class_reason: "x", meal: { text_edits: [{ field: "workflow_md", find: "- T-60 oven on", replace: "- T-70 oven on" }] } }, "dish", "fish-pie");
ok("a dish page cannot change the meal", t.made === 0 && /This is a dish page/.test(t.res.content), t.res);
t = await tryOne({ summary: "Wrong line number for the butter.", class: "minor", class_reason: "x", dishes: [{ slug: "fish-pie", ingredient_changes: [{ op: "update", line: 2, name: "unsalted butter", set: { qty: 80 } }] }] });
ok("line and name must agree", t.made === 0 && /line 2 of fish-pie is "whole milk"/.test(t.res.content), t.res);
t = await tryOne({ summary: "Add an ingredient the kitchen does not know.", class: "material", class_reason: "x", dishes: [{ slug: "fish-pie", ingredient_changes: [{ op: "add", line: 3, item: { name: "parsley", qty: 10, unit: "g" } }] }] });
ok("unknown ingredient names are refused with close matches", t.made === 0 && /not an ingredient name/.test(t.res.content) && /flat-leaf parsley/.test(t.res.content), t.res);
t = await tryOne({ summary: "Rename the dish through set.", class: "minor", class_reason: "x", dishes: [{ slug: "fish-pie", set: { name: "Pie" } }] });
ok("fields outside the allowed set are refused", t.made === 0 && /cannot be set on a dish here/.test(t.res.content), t.res);
t = await tryOne({ summary: "Scale the butter and add parsley, remove nothing.", class: "minor", class_reason: "x", dishes: [{ slug: "fish-pie", ingredient_changes: [{ op: "update", line: 3, name: "unsalted butter", set: { qty: "80" } }, { op: "add", line: 0, item: { name: "flat-leaf parsley", qty: 10, unit: "g", prep_note: "chopped" } }, { op: "remove", line: 2, name: "whole milk" }], set: { servings: 5 } }] });
const c3 = T.assistant_change.at(-1);
ok("add, update and remove build the right list, as material", t.made === 1 && c3.class === "material" && c3.saves[0].p.ingredients.map((x: any) => x.name).join() === "flat-leaf parsley,smoked haddock,unsalted butter" && c3.saves[0].p.ingredients[2].qty === 80 && c3.saves[0].p.servings === 5 && c3.undo[0].p.servings === 3 && c3.undo[0].p.ingredients.length === 3, c3.saves[0].p);
checkAnswer = { status: "error", message: "kitchen_save_dish: unit(s) {blob} not allowed" };
t = await tryOne({ summary: "A proposal the save functions reject.", class: "minor", class_reason: "x", meal: { text_edits: [{ field: "shopping_notes", append: "Check the tin size." }] } });
ok("a failed dry run is marked failed and sent back", T.assistant_change.at(-1).status === "failed" && /failed the save check/.test(t.res.content), t.res);
checkAnswer = { status: "ok" };

// --- the card actions
t = await tryOne({ summary: "Add a shopping note about the tin.", class: "minor", class_reason: "A note.", meal: { text_edits: [{ field: "shopping_notes", append: "Check the tin size." }] } });
const minor = T.assistant_change.at(-1);
let r = await J(await call({ action: "change", change_id: minor.id, op: "apply" }));
ok("Apply on a minor card", r.status === "applied" && r.change.status === "applied" && applyCalls.at(-1).p_mode === "apply", r);
r = await J(await call({ action: "change", change_id: minor.id, op: "undo" }));
ok("Undo", r.status === "undone" && r.change.status === "undone", r);
r = await J(await call({ action: "change", change_id: c3.id, op: "apply" }));
ok("a superseded card cannot be applied", r.status !== "applied", r);
t = await tryOne({ summary: "Bake at 210°C instead of 200°C.", class: "material", class_reason: "Oven temperature changes.", dishes: [{ slug: "fish-pie", text_edits: [{ field: "method_md", find: "**Bake at 200°C / 390°F for 30 min**", replace: "**Bake at 210°C / 410°F for 30 min**" }] }] });
const mat = T.assistant_change.at(-1);
r = await J(await call({ action: "change", change_id: mat.id, op: "apply" }));
ok("Apply on a material card is refused", r.status === "needs_review" && mat.status === "proposed", r);
r = await J(await call({ action: "change", change_id: mat.id, op: "file" }));
const k = T.kitchen_comment.at(-1);
ok("Send for review files a queue comment and marks the card", r.status === "filed" && mat.status === "filed" && k && k.meal_id === "m1" && k.surface === "app-ask" && k.category === "suggestion" && k.comment.includes(mat.id) && /kitchen_assistant_change_close/.test(k.comment) && k.comment_hash.length === 64 && k.comment.length <= 2000, k);
r = await J(await call({ action: "change", change_id: mat.id, op: "file" }));
ok("filing twice does nothing more", r.status === "not_open" && T.kitchen_comment.length === 1, r);
r = await J(await call({ action: "change", change_id: "nope", op: "apply" }));
ok("bad change id", r.http === 400, r);
r = await J(await call({ action: "open", kind: "meal", slug: "fish-pie-sunday" }));
ok("open returns the cards with their messages, without failed ones or payloads", r.changes.length >= 4 && r.changes.every((c: any) => c.status !== "failed" && !("saves" in c)) && r.changes.some((c: any) => c.id === mat.id && c.status === "filed" && r.messages.some((m: any) => m.id === c.message_id)), r.changes.map((c: any) => c.status));
script = [textTurn("ok")];
await readSse(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "what happened to my change?" }));
ok("the model is told what became of each card", /\[App note: a material change card was shown to Jin: "Bake at 210°C instead of 200°C\.". Its status now: filed\.\]/.test(JSON.stringify(calls.at(-1).messages).replace(/\\"/g, '"')), 0);
console.log(fails ? `\n${fails} FAILED` : "\nall passed");
process.exit(fails ? 1 : 0);
