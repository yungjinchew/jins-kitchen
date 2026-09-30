import json, glob, os
OUT=os.path.dirname(os.path.abspath(__file__))
DOCS="/mnt/user-data/uploads/Claude Cowork Playground/Cooking/jins-kitchen/site/docs"
PDF=os.path.join(OUT,'pdf')
data={json.load(open(f))['assignment_key']:json.load(open(f)) for f in sorted(glob.glob(OUT+'/out/*.json'))}

# decisions
KEEP_METHOD={'aegean-roasted-salmon','aegean-roasted-broccolini','aegean-pearl-barley','aegean-cucumber-tomato-salad',
 'maafe-chicken-peanut-stew','maafe-steamed-rice','maafe-tomato-cucumber-lime-salad','maafe-birds-eye-chilli-paste','maafe-crushed-roasted-peanuts','maafe-chilled-pineapple-lime-flaky-salt',
 'maiale-al-latte','maiale-creamy-cannellini-beans','maiale-charred-broccolini-lemon-zest',
 'chicken-stew-white-wine-wings-gremolata','chicken-stew-orange-olive-oil-cake'}
KEEP_WORKFLOW={'aegean-salmon-dinner','west-african-peanut-stew-dinner'}
RENAME={'ribeye-yogurt-mustard-cream':'Horseradish Cream (cooked as yogurt–mustard stand-in)'}
DEPT_OVR={'cider vinegar':'Oils & Liquids','duck fat':'Oils & Liquids','sake':'Alcohol','mirin':'Alcohol','medium-dry cider':'Alcohol',
 'rendered pork fat, reserved':'Oils & Liquids','beef drippings':'Oils & Liquids','white miso (shiro)':'Pantry','mayonnaise':'Pantry','ketchup':'Pantry'}
PROTEIN_OVR={'white-bean-turkey-spinach-soup':'Turkey'}

def q(v):
    if v is None: return 'null'
    if isinstance(v,bool): return 'true' if v else 'false'
    if isinstance(v,(int,float)): return repr(v)
    if isinstance(v,list): return "array["+",".join(q(x) for x in v)+"]::text[]" if v else "'{}'::text[]"
    s=str(v); tag='$m$'
    while tag in s: tag=tag[:-1]+'x$'
    return f"{tag}{s}{tag}"
def qj(v): return q(json.dumps(v,ensure_ascii=False))+"::jsonb" if v is not None else 'null'

ing={}
for d in data.values():
    for x in d['dishes']:
        for i in x['ingredients']:
            n=i['name'].strip().lower(); i['name']=n
            ing.setdefault(n,(DEPT_OVR.get(n,i['department']),bool(i.get('pantry_check'))))
batches=[("00_ingredients","insert into public.ingredient (name, department, pantry_default) values\n"+",\n".join(f"({q(n)},{q(dp)},false)" for n,(dp,pc) in sorted(ing.items()))+"\non conflict (name) do nothing;")]

