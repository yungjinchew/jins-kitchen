// end-to-end test of kitchen-assistant against an in-memory database and a scripted Anthropic stream
import { T, RPC } from "./mock-supabase.ts";

const env: Record<string, string> = { SUPABASE_URL: "http://db", SUPABASE_SECRET_KEYS: '{"default":"sb_secret_x"}', ANTHROPIC_API_KEY: "" };
let handler: (r: Request) => Promise<Response>;
(globalThis as any).Deno = { env: { get: (k: string) => env[k] }, serve: (h: any) => { handler = h; } };

T.kitchen_config.push(
  { key: "governance_base", value: "https://gh/gov/" }, { key: "cellar_url", value: "https://gh/cellar.md" },
  { key: "assistant_model", value: "claude-opus-5-5" }, { key: "assistant_model_economy", value: "claude-sonnet-5-5" },
  { key: "assistant_daily_limit", value: "3" }, { key: "assistant_monthly_usd", value: "15" }, { key: "assistant_max_tokens", value: "2000" },
  { key: "assistant_prices", value: '{"claude-opus-5-5":{"in":4,"cw":5,"cr":0.2,"out":20},"claude-sonnet-5-5":{"in":2,"cw":2.5,"cr":0.1,"out":10}}' },
  { key: "spend_mode_url", value: "https://spend/rpc" }, { key: "spend_mode_key", value: "pk" },
);
T.meal.push({ slug: "fish-pie-sunday", name: "Fish Pie Sunday", status: "designed" });
T.dish.push({ slug: "fish-pie", name: "Fish Pie", status: "designed" }, { slug: "fish-stock", name: "Fish Stock", status: "cooked" });
RPC.kitchen_meal_context = ({ p_slug }) => p_slug === "fish-pie-sunday" ? { kind: "meal", meal: { slug: p_slug, name: "Fish Pie Sunday" }, dishes: [], documents: [1] }
  : T.dish.find((d) => d.slug === p_slug) ? { kind: "dish", dish: { slug: p_slug } } : { kind: "none" };
RPC.kitchen_assistant_usage = () => ({
  questions_24h: T.assistant_message.filter((m) => m.role === "user").length,
  month_usd: T.assistant_message.reduce((n, m) => n + Number(m.cost_usd || 0), 0),
});

let spend = "normal";
const calls: any[] = [];
const sse = (evs: any[]) => new Response(new ReadableStream({
  start(c) { const e = new TextEncoder(); const s = evs.map((x) => `event: ${x.type}\ndata: ${JSON.stringify(x)}\n\n`).join("");
    for (let i = 0; i < s.length; i += 37) c.enqueue(e.encode(s.slice(i, i + 37))); c.close(); } }), { status: 200, headers: { "content-type": "text/event-stream" } });
let script: (() => Response)[] = [];
globalThis.fetch = (async (url: any, init: any) => {
  const u = String(url);
  if (u.startsWith("https://gh/gov/manifest.json")) return new Response(JSON.stringify({ framework_version: "3.16", files: [
    { id: "core", file: "core.md", always: true, load_when: "always" }, { id: "wine_pairing", file: "wine.md", load_when: "Wine" }, { id: "meal_workflow", file: "wf.md", load_when: "2+ components" }] }));
  if (u.startsWith("https://gh/gov/core.md")) return new Response("CORE RULES ".repeat(50));
  if (u.startsWith("https://gh/gov/wine.md")) return new Response("WINE RULES");
  if (u.startsWith("https://gh/cellar.md")) return new Response("Snapshot 2026-11-14\n## Current cellar\n| 2019 | Barolo |");
  if (u.startsWith("https://spend/rpc")) return new Response(JSON.stringify(spend));
  if (u === "https://api.anthropic.com/v1/messages") { calls.push({ headers: init.headers, body: JSON.parse(init.body) }); return script.shift()!(); }
  throw new Error("unexpected fetch " + u);
}) as any;

await import("./index.ts");
const KEY = "ab".repeat(32);
const call = (body: any, key = KEY) => handler(new Request("http://fn/", { method: "POST", headers: { "content-type": "application/json", origin: "https://dev--jins-kitchen.netlify.app", "x-device-key": key, "user-agent": "TestPhone" }, body: JSON.stringify(body) }));
const J = async (r: Response) => ({ http: r.status, ...(await r.json()) });
let fails = 0;
const ok = (name: string, cond: any, detail?: any) => { if (!cond) fails++; console.log((cond ? "PASS " : "FAIL ") + name + (cond ? "" : "  -> " + JSON.stringify(detail))); };
const readSse = async (r: Response) => (await r.text()).split("\n\n").filter(Boolean).map((l) => JSON.parse(l.replace(/^data: /, "")));

