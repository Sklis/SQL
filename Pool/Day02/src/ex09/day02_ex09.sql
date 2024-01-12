with women as (select *
               from person
               where gender = 'female'),
     orders as (select women.name,
                       m.pizza_name,
                       po.*
                from person_order po
                         join women on po.person_id = women.id
                         join menu m on po.menu_id = m.id)
select ord.name
from orders as ord
where ord.pizza_name = 'cheese pizza'
  and exists(select orders.name
             from orders
             where orders.pizza_name = 'pepperoni pizza'
               and orders.name = ord.name)
order by ord.name;

--Второй выриант
WITH p_pp AS(
    SELECT person_id, pizza_name
    FROM menu
             JOIN person_order p on menu.id = p.menu_id
    WHERE pizza_name = 'pepperoni pizza'
), p_cp AS (
    SELECT person_id, pizza_name
    FROM menu
             JOIN person_order p on menu.id = p.menu_id
    WHERE pizza_name = 'cheese pizza'
)

SELECT name
FROM (
         SELECT id, name
         FROM person
         WHERE gender = 'female'
     ) AS ps
         JOIN p_pp ON ps.id = p_pp.person_id
         JOIN p_cp ON ps.id = p_cp.person_id