select address,
       pz.name,
       count(pz.name) as count_of_orders
from person
         join person_order po on person.id = po.person_id
         join menu m on m.id = po.menu_id
         join pizzeria pz on pz.id = m.pizzeria_id
group by 1, 2
order by 1, 2;
