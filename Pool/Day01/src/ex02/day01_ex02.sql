-- pizza_name все из таблицы menu
-- name из таблицы person
-- объединить две отсортированные таблицы в одну используя UNION
(select mu.pizza_name
from menu as mu)
union
(select mu.pizza_name
 from menu as mu)
order by pizza_name desc;