// --- access lock
let r = await J(await call({ action: "open", kind: "meal", slug: "fish-pie-sunday" }, "zz"));
ok("bad key is refused", r.http === 400 && r.status === "bad_key", r);
r = await J(await call({ action: "open", kind: "meal", slug: "fish-pie-sunday" }));
ok("unknown device is unpaired", r.status === "unpaired", r);
r = await J(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "hi" }));
ok("unknown device cannot ask", r.status === "unpaired" && calls.length === 0, r);
r = await J(await call({ action: "pair" }));
const code = r.code;
ok("pair gives a 6-character code", r.status === "pending" && /^[A-Z2-9]{6}$/.test(code), r);
ok("only the hash is stored", T.assistant_device.length === 1 && T.assistant_device[0].key_hash.length === 64 && !JSON.stringify(T.assistant_device).includes(KEY));
r = await J(await call({ action: "pair" }));
ok("asking again keeps the same code", r.code === code, r);
r = await J(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "hi" }));
ok("pending device cannot ask", r.status === "pending" && calls.length === 0, r);
T.assistant_device[0].status = "approved"; // what kitchen_assistant_pair_approve does
r = await J(await call({ action: "open", kind: "meal", slug: "fish-pie-sunday" }));
ok("approved device opens, no key yet", r.status === "ok" && r.has_key === false && r.daily_limit === 3 && r.messages.length === 0, r);
r = await J(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "hi" }));
ok("no key -> no_key, nothing sent", r.status === "no_key" && calls.length === 0 && T.assistant_message.length === 0, r);

// --- a question with a tool call
env.ANTHROPIC_API_KEY = "sk-test";
script = [
  () => sse([
    { type: "message_start", message: { usage: { input_tokens: 100, cache_creation_input_tokens: 20000, cache_read_input_tokens: 0, output_tokens: 1 } } },
    { type: "content_block_start", index: 0, content_block: { type: "text", text: "" } },
    { type: "content_block_delta", index: 0, delta: { type: "text_delta", text: "Checking the cellar." } },
    { type: "content_block_stop", index: 0 },
    { type: "content_block_start", index: 1, content_block: { type: "tool_use", id: "toolu_1", name: "read_cellar", input: {} } },
    { type: "content_block_delta", index: 1, delta: { type: "input_json_delta", partial_json: "{" } },
    { type: "content_block_delta", index: 1, delta: { type: "input_json_delta", partial_json: "}" } },
    { type: "content_block_stop", index: 1 },
    { type: "ping" },
    { type: "message_delta", delta: { stop_reason: "tool_use" }, usage: { output_tokens: 40 } },
    { type: "message_stop" }]),
  () => sse([
    { type: "message_start", message: { usage: { input_tokens: 300, cache_creation_input_tokens: 0, cache_read_input_tokens: 20000, output_tokens: 1 } } },
    { type: "content_block_start", index: 0, content_block: { type: "text", text: "" } },
    { type: "content_block_delta", index: 0, delta: { type: "text_delta", text: "Open the **2019 Barolo**." } },
    { type: "content_block_stop", index: 0 },
    { type: "message_delta", delta: { stop_reason: "end_turn" }, usage: { output_tokens: 60 } },
    { type: "message_stop" }]),
];
let resp = await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "Which wine?" });
let ev = await readSse(resp);
ok("stream is SSE with CORS for the preview origin", resp.headers.get("content-type")!.startsWith("text/event-stream") && resp.headers.get("access-control-allow-origin") === "https://dev--jins-kitchen.netlify.app");
ok("events: start, deltas, tool, done", ev[0].t === "start" && ev.some((e) => e.t === "tool" && /cellar/.test(e.label)) && ev[ev.length - 1].t === "done", ev.map((e) => e.t));
ok("text streamed in order", ev.filter((e) => e.t === "delta").map((e) => e.text).join("") === "Checking the cellar.\n\nOpen the **2019 Barolo**.");
ok("two model calls, second carries the tool result", calls.length === 2 && calls[1].body.messages.at(-1).content[0].type === "tool_result" && /Current cellar/.test(calls[1].body.messages.at(-1).content[0].content) && calls[1].body.messages.at(-2).content.some((b: any) => b.type === "tool_use" && b.id === "toolu_1"));
const b0 = calls[0].body;
ok("request shape: model, stream, 2 cached system blocks, 4 tools, key header", b0.model === "claude-opus-5-5" && b0.stream === true && b0.system.length === 2 && b0.system.every((s: any) => s.cache_control) && b0.tools.length === 4 && calls[0].headers["x-api-key"] === "sk-test" && calls[0].headers["anthropic-version"] === "2023-06-01", { m: b0.model, t: b0.tools.length });
ok("record is in the prompt without documents", /fish-pie-sunday/.test(b0.system[1].text) && !/documents/.test(b0.system[1].text));
ok("question carries the Singapore date", /Singapore\]\nWhich wine\?$/.test(b0.messages.at(-1).content), b0.messages.at(-1).content);
const am = T.assistant_message.find((m) => m.role === "assistant");
const expCost = (400 * 4 + 20000 * 5 + 20000 * 0.2 + 100 * 20) / 1e6;
ok("answer saved with usage and cost", am && am.status === "ok" && am.usage.output_tokens === 100 && am.usage.cache_read_input_tokens === 20000 && Math.abs(am.cost_usd - expCost) < 1e-5 && am.tools[0].name === "read_cellar", am && { u: am.usage, c: am.cost_usd, expCost });
ok("done reports the count and cost", ev.at(-1).used_today === 1 && ev.at(-1).daily_limit === 3 && Math.abs(ev.at(-1).cost_usd - expCost) < 1e-3, ev.at(-1));

