select p.name,
       m.pizza_name,
       m.price,
       (m.price - (m.price * pd.discount) / 100) as discount_price,
       p2.name as pizzeria_name
from person_order po
    inner join person p on po.person_id = p.id
    inner join menu m on m.id = po.menu_id
    inner join public.person_discounts pd on p.id = pd.person_id
    inner join public.pizzeria p2 on m.pizzeria_id = p2.id
order by 1, 2;