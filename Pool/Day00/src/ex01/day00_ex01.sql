SELECT per.name, per.age
FROM person AS per
WHERE per.gender = 'female' 
  AND per.address = 'Kazan'
ORDER BY per.name;