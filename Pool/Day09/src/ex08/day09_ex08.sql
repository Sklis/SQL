CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop int DEFAULT 10)
    RETURNS SETOF integer
AS $$
WITH RECURSIVE fibonachi_num(curr,next) AS
                   (
                       SELECT
                           0,1
                       UNION ALL
                       SELECT
                           next,curr+next
                       FROM fibonachi_num
                       WHERE next < pstop
                   )
SELECT curr FROM fibonachi_num
$$
    LANGUAGE sql;
select * from fnc_fibonacci(100);
select * from fnc_fibonacci(20);