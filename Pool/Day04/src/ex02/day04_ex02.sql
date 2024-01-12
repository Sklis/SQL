CREATE VIEW v_generated_dates AS
SELECT day::date AS generated_date
FROM generate_series('2022-01-01'::date, '2022-01-31'::date, '1 day') day
ORDER BY 1;

-- SELECT * FROM v_generated_dates;