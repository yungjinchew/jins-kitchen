// headless check of the Ask panel in the real page: phone viewport, mocked database and mocked kitchen-assistant
const { chromium } = require('playwright');
const http = require('http'), fs = require('fs'), path = require('path');
const SITE = process.argv[2], SHOTS = process.argv[3] || '/tmp/ask-shots';
fs.mkdirSync(SHOTS, { recursive: true });
const server = http.createServer((q, s) => { const f = path.join(SITE, q.url.split('?')[0] === '/' ? 'index.html' : q.url.split('?')[0]);
  fs.readFile(f, (e, b) => { if (e) { s.writeHead(404); s.end(); } else { s.writeHead(200, { 'Content-Type': f.endsWith('.html') ? 'text/html' : f.endsWith('.js') ? 'text/javascript' : 'application/octet-stream' }); s.end(b); } }); }).listen(8765);

const D1 = '11111111-1111-4111-8111-111111111111', M1 = '22222222-2222-4222-8222-222222222222';
const FIX = {
  dish: [{ id: D1, slug: 'fish-pie', name: 'Fish Pie (Smoked Haddock, Celeriac Mash)', status: 'designed', category: ['Main'], cuisine: ['British'], protein: 'Fish', summary: 'A fish pie.', servings: 3, equipment: ['Oven'], difficulty: 'medium', created_at: '2026-11-01T00:00:00Z', updated_at: '2026-11-02T00:00:00Z', base_id: null,
    method_md: '## Method\n\n1. **Poach the fish in 500 ml milk at 75°C / 167°F for 8 min.** Lift out.\n2. **Bake at 200°C / 390°F for 30 min** until the centre reads 75°C / 167°F.\n' }],
  meal: [{ id: M1, slug: 'fish-pie-sunday', name: 'Fish Pie Sunday', status: 'designed', planned_date: null, service_time: '18:00:00', pax: 3, workflow_md: '## Timeline\n\n- T-60 oven on', shared_prep_md: null, wine_pairing: null, created_at: '2026-11-01T00:00:00Z', updated_at: '2026-11-02T00:00:00Z' }],
  meal_dish: [{ meal_id: M1, dish_id: D1, role: 'main', service_order: 1 }],
  cook: [], document: [], dish_ingredient: [], dish_rating_rollup: [], open_validations: [], measurement: [], wine_pick: [], cook_inbox: [],
};
const sse = (evs) => evs.map((e) => 'data: ' + JSON.stringify(e) + '\n\n').join('');
const ANSWER = 'Yes. **Poach the fish and make the mash the day before**; assemble cold and bake from the fridge.\n\n- Add 10 min to the bake: 40 min at 200°C / 390°F\n- Centre must read 75°C / 167°F before it leaves the oven\n\nNot saved: this is advice, the recipe is unchanged.';

