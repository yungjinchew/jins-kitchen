-- 2026-11-02 data fix: unlink the arugula salad from Lamb Shoulder Pie Sunday.
-- Approved by Jin in session ("Go and unlink"); the menu now serves the cider-vinegar fennel salad instead.
-- kitchen_save_meal links dishes but never unlinks, so this one row is removed directly.
-- The dish itself (short-ribs-arugula-salad) is untouched and stays linked to Short Ribs Dinner.
-- Applied 2026-11-02 by Claude through the SQL editor (paste SHA-256 matched this file; Success, no rows returned); verified through the connector: lamb-shoulder-pie-sunday now links only lamb-shoulder-pie-puff-lid until the menu save; the arugula dish remains on short-ribs-dinner.
delete from public.meal_dish
where meal_id = (select id from public.meal where slug = 'lamb-shoulder-pie-sunday')
  and dish_id = (select id from public.dish where slug = 'short-ribs-arugula-salad');
