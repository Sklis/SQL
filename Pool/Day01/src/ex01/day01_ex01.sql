-- pizza_name из таблицы menu
-- name из таблицы person
-- объединить две отсортированные таблицы в одну используя UNION ALL
(select pers.name as object_name
from person as pers
order by object_name)
union all
(select mu.pizza_name as object_name
from menu as mu
order by object_name);