(async () => {
  let fails = 0; const ok = (n, c, d) => { if (!c) fails++; console.log((c ? 'PASS ' : 'FAIL ') + n + (c ? '' : ' -> ' + (d === undefined ? '' : JSON.stringify(d)))); };
  const browser = await chromium.launch({ executablePath: '/usr/bin/google-chrome', args: ['--no-sandbox'] });
  for (const scheme of ['light', 'dark']) {
    const ctx = await browser.newContext({ viewport: { width: 390, height: 844 }, deviceScaleFactor: 2, colorScheme: scheme, serviceWorkers: 'block' });
    const page = await ctx.newPage();
    const errors = []; page.on('pageerror', (e) => errors.push(String(e))); page.on('console', (m) => { if (m.type() === 'error' && !/Failed to load resource|net::ERR/.test(m.text())) errors.push(m.text()); });
    const fn = { state: 'unpaired', calls: [], msgs: [], has_key: true };
    await page.route('**/*', async (route) => {
      const u = route.request().url();
      if (u.startsWith('http://localhost:8765')) return route.continue();
      if (u.includes('/rest/v1/')) { const t = u.split('/rest/v1/')[1].split('?')[0]; return route.fulfill({ status: 200, contentType: 'application/json', headers: { 'content-range': '0-0/' + (FIX[t] || []).length }, body: JSON.stringify(FIX[t] || []) }); }
      if (u.includes('/functions/v1/kitchen-assistant')) {
        const b = JSON.parse(route.request().postData() || '{}'), key = route.request().headers()['x-device-key'];
        fn.calls.push({ ...b, key });
        const J = (o) => route.fulfill({ status: 200, contentType: 'application/json', body: JSON.stringify(o) });
        if (b.action === 'pair') { fn.state = 'pending'; return J({ status: 'pending', code: 'K7M2QX' }); }
        if (fn.state !== 'approved') return J(fn.state === 'pending' ? { status: 'pending', code: 'K7M2QX' } : { status: 'unpaired' });
        const lim = { used_today: fn.msgs.filter((m) => m.role === 'user').length, daily_limit: 60, month_usd: 0.4, monthly_usd_cap: 15, spend_mode: 'normal', model: 'claude-opus-5-5' };
        if (b.action === 'open') return J({ status: 'ok', version: 'ASK 1.0', has_key: fn.has_key, thread_id: null, messages: fn.msgs, ...lim });
        if (b.action === 'ask') {
          if (!fn.has_key) return J({ status: 'no_key' });
          fn.msgs.push({ role: 'user', content: b.message, status: 'ok' }, { role: 'assistant', content: ANSWER, status: 'ok', tools: [{ label: 'Read meal workflow rules' }] });
          return route.fulfill({ status: 200, headers: { 'content-type': 'text/event-stream; charset=utf-8' }, body: sse([{ t: 'start' }, { t: 'tool', label: 'Read meal workflow rules' }, ...ANSWER.match(/[\s\S]{1,23}/g).map((x) => ({ t: 'delta', text: x })), { t: 'done', used_today: lim.used_today + 1, daily_limit: 60, month_usd: 0.52, monthly_usd_cap: 15 }]) });
        }
        return J({ status: 'error', message: 'Unknown action' });
      }
      return route.fulfill({ status: 200, contentType: 'text/css', body: '' }); // fonts, GitHub
    });
    await page.goto('http://localhost:8765/#/meal/fish-pie-sunday');
    await page.waitForSelector('.glass.ask', { timeout: 15000 });
    ok(`[${scheme}] meal page shows the Ask card`, await page.locator('.glass.ask a.btn').innerText() === 'Ask about this meal');
    await page.locator('.glass.ask').scrollIntoViewIfNeeded(); await page.screenshot({ path: `${SHOTS}/${scheme}-1-meal-card.png` });
    await page.click('.glass.ask a.btn');
    await page.waitForSelector('.askpair .btn');
    ok(`[${scheme}] unpaired device sees the pairing step, no form`, /Pair this device/.test(await page.locator('#askbody').innerText()) && await page.locator('.askform').count() === 0);
    ok(`[${scheme}] opening did not ask for a code by itself`, !fn.calls.some((c) => c.action === 'pair'));
    await page.click('.askpair .btn');
    await page.waitForSelector('.askcode');
    ok(`[${scheme}] pairing code is shown`, await page.locator('.askcode').innerText() === 'K7M2QX');
    const key = fn.calls.at(-1).key;
    ok(`[${scheme}] device key is 64 hex and stays the same`, /^[a-f0-9]{64}$/.test(key) && fn.calls.every((c) => c.key === key), key);
    await page.screenshot({ path: `${SHOTS}/${scheme}-2-pair.png` });
    await page.click('.askpair .btn'); await page.waitForSelector('.askerr');
    ok(`[${scheme}] Check before approval says not yet`, /Not approved yet/.test(await page.locator('.askerr').innerText()));
    fn.state = 'approved';
    await page.click('.askpair .btn'); await page.waitForSelector('.askform');
    ok(`[${scheme}] approved: starters and the form`, await page.locator('.askchips .chip').count() === 3 && /0 of 60 questions today/.test(await page.locator('#askfoot').innerText()), await page.locator('#askfoot').innerText());
    await page.screenshot({ path: `${SHOTS}/${scheme}-3-empty.png` });
    await page.fill('#askin', 'Can I make this the day before?');
    await page.click('#askgo');
    await page.waitForFunction(() => document.querySelector('#askgo') && !document.querySelector('#askgo').disabled && document.querySelectorAll('.askm.a').length === 1);
    const a = await page.locator('.askm.a').innerHTML();
    ok(`[${scheme}] answer rendered: bold, list, tool chip`, /<b>Poach the fish and make the mash the day before<\/b>/.test(a) && /<ul><li>Add 10 min/.test(a) && /Read meal workflow rules/.test(a) && !/asklive/.test(a), a.slice(0, 300));
    ok(`[${scheme}] question bubble, cleared box, count updated`, await page.locator('.askm.u .askb').innerText() === 'Can I make this the day before?' && await page.inputValue('#askin') === '' && /1 of 60 questions today/.test(await page.locator('#askfoot').innerText()));
    const sent = fn.calls.at(-1);
    ok(`[${scheme}] request carries kind, slug, message`, sent.action === 'ask' && sent.kind === 'meal' && sent.slug === 'fish-pie-sunday' && sent.message === 'Can I make this the day before?' && sent.new_thread === false, sent);
    await page.screenshot({ path: `${SHOTS}/${scheme}-4-answer.png`, fullPage: true });
    // typing survives the end of a second answer; a data refresh never redraws the page
    await page.fill('#askin', 'And the mash?'); await page.click('#askgo');
    await page.type('#askin', 'next question draft');
    await page.waitForFunction(() => document.querySelectorAll('.askm.a').length === 2 && !document.querySelector('#askgo').disabled);
    ok(`[${scheme}] a question typed while the answer arrives is kept`, await page.inputValue('#askin') === 'next question draft', await page.inputValue('#askin'));
    await page.evaluate(() => { document.activeElement.blur(); freshRedraw(); });
    ok(`[${scheme}] data refresh leaves the Ask page alone`, await page.inputValue('#askin') === 'next question draft' && await page.locator('.askm.a').count() === 2);
    // leave and come back: conversation is still there; header back goes to the meal
    await page.click('header .back'); await page.waitForSelector('.glass.ask');
    ok(`[${scheme}] Back returns to the meal`, /#\/meal\/fish-pie-sunday$/.test(page.url()), page.url());
    await page.click('.glass.ask a.btn'); await page.waitForSelector('.askform');
    ok(`[${scheme}] conversation kept on return`, await page.locator('.askm.a').count() === 2 && await page.inputValue('#askin') === 'next question draft');
    await page.click('#askfoot button');
    ok(`[${scheme}] New conversation clears the page`, await page.locator('.askm').count() === 0 && await page.locator('.askchips .chip').count() === 3);
    await page.click('.askchips .chip >> nth=2'); await page.waitForFunction(() => document.querySelectorAll('.askm.a').length === 1 && !document.querySelector('#askgo').disabled);
    ok(`[${scheme}] a starter asks its question in a new thread`, fn.calls.at(-1).message === 'Scale this to 5 people' && fn.calls.at(-1).new_thread === true, fn.calls.at(-1));
    // the dish page has its own card and its own conversation; no key hides the form
    fn.has_key = false; fn.msgs = [];
    await page.goto('http://localhost:8765/#/dish/fish-pie'); await page.waitForSelector('.glass.ask');
    ok(`[${scheme}] dish page shows the Ask card`, await page.locator('.glass.ask a.btn').innerText() === 'Ask about this dish');
    await page.click('.glass.ask a.btn'); await page.waitForSelector('.asknote');
    ok(`[${scheme}] no key: explains, hides the form`, /Anthropic key/.test(await page.locator('.asknote').innerText()) && await page.locator('.askform').count() === 0);
    await page.screenshot({ path: `${SHOTS}/${scheme}-5-nokey.png` });
    const over = await page.evaluate(() => document.documentElement.scrollWidth > window.innerWidth + 1);
    ok(`[${scheme}] no sideways scroll at 390 px`, !over);
    ok(`[${scheme}] no page errors`, errors.length === 0, errors);
    await ctx.close();
  }
  await browser.close(); server.close();
  console.log(fails ? `\n${fails} FAILED` : '\nall passed'); process.exit(fails ? 1 : 0);
})().catch((e) => { console.error(e); process.exit(2); });
