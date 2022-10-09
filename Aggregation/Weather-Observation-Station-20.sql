--MySQL
SELECT COUNT(*) INTO @cnt
FROM STATION;

SELECT ROUND(AVG(LAT_N),4)
FROM (
    SELECT 
        LAT_N,
        ROW_NUMBER()OVER(ORDER BY LAT_N) AS num
    FROM STATION
    ) t
WHERE MOD(@cnt,2) = 0 
AND t.num IN (@cnt/2, @cnt/2+1)
OR t.num = (@cnt+1)/2;


--MS SQL Server
--- Method 1:
DECLARE @cnt INT
SET @cnt = (SELECT COUNT(*) FROM STATION);

SELECT ROUND(AVG(LAT_N),4)
FROM (
    SELECT 
        LAT_N,
        ROW_NUMBER()OVER(ORDER BY LAT_N) AS num
    FROM STATION
    ) t
WHERE @cnt%2 = 0 
AND t.num IN (@cnt/2, @cnt/2+1)
OR t.num = (@cnt+1)/2;

--- Method 2:
SELECT 
TOP 1 CAST(
  PERCENTILE_CONT(0.5) 
  WITHIN GROUP (ORDER BY LAT_N) OVER() AS DECIMAL(10,4))
FROM STATION;
