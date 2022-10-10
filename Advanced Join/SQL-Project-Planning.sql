--MySQL
SET sql_mode = '';
SELECT Start_Date, End_Date
FROM 
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b 
WHERE Start_Date < End_Date
GROUP BY Start_Date 
ORDER BY DATEDIFF(End_Date, Start_Date), Start_Date

--MS SQL Server
SELECT MIN(start_date), MAX(end_date)
FROM (
    SELECT 
        start_date, end_date, 
        SUM(flag) OVER(ORDER BY start_date) AS grp
    FROM (
        SELECT 
            task_id, start_date, end_date,
            CASE WHEN LAG(end_date) OVER(ORDER BY start_date) = start_date 
                 THEN 0 ELSE 1 END AS flag
        FROM Projects
        ) t1
        ) t2
GROUP BY grp
ORDER BY DATEDIFF(DAY, MIN(start_date), MAX(end_date)), MIN(start_date)
