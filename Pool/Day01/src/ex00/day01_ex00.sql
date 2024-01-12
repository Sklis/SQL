-- menu_id и pizza_name из таблицы menu
-- id and name из таблицы person
-- объединить две таблицы в одну используя UNION и сортирует ее
select
	me.id as object_id,
	me.pizza_name as object_name
from
	menu as me
union
select
	per.id as object_id,
	per.name as object_name
from
	person as per
order by
	object_id, object_name;