INSERT INTO person_order
VALUES (
        generate_series((SELECT MAX(id) FROM person_order) + 1,
            (SELECT MAX(id) FROM person_order) + (SELECT MAX(id) FROM person)),
        generate_series((SELECT MIN(id) FROM person), (SELECT MAX(id) FROM person), 1),
        (SELECT id FROM menu WHERE pizza_name = 'greek pizza'),'2022-02-25'
        );


-- select count(*)=9 as check
-- from person_order
-- where order_date='2022-02-25' and menu_id = (select id from menu where pizza_name = 'greek pizza')