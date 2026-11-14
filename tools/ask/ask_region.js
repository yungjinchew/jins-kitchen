// ---------------------------------------------------------------- ask Claude about one meal or dish
// ASK 1.0 (2026-11-14). Stage 1: questions only. The page talks to the kitchen-assistant Edge Function, which reads the
// recipe, its cook history, the governance files and the cellar, and cannot save anything. A device has to be paired
// once: the phone makes a random key (kept in localStorage, never shown), the function stores only its SHA-256 and
// answers with a 6-character code that Jin sends to Claude in a chat to approve. Answers are drawn through askMd, which
// escapes everything first, so nothing the model writes can run as page code. Applied by tools/ask/apply_ask.py.
const ASK={S:{},draft:{},busy:{},dev:{st:'unknown',code:null},cur:null};
const ASK_URL=SB_URL+'/functions/v1/kitchen-assistant';
function askKey(make){ let k=null; try{k=localStorage.getItem('kitchen:ask:key');}catch(e){}
  if(!k&&make){ k=[...crypto.getRandomValues(new Uint8Array(32))].map(b=>b.toString(16).padStart(2,'0')).join(''); try{localStorage.setItem('kitchen:ask:key',k);}catch(e){} }
  return k; }
const askCall=body=>fetch(ASK_URL,{method:'POST',headers:{'Content-Type':'application/json',apikey:SB_KEY,'x-device-key':askKey(true)},body:JSON.stringify(body)});
const askS=k=>ASK.S[k]||(ASK.S[k]={st:'load',msgs:[],info:null,err:null,fresh:false,at:0});
function askMd(s){ // a small, safe markdown: escape first, then bold, italic, code, headings and lists
  const inl=t=>esc(t).replace(/`([^`]+)`/g,'<code>$1</code>').replace(/\*\*([^*]+)\*\*/g,'<b>$1</b>').replace(/(^|[\s(])\*([^*\s][^*]*)\*(?=[\s).,;:!?]|$)/g,'$1<i>$2</i>');
  let h='', list=null, para=[];
  const fp=()=>{ if(para.length){ h+='<p>'+para.map(inl).join('<br>')+'</p>'; para=[]; } }, fl=()=>{ if(list){ h+='</'+list+'>'; list=null; } };
  for(const raw of String(s||'').replace(/\r/g,'').split('\n')){ const l=raw.trimEnd(); let m;
    if(!l.trim()){ fp(); fl(); continue; }
    if((m=l.match(/^\s*#{1,4}\s+(.*)$/))){ fp(); fl(); h+='<h4>'+inl(m[1])+'</h4>'; continue; }
    if((m=l.match(/^\s*[-*•]\s+(.*)$/))){ fp(); if(list!=='ul'){ fl(); h+='<ul>'; list='ul'; } h+='<li>'+inl(m[1])+'</li>'; continue; }
    if((m=l.match(/^\s*(\d{1,3})[.)]\s+(.*)$/))){ fp(); if(list!=='ol'){ fl(); h+='<ol start="'+m[1]+'">'; list='ol'; } h+='<li>'+inl(m[2])+'</li>'; continue; }
    if(/^\s*\|.*\|\s*$/.test(l)){ if(/^\s*\|[\s:|-]+\|\s*$/.test(l)) continue; fl(); para.push(l.replace(/^\s*\||\|\s*$/g,'').split('|').map(x=>x.trim()).join(' · ')); continue; }
    fl(); para.push(l.trim()); }
  fp(); fl(); return h; }
function askBox(kind,slug){ return `<section class="glass ask"><div class="eyebrow">Ask Claude</div><p class="askp">Timing, scaling, substitutions, what to prep ahead: answered from this recipe, its cook history and your kitchen rules.</p><a class="btn ghost" href="#/ask/${kind}/${slug}">Ask about this ${kind}</a></section>`; }
const ASK_STARTERS={meal:['What can I prep the day before?','Where is this most likely to go wrong?','Scale this to 5 people'],dish:['What can I prep ahead?','Where is this most likely to go wrong?','What should I taste for at the end?']};
const askDots='<span class="askdots" aria-hidden="true"><i></i><i></i><i></i></span>';
function askMsgHtml(m){
  if(m.role==='user') return `<div class="askm u"><div class="askb">${esc(m.content).replace(/\n/g,'<br>')}</div></div>`;
  const tl=(m.tools||[]).filter(t=>t&&t.label).map(t=>`<span>${esc(t.label)}</span>`).join('');
  const wait=m.live&&!m.content?`<div class="askwait" role="status">${askDots}Reading the recipe…</div>`:'';
  return `<div class="askm a"${m.live?' id="asklive"':''}>${tl?`<div class="asktl">${tl}</div>`:''}${wait}<div class="askmd">${askMd(m.content)}</div>${m.note?`<p class="asknote">${esc(m.note)}</p>`:''}${m.status&&m.status!=='ok'&&m.error_detail?`<p class="askerr">${esc(m.error_detail)}</p>`:''}</div>`;
}
function askMsgsHtml(kind,slug){ const s=askS(kind+'/'+slug);
  if(!s.msgs.length) return `<div class="askchips">${ASK_STARTERS[kind].map(q=>`<button type="button" class="chip" onclick="askSend('${kind}','${slug}',this.textContent)">${esc(q)}</button>`).join('')}</div>`;
  return s.msgs.map(askMsgHtml).join(''); }
function askFootHtml(kind,slug){ const k=kind+'/'+slug, s=askS(k), i=s.info||{};
  const n=i.daily_limit?` ${i.used_today||0} of ${i.daily_limit} questions today.`:'';
  return `Reads this ${kind}, its cook history and your kitchen rules. It cannot change the recipe yet.${n}${s.msgs.length&&!ASK.busy[k]?` <button type="button" onclick="askNew('${kind}','${slug}')">New conversation</button>`:''}`; }
function askOff(s){ const i=s.info||{}; // why asking is off, if it is
  if(i.has_key===false) return 'Ask switches on when the Anthropic key is added in Supabase (Edge Functions, Secrets, ANTHROPIC_API_KEY).';
  if(i.spend_mode==='paused') return 'Ask is paused by the spend switch (claude_api). Tell Claude “claude_api back to normal” to switch it on.';
  if(i.daily_limit&&i.used_today>=i.daily_limit) return `That is ${i.daily_limit} questions in 24 hours, the daily cap. Try again later.`;
  if(i.monthly_usd_cap&&i.month_usd>=i.monthly_usd_cap) return `This month’s ceiling of US$${i.monthly_usd_cap} is reached. Ask Claude in a chat to raise it.`;
  return ''; }
function askBody(kind,slug){ const k=kind+'/'+slug, s=askS(k), d=ASK.dev;
  if(d.st==='unpaired'||d.st==='pending'||d.st==='revoked'||d.st==='pair_cap'){
    if(d.st==='pending'&&d.code) return `<div class="askpair"><p><b>Pair this device.</b> Send this code to Claude in any chat, for example “pair my kitchen app, code ${esc(d.code)}”.</p><div class="askcode" aria-label="Pairing code">${esc(d.code)}</div><p class="askfoot">The code lasts 24 hours. When Claude says the device is approved, tap Check.</p><button class="btn" onclick="askOpen('${kind}','${slug}',true)">Check</button>${d.msg?`<p class="askerr">${esc(d.msg)}</p>`:''}</div>`;
    if(d.st==='revoked') return `<div class="askpair"><p><b>This device was switched off.</b> Pair it again to ask.</p><button class="btn" onclick="askPair('${kind}','${slug}',true)">Pair this device again</button></div>`;
    if(d.st==='pair_cap') return `<div class="askpair"><p class="askerr">Too many pairing codes were asked for today. Tell Claude in a chat and try again.</p></div>`;
    return `<div class="askpair"><p><b>Pair this device.</b> Ask is locked to the phones and browsers you approve. It takes one code, once.</p><button class="btn" onclick="askPair('${kind}','${slug}')">Get a pairing code</button>${d.msg?`<p class="askerr">${esc(d.msg)}</p>`:''}</div>`;
  }
  if(s.st==='load') return `<div class="askwait" role="status">${askDots}Opening…</div>`;
  if(s.st==='error') return `<p class="askerr">${esc(s.err||'Could not reach the kitchen assistant.')}</p><button class="btn ghost" onclick="askOpen('${kind}','${slug}',true)">Try again</button>`;
  const off=askOff(s), busy=!!ASK.busy[k];
  return `<div id="askmsgs" aria-live="polite">${askMsgsHtml(kind,slug)}</div>
    ${s.err?`<p class="askerr" id="askerr">${esc(s.err)}</p>`:'<p class="askerr" id="askerr" hidden></p>'}
    ${off?`<p class="asknote">${esc(off)}</p>`:`<form class="askform" onsubmit="event.preventDefault();askSend('${kind}','${slug}')"><textarea class="search" id="askin" rows="2" maxlength="4000" aria-label="Your question" placeholder="Ask about this ${kind}" oninput="ASK.draft['${k}']=this.value" onkeydown="if(event.key==='Enter'&&(event.metaKey||event.ctrlKey)){event.preventDefault();askSend('${kind}','${slug}')}">${esc(ASK.draft[k]||'')}</textarea><button class="btn" id="askgo" type="submit"${busy?' disabled':''}>${busy?'Answering…':'Ask'}</button></form>`}
    <div class="askfoot" id="askfoot">${askFootHtml(kind,slug)}</div>`;
}
const askHere=k=>parse().view==='ask'&&ASK.cur===k;
function askDraw(kind,slug){ const k=kind+'/'+slug; if(!askHere(k)) return; const el=document.getElementById('askbody'); if(el) el.innerHTML=askBody(kind,slug); }
function askPaint(kind,slug){ // redraw the conversation without touching the question being typed
  const k=kind+'/'+slug; if(!askHere(k)) return; const ms=document.getElementById('askmsgs'), ft=document.getElementById('askfoot'), go=document.getElementById('askgo'), er=document.getElementById('askerr'), s=askS(k);
  if(!ms||!ft||(!go&&!askOff(s))||(go&&askOff(s))){ askDraw(kind,slug); return; }
  ms.innerHTML=askMsgsHtml(kind,slug); ft.innerHTML=askFootHtml(kind,slug);
  if(go){ go.disabled=!!ASK.busy[k]; go.textContent=ASK.busy[k]?'Answering…':'Ask'; }
  if(er){ er.hidden=!s.err; er.textContent=s.err||''; } }
const askNearEnd=()=>window.innerHeight+window.scrollY>=document.documentElement.scrollHeight-160;
const askToEnd=()=>window.scrollTo(0,document.documentElement.scrollHeight);
function askLive(k,m){ if(!askHere(k)) return; const el=document.getElementById('asklive'); if(!el) return; const stick=askNearEnd();
  el.outerHTML=askMsgHtml(m); if(stick) askToEnd(); }
function askTake(j,kind,slug){ // a JSON answer from the function: device state, limits, or an error
  const k=kind+'/'+slug, s=askS(k), st=j&&j.status;
  if(st==='unpaired'||st==='pending'||st==='revoked'||st==='pair_cap'){ ASK.dev={st,code:j.code||null}; return false; }
  if(st==='bad_key'){ try{localStorage.removeItem('kitchen:ask:key');}catch(e){} ASK.dev={st:'unpaired',code:null}; return false; }
  ASK.dev={st:'approved',code:null};
  if(st==='ok'){ s.st='ok'; s.info=j; s.err=null; s.at=Date.now(); if(!ASK.busy[k]&&!s.fresh) s.msgs=(j.messages||[]).map(m=>({role:m.role,content:m.content||'',status:m.status,tools:m.tools||[],error_detail:m.error_detail})); return true; }
  if(st==='no_key'||st==='paused'||st==='limit'||st==='month_cap'){ s.st='ok'; s.info={...(s.info||{}),...j,...(st==='no_key'?{has_key:false}:{}),...(st==='paused'?{spend_mode:'paused'}:{})}; return false; }
  if(st==='not_found'){ s.st='ok'; s.err='This recipe is not in the database yet, so there is nothing to ask about.'; return false; }
  s.err=(j&&j.message)||'The kitchen assistant hit an error. Try again.'; if(s.st==='load') s.st='error'; return false; }
async function askOpen(kind,slug,manual){ const k=kind+'/'+slug, s=askS(k);
  if(manual){ s.st='load'; if(ASK.dev.st!=='pending') askDraw(kind,slug); }
  try{ const r=await askCall({action:'open',kind,slug}); const j=await r.json(); askTake(j,kind,slug);
    if(manual&&ASK.dev.st==='pending') ASK.dev.msg='Not approved yet. Send the code to Claude, then check again.'; }
  catch(e){ s.st='error'; s.err=navigator.onLine===false?'You are offline. Ask needs a connection.':'Could not reach the kitchen assistant. Check the connection and try again.'; }
  askDraw(kind,slug); }
async function askPair(kind,slug,again){ const k=kind+'/'+slug;
  if(again){ try{localStorage.removeItem('kitchen:ask:key');}catch(e){} }
  const key=askKey(true); if(!key||askKey(false)!==key){ ASK.dev={st:'unpaired',code:null,msg:'This browser will not keep the device key (private browsing?). Open the app normally and try again.'}; askDraw(kind,slug); return; }
  try{ const r=await askCall({action:'pair'}); const j=await r.json();
    if(j.status==='approved'){ ASK.dev={st:'approved',code:null}; return askOpen(kind,slug,true); }
    ASK.dev={st:j.status==='pending'?'pending':(j.status||'unpaired'),code:j.code||null}; }
  catch(e){ toast('Could not reach the kitchen assistant'); }
  askDraw(kind,slug); }
function askNew(kind,slug){ const k=kind+'/'+slug, s=askS(k); if(ASK.busy[k]) return; s.msgs=[]; s.fresh=true; s.err=null; askDraw(kind,slug); const t=document.getElementById('askin'); if(t) t.focus(); }
async function askSend(kind,slug,text){ const k=kind+'/'+slug, s=askS(k), ta=document.getElementById('askin');
  const q=String(text!=null?text:(ta?ta.value:'')).trim(); if(!q||ASK.busy[k]) return;
  ASK.busy[k]=1; s.err=null; ASK.draft[k]=''; if(ta) ta.value='';
  const live={role:'assistant',content:'',status:'ok',tools:[],live:true};
  s.msgs.push({role:'user',content:q,status:'ok'},live); askPaint(kind,slug); askToEnd();
  const drop=()=>{ s.msgs=s.msgs.filter(m=>m!==live); const i=s.msgs.map(m=>m.content).lastIndexOf(q); if(i>=0&&s.msgs[i].role==='user') s.msgs.splice(i,1); if(!ASK.draft[k]){ ASK.draft[k]=q; const t=document.getElementById('askin'); if(t&&askHere(k)&&!t.value) t.value=q; } };
  let frame=0; const soon=()=>{ if(frame) return; frame=requestAnimationFrame(()=>{ frame=0; askLive(k,live); }); };
  try{ const r=await askCall({action:'ask',kind,slug,message:q,new_thread:!!s.fresh});
    if(!(r.headers.get('content-type')||'').startsWith('text/event-stream')){ let j={}; try{j=await r.json();}catch(e){} drop(); askTake(j,kind,slug); }
    else{ s.fresh=false; const rd=r.body.getReader(), dec=new TextDecoder(); let buf='';
      for(;;){ const {value,done}=await rd.read(); if(done) break; buf+=dec.decode(value,{stream:true}); let n;
        while((n=buf.indexOf('\n\n'))>=0){ const line=buf.slice(0,n); buf=buf.slice(n+2); if(!line.startsWith('data:')) continue; let ev; try{ev=JSON.parse(line.slice(5));}catch(e){continue;}
          if(ev.t==='delta'){ live.content+=ev.text||''; soon(); }
          else if(ev.t==='tool'){ live.tools.push({label:ev.label}); soon(); }
          else if(ev.t==='note'){ live.note=ev.text; }
          else if(ev.t==='error'){ live.status='error'; live.error_detail=ev.message; }
          else if(ev.t==='done'){ s.info={...(s.info||{}),used_today:ev.used_today,daily_limit:ev.daily_limit,month_usd:ev.month_usd,monthly_usd_cap:ev.monthly_usd_cap}; } } }
      if(!live.content&&live.status==='ok'){ live.status='error'; live.error_detail='No answer came back. Ask again.'; } }
  }catch(e){ if(live.content){ live.status='partial'; live.error_detail='The connection dropped. The full answer may be there when you reopen this page.'; } else { drop(); s.err=navigator.onLine===false?'You are offline. Ask needs a connection.':'Could not reach the kitchen assistant. Check the connection and try again.'; } }
  live.live=false; ASK.busy[k]=0; const stick=askNearEnd(); askPaint(kind,slug); if(stick&&askHere(k)) askToEnd();
}
routes.ask=(kind,slug)=>{
  kind=kind==='dish'?'dish':'meal'; const o=kind==='meal'?IDX.mealBySlug[slug]:IDX.dishBySlug[slug];
  if(!o) return notFound(kind==='meal'?'Meal':'Dish',kind==='meal'?'#/meals':'#/library');
  setHeader('Ask','#/'+kind+'/'+slug); tabs(kind==='meal'?'meals':'library');
  const k=kind+'/'+slug, s=askS(k); ASK.cur=k;
  if(!ASK.busy[k]&&Date.now()-(s.at||0)>300000&&!s._opening){ s._opening=1; if(!s.msgs.length&&s.st!=='ok') s.st='load'; setTimeout(()=>askOpen(kind,slug).finally(()=>{s._opening=0;}),0); }
  return `<div class="askv"><div class="eyebrow">Ask Claude</div><h2 class="askt">${nameHtml(o.name)}</h2><div id="askbody">${askBody(kind,slug)}</div></div>`;
};
// ---------------------------------------------------------------- end ask
