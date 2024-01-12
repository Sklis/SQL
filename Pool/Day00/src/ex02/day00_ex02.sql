-- the first operator contains comparison signs (<=, >=)
SELECT pizza.name, pizza.rating
FROM pizzeria AS pizza
WHERE pizza.rating <= 5
  AND pizza.rating >= 3.5
ORDER BY pizza.rating;

-- the second select statement contains the keyword BETWEEN
SELECT pizza.name, pizza.rating
FROM pizzeria AS pizza
WHERE pizza.rating BETWEEN 3.5 AND 5
ORDER BY pizza.rating;