select p.name
from person as p
where p.gender = 'female'
    and p.age > 25
order by name;