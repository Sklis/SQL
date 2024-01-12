-- order_date и person_id из person_order
-- получение name и age из person и сопастовление с person_id из person_order
-- объединить в одну таблицу полученные данные
select
	po.order_date, concat(p.name, ' (age:', p.age, ')') as person_information
from
     (person_order as po(person_id, id, menu_id, order_date)
    natural join person p)
order by
	order_date, person_information;