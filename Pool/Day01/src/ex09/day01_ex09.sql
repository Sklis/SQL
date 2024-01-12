-- name из pizzeria
-- возвращают список названий пиццерий, которые не посещались людьми
--
select piz.name as name
from pizzeria piz
where id not in(
    select pv.pizzeria_id
    from person_visits pv);

select piz.name as name
from pizzeria piz
where not exists(
    select pv.pizzeria_id
    from person_visits pv
    where piz.id = pv.pizzeria_id);
