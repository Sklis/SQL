-- order_date и person_id из person_order
-- получение name из person и сопастовление с person_id из person_order
-- visit_date и person_id из person_visits
-- получение name из person и сопастовление с person_id из person_visits
-- объединить две таблицы в одну используя intersect
(select per_o.order_date as action_date,
       (select pers.name
        from person as pers
        where pers.id = per_o.person_id) as person_name
from person_order as per_o)
intersect
(select mu.visit_date as action_date,
        (select pers.name
        from person as pers
        where pers.id = mu.person_id)  as person_name
from person_visits as mu)
order by action_date asc, person_name desc;

-- Второй способ
SELECT DISTINCT pers_o.order_date AS action_date,
                person.name       AS person_name
FROM person_order AS pers_o
         JOIN person_visits ON pers_o.order_date = person_visits.visit_date
         JOIN person ON pers_o.person_id = person.id
ORDER BY action_date ASC, person_name DESC;