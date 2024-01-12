CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats
AS
SELECT pi.name AS pizzeria_name
FROM (SELECT * FROM person) AS p
         JOIN person_visits pv ON p.id = pv.person_id
         JOIN pizzeria pi ON pv.pizzeria_id = pi.id
         JOIN menu m ON pi.id = m.pizzeria_id
WHERE m.price < 800
  AND pv.visit_date = '2022-01-08'
  AND p.name = 'Dmitriy';

-- SELECT * FROM mv_dmitriy_visits_and_eats;
-- DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;