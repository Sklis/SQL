UPDATE menu
SET price = (SELECT price FROM menu WHERE pizza_name = 'greek pizza') * 0.9
WHERE pizza_name = 'greek pizza';


-- select (800-800*0.1) = price as check
-- from menu
-- where pizza_name ='greek pizza'