#!/usr/bin/env node
// Step check, the same test as the app's #/stepcheck (Core §III "Method steps stand alone", 6 Nov 2026).
// Usage: node stepcheck.js <method.md> [more.md …]
// It loads the parsing code from ../../site/index.html at run time, so it always matches the deployed app.
// Prints each step that hides an action (a sentence after its lead that starts with an action), each step over the
// Core 3.17 step budget (lead over 30 words or with two or more semicolons; step over 70 words) and a summary per file.
// Exit code 0 = no step hides an action or runs over budget in any file.
const fs = require('fs'), path = require('path');
const src = fs.readFileSync(path.join(__dirname, '..', '..', 'site', 'index.html'), 'utf8');
const cut = (from, to) => { const a = src.indexOf(from), b = src.indexOf(to, a); if (a < 0 || b < 0) throw new Error('marker not found: ' + from); return src.slice(a, b); };
const code = cut('const M_YIELD=', '\nconst mdInline=') + '\n' + cut('const ACT_START=', '\nconst stepDishes=');
const api = new Function(code + '\nreturn {stepIssues};')();
let bad = 0;
for (const f of process.argv.slice(2)) {
  const r = api.stepIssues({ method_md: fs.readFileSync(f, 'utf8') });
  r.hid.forEach(s => console.log(`${path.basename(f)}: HIDDEN ${s.phase} ${s.k}: ${s.text}`));
  r.long.forEach(s => console.log(`${path.basename(f)}: LONG ${s.phase} ${s.k} (${s.why}): ${String(s.text).replace(/\*\*/g, '').slice(0, 100)}…`));
  console.log(`${path.basename(f)}: steps ${r.n} · hidden ${r.hid.length} · over budget ${r.long.length} · without a bold lead ${r.nolead}`);
  bad += r.hid.length + r.long.length;
}
process.exit(bad ? 1 : 0);
