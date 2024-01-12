INSERT INTO menu
VALUES ((SELECT max(id)
         FROM menu) + 1,
        (SELECT pi.id
         FROM pizzeria pi
         WHERE pi.name = 'Dominos'),
        'sicilian pizza', 900);

select count(*)=1 as check
from menu
where id = 20 and pizzeria_id=2 and pizza_name = 'sicilian pizza' and price=900
