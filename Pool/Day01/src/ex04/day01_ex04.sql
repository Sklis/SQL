--  order_date и person_id из person_order
-- visit_date и person_id из person_visits
-- объединить две таблицы в одну используя except all

(select per_o.person_id as person_id
from person_order as per_o
where order_date = '2022-01-07')
except all
(select per_v.person_id as person_id
from person_visits as per_v
where per_v.visit_date = '2022-01-07');