// --- follow-up keeps the conversation
script = [() => sse([
  { type: "message_start", message: { usage: { input_tokens: 50, cache_creation_input_tokens: 0, cache_read_input_tokens: 20400, output_tokens: 1 } } },
  { type: "content_block_start", index: 0, content_block: { type: "text", text: "" } },
  { type: "content_block_delta", index: 0, delta: { type: "text_delta", text: "Decant 1 hour." } },
  { type: "content_block_stop", index: 0 },
  { type: "message_delta", delta: { stop_reason: "end_turn" }, usage: { output_tokens: 10 } }, { type: "message_stop" }])];
ev = await readSse(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "Decant?" }));
const b2 = calls[2].body;
ok("follow-up sends history in alternation", b2.messages.length === 3 && b2.messages.map((m: any) => m.role).join() === "user,assistant,user" && /Barolo/.test(b2.messages[1].content), b2.messages.map((m: any) => m.role));
r = await J(await call({ action: "open", kind: "meal", slug: "fish-pie-sunday" }));
ok("open returns the saved conversation", r.messages.length === 4 && r.used_today === 2, { n: r.messages.length, u: r.used_today });

// --- a model error is reported and logged, a dish thread is separate
script = [() => new Response(JSON.stringify({ type: "error", error: { type: "overloaded_error", message: "Overloaded" } }), { status: 529 })];
ev = await readSse(await call({ action: "ask", kind: "dish", slug: "fish-pie", message: "Scale to 5?" }));
ok("model error -> friendly error event, logged", ev.some((e) => e.t === "error" && /busy/.test(e.message)) && T.assistant_message.at(-1).status === "error" && T.assistant_thread.length === 2, ev);

// --- caps and the switch
r = await J(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "4th" }));
ok("daily cap stops the 4th question", r.status === "limit" && calls.length === 4, r);
T.kitchen_config.find((c) => c.key === "assistant_daily_limit")!.value = "100";
T.assistant_message.push({ role: "assistant", cost_usd: 15, created_at: new Date().toISOString() });
r = await J(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "x" }));
ok("config is cached 60 s (cap still 3)", r.status === "limit", r);
r = await J(await call({ action: "ask", kind: "meal", slug: "nope", message: "x" }));
ok("still gated before lookup", r.status === "limit", r);
T.assistant_device[0].status = "revoked";
r = await J(await call({ action: "ask", kind: "meal", slug: "fish-pie-sunday", message: "x" }));
ok("revoked device is refused", r.status === "revoked", r);
const o = await handler(new Request("http://fn/", { method: "OPTIONS", headers: { origin: "https://evil.example" } }));
ok("CORS never echoes a foreign origin", o.headers.get("access-control-allow-origin") === "https://jins-kitchen.netlify.app");
console.log(fails ? `\n${fails} FAILED` : "\nall passed");
process.exit(fails ? 1 : 0);
