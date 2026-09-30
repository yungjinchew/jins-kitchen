import json, glob, os, re, sys, collections

OUT = os.path.dirname(os.path.abspath(__file__))
files = sorted(glob.glob(os.path.join(OUT, 'out', '*.json')))
data = [json.load(open(f)) for f in files]

DEPTS = {"Protein","Produce","Dairy","Pantry","Bread","Oils & Liquids","Seasoning","Frozen","Alcohol"}
ROLES = {"main","side","sauce","dessert","soup","bread","starter","salad"}
DSTAT = {"idea","designed","cooked","retired"}
MSTAT = {"backlog","planned","cooked"}
REP = {None,"yes","with_modifications","no"}

errors = []
dish_slugs, meal_slugs = {}, {}
ingredients = {}  # name -> (department, pantry_default)
ing_conflicts = []

for d in data:
    key = d['assignment_key']
    for dish in d['dishes']:
        s = dish['slug']
        if s in dish_slugs: errors.append(f"dup dish slug {s} in {key} and {dish_slugs[s]}")
        dish_slugs[s] = key
        if dish['status'] not in DSTAT: errors.append(f"{key}/{s}: bad status {dish['status']}")
        for ing in dish.get('ingredients', []):
            n = ing['name'].strip().lower()
            ing['name'] = n
            dep = ing['department']
            if dep not in DEPTS: errors.append(f"{key}/{s}: bad department {dep} for {n}")
            if n in ingredients and ingredients[n][0] != dep:
                ing_conflicts.append((n, ingredients[n][0], dep, key))
            ingredients.setdefault(n, (dep, bool(ing.get('pantry_check'))))
    m = d.get('meal')
    if m:
        if m['slug'] in meal_slugs: errors.append(f"dup meal slug {m['slug']}")
        meal_slugs[m['slug']] = key
        if m['status'] not in MSTAT: errors.append(f"{key}: bad meal status")
        local = {x['slug'] for x in d['dishes']}
        for c in m['components']:
            if c['dish_slug'] not in local: errors.append(f"{key}: component {c['dish_slug']} not a dish in file")
            if c['role'] not in ROLES: errors.append(f"{key}: bad role {c['role']}")
    for c in d['cooks']:
        if c['owner'] == 'dish' and c['dish_slug'] not in {x['slug'] for x in d['dishes']}:
            errors.append(f"{key}: cook dish_slug {c['dish_slug']} missing")
        if c['owner'] == 'meal' and not m: errors.append(f"{key}: meal cook without meal")
        if c.get('repeat') not in REP: errors.append(f"{key}: bad repeat {c.get('repeat')}")
        if not re.match(r'^\d{4}-\d{2}-\d{2}$', c['cooked_on'] or ''): errors.append(f"{key}: bad date {c['cooked_on']}")

print("files", len(files), "meals", len(meal_slugs), "dishes", len(dish_slugs), "ingredients", len(ingredients),
      "cooks", sum(len(d['cooks']) for d in data), "dish_ingredients", sum(len(x.get('ingredients',[])) for d in data for x in d['dishes']))
print("ingredient department conflicts:", len(ing_conflicts))
for c in ing_conflicts[:40]: print("  ", c)
if errors:
    print("ERRORS:"); [print("  ", e) for e in errors]; sys.exit(1)

def q(v):
    if v is None: return 'null'
    if isinstance(v, bool): return 'true' if v else 'false'
    if isinstance(v, (int, float)): return repr(v)
    if isinstance(v, list):
        return "array[" + ",".join(q(x) for x in v) + "]::text[]" if v else "'{}'::text[]"
    s = str(v)
    tag = '$m$'
    while tag in s: tag = tag[:-1] + 'x$'
    return f"{tag}{s}{tag}"
def qj(v):
    return q(json.dumps(v, ensure_ascii=False)) + "::jsonb" if v is not None else 'null'

