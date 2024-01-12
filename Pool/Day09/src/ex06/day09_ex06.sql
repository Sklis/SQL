CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
    pperson VARCHAR DEFAULT 'Dmitriy',
    pprice INTEGER DEFAULT 500,
    pdate DATE DEFAULT '2022-01-08'
)
    RETURNS TABLE (name VARCHAR)
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT pizzeria.name
        FROM  pizzeria
                  JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
                  JOIN person ON person.id  = person_visits.person_id
                  JOIN menu ON menu.pizzeria_id = pizzeria.id
        WHERE person.name = pperson
          AND menu.price < pprice
          AND person_visits.visit_date = pdate;
END;
$$;

select *
from fnc_person_visits_and_eats_on_date(pprice := 800);
select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
