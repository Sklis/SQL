CREATE VIEW v_symmetric_union
AS
WITH R AS (SELECT *
           FROM person_visits
           WHERE visit_date = '2022-01-02'),
     S AS (SELECT *
           FROM person_visits
           WHERE visit_date = '2022-01-06'),
     diffR AS (SELECT person_id
               FROM R
               EXCEPT
               SELECT person_id
               FROM S),
     diffS AS (SELECT person_id
               FROM S
               EXCEPT
               SELECT person_id
               FROM R)
SELECT *
FROM diffR
UNION
SELECT *
FROM diffS
ORDER BY 1;

-- SELECT * FROM v_symmetric_union;
-- DROP VIEW v_symmetric_union;