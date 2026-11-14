#!/usr/bin/env python3
"""Ask applier for jins-kitchen site/index.html (the version is read from ask_region.js).

Re-runnable, like tools/print-spec/apply_print_spec.py. It puts three things into index.html and touches nothing else:
  1. the Ask script (ask_region.js), between its own start and end markers, just before the print section;
  2. the Ask styles (ask.css), between /* ASK ... */ and /* END ASK */, at the end of the main style block;
  3. four one-line hooks: the Ask card on the dish page and on the meal page, the Back label, and the rule that a
     data refresh never redraws the Ask page.
Run it again after an update to ask_region.js or ask.css, or after another edit to index.html dropped the section.
Exits 0 without writing when the file already matches.

Usage: python3 apply_ask.py <path/to/index.html> [<dir with ask_region.js and ask.css>]
"""
import sys, re, io, os

path = sys.argv[1]
here = sys.argv[2] if len(sys.argv) > 2 else os.path.dirname(os.path.abspath(__file__))
rd = lambda p: io.open(p, encoding='utf-8', newline='').read()
src = rd(path)
region = rd(os.path.join(here, 'ask_region.js'))
css = rd(os.path.join(here, 'ask.css'))
m = re.search(r'ASK ([0-9.]+)', region); MARK = 'ASK ' + (m.group(1) if m else '?')
assert '\r' not in region and '\r' not in css, 'the Ask files must use LF line endings'

R_START = '// ---------------------------------------------------------------- ask Claude about one meal or dish'
R_END = '// ---------------------------------------------------------------- end ask\n'
PRINT_START = '// ---------------------------------------------------------------- print (cooking sheet rendered from the database)'
assert region.startswith(R_START) and region.endswith(R_END), 'ask_region.js must start and end with its markers'
out = src

# 1. script
if out.count(R_START):
    assert out.count(R_START) == 1 and out.count(R_END) == 1, 'ask markers not found exactly once'
    i, j = out.find(R_START), out.find(R_END) + len(R_END)
    assert j > i
    out = out[:i] + region + out[j:]
else:
    assert out.count(PRINT_START) == 1, 'print section marker not found exactly once'
    i = out.find(PRINT_START)
    out = out[:i] + region + '\n' + out[i:]

# 2. styles
C_START, C_END = '/* ASK ', '/* END ASK */\n'
assert css.startswith(C_START) and css.endswith(C_END), 'ask.css must start and end with its markers'
if out.count(C_END):
    assert out.count(C_END) == 1, 'ask style markers not found exactly once'
    j = out.find(C_END) + len(C_END); i = out.rfind(C_START, 0, j)
    assert 0 < i < j
    out = out[:i] + css + out[j:]
else:
    A = '\n</style>\n'
    assert out.count(A) == 1, 'main </style> not found exactly once'
    i = out.find(A) + 1
    out = out[:i] + css + out[i:]

# 3. hooks (old -> new); each is skipped when already made
HOOKS = [
    ("${wineBox('dish',d.slug)}\n", "${wineBox('dish',d.slug)}\n    ${askBox('dish',d.slug)}\n"),
    ("${wineBox('meal',m.slug)}\n", "${wineBox('meal',m.slug)}\n    ${askBox('meal',m.slug)}\n"),
    ("print:'Print',postcook:'Log cook'}[v]", "print:'Print',postcook:'Log cook',ask:'Ask'}[v]"),
    ("if(v==='postcook') return;", "if(v==='postcook'||v==='ask') return;"),
]
for old, new in HOOKS:
    if out.count(new) == 1:
        continue
    assert out.count(old) == 1, 'hook anchor not found exactly once: ' + old[:50]
    out = out.replace(old, new)

if out == src:
    print('already up to date:', MARK); sys.exit(0)
io.open(path, 'w', encoding='utf-8', newline='').write(out)
print('applied', MARK, '->', path, len(src), '->', len(out), 'chars')
