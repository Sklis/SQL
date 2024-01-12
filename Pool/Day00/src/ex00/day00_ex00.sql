-- Active: 1699003323355@@127.0.0.1@5432
SELECT per.name, per.age
FROM person AS per
WHERE per.address = 'Kazan';