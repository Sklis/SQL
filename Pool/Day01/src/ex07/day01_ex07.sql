-- order_date и person_id из person_order
-- получение name и age из person и сопастовление с person_id из person_order
-- объединить в одну таблицу полученные данные
select per_o.order_date,
       (select concat(pers.name, ' (age:', pers.age, ')')
        from person as pers
        where pers.id = per_o.person_id) as person_information
from person_order as per_o
order by order_date, person_information;

-- Второй вариант
select  pers_o.order_date, concat(pers.name, ' (age:', pers.age) as person_information
from person as pers
join person_order as pers_o
on pers.id = pers_o.person_id
order by order_date, person_information;