for key,d in data.items():
    sql=["begin;"]; m=d.get('meal')
    if m:
        if any(x['existing'] for x in d['dishes']) and key not in ('tomahawk','little-joe-ribeye'):
            # existing meal: fill workflow/shared prep where empty
            if m['slug'] not in KEEP_WORKFLOW:
                sql.append(f"update public.meal set workflow_md={q(m.get('workflow_md'))}, shared_prep_md=coalesce(nullif(shared_prep_md,''),{q(m.get('shared_prep_md'))}) where slug={q(m['slug'])};")
            else:
                sql.append(f"update public.meal set shared_prep_md=coalesce(nullif(shared_prep_md,''),{q(m.get('shared_prep_md'))}) where slug={q(m['slug'])};")
        else:
            sql.append(f"insert into public.meal (slug,name,planned_date,status,pax,workflow_md,shared_prep_md,wine_pairing) values ({q(m['slug'])},{q(m['name'])},{q(m.get('planned_date'))},{q(m['status'])}::meal_status,{q(m.get('pax') or 3)},{q(m.get('workflow_md'))},{q(m.get('shared_prep_md'))},{q(m.get('wine_pairing'))});")
    for x in d['dishes']:
        s=x['slug']; prot=PROTEIN_OVR.get(s,x.get('protein'))
        if x['existing']:
            if s in KEEP_METHOD: continue
            name_sql=f", name={q(RENAME[s])}" if s in RENAME else ""
            sql.append(f"update public.dish set method_md={q(x['method_md'])}, summary=coalesce(nullif(summary,''),{q(x.get('summary'))}), servings=coalesce(servings,{q(x.get('servings'))}), equipment=case when coalesce(array_length(equipment,1),0)=0 then {q(x.get('equipment') or [])} else equipment end, designed_unvalidated=case when coalesce(jsonb_array_length(designed_unvalidated),0)=0 then {qj(x.get('designed_unvalidated') or [])} else designed_unvalidated end, source=coalesce(nullif(source,''),{q(x.get('source'))}), governance_version=coalesce(governance_version,{q(x.get('governance_version'))}), protein=coalesce(protein,{q(prot)}), category=case when coalesce(array_length(category,1),0)=0 then {q(x.get('category') or [])} else category end, difficulty=coalesce(difficulty,{q(x.get('difficulty'))}){name_sql} where slug={q(s)};")
            sql.append(f"delete from public.dish_ingredient where dish_id=(select id from public.dish where slug={q(s)});")
        else:
            sql.append(f"insert into public.dish (slug,name,protein,category,cuisine,difficulty,tags,occasion,status,source,governance_version,summary,method_md,servings,equipment,designed_unvalidated,nutrition_estimate) values ({q(s)},{q(x['name'])},{q(prot)},{q(x.get('category') or [])},{q(x.get('cuisine') or [])},{q(x.get('difficulty'))},{q(x.get('tags') or [])},{q(x.get('occasion') or [])},{q(x['status'])}::dish_status,{q(x.get('source'))},{q(x.get('governance_version'))},{q(x.get('summary'))},{q(x['method_md'])},{q(x.get('servings'))},{q(x.get('equipment') or [])},{qj(x.get('designed_unvalidated') or [])},{qj(x.get('nutrition_estimate'))});")
        for i,g in enumerate(x['ingredients']):
            sql.append(f"insert into public.dish_ingredient (dish_id,ingredient_id,qty,unit,qty_alt,prep_note,pantry_check,optional,sort_order) select d.id,i.id,{q(g.get('qty'))},{q(g.get('unit'))},{q(g.get('qty_alt'))},{q(g.get('prep_note'))},{q(bool(g.get('pantry_check')))},{q(bool(g.get('optional')))},{i+1} from public.dish d, public.ingredient i where d.slug={q(s)} and i.name={q(g['name'])};")
    if m:
        for c in m['components']:
            sql.append(f"insert into public.meal_dish (meal_id,dish_id,role,service_order) select m.id,d.id,{q(c['role'])}::dish_role,{q(c.get('service_order') or 0)} from public.meal m, public.dish d where m.slug={q(m['slug'])} and d.slug={q(c['dish_slug'])} and not exists (select 1 from public.meal_dish x where x.meal_id=m.id and x.dish_id=d.id);")
    # documents
    src=d['source_file']; folder=src.split('/')[1]; fname=os.path.basename(src)
    owner=('meal',m['slug']) if m else ('dish',d['dishes'][0]['slug'])
    osel=f"(select id from public.{owner[0]} where slug={q(owner[1])})"
    files=[(src,fname)]
    stem,ext=os.path.splitext(fname)
    if ext=='.docx' and os.path.exists(os.path.join(PDF,stem+'.pdf')): files.append((f"docs/{folder}/v1/{stem}.pdf",stem+'.pdf'))
    if key=='chicken-stew': files.append((f"docs/{folder}/v1/{stem}.html",stem+'.html'))
    for path,fn in files:
        kind=os.path.splitext(fn)[1][1:]
        local=os.path.join(PDF,fn) if kind=='pdf' else os.path.join(DOCS,path.split('/',1)[1])
        b=os.path.getsize(local)
        sql.append(f"insert into public.document (owner_type,owner_id,kind,version,governance_version,storage_path,file_name,bytes,is_latest) values ({q(owner[0])}::owner_type,{osel},{q(kind)}::doc_kind,1,null,{q(path)},{q(fn)},{b},true);")
    sql.append("commit;")
    batches.append((key,"\n".join(sql)))
    os.makedirs(OUT+"/sqljson",exist_ok=True)
    if key!="aegean-salmon": json.dump([x for x in sql if x not in ("begin;","commit;")],open(f"{OUT}/sqljson/{key}.json","w"),ensure_ascii=False)
os.makedirs(OUT+'/sql',exist_ok=True)
for i,(k,s) in enumerate(batches):
    p=f"{OUT}/sql/{i:02d}_{k}.sql"; open(p,'w').write(s); print(p,len(s))
