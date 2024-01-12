create unique index idx_person_order_order_date
    on person_order (person_id, menu_id)
    where order_date = '2022-01-01';

set enable_seqscan = off;

explain analyse
select  person_id, menu_id
from person_order
where order_date = '2022-01-01' and person_id = 2;