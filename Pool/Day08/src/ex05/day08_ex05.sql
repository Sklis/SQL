-- Session 1
begin transaction isolation level read committed;

select sum(rating) from pizzeria;

select sum(rating) from pizzeria;

commit;

select sum(rating) from pizzeria;

--Session 2
begin transaction isolation level read committed;

update pizzeria
set rating = 1
where name = 'Pizza Hut';

commit;

select sum(rating)
from pizzeria;