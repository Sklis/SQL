-- все из person и pizzeria
-- выполнение декартова произведения
-- между person и pizzeria
select *
from person as pers
cross join pizzeria as pizz
order by pers.id, pizz.id