#!/usr/bin/env python3
"""makesql.py <slug> <orig.md> <new.md> "<source note>"

Builds the save SQL for a wording-only edit of a dish's method_md (used for the 6 Nov 2026 step conversion of 70 dishes).
- <orig.md> is the method exactly as stored: its md5 must equal md5(method_md) in the database (check before editing).
- every changed line must be a step or paragraph line: headings, table rows and blank lines must not change, and the line
  count must not change (no step is split or merged, so step numbers cited elsewhere stay right)
- prints each changed line old -> new
- writes <slug>.sql next to new.md: one kitchen_save_dish call that rebuilds method_md server-side from the stored text
  with replace() pairs, so only the changed lines are sent. It saves only when the stored text still has the original md5
  AND the result has the new md5; otherwise it raises division_by_zero and nothing is written. The divisor depends on the
  row on purpose: Postgres folds a constant 1/0 at plan time and would raise on every run.
Run the .sql unchanged through the Supabase connector, then confirm md5(method_md) equals the new md5.
"""
import sys, io, hashlib, re, os

slug, op, np_, src = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
o = io.open(op, encoding='utf-8', newline='').read()
n = io.open(np_, encoding='utf-8', newline='').read()
md5 = lambda s: hashlib.md5(s.encode('utf-8')).hexdigest()
ol, nl = o.split('\n'), n.split('\n')
bad = []
if len(ol) != len(nl):
    bad.append(f'line count changed: {len(ol)} -> {len(nl)} (steps must not be split or merged)')
pairs = []
for i, (a, b) in enumerate(zip(ol, nl)):
    if a == b:
        continue
    if re.match(r'^\s*(#|\|)', a) or re.match(r'^\s*(#|\|)', b) or not a.strip() or not b.strip():
        bad.append(f'line {i+1}: heading, table row or blank line changed')
    j = i; old = a; new = b   # widen with the previous line(s) until the old text is unique in the original
    while o.count(old) != 1 and j > 0:
        j -= 1; old = ol[j] + '\n' + old; new = nl[j] + '\n' + new
    if o.count(old) != 1:
        bad.append(f'line {i+1}: old text not unique in the original')
    pairs.append((i + 1, old, new))
t = o
for _, old, new in pairs:
    t = t.replace(old, new)
if t != n:
    bad.append('applying the pairs to the original does not give the new text')
for ln, old, new in pairs:
    print(f'--- line {ln}\nOLD: {old}\nNEW: {new}')
if bad:
    print('PROBLEMS:\n- ' + '\n- '.join(bad)); sys.exit(1)

def dq(s, tag):
    assert f'${tag}$' not in s
    return f'${tag}${s}${tag}$'
expr = 'method_md'
for k, (_, old, new) in enumerate(pairs, 1):
    expr = f'replace({expr}, {dq(old, f"o{k}")}, {dq(new, f"n{k}")})'
src_sql = src.replace("'", "''")
sql = (f"select public.kitchen_save_dish('{slug}', jsonb_build_object('method_md', x.t), '{src_sql}') r, md5(x.t) new_md5\n"
       f"from (select {expr} t, md5(method_md) m0 from dish where slug = '{slug}') x\n"
       f"where case when x.m0 = '{md5(o)}' and md5(x.t) = '{md5(n)}' then true else (1/(0*length(x.m0))) = 1 end;")
out = os.path.join(os.path.dirname(os.path.abspath(np_)), slug + '.sql')
io.open(out, 'w', encoding='utf-8', newline='').write(sql + '\n')
print(f'OK {len(pairs)} changed line(s); orig md5 {md5(o)}; new md5 {md5(n)}; SQL written to {out}')
