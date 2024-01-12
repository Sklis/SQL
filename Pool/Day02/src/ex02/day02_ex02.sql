select coalesce(p.name, '-') as person_name,
       query.visit_date      as visit_date,
       coalesce(pz.name, '-') as pizzeria_name
from person as p
    full join (select *
                from person_visits as pv
                where pv.visit_date between '2022-01-01' and  '2022-01-03') as query
                on p.id = query.person_id
    full join pizzeria as pz
            on query.pizzeria_id = pz.id
order by person_name, visit_date, pizzeria_name;