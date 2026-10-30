#!/usr/bin/env python3
"""Print spec 1.0 (2026-10-30) for jins-kitchen site/index.html.

Re-runnable: replaces the print section (from the "print (cooking sheet" marker to the "shopping" marker) with
print_region.js and makes three CSS edits in the .sheet block (skipped when already made). Touches nothing else, so it
can be applied on top of other work in index.html, and re-applied after an update to print_region.js or after another
edit to index.html overwrote it. Exits 0 without writing when the file already matches.

Usage: python3 apply_print_spec.py <path/to/index.html> <path/to/print_region.js>
"""
import sys, re, io

path, region_path = sys.argv[1], sys.argv[2]
src = io.open(path, encoding='utf-8', newline='').read()
region = io.open(region_path, encoding='utf-8', newline='').read()
MARK = 'PRINT SPEC 1.0'

START = '// ---------------------------------------------------------------- print (cooking sheet rendered from the database)'
END = '// ---------------------------------------------------------------- shopping'
i, j = src.find(START), src.find(END)
assert i > 0 and j > i and src.count(START) == 1 and src.count(END) == 1, 'print section markers not found exactly once'
out = src[:i] + region + src[j:]

CSS = [
    ('.sheet .ingt td:last-child,.sheet .ingt th:last-child{width:40%}',
     '.sheet .ingt td:last-child,.sheet .ingt th:last-child{width:33%}'),
    ('.sheet .shop td:nth-child(n+2),.sheet .shop th:nth-child(n+2){width:13%}',
     '.sheet .shop2 th.ck,.sheet .shop2 td.ck,.sheet table.tmin th.ck,.sheet table.tmin td.ck,.sheet table.meas th.ck,.sheet table.meas td.ck{width:18px;padding-left:2px;padding-right:2px;text-align:center}\n'
     '.sheet .shop2 th:nth-child(3),.sheet .shop2 td:nth-child(3){width:20%}.sheet .shop2 th:nth-child(4),.sheet .shop2 td:nth-child(4){width:34%}\n'
     '.sheet .tick{display:inline-block;width:8px;height:8px;border:1px solid #666;border-radius:1px;vertical-align:-1px}\n'
     '.sheet table.tmin td:nth-child(2){font-weight:700;width:16%}.sheet table.tmin th.clk,.sheet table.tmin td.clk{width:11%;white-space:nowrap;color:var(--pc);font-weight:700}.sheet table.tmin td.ck{font-weight:400}\n'
     '.sheet table.meas td:last-child{width:26%}.sheet .meas td.dept{background:#F0F0F0;font-weight:700;font-size:.9em}\n'
     '.sheet p.dsub{font-style:italic;color:#555;margin:0 0 2px}.sheet p.ov{margin:4px 0 6px}.sheet p.pantry{margin-top:4px}'),
    (' .sheet .dish{break-before:page;margin-top:0;padding-top:0;border-top:0}.sheet .dish>h2:first-child{margin-top:0}.sheet .pb{margin-top:0;padding-top:0;border-top:0}',
     ' .sheet .pg{break-before:page}.sheet .dish.pg,.sheet .cover.pg,.sheet>.dish:first-child{margin-top:0;padding-top:0;border-top:0}.sheet .dish>h2:first-child{margin-top:0}'
     '.sheet .dish.side{margin-top:14pt;padding-top:5pt;border-top:.5pt solid #DDD}.sheet .keep{break-inside:avoid}.sheet .pb{margin-top:0;padding-top:0;border-top:0}.sheet .tick{width:2.6mm;height:2.6mm}'),
]
for old, new in CSS:
    if out.count(old) == 1:
        out = out.replace(old, new)
    else:
        assert out.count(new) == 1, 'CSS anchor not found exactly once: ' + old[:60]
if out == src:
    print('already up to date:', MARK); sys.exit(0)

io.open(path, 'w', encoding='utf-8', newline='').write(out)
print('applied', MARK, '->', path, len(src), '->', len(out), 'chars')
