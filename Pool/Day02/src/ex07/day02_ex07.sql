select pz.name as pizzeria_name
from (select *
      from person
      where person.name = 'Dmitriy') as pers
join (
    select *
    from person_visits
    where  visit_date = '2022-01-08'
) as pv on pers.id = pv.person_id
join pizzeria as pz on pv.pizzeria_id = pz.id;
