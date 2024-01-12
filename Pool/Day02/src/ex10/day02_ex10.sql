select
    p1.name person_name1, p2.name person_name2, p1.address
from person p1
    join person p2 on p1.address = p2.address
where p1 > p2
order by 1, 2, 3;