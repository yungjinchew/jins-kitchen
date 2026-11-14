// in-memory stand-in for supabase-js, just enough for kitchen-assistant's calls
export const T: Record<string, any[]> = { kitchen_config: [], assistant_device: [], assistant_thread: [], assistant_message: [], assistant_change: [], kitchen_comment: [], dish: [], meal: [], dish_ingredient: [], ingredient: [] };
export const RPC: Record<string, (a: any) => any> = {};
let seq = 0;
const uuid = () => `00000000-0000-4000-8000-${String(++seq).padStart(12, "0")}`;
class Q {
  f: ((r: any) => boolean)[] = []; op = "select"; payload: any = null; ord: [string, boolean] | null = null; lim = 1e9; head = false; cnt = false; one: string | null = null; t: string;
  constructor(t: string) { this.t = t; }
  select(_c?: string, o?: any) { if (o?.head) this.head = true; if (o?.count) this.cnt = true; return this; }
  insert(p: any) { this.op = "insert"; this.payload = p; return this; }
  update(p: any) { this.op = "update"; this.payload = p; return this; }
  eq(k: string, v: any) { this.f.push((r) => r[k] === v); return this; }
  gt(k: string, v: any) { this.f.push((r) => r[k] > v); return this; }
  neq(k: string, v: any) { this.f.push((r) => r[k] !== v); return this; }
  in(k: string, v: any[]) { this.f.push((r) => v.includes(r[k])); return this; }
  gte(k: string, v: any) { this.f.push((r) => r[k] >= v); return this; }
  not(k: string, _o: string, _v: any) { this.f.push((r) => r[k] != null); return this; }
  ilike(k: string, v: string) { const re = new RegExp("^" + v.replace(/%/g, ".*") + "$", "i"); this.f.push((r) => re.test(r[k])); return this; }
  order(k: string, o?: any) { this.ord = [k, o?.ascending !== false]; return this; }
  limit(n: number) { this.lim = n; return this; }
  maybeSingle() { this.one = "maybe"; return this; }
  single() { this.one = "single"; return this; }
  run() {
    const rows = T[this.t]; if (!rows) return { data: null, error: { message: "no table " + this.t } };
    let out: any[];
    if (this.op === "insert") { const r = { id: uuid(), created_at: new Date().toISOString(), ...this.payload }; rows.push(r); out = [r]; }
    else { out = rows.filter((r) => this.f.every((f) => f(r))); if (this.op === "update") out.forEach((r) => Object.assign(r, this.payload)); }
    if (this.ord) { const [k, asc] = this.ord; out = [...out].sort((a, b) => (a[k] < b[k] ? -1 : a[k] > b[k] ? 1 : 0) * (asc ? 1 : -1)); }
    const count = out.length; out = out.slice(0, this.lim);
    if (this.head) return { data: null, count, error: null };
    if (this.one) return out.length ? { data: out[0], error: null } : { data: null, error: this.one === "single" ? { message: "no rows" } : null };
    return { data: out, count: this.cnt ? count : undefined, error: null };
  }
  then(res: any, rej: any) { try { return Promise.resolve(this.run()).then(res, rej); } catch (e) { return Promise.reject(e).then(res, rej); } }
}
export function createClient(_u: string, _k: string, _o?: any) {
  return { from: (t: string) => new Q(t), rpc: (n: string, a: any) => Promise.resolve(RPC[n] ? { data: RPC[n](a), error: null } : { data: null, error: { message: "no rpc " + n } }) };
}
