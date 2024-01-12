WITH RECURSIVE possible_route AS (
  SELECT
    tp.point2,
    tp.cost,
    1 AS step,
    ARRAY['a']AS arr_node
  FROM nodes AS tp
  WHERE tp.point1 = 'a'
  UNION ALL
  SELECT
    tp.point2,
    pr.cost + tp.cost,
    pr.step + 1,
    array_append(pr.arr_node, pr.point2)
  FROM
    possible_route pr
    JOIN nodes tp ON tp.point1 = pr.point2
  WHERE
    tp.point1 <> ALL (pr.arr_node)
    AND step < 4
)
SELECT
  pr.cost AS total_cost,
  array_append(arr_node, 'a') AS tour
FROM
  possible_route pr
WHERE
  pr.point2 = 'a'
  AND pr.step=4
  AND (
        pr.cost = (
          SELECT min(cost)
          FROM possible_route pr
          WHERE
            pr.point2 = 'a'
            AND pr.step=4
        ) OR pr.cost = (
          SELECT max(cost)
          FROM possible_route pr
          WHERE pr.point2 = 'a'
          AND pr.step=4
        )
      )
ORDER BY
  total_cost,
  tour
