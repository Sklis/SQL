-- Session 1
begin transaction isolation level repeatable read;

select sum(rating)
from pizzeria;

select sum(rating)
from pizzeria;

commit;

select sum(rating)
from pizzeria;

--Session 2
begin transaction isolation level repeatable read;

update pizzeria
set rating = 5 where name = 'Pizza Hut';

commit;

select sum(rating) from pizzeria;