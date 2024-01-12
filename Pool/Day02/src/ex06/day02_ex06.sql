with orders as (select *
                from person_order as pers_o
                         right join (select *
                                     from person as p
                                     where p.name in ('Anna', 'Denis')) as pers on pers_o.person_id = pers.id)
select mu.pizza_name,
       pizza.name as pizzeria_name
from menu as mu
         join orders on mu.id = orders.menu_id
         join pizzeria pizza on mu.pizzeria_id = pizza.id
order by pizza_name, pizzeria_name;