#!/usr/bin/env node
// Step check, the same test as the app's #/stepcheck (Core §III "Method steps stand alone", 6 Nov 2026).
// Usage: node stepcheck.js <method.md> [more.md …]
// It loads the parsing code from ../../site/index.html at run time, so it always matches the deployed app.
// Prints each step that hides an action (a sentence after its lead that starts with an action) and a summary per file.
// Exit code 0 = no step hides an action in any file.
const fs = require('fs'), path = require('path');
const src = fs.readFileSync(path.join(__dirname, '..', '..', 'site', 'index.html'), 'utf8');
const cut = (from, to) => { const a = src.indexOf(from), b = src.indexOf(to, a); if (a < 0 || b < 0) throw new Error('marker not found: ' + from); return src.slice(a, b); };
const code = cut('const M_YIELD=', '\nconst mdInline=') + '\n' + cut('const ACT_START=', '\nconst stepDishes=');
const api = new Function(code + '\nreturn {stepIssues};')();
let bad = 0;
for (const f of process.argv.slice(2)) {
  const r = api.stepIssues({ method_md: fs.readFileSync(f, 'utf8') });
  r.hid.forEach(s => console.log(`${path.basename(f)}: HIDDEN ${s.phase} ${s.k}: ${s.text}`));
  console.log(`${path.basename(f)}: steps ${r.n} · hidden ${r.hid.length} · without a bold lead ${r.nolead}`);
  bad += r.hid.length;
}
process.exit(bad ? 1 : 0);
