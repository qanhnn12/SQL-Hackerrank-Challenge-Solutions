--MySQL
SELECT CEIL(AVG(Salary)-AVG(REPLACE(Salary,'0','')))
FROM EMPLOYEES;

--MS SQL Server
SELECT CAST(
    CEILING(
           (AVG(CAST(Salary AS Float)) 
           - AVG(CAST(REPLACE(Salary, 0, '') AS Float)))) 
        AS INT)
FROM EMPLOYEES;
