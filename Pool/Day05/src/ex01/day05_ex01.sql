set enable_seqscan =off;

explain analyse
select m.pizza_name,
       pz.name pizzeria_name
from menu m
inner join pizzeria pz on m.pizzeria_id = pz.id;