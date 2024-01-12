-- Создаем нужные столбцы
-- список имен людей, сделавших заказ на пиццу в соответствующей пиццерии
select per.name as name, m.pizza_name, p.name as pizzeria_name
from person_order as po
    join person per on po.person_id = per.id
    join menu m on po.menu_id = m.id
    join pizzeria p on m.pizzeria_id = p.id
order by name, pizza_name, pizzeria_name;