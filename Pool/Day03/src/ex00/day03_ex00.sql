WITH pm AS (
    SELECT p.id,p.name, m.pizza_name, m.price
    FROM pizzeria p
             JOIN menu m on p.id = m.pizzeria_id
    WHERE m.price BETWEEN 800 AND 1000
), kate_visit AS (
    SELECT pizzeria_id,visit_date
    FROM (
             SELECT id, name
             FROM person
             WHERE name = 'Kate'
         ) AS p
             JOIN person_visits AS pv ON p.id = pv.person_id
)
SELECT pm.pizza_name, pm.price, pm.name AS pizzeria_name, kate_visit.visit_date
FROM pm
         JOIN kate_visit ON pm.id = kate_visit.pizzeria_id
ORDER BY pm.pizza_name, pm.price, pm.name;

