-- 2026-11-02 data fix: unlink the arugula salad from Short Rib Pie Sunday.
-- Approved by Jin in session ("Go and unlink"); the menu now serves the endive salad instead.
-- kitchen_save_meal links dishes but never unlinks, so this one row is removed directly.
-- The dish itself (short-ribs-arugula-salad) is untouched and stays linked to its other meals.
-- Applied 2026-11-02 by Claude through the SQL editor (paste SHA-256 matched this file; Success, no rows returned); verified through the connector: short-rib-pie-sunday now links only short-rib-pie-puff-lid until the menu save.
delete from public.meal_dish
where meal_id = (select id from public.meal where slug = 'short-rib-pie-sunday')
  and dish_id = (select id from public.dish where slug = 'short-ribs-arugula-salad');
