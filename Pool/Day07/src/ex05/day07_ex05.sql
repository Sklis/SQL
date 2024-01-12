select distinct p.name
from person p
    join public.person_visits pv on p.id = pv.person_id
order by 1;
