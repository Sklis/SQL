with dates as (
        select day::date as missing_date
        from generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') as day),
     visits as (select pv.visit_date
                from person_visits as pv
                where pv.person_id = 1
                    or pv.person_id = 2)
select dates.missing_date
from dates
    full outer join visits on dates.missing_date = visits.visit_date
where visit_date is null
order by missing_date;