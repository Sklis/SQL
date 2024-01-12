with pizza as (
    select *
    from menu as m
    where m.pizza_name in ('mushroom pizza', 'pepperoni pizza'))
select pizza.pizza_name,
       pz.name as pizzeria_name,
       pizza.price
from pizza
    join pizzeria as pz on pizza.pizzeria_id = pz.id
order by 1, 2;
