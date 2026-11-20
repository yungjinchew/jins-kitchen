// stage 4 (ASK 1.3): which dishes are on a meal — swaps, new dishes, refusals, the review draft — against an in-memory database
import { T, RPC } from "./mock-supabase.ts";

const env: Record<string, string> = { SUPABASE_URL: "http://db", SUPABASE_SECRET_KEYS: '{"default":"sb_secret_x"}', ANTHROPIC_API_KEY: "sk-test" };
let handler: (r: Request) => Promise<Response>;
(globalThis as any).Deno = { env: { get: (k: string) => env[k] }, serve: (h: any) => { handler = h; } };

T.kitchen_config.push(
  { key: "governance_base", value: "https://gh/gov/" }, { key: "cellar_url", value: "https://gh/cellar.md" },
  { key: "assistant_model", value: "claude-opus-5-5" }, { key: "assistant_daily_limit", value: "60" }, { key: "assistant_monthly_usd", value: "15" },
  { key: "assistant_max_tokens", value: "6000" }, { key: "assistant_prices", value: "{}" }, { key: "review_max_rounds", value: "3" },
  { key: "assistant_review_daily_limit", value: "5" },
);
const PIE = "## Method\n\n1. **Bake the pie at 200°C / 390°F for 35 min** until the filling reads 74°C / 165°F.\n2. **Rest 10 min.** Serve.\n";
const CHOC = "## Method\n\n1. **Melt the chocolate over a water bath.** Dip the mandarin segments.\n2. **Chill 20 min.** Serve.\n";
T.meal.push(
  { id: "m1", slug: "pot-pie-sunday", name: "Chicken Pot Pie Sunday", service_time: "18:00:00", pax: 3, workflow_md: "## Timeline\n\n- T-60 oven on\n- T-35 pie in\n- T-20 dip the mandarins in chocolate", shared_prep_md: null, shopping_notes: "Buy 4 mandarins.", updated_at: "2026-11-19T00:00:00.000001+00:00" },
  { id: "m2", slug: "solo-supper", name: "Solo Supper", service_time: "18:00:00", pax: 3, workflow_md: null, shared_prep_md: null, shopping_notes: null, updated_at: "2026-11-19T00:00:00.000009+00:00" },
);
T.dish.push(
  { id: "d1", slug: "pot-pie-chicken-pie", name: "Chicken Pot Pie", summary: null, servings: 3, equipment: ["Oven"], nutrition_estimate: null, method_md: PIE, updated_at: "2026-11-19T00:00:00.000002+00:00" },
  { id: "d2", slug: "pot-pie-chocolate-mandarins", name: "Chocolate Mandarins", summary: null, servings: 3, equipment: null, nutrition_estimate: null, method_md: CHOC, updated_at: "2026-11-19T00:00:00.000003+00:00" },
  { id: "d3", slug: "yuzu-sorbet-berries", name: "Yuzu Sorbet with Berries", summary: null, servings: 3, equipment: null, nutrition_estimate: null, method_md: "1. **Scoop.**", updated_at: "2026-11-01T00:00:00+00:00" },
  { id: "d4", slug: "solo-soup", name: "Solo Soup", summary: null, servings: 3, equipment: null, nutrition_estimate: null, method_md: "1. **Heat.**", updated_at: "2026-11-01T00:00:00+00:00" },
);
T.ingredient.push({ name: "strawberry" }, { name: "fresh mint" }, { name: "dark chocolate" }, { name: "mandarin" });
const onMeal = (slug: string) => slug === "pot-pie-sunday"
  ? [{ slug: "pot-pie-chicken-pie", name: "Chicken Pot Pie", role: "main", service_order: 1, method_md: PIE, ingredients: [] },
     { slug: "pot-pie-chocolate-mandarins", name: "Chocolate Mandarins", role: "dessert", service_order: 2, method_md: CHOC, ingredients: [] }]
  : [{ slug: "solo-soup", name: "Solo Soup", role: "soup", service_order: 1, ingredients: [] }];
