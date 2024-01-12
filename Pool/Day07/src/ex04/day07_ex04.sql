select p.name,
       count(pv.pizzeria_id) count_of_visits
from person p
    join person_visits pv on p.id = pv.person_id
group by 1
having count(pv.pizzeria_id) > 3;
