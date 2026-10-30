// ---------------------------------------------------------------- print (cooking sheet rendered from the database)
// PRINT SPEC 1.2 (2026-10-30; 1.0 and 1.1 the same day; 1.2 matches print protocol v1.2, whose change is to authoring rules, not to the code). Every printed cooking sheet and dish sheet is built here, so every print follows one method.
// The written spec is the print protocol in jins-cooking-governance (recipe_output_print_protocol.md). Change the two
// together, then open #/printcheck and confirm the totals and that no flags appear.
const PF={full:false,shop:false};
const PRINT={
  spec:'print spec 1.2',
  // meal workflow: planning and verification sections stay in the database and off the cooking sheet
  wfDrop:/^(?:the\s+)?menu\b|^failure\s+priorit|^heat\b|^oven\s+sequenc|^parallel\b|^(?:final\s+)?plating\s+window|^timeline\s+verification|^arithmetic\s+check|^meal\s+balance|^sourcing\s+notes?|^register\b|^nutrition|^flavou?r\s+architecture|^scaling/i,
  // dish: design-record sections; the overview and yield/timing are lifted into the dish header instead
  dishDrop:/^flavou?r\s+architecture|^nutrition|^scaling|^correction\s+to\s+the\s+superseded|^superseded\s+variant|^dish\s+overview|^overview$|^yield\b|^timing$/i,
  ingDup:/^ingredients?(?:\s+list)?$/i, // a method's own ingredient list, dropped when the ingredient table prints
  pageRoles:/^(main|soup)$/i            // these start a page; every other dish follows on when it fits whole
};
function stripSections(t,names){ // drop "## <name>" blocks (to the next ## heading) — kept for older callers
  if(!t) return '';
  const out=[]; let skip=false;
  for(const l of t.split('\n')){
    const m=l.match(/^##\s+(.*)/);
    if(m){skip=names.some(n=>m[1].trim().toLowerCase().startsWith(n));}
    if(!skip) out.push(l);
  }
  return out.join('\n');
}
function mdCut(t,re){ // remove "#… Title" blocks whose title matches re, to the next heading of the same or higher level
  const out=[], cut=[]; let lv=0, cur=null;
  for(const l of String(t||'').replace(/\r/g,'').split('\n')){
    const m=l.match(/^(#{1,6})\s+(.*)/);
    if(m){const n=m[1].length, ti=m[2].replace(/[*_`]/g,'').trim();
      if(lv&&n<=lv){lv=0;cur=null;}
      if(!lv&&re.test(ti)){lv=n;cur={title:ti,lines:[]};cut.push(cur);continue;}}
    if(lv){cur.lines.push(l);continue;}
    out.push(l);
  }
  return {text:out.join('\n'),cut};
}
const mdPlain=lines=>lines.map(l=>l.replace(/^\s*(?:[-*•]|\d+[.)])\s+/,'').replace(/\*\*|__|[*_`]/g,'').trim()).filter(Boolean);
const firstSentence=s=>{const m=String(s).match(/^.*?[.!?](?=\s+[A-Z0-9“"(]|$)/); return m?m[0]:String(s);};
const FRAC={'0.125':'⅛','0.25':'¼','0.33':'⅓','0.333':'⅓','0.5':'½','0.67':'⅔','0.667':'⅔','0.75':'¾'};
function fracQ(q){const w=Math.floor(q+1e-9), f=String(Math.round((q-w)*1000)/1000); if(f==='0') return String(w); return FRAC[f]?(w?String(w):'')+FRAC[f]:null;}
function printQty(di){ // "280 g", "¼ tsp", "2" — spaced units, spoon fractions, no "piece"
  if(di.qty==null) return di.qty_alt||di.unit||'';
  const q=+di.qty, u=di.unit||'', counted=/^(tsp|tbsp|cups?|pieces?|whole|)$/.test(u);
  const n=(counted&&fracQ(q))||String(Math.round(q*100)/100);
  return (!u||/^(pieces?|whole)$/.test(u))?n:n+' '+u;
}
function printAlt(di,main){const a=String(di.qty_alt||'').trim(); if(di.qty==null||!a) return ''; const k=s=>s.replace(/\s+/g,'').toLowerCase(); return k(a)===k(main)?'':a;}
const pUnits=s=>String(s||'').replace(/(\d)(g|kg|ml|l)\b/g,'$1 $2').replace(/(\d(?:\.\d+)?)\s+pieces?\b/g,'$1');
function storedPdf(o){return (o.docs||[]).filter(x=>x.kind==='pdf'&&x.is_latest).sort((p,q)=>q.version-p.version)[0]||null;}
function pdfIsCurrent(kind,o,pdf){ // a stored PDF counts only while nothing it covers has been edited since it was generated
  const upd=[o.updated_at,...(kind==='meal'?o.dishes.map(x=>x.dish.updated_at):[])].filter(Boolean).map(t=>+new Date(t));
  return !upd.length||+new Date(pdf.generated_at)>=Math.max(...upd);
}
function printBtn(kind,o,cls='btn ghost sm',label='Print'){ // always the live sheet; a stored PDF is a secondary link on the print page
  return `<a class="${cls}" href="#/print/${kind}/${o.slug}">${label}</a>`;
}
const fmtQ=(q,u)=>(Math.round(q*100)/100)+(/^(g|ml|kg|l)$/.test(u||'')?'':' ')+(u||'');
function hhmm(min){min=((min%1440)+1440)%1440; return String(Math.floor(min/60)).padStart(2,'0')+':'+String(min%60).padStart(2,'0');}
function clockOf(cell,svc){ // "T−75" → 16:45 for an 18:00 service; "T−57 to T−50" → 17:03–17:10; "T−1:15" → 16:45; "T−24 hr" → 18:00 −1 day; E+ / P+ rows and day labels stay blank
  const t=String(cell).replace(/\([^)]*\)/g,'').replace(/[*_]/g,'').trim();
  if(!/^T(?![a-z])/.test(t)) return '';
  const vs=[...t.matchAll(/\bT\s*([−–+-])\s*(\d+(?:\.\d+|:\d{2})?(?:\s*(?:hr|h|hours?)\b(?:\s*\d+\s*(?:min|m)\b)?|\s*(?:min|m)\b)?)/gi)] // hours and h:mm read as cook mode reads them (parseTm)
    .map(m=>{const v=/\./.test(m[2])?Math.round(+m[2]):parseTm('T-'+m[2]); return v==null?null:svc+(m[1]==='+'?1:-1)*v;}).filter(v=>v!=null);
  if(!vs.length) return /^T\s*$/.test(t)?hhmm(svc):'';
  const day=vs[0]<0?' −1 day':'';
  return (vs.length>1?hhmm(vs[0])+'–'+hhmm(vs[vs.length-1]):hhmm(vs[0]))+day;
}
function sheetPost(html,o){ // DOM pass over rendered markdown: T-minus tables get a tick box and a clock column; CCP tables lose the Outcome column
  const tp=document.createElement('template'); tp.innerHTML=html;
  tp.content.querySelectorAll('td,th').forEach(c=>{if(c.innerHTML.includes('**')) c.innerHTML=c.innerHTML.replace(/\*\*([^*]+?)\*\*/g,'<b>$1</b>');}); // tables stored as raw HTML skip markdown
  tp.content.querySelectorAll('tr').forEach(r=>{const k=((r.cells[0]||{}).textContent||'').trim().toLowerCase(); if(/^(critical|major|minor)$/.test(k)) r.classList.add('c-'+k);});
  tp.content.querySelectorAll('table').forEach(tb=>{
    const rows=[...tb.rows]; if(!rows.length) return;
    const head=[...rows[0].cells].map(c=>c.textContent.trim());
    if(o.ccp){const i=head.findIndex(h=>/^outcome$/i.test(h)); if(i>=0&&head.some(h=>/^(class|severity)$/i.test(h))) rows.forEach(r=>{if(r.cells[i]) r.deleteCell(i);});}
    if(o.svc!=null&&rows.filter(r=>/^\s*T\s*[−–-]\s*\d/.test((r.cells[0]||{}).textContent||'')).length>=3){
      tb.classList.remove('t2'); tb.classList.add('tmin');
      rows.forEach(r=>{const th=r.cells[0].tagName==='TH';
        const ck=document.createElement(th?'th':'td'); ck.className='ck'; if(!th) ck.innerHTML='<span class="tick"></span>'; r.insertBefore(ck,r.cells[0]);
        const c=document.createElement(th?'th':'td'); c.className='clk'; c.textContent=th?'Clock':clockOf(r.cells[1].textContent,o.svc); r.insertBefore(c,r.cells[2]||null);});
    }
  });
  return tp.innerHTML;
}
const svcMin=t=>{const [h,m]=String(t||'18:00').split(':').map(Number); return (h||0)*60+(m||0);};
function sheetShop(dishes,m){ // shopping list (its own page): tick · ingredient with its buying spec · what to buy · used in; pantry checks on one line
  const items=aggregate(dishes); if(!items.length) return '';
  const multi=dishes.length>1, buy=items.filter(i=>!i.pantry), pantry=items.filter(i=>i.pantry), cols=multi?4:3;
  const deptOf=i=>DEPT_ORDER.includes(i.dept)?i.dept:'Other';
  const row=e=>`<tr><td class="ck"><span class="tick"></span></td><td>${esc(e.label)}${e.optional?' <span class="meta">(optional)</span>':''}${e.spec||e.avoid?`<br><span class="meta">${buyHtml(e.spec,e.avoid)}</span>`:''}</td><td>${esc(pUnits(e.buyQty||e.qty))}${e.extraNote?` <span class="meta">${esc(e.extraNote)}</span>`:''}</td>${multi?`<td><span class="meta">${esc(pUnits(e.attr||''))}</span></td>`:''}</tr>`;
  const rows=[...DEPT_ORDER,'Other'].filter(dp=>buy.some(i=>deptOf(i)===dp)).map(dp=>`<tr><td class="dept" colspan="${cols}">${esc(dp)}</td></tr>`+buy.filter(i=>deptOf(i)===dp).map(row).join('')).join('');
  return `<h2>Shopping list</h2>${m?shopNotesHtml(m):''}${rows?`<table class="shop shop2${multi?'':' one'}"><thead><tr><th class="ck"></th><th>Ingredient</th><th>Buy</th>${multi?'<th>Used in</th>':''}</tr></thead><tbody>${rows}</tbody></table>`:''}`
    +(pantry.length?`<p class="pantry"><b>Pantry check</b> — ${pantry.map(e=>esc(e.label)+' '+esc(pUnits(e.qty))).join(' · ')}</p>`:'');
}
// designed parameters still open: a dish-level cook row with verdict 'confirmed' closes one (same rule as the open_validations view)
const openValOf=d=>(d.designed_unvalidated||[]).filter(p=>!(d.cooks||[]).some(c=>(c.parameter_confirmations||[]).some(pc=>pc.param===p.param&&pc.verdict==='confirmed')));
function sheetMeasure(ds){ // what to observe and write down for the cook log: one table per sheet, grouped by dish
  const all=ds.map(d=>({d,ps:openValOf(d)})).filter(g=>g.ps.length); if(!all.length) return '';
  const isM=p=>!!(p&&p.measure===true), flagged=all.some(g=>g.ps.some(isM)); // readings the recipe marks measure: true lead (print protocol 3.3)
  const groups=flagged?all.map(g=>({d:g.d,ps:g.ps.filter(isM)})).filter(g=>g.ps.length):all;
  const rest=flagged?all.reduce((n,g)=>n+g.ps.filter(p=>!isM(p)).length,0):0;
  const tick='<td class="ck"><span class="tick"></span></td>';
  return `<h3>Measure on the day</h3><table class="meas"><thead><tr><th class="ck"></th><th>Designed value to check</th><th>Observed</th></tr></thead><tbody>${groups.map(g=>(ds.length>1?`<tr><td class="dept" colspan="3">${esc(g.d.name)}</td></tr>`:'')+g.ps.map(p=>`<tr>${tick}<td><b>${esc(p.param)}</b>${p.designed_value?' — '+esc(p.designed_value):''}</td><td></td></tr>`).join('')).join('')}</tbody></table>${rest?`<p class="meta">${rest} other open check${rest>1?'s':''}: see Log the cook in the app.</p>`:''}`;
}
function sheetIngs(d){
  if(!d.ings.length) return '';
  return `<h3>Ingredients</h3><table class="ingt"><thead><tr><th>Ingredient</th><th>Amount</th></tr></thead><tbody>${d.ings.map(di=>{const a=printQty(di), alt=printAlt(di,a);
    return `<tr><td>${esc(ingName(di))}${di.buy_spec||di.buy_avoid?` <span class="meta">· ${buyHtml(di.buy_spec,di.buy_avoid)}</span>`:''}${di.prep_note?` <span class="meta">— ${esc(di.prep_note)}</span>`:''}${di.optional?' <span class="meta">(optional)</span>':''}</td><td>${esc(a)}${alt?` <span class="meta">(${esc(alt)})</span>`:''}</td></tr>`;}).join('')}</tbody></table>`;
}
function sheetDish(d,role,first,measure){
  const cls='dish'+(first?'':(PF.full||PRINT.pageRoles.test(role||''))?' pg':' side keep');
  if(PF.full){ // full record: every section as stored
    return `<section class="${cls}"><h2>${esc(d.name)}</h2>
    <div class="meta">${esc([role,d.servings?'serves '+num(d.servings):null,(d.equipment||[]).length?d.equipment.join(', '):null].filter(Boolean).join(' · '))}</div>
    ${sheetIngs(d)}
    ${d.method_md?`<div class="md">${md(d.method_md)}</div>`:'<p class="meta">No recipe text stored for this dish.</p>'}
    ${openValOf(d).length?`<h3>Designed — not yet validated</h3><ul>${openValOf(d).map(p=>`<li><b>${esc(p.param)}</b>${p.designed_value?' — '+esc(p.designed_value):''}${p.note?` <span class="meta">${esc(p.note)}</span>`:''}</li>`).join('')}</ul>`:''}
  </section>`;
  }
  let {text,cut}=mdCut(d.method_md,PRINT.dishDrop);
  if(d.ings.length) text=mdCut(text,PRINT.ingDup).text;
  const take=re=>mdPlain(cut.filter(c=>re.test(c.title)).flatMap(c=>c.lines));
  const ov=take(/overview/i).join(' '), tm=take(/^yield|^timing$/i).join(' · ');
  const meta=[role,!tm&&d.servings?'serves '+num(d.servings):null,(d.equipment||[]).length?d.equipment.join(', '):null].filter(Boolean).join(' · ');
  return `<section class="${cls}"><h2>${esc(d.name)}</h2>
    ${tm?`<p class="dsub">${esc(tm)}</p>`:''}${meta?`<div class="meta">${esc(meta)}</div>`:''}
    ${ov?`<p class="ov">${esc(firstSentence(ov))}</p>`:''}
    ${sheetIngs(d)}
    ${text.trim()?`<div class="md">${sheetPost(md(text),{ccp:true})}</div>`:'<p class="meta">No recipe text stored for this dish.</p>'}
    ${measure?sheetMeasure([d]):''}
  </section>`;
}
function sheetBody(kind,owner){ // the inside of .sheet: used by the print view and by #/printcheck, so both measure the same thing
  const long=d=>new Date(d).toLocaleDateString('en-GB',{day:'numeric',month:'long',year:'numeric'});
  const ds=kind==='meal'?owner.dishes.map(x=>({d:x.dish,role:x.role})):[{d:owner,role:(owner.category||[]).join('/')}];
  const shop=kind==='meal'&&(PF.shop||PF.full)?sheetShop(ds.map(x=>x.d),owner):'';
  const wf=owner.workflow_md?(PF.full?owner.workflow_md:mdCut(owner.workflow_md,PRINT.wfDrop).text):'';
  const cover=kind==='meal'?`<section class="cover${shop?' pg':''}"><h1>${esc(owner.name)}</h1><p class="sub">${esc([owner.last?long(owner.last+'T00:00:00'):null,owner.pax?owner.pax+' pax':null,'service '+(owner.service_time||'18:00').slice(0,5)].filter(Boolean).join(' · '))}</p>
      ${owner.wine_pairing?`<p><b>Wine</b> ${esc(owner.wine_pairing)}</p>`:''}
      <h3>Menu</h3><ul>${ds.map(x=>`<li><b>${esc(x.d.name)}</b> <span class="meta">${esc(x.role)}</span></li>`).join('')}</ul>
      ${owner.shared_prep_md?`<h3>Shared prep</h3><div class="md">${md(owner.shared_prep_md)}</div>`:''}
      ${wf.trim()?`<div class="pb"><h2>Meal workflow</h2><div class="md">${sheetPost(md(wf),{svc:svcMin(owner.service_time),ccp:!PF.full})}</div></div>`:''}</section>`:'';
  const head=shop?`<section class="shopsec"><h1>${esc(owner.name)}</h1>${shop}</section>`:'';
  const dishes=ds.map((x,i)=>sheetDish(x.d,x.role,kind==='dish'&&i===0,kind==='dish')).join('');
  const meas=kind==='meal'&&!PF.full?sheetMeasure(ds.map(x=>x.d)):'';
  if(!meas) return head+cover+dishes;
  // one checklist per meal, placed where it costs less paper: at the end of the cover (beside the timeline) or after the last dish
  const a=head+cover.replace(/<\/section>$/,`<div class="measure">${meas}</div></section>`)+dishes, b=head+cover+dishes+`<section class="measure">${meas}</section>`;
  const cost=h=>{const p=pageMap(h); return p.n*100+p.fill.filter(f=>f<15).length;}; // fewer pages first, then fewer near-empty pages; a tie keeps it by the timeline
  return cost(a)<=cost(b)?a:b;
}
routes.print=(kind,slug)=>{
  const owner=kind==='meal'?IDX.mealBySlug[slug]:IDX.dishBySlug[slug]; if(!owner)return notFound(kind==='meal'?'Meal':'Dish','#/library');
  setHeader('Print',kind==='meal'?'#/meal/'+slug:'#/dish/'+slug); tabs(kind==='meal'?'meals':'library');
  const long=d=>new Date(d).toLocaleDateString('en-GB',{day:'numeric',month:'long',year:'numeric'});
  const css=t=>String(t).replace(/[\\"]/g,'\\$&').replace(/[\n\r]/g,' ');
  const hf='font-family:Arial,Helvetica,sans-serif;vertical-align:bottom;padding-bottom:1.5mm;margin-bottom:3mm;border-bottom:.5pt solid #B9D3DC;';
  const when=kind==='meal'&&owner.last?' · '+long(owner.last+'T00:00:00'):'';
  // running header and footer (Chrome 131+; older browsers print the same pages without them)
  const page=`<style>@page{margin:21mm 19mm 17mm;
    @top-left{content:"${css(owner.name+when)}";${hf}font-size:8pt;font-weight:700;color:#1B5E7B}
    @top-right{content:"Page " counter(page);${hf}font-size:7.5pt;color:#999}
    @bottom-right{content:"Generated ${long(Date.now())} · jins-kitchen · ${PRINT.spec}";font-family:Arial,Helvetica,sans-serif;font-size:7pt;color:#999;vertical-align:top;padding-top:2mm}}</style>`;
  const body=sheetBody(kind,owner), stg=document.getElementById('pcstage'); if(stg) stg.innerHTML='';
  const pdf=storedPdf(owner);
  const btns=[`<button class="btn sm" onclick="window.print()">Print / save PDF</button>`,
    kind==='meal'&&!PF.full?`<button class="btn ghost sm" onclick="PF.shop=!PF.shop;render()">${PF.shop?'Remove shopping list':'Add shopping list'}</button>`:'',
    `<button class="btn ghost sm" onclick="PF.full=!PF.full;render()">${PF.full?'Cooking sheet':'Full record'}</button>`,
    pdf?`<a class="btn ghost sm" href="${DOCS_BASE+pdf.storage_path}" target="_blank" rel="noopener">Stored PDF v${pdf.version}</a>`:''].filter(Boolean).join('');
  const note=PF.full?'Full record: every stored section, one dish per page, with the shopping list.'
    :`Cooking sheet (${PRINT.spec}): flavour architecture, nutrition, scaling notes and the workflow's planning and check sections are left out. Mains start a page; shorter dishes follow on.${kind==='meal'?(PF.shop?' The shopping list prints first, on its own page.':' Shopping list off: add it here, or shop from the phone list.'):''}`;
  return `<div class="stack" style="padding-top:12px">${page}
    <div class="btnrow noprint">${btns}</div>
    <p class="muted small noprint">${note}${pdf?` A stored PDF from ${fmtDate(pdf.generated_at.slice(0,10))} is also on file${pdfIsCurrent(kind,owner,pdf)?'.':'; the record has been edited since it was made.'}`:''}</p>
    <div class="sheet">${body}</div>
  </div>`;
};
// paging engine (shared by the print view and #/printcheck): a sheet rendered off-screen with the print stylesheet and paged
// as A4 by Chrome's own page-breaking — multi-column layout, one column = one 172 × 259 mm page (A4 inside the @page margins)
const PGEO={mm:96/25.4,w:172,h:259,gap:14};
function pageMap(inner){
  let st=document.getElementById('pcstyle');
  if(!st){const rules=[];
    for(const sh of document.styleSheets){let rs; try{rs=sh.cssRules}catch(e){continue}
      for(const r of rs) if(r instanceof CSSMediaRule&&/print/.test(r.media.mediaText)) for(const ir of r.cssRules) if(/\.sheet/.test(ir.selectorText||'')) rules.push(ir.selectorText.split(',').map(x=>'#pcstage '+x.trim()).join(',')+'{'+ir.style.cssText+'}');}
    st=document.createElement('style'); st.id='pcstyle';
    st.textContent=rules.join('\n')+`\n#pcstage .sheet{box-sizing:content-box;width:${PGEO.w}mm;height:${PGEO.h}mm;column-width:${PGEO.w}mm;column-gap:${PGEO.gap}mm;column-fill:auto;overflow:visible;padding:0;border:0;border-radius:0} #pcstage .sheet .pg{break-before:column}`;
    document.head.appendChild(st);}
  let stage=document.getElementById('pcstage');
  if(!stage){stage=document.createElement('div'); stage.id='pcstage'; stage.setAttribute('aria-hidden','true'); stage.style.cssText='position:absolute;left:-30000px;top:0;width:400mm;visibility:hidden'; document.body.appendChild(stage);}
  stage.innerHTML=`<div class="sheet">${inner}</div>`;
  const sh=stage.firstElementChild, R=sh.getBoundingClientRect(), W=PGEO.w*PGEO.mm, G=PGEO.gap*PGEO.mm, H=PGEO.h*PGEO.mm, pages={};
  for(const e of sh.querySelectorAll('*')) for(const r of e.getClientRects()){if(!r.width&&!r.height) continue; const p=Math.floor((r.left-R.left+1)/(W+G)); pages[p]=Math.max(pages[p]||0,r.bottom-R.top);}
  const n=Math.max(0,...Object.keys(pages).map(Number))+1;
  return {n,fill:[...Array(n)].map((_,i)=>Math.round((pages[i]||0)/H*100)),sh,R,W,G};
}
// print check: every meal's cooking sheet through the paging engine, with the spec's flags. Run after any change to this code.
routes.printcheck=()=>{
  setHeader('Print check','#/more'); tabs('more');
  setTimeout(()=>{try{printCheck();}catch(e){const o=document.getElementById('pcout'); if(o) o.textContent='Print check failed: '+e.message;}},30);
  return `<div class="stack" style="padding-top:12px"><p class="muted small">Every meal's cooking sheet, paged as A4 with the print stylesheet (${esc(PRINT.spec)}). Flags: a page under 15% full · a main not starting a page · a design-only section printed · markdown left in the text · a table wider than the page.</p>
    <div id="pcout"><span class="spin"></span> Measuring…</div></div>`;
};
function printCheck(){
  const out=document.getElementById('pcout'); if(!out) return;
  const res=[], keep=[PF.full,PF.shop]; PF.full=false; PF.shop=false;
  try{
    for(const m of DB.meal){
      const {n,fill,sh,R,W}=pageMap(sheetBody('meal',m)), flags=[];
      fill.forEach((f,i)=>{if(f<15) flags.push('page '+(i+1)+' is '+f+'% full');});
      sh.querySelectorAll('section.dish.pg').forEach(s=>{const r=s.getClientRects()[0]; if(r&&r.top-R.top>2) flags.push('main mid-page: '+s.querySelector('h2').textContent);});
      sh.querySelectorAll('h2,h3,h4').forEach(h=>{const t=h.textContent.trim(); if((h.closest('.pb')&&PRINT.wfDrop.test(t))||/^(scaling|flavou?r\s+architecture|nutrition)/i.test(t)) flags.push('printed: '+t);});
      if(/\*\*|^#{1,4}\s|\|\s*-{3}/m.test(sh.textContent)) flags.push('markdown in text');
      sh.querySelectorAll('table').forEach(t=>{if([...t.rows].some(r=>r.getBoundingClientRect().width>W+2)) flags.push('table wider than the page');});
      res.push({m,n,low:fill.filter(f=>f<40).length,flags});
    }
  } finally {[PF.full,PF.shop]=keep; const st=document.getElementById('pcstage'); if(st) st.innerHTML='';}
  const tot=res.reduce((a,r)=>a+r.n,0), low=res.reduce((a,r)=>a+r.low,0), fl=res.reduce((a,r)=>a+r.flags.length,0);
  out.innerHTML=`<p><b>${res.length} meals · ${tot} pages · ${low} pages under 40% full · ${fl} flag${fl===1?'':'s'}</b></p>
    <div class="md"><table><thead><tr><th>Meal</th><th>Pages</th><th>Under 40%</th><th>Flags</th></tr></thead><tbody>${res.map(r=>`<tr><td><a href="#/print/meal/${r.m.slug}">${esc(r.m.name)}</a></td><td>${r.n}</td><td>${r.low}</td><td>${esc(r.flags.join('; '))||'—'}</td></tr>`).join('')}</tbody></table></div>`;
}

