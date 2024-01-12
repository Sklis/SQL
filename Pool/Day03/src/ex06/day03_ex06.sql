WITH find AS (SELECT m.pizza_name,
                     m.price,
                     pi.name,
                     pi.id
              FROM menu m
                       JOIN pizzeria pi ON m.pizzeria_id = pi.id)
SELECT q1.pizza_name,
       q1.name AS pizzeria_name_1,
       f.name  AS pizzeria_name_2,
       q1.price
FROM (SELECT *
      FROM find) q1
         JOIN find f ON q1.price = f.price
    AND q1.pizza_name = f.pizza_name
    AND q1.id > f.id
ORDER BY 1;