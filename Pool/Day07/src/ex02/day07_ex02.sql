with visits as (select pz.name,
                       count(pizzeria_id),
                       'visit' as action_type
                from person_visits pv
                    join pizzeria pz on pv.pizzeria_id = pz.id
                group by 1
                order by 2 desc
                limit 3),
    orders as (select pz.name,
                      count(pz.name),
                      'order' as action_type
               from person_order po
                    join menu m on po.menu_id = m.id
                    join pizzeria pz on m.pizzeria_id = pz.id
               group by 1
               order by 2 desc
               limit 3)
select *
from visits
union all
select *
from orders
order by 3, 2 desc;