RPC.kitchen_meal_context = ({ p_slug }) => ["pot-pie-sunday", "solo-supper"].includes(p_slug) ? { kind: "meal", meal: { slug: p_slug, name: p_slug }, dishes: onMeal(p_slug) }
  : T.dish.find((d) => d.slug === p_slug) ? { kind: "dish", dish: { slug: p_slug, method_md: "x", ingredients: [] } } : { kind: "none" };
RPC.kitchen_assistant_usage = () => ({ questions_24h: 0, month_usd: 0, reviews_24h: 0 });
const applyCalls: any[] = [];
RPC.kitchen_assistant_change_apply = ({ p_change, p_mode }) => {
  applyCalls.push({ p_change, p_mode });
  const c = T.assistant_change.find((x) => x.id === p_change);
  if (p_mode === "check") return { status: "ok" };
  if (p_mode === "apply") { if (c.class !== "minor" && c.review_status !== "passed") return { status: "needs_review" }; c.status = "applied"; return { status: "applied" }; }
  c.status = "undone"; return { status: "undone" };
};
RPC.kitchen_assistant_review_lock = () => true;
const reqs: any[] = [];
RPC.kitchen_review_request = (a) => { reqs.push(a); return { status: "requested", review_id: "rv" + reqs.length, model: "gpt-6-astra", framework_loaded: true }; };

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
  if (u.startsWith("https://gh/gov/manifest.json")) return new Response(JSON.stringify({ framework_version: "3.16", files: [{ id: "core", file: "core.md", always: true }, { id: "meal_workflow", file: "wf.md", load_when: "2+" }] }));
  if (u.startsWith("https://gh/gov/core.md")) return new Response("CORE");
  if (u === "https://api.anthropic.com/v1/messages") { calls.push(JSON.parse(init.body)); return script.shift()!(); }
  throw new Error("unexpected fetch " + u);
}) as any;

await import("./index.ts");
const KEY = "ab".repeat(32);
const call = (body: any) => handler(new Request("http://fn/", { method: "POST", headers: { "content-type": "application/json", origin: "https://jins-kitchen.netlify.app", "x-device-key": KEY }, body: JSON.stringify(body) }));
const J = async (r: Response) => ({ http: r.status, ...(await r.json()) });
const readSse = async (r: Response) => (await r.text()).split("\n\n").filter(Boolean).map((l) => JSON.parse(l.replace(/^data: /, "")));
let fails = 0;
const ok = (name: string, cond: any, detail?: any) => { if (!cond) fails++; console.log((cond ? "PASS " : "FAIL ") + name + (cond ? "" : "  -> " + JSON.stringify(detail))); };
await call({ action: "pair" }); T.assistant_device[0].status = "approved";
const tryOne = async (input: any, kind = "meal", slug = "pot-pie-sunday") => { script = [toolTurn(input), textTurn("x")]; const n = T.assistant_change.length; await readSse(await call({ action: "ask", kind, slug, message: "q" })); return { made: T.assistant_change.length - n, res: calls.at(-1).messages.at(-1).content[0], c: T.assistant_change.at(-1) }; };

// --- the model is told what it may now do
script = [textTurn("ok")];
await readSse(await call({ action: "ask", kind: "meal", slug: "pot-pie-sunday", message: "hello" }));
const sys = calls[0].system[0].text, pc = calls[0].tools[3];
ok("instructions allow swaps and point cook logs and wine to the app", /Changing which dishes are in the meal/.test(sys) && !/linking or removing dishes/.test(sys) && /Log the cook page/.test(sys) && /In the glass/.test(sys), sys.slice(0, 200));
ok("instructions carry the 16 Nov household rules", /modest portion of rice, noodles or bread/.test(sys) && /desserts are balanced/.test(sys) && !/Carbohydrate moderation is Jin's standing preference/.test(sys));
ok("propose_change offers dishes_out and dishes_in with roles and a new dish", pc.input_schema.properties.meal.properties.dishes_out && pc.input_schema.properties.meal.properties.dishes_in.items.properties.role.enum.includes("dessert") && pc.input_schema.properties.meal.properties.dishes_in.items.properties.new.required.includes("nutrition_estimate"));

// --- A: swap the dessert for a saved dish, with the workflow carried through; the model calls it minor
let t = await tryOne({ summary: "Swap the chocolate mandarins for yuzu sorbet with berries.", class: "minor", class_reason: "Dessert swap.",
  meal: { dishes_out: [{ slug: "pot-pie-chocolate-mandarins" }], dishes_in: [{ slug: "yuzu-sorbet-berries", role: "dessert" }],
    text_edits: [{ field: "workflow_md", find: "- T-20 dip the mandarins in chocolate", replace: "- T-5 scoop the sorbet" }, { field: "shopping_notes", find: "Buy 4 mandarins.", replace: "Buy the sorbet and berries." }] } });
let c = t.c;
ok("A: accepted, and material whatever the model said", t.made === 1 && c.class === "material" && /a dish is taken off the meal/.test(c.class_reason) && /a dish is added to the meal/.test(c.class_reason), c.class_reason);
ok("A: card shows the dish out and the dish in", c.display.some((d: any) => d.where === "Meal · Dishes" && d.was === "Chocolate Mandarins (dessert)" && /stays in the Library/.test(d.now)) && c.display.some((d: any) => d.where === "Meal · Dishes" && d.now === "Add: Yuzu Sorbet with Berries (dessert)"), c.display);
ok("A: saves are meal fields, then the link (in the dessert's place), then the unlink", c.saves.map((s: any) => s.entity).join() === "meal,link,unlink" && c.saves[1].dish === "yuzu-sorbet-berries" && c.saves[1].role === "dessert" && c.saves[1].service_order === 2 && c.saves[2].dish === "pot-pie-chocolate-mandarins" && c.saves[1].slug === "pot-pie-sunday", c.saves);
ok("A: undo puts the dessert back first, then takes the sorbet off, then restores the fields", c.undo.map((s: any) => s.entity).join() === "link,unlink,meal" && c.undo[0].dish === "pot-pie-chocolate-mandarins" && c.undo[0].role === "dessert" && c.undo[0].service_order === 2 && c.undo[1].dish === "yuzu-sorbet-berries" && /dip the mandarins/.test(c.undo[2].p.workflow_md), c.undo);
ok("A: one meal guard", c.guards.length === 1 && c.guards[0].entity === "meal" && c.guards[0].updated_at === "2026-11-19T00:00:00.000001+00:00", c.guards);
ok("A: dry run made; the tool result names the review route", applyCalls.at(-1).p_mode === "check" && /MATERIAL/.test(t.res.content) && /Review with GPT/.test(t.res.content), t.res);
let r = await J(await call({ action: "change", change_id: c.id, op: "apply" }));
ok("A: Apply before the review is refused", r.status === "needs_review", r);

// --- the review draft shows the meal as it will be
r = await J(await call({ action: "change", change_id: c.id, op: "review" }));
const draft = reqs.at(-1)?.p_draft ?? "";
ok("A: review draft has the sorbet, not the mandarins, and the edited workflow", /# DISH: Yuzu Sorbet with Berries \(dessert\)/.test(draft) && !/# DISH: Chocolate Mandarins/.test(draft) && /T-5 scoop the sorbet/.test(draft) && /Chocolate Mandarins \(dessert\)/.test(draft) && reqs.at(-1).p_multi_component === true, draft.slice(0, 900));

// --- B: a new simple dish, with one new ingredient name
const SORBET = { name: "Mango Sorbet with Strawberries", category: ["Dessert"], servings: 3, summary: "Bought sorbet, fresh berries.",
  method_md: "## Method\n\n1. **Hull and halve 200 g / 7 oz strawberries; chill.**\n2. **Soften the sorbet 5 min at room temperature.**\n3. **Scoop into chilled bowls and top with the berries and mint.**",
  ingredients: [{ name: "mango sorbet", qty: 500, unit: "ml", qty_alt: "2 cups", buy_spec: "good-quality, dairy-free", department: "Frozen" }, { name: "strawberry", qty: 200, unit: "g" }, { name: "fresh mint", qty: 2, unit: "sprig", optional: true }],
  nutrition_estimate: { kcal: 190, protein_g: 1, carbs_g: 45, fat_g: 0.5, per: "serving" } };
t = await tryOne({ summary: "Replace the dessert with a bought mango sorbet and strawberries.", class: "material", class_reason: "A new dessert.",
  meal: { dishes_out: [{ slug: "pot-pie-chocolate-mandarins" }], dishes_in: [{ slug: "pot-pie-mango-sorbet", role: "dessert", new: SORBET }] } });
c = t.c;
const dn = c.saves.find((s: any) => s.entity === "dish_new");
ok("B: the new dish is saved first, as designed, with provenance and the Core version", t.made === 1 && c.saves.map((s: any) => s.entity).join() === "dish_new,link,unlink" && dn.slug === "pot-pie-mango-sorbet" && dn.p.status === "designed" && dn.p.governance_version === "v3.16" && /^Ask in app \d{4}-\d{2}-\d{2}: made for pot-pie-sunday$/.test(dn.p.source) && dn.p.ingredients.length === 3 && dn.p.ingredients[0].qty === 500, dn);
ok("B: the unknown name is created with its department; the known ones are not", JSON.stringify(dn.p.new_ingredients) === JSON.stringify([{ name: "mango sorbet", department: "Frozen" }]) && !("department" in dn.p.ingredients[0]), dn.p.new_ingredients);
ok("B: guards hold the meal and the free slug; undo takes the new dish off and puts the old one back", c.guards.some((g: any) => g.entity === "dish_new" && g.slug === "pot-pie-mango-sorbet") && c.undo.map((s: any) => s.entity + ":" + s.dish).join() === "link:pot-pie-chocolate-mandarins,unlink:pot-pie-mango-sorbet", c.undo);
ok("B: the card shows the new dish in full", c.display.some((d: any) => d.now === "Add a new dish: Mango Sorbet with Strawberries (dessert)") && c.display.some((d: any) => d.where === "Mango Sorbet with Strawberries · Ingredients" && /500 ml mango sorbet/.test(d.now) && d.now.split("\n").length === 3) && c.display.some((d: any) => d.where === "Mango Sorbet with Strawberries · Method") && c.display.some((d: any) => /190 kcal/.test(d.now)), c.display);
r = await J(await call({ action: "change", change_id: c.id, op: "review" }));
ok("B: review draft carries the new dish, marked new, with its rows", /# DISH: Mango Sorbet with Strawberries \(NEW DISH, made by this change\) \(dessert\)/.test(reqs.at(-1).p_draft) && /500 ml mango sorbet/.test(reqs.at(-1).p_draft) && /Soften the sorbet/.test(reqs.at(-1).p_draft), reqs.at(-1).p_draft.slice(-900));

// --- C: refusals
const ref = async (name: string, input: any, re: RegExp, kind = "meal", slug = "pot-pie-sunday") => { const x = await tryOne({ summary: "A change that should be refused.", class: "material", class_reason: "x", ...input }, kind, slug); ok(name, x.made === 0 && re.test(x.res.content) && x.res.is_error === true, x.res); };
await ref("C: a dish page cannot swap dishes", { meal: { dishes_out: [{ slug: "pot-pie-chocolate-mandarins" }] } }, /This is a dish page/, "dish", "pot-pie-chicken-pie");
await ref("C: a dish not on the meal cannot be taken off", { meal: { dishes_out: [{ slug: "yuzu-sorbet-berries" }] } }, /is not on this meal/);
await ref("C: a dish already on the meal cannot be put on", { meal: { dishes_in: [{ slug: "pot-pie-chicken-pie", role: "main" }] } }, /already on this meal/);
await ref("C: an unknown saved slug", { meal: { dishes_in: [{ slug: "lemon-posset", role: "dessert" }] } }, /No saved dish has the slug "lemon-posset"/);
await ref("C: a new dish on a slug already taken", { meal: { dishes_in: [{ slug: "yuzu-sorbet-berries", role: "dessert", new: SORBET }] } }, /already saved \(Yuzu Sorbet with Berries\)/);
await ref("C: a bad role", { meal: { dishes_in: [{ slug: "yuzu-sorbet-berries", role: "pudding" }] } }, /is not a dish role/);
await ref("C: a bad slug", { meal: { dishes_in: [{ slug: "Mango Sorbet", role: "dessert", new: SORBET }] } }, /is not a dish slug/);
await ref("C: more than 12 ingredient lines", { meal: { dishes_in: [{ slug: "pot-pie-big", role: "dessert", new: { ...SORBET, ingredients: Array.from({ length: 13 }, () => ({ name: "strawberry", qty: 10, unit: "g" })) } }] } }, /at most 12/);
await ref("C: more than 8 steps", { meal: { dishes_in: [{ slug: "pot-pie-big", role: "dessert", new: { ...SORBET, method_md: Array.from({ length: 9 }, (_, i) => `${i + 1}. **Step ${i + 1}.**`).join("\n") } }] } }, /at most 8/);
await ref("C: a step without a bold lead", { meal: { dishes_in: [{ slug: "pot-pie-big", role: "dessert", new: { ...SORBET, method_md: "1. **Chill the bowls.**\n2. Scoop the sorbet." } }] } }, /bold lead/);
await ref("C: an unknown ingredient name without a department", { meal: { dishes_in: [{ slug: "pot-pie-big", role: "dessert", new: { ...SORBET, ingredients: [{ name: "passion fruit", qty: 2, unit: "piece" }] } }] } }, /"passion fruit" is not an ingredient name/);
await ref("C: no nutrition estimate", { meal: { dishes_in: [{ slug: "pot-pie-big", role: "dessert", new: { ...SORBET, nutrition_estimate: null } }] } }, /nutrition_estimate/);
await ref("C: a bad category", { meal: { dishes_in: [{ slug: "pot-pie-big", role: "dessert", new: { ...SORBET, category: ["Pudding"] } }] } }, /category is a list/);
await ref("C: the only dish of a meal cannot go", { meal: { dishes_out: [{ slug: "solo-soup" }] } }, /keeps at least one dish/, "meal", "solo-supper");
await ref("C: a dish taken off cannot be edited in the same change", { dishes: [{ slug: "pot-pie-chocolate-mandarins", text_edits: [{ field: "method_md", find: "**Chill 20 min.**", replace: "**Chill 30 min.**" }] }], meal: { dishes_out: [{ slug: "pot-pie-chocolate-mandarins" }] } }, /do not edit it in the same change/);
await ref("C: the same dish in and out", { meal: { dishes_out: [{ slug: "pot-pie-chocolate-mandarins" }], dishes_in: [{ slug: "pot-pie-chocolate-mandarins", role: "dessert" }] } }, /both taken off and put on|already on this meal/);

// --- D: the only dish of a meal can be swapped (link before unlink)
t = await tryOne({ summary: "Swap the soup for the yuzu sorbet, as a test.", class: "material", class_reason: "x", meal: { dishes_out: [{ slug: "solo-soup" }], dishes_in: [{ slug: "yuzu-sorbet-berries", role: "dessert" }] } }, "meal", "solo-supper");
ok("D: a one-dish meal can swap its dish; the new one goes last as its role differs", t.made === 1 && t.c.saves.map((s: any) => s.entity).join() === "link,unlink" && t.c.saves[0].service_order === 2, t.c.saves);

console.log(fails ? `\n${fails} FAILED` : "\nall passed");
process.exit(fails ? 1 : 0);
