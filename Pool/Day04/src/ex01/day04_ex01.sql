SELECT female.name
FROM v_persons_female female
UNION ALL
SELECT male.name
FROM v_persons_male male
ORDER BY 1;