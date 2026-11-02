-- jins-kitchen migration 0015 (2026-11-02): the Next time queue
-- Applied 2026-11-02 by Claude through the Supabase SQL editor (the connector cancelled it; paste verified by SHA-256).
--  * meal.queue_rank: Jin's Next time order (1 = next). Null = not in the queue. On the Meals page every meal sits in
--    exactly one list: Next time (queued), Cooked (cooked, not queued) or Uncooked (not cooked, not queued: kept to
--    come back to). All = the three together.
--  * Trigger meal_queue: a new meal that is not cooked joins the end of the queue; a meal newly planned for a date joins
--    the end if it was not queued; a meal leaves the queue when it is cooked (status turns cooked, or a cooked meal is
--    cooked again: its planned_date moves).
--  * kitchen_meal_queue(order, remove): the app's Reorder, Off list and Add to Next time. The meals in "order" take
--    positions 1..n in that order (a cooked meal listed there is queued to cook again), the meals in "remove" leave the
--    queue, and any other queued meal keeps its place after them. Callable by the app (anon). Data protocol v1.18 §3.3.

alter table public.meal add column if not exists queue_rank int;
create index if not exists meal_queue_idx on public.meal (queue_rank) where queue_rank is not null;

-- first queue: today's Next time list, dated meals soonest first, then the undated ones newest first
with q as (
  select id, row_number() over (order by (planned_date is null), planned_date, created_at desc, id) as rn
  from public.meal where status <> 'cooked'
)
update public.meal m set queue_rank = q.rn from q where m.id = q.id and m.queue_rank is null
  and not exists (select 1 from public.meal x where x.queue_rank is not null);

create or replace function public.meal_queue_trg() returns trigger language plpgsql set search_path to 'public' as $fn$
begin
  if tg_op = 'INSERT' then
    if new.status <> 'cooked' and new.queue_rank is null then
      new.queue_rank := coalesce((select max(queue_rank) from public.meal), 0) + 1;
    end if;
  else
    if new.status = 'cooked' and (old.status <> 'cooked' or new.planned_date is distinct from old.planned_date) then
      new.queue_rank := null;
    elsif new.status = 'planned' and new.queue_rank is null and old.queue_rank is null
          and (old.status <> 'planned' or new.planned_date is distinct from old.planned_date) then
      new.queue_rank := coalesce((select max(queue_rank) from public.meal), 0) + 1;
    end if;
  end if;
  return new;
end $fn$;
drop trigger if exists meal_queue on public.meal;
create trigger meal_queue before insert or update on public.meal for each row execute function public.meal_queue_trg();

create or replace function public.kitchen_meal_queue(p_order text[], p_remove text[] default '{}')
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare v_bad text[];
begin
  p_order := coalesce(p_order, '{}'); p_remove := coalesce(p_remove, '{}');
  if cardinality(p_order) > 300 or cardinality(p_remove) > 300 then
    return jsonb_build_object('status', 'error', 'detail', 'too many meals'); end if;
  select array_agg(s) into v_bad from unnest(p_order || p_remove) s where not exists (select 1 from public.meal m where m.slug = s);
  if v_bad is not null then
    return jsonb_build_object('status', 'error', 'detail', 'unknown meal: ' || array_to_string(v_bad, ', ')); end if;
  update public.meal set queue_rank = null where slug = any(p_remove) and not (slug = any(p_order));
  update public.meal m set queue_rank = 100000 + m.queue_rank where m.queue_rank is not null and not (m.slug = any(p_order));
  update public.meal m set queue_rank = t.o from unnest(p_order) with ordinality as t(s, o) where m.slug = t.s;
  with r as (select id, row_number() over (order by queue_rank, id) as rn from public.meal where queue_rank is not null)
  update public.meal m set queue_rank = r.rn from r where m.id = r.id and m.queue_rank is distinct from r.rn;
  return jsonb_build_object('status', 'ok',
    'queue', (select coalesce(jsonb_agg(slug order by queue_rank), '[]'::jsonb) from public.meal where queue_rank is not null));
end $fn$;

revoke all on function public.meal_queue_trg() from public, anon, authenticated;
revoke all on function public.kitchen_meal_queue(text[], text[]) from public;
grant execute on function public.kitchen_meal_queue(text[], text[]) to anon, authenticated, service_role;
