select p.name,
       count(pizzeria_id) as count_of_visits
from person_visits pv
    join public.person p on pv.person_id = p.id
group by 1
order by 2 desc , 1
limit 4;
