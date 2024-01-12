WITH woman AS (SELECT pi.name as w_id
               FROM pizzeria pi
                        JOIN person_visits pv on pi.id = pv.pizzeria_id
                        JOIN person p on p.id = pv.person_id
               WHERE p.gender = 'female'),
     man AS (SELECT pi.name AS m_id
             FROM pizzeria pi
                      JOIN person_visits pv on pi.id = pv.pizzeria_id
                      JOIN person p on p.id = pv.person_id
             WHERE p.gender = 'male'),
     only_woman AS (SELECT w_id AS pizzeria_name
                    FROM woman
                    EXCEPT ALL
                    SELECT m_id
                    FROM man),
     only_man AS (SELECT m_id AS pizzeria_name
                  FROM man
                  EXCEPT ALL
                  SELECT w_id
                  FROM woman)
SELECT pizzeria_name
FROM only_woman
UNION ALL
SELECT pizzeria_name
FROM only_man
ORDER BY 1;