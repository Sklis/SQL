CREATE VIEW v_price_with_discount
AS
WITH orders AS (SELECT p.name, m.pizza_name, m.price
                FROM person_order po
                         JOIN person p on po.person_id = p.id
                         JOIN menu m on po.menu_id = m.id)
SELECT *, round(price - price * 0.1) AS discount_price
FROM orders
ORDER BY name, pizza_name;

-- SELECT * FROM v_price_with_discount;
-- DROP VIEW v_price_with_discount;