batches = []
# batch 0: ingredients
OVR={'bay leaf':'Seasoning','water':'Pantry','tomato':'Produce','chicken stock':'Pantry'}
rows = [f"({q(n)},{q(OVR.get(n,dep))},{q(pd)})" for n,(dep,pd) in sorted(ingredients.items())]
batches.append(("ingredients", "insert into public.ingredient (name, department, pantry_default) values\n" + ",\n".join(rows) + "\non conflict (name) do nothing;"))

for d in data:
    key = d['assignment_key']; sql = []
    m = d.get('meal')
    if m:
        sql.append(f"""insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing,legacy_notion_id)
values ({q(m['slug'])},{q(m['name'])},{q(m.get('planned_date'))},{q(m['status'])}::meal_status,{q(m.get('pax') or 3)},{q(m.get('workflow_md'))},{q(m.get('shared_prep_md'))},{q(m.get('wine_pairing'))},{q(m.get('legacy_notion_id'))});""")
    for x in d['dishes']:
        sql.append(f"""insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate,legacy_notion_id)
values ({q(x['slug'])},{q(x['name'])},{q(x.get('protein'))},{q(x.get('category') or [])},{q(x.get('cuisine') or [])},{q(x.get('difficulty'))},{q(x.get('tags') or [])},{q(x.get('occasion') or [])},{q(x['status'])}::dish_status,{q(x.get('source'))},{q(x.get('governance_version'))},{q(x.get('summary'))},{q(x.get('method_md'))},{q(x.get('servings'))},{q(x.get('equipment') or [])},{qj(x.get('designed_unvalidated') or [])},{qj(x.get('nutrition_estimate'))},{q(x.get('legacy_notion_id'))});""")
        for i, ing in enumerate(x.get('ingredients', [])):
            sql.append(f"""insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order)
select d.id, i.id, {q(ing.get('qty'))}, {q(ing.get('unit'))}, {q(ing.get('qty_alt'))}, {q(ing.get('prep_note'))}, {q(bool(ing.get('pantry_check')))}, {q(bool(ing.get('optional')))}, {i+1}
from public.dish d, public.ingredient i where d.slug={q(x['slug'])} and i.name={q(ing['name'])};""")
    if m:
        for c in m['components']:
            sql.append(f"""insert into public.meal_dish (meal_id,dish_id,role,service_order)
select m.id, d.id, {q(c['role'])}::dish_role, {q(c.get('service_order') or 0)} from public.meal m, public.dish d where m.slug={q(m['slug'])} and d.slug={q(c['dish_slug'])};""")
    for c in d['cooks']:
        if c['owner'] == 'meal':
            sel = f"select m.id, null::uuid" ; frm = f"from public.meal m where m.slug={q(m['slug'])}"
        else:
            sel = f"select null::uuid, d.id"; frm = f"from public.dish d where d.slug={q(c['dish_slug'])}"
        rep = f"{q(c.get('repeat'))}::repeat_verdict" if c.get('repeat') else 'null'
        sql.append(f"""insert into public.cook (meal_id,dish_id,cooked_on,rating,execution_rating,repeat,cook_notes,deviations,parameter_confirmations,household_split,wine_outcome)
{sel}, {q(c['cooked_on'])}::date, {q(c.get('rating'))}, {q(c.get('execution_rating'))}, {rep}, {q(c.get('cook_notes'))}, {qj(c.get('deviations') or [])}, {qj(c.get('parameter_confirmations') or [])}, {q(c.get('household_split'))}, {q(c.get('wine_outcome'))} {frm};""")
    batches.append((key, "\n".join(sql)))

os.makedirs(os.path.join(OUT,'sql'), exist_ok=True)
for i,(k,s) in enumerate(batches):
    p = os.path.join(OUT,'sql',f"{i:02d}_{k}.sql"); open(p,'w').write(s)
    print(f"{p}  {len(s)} bytes")
