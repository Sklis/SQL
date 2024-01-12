-- Session 1
begin;

update pizzeria
set rating = 4
where name = 'Dominos';

update pizzeria
set rating = 4
where name = 'Pizza Hut';

commit;

select sum(rating)
from pizzeria;

-- Session 2
begin;

update pizzeria
set rating = 3
where name = 'Pizza Hut';

update pizzeria
set rating = 3
where name = 'Dominos';

commit;