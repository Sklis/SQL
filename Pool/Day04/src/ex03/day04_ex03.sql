SELECT dates.generated_date AS missing_date
FROM v_generated_dates dates
EXCEPT
SELECT pv.visit_date
FROM person_visits pv
ORDER BY 1;