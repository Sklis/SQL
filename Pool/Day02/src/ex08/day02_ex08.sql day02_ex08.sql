with male as
         (select *
          from person
          where address in('Moscow', 'Samara')
            and gender = 'male'),
     orders as
         (select *
          from person_order
                   inner join
               menu on person_order.menu_id = menu.id
          where menu.pizza_name in ('pepperoni pizza', 'mushroom pizza'))
select  male.name
from male
         inner join  orders on orders.person_id = male.id
order by male.name desc ;

