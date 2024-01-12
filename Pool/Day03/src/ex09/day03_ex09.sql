INSERT INTO person_visits
VALUES ((SELECT MAX(id) FROM person_visits) + 1,
        (SELECT p.id FROM person p WHERE p.name = 'Denis'),
        (SELECT pi.id FROM pizzeria pi WHERE pi.name = 'Dominos'),
        (TIMESTAMP '2022-02-24')::date),
       ((SELECT MAX(id) FROM person_visits) + 2,
        (SELECT p.id FROM person p WHERE p.name = 'Irina'),
        (SELECT pi.id FROM pizzeria pi WHERE pi.name = 'Dominos'),
        TIMESTAMP '2022-02-24');


-- select count(*)=2 as check
-- from person_visits
-- where visit_date = '2022-02-24' and person_id in (6,4) and pizzeria_id=2;