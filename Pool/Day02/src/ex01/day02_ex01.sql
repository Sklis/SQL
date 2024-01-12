select day::date as missing_date
from generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') as day
    left join (select pv.visit_date
                from person_visits as pv
                where pv.person_id = 1
                    or pv.person_id = 2) as query
                on day = query.visit_date
where visit_date is null
order by missing_date;