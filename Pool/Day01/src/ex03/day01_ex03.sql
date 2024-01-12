                            --  order_date и person_id из person_order
                            -- visit_date и person_id из person_visits
                            -- объединить две таблицы в одну используя intersect
(select per_o.order_date as action_date,
       per_o.person_id as person_id
from person_order as per_o)
intersect
(select mu.visit_date as action_date,
        mu.person_id as person_id
from person_visits as mu)
order by action_date asc, person_id desc;