select distinct pz.name, pz.rating
from pizzeria as pz
    left join person_visits as pv on pz.id = pv.pizzeria_id
where pv.pizzeria_id is null;