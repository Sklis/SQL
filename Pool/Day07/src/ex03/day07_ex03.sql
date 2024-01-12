with main as ((select pz.name,
                      count(person_id) as count,
                      'visits' as action_type
                from person_visits pv
                    join pizzeria pz on pv.pizzeria_id = pz.id
                group by 1
                order by 2 desc)
            union all
            (select pz.name,
                    count(pz.name) count,
                    'order' action_type
            from person_order po
                join menu m on po.menu_id = m.id
                join pizzeria pz on pz.id = m.pizzeria_id
            group by 1
            order by 2 desc))
select name,
       sum(count) total_count
from main
group by 1
order by 2 desc, 1;