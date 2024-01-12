WITH woman AS (SELECT DISTINCT pi.name AS w_id
               FROM pizzeria pi
                        JOIN menu m on pi.id = m.pizzeria_id
                        JOIN person_order po on m.id = po.menu_id
                        JOIN person p on p.id = po.person_id
               WHERE p.gender = 'female'),
     man AS (SELECT DISTINCT pi.name AS m_id
             FROM pizzeria pi
                      JOIN menu m on pi.id = m.pizzeria_id
                      JOIN person_order o on m.id = o.menu_id
                      JOIN person p on p.id = o.person_id
             WHERE p.gender = 'male'),
     only_woman AS (SELECT m_id AS pizzeria_name
                    FROM man
                    EXCEPT
                    SELECT w_id
                    FROM woman),
     only_man AS (SELECT w_id AS pizzeria_name
                  FROM woman
                  EXCEPT
                  SELECT m_id
                  FROM man)
SELECT pizzeria_name
FROM only_woman
UNION ALL
SELECT pizzeria_name
FROM only_man
ORDER BY 1;