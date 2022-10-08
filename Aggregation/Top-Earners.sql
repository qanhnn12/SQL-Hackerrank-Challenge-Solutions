# Method 1: MySQL & MS SQL Server
SELECT salary*months, COUNT(*)
FROM Employee 
WHERE salary*months = (SELECT MAX(salary*months)
                       FROM Employee )
GROUP BY salary*months;

# Method 2: MySQL
SELECT salary*months, COUNT(*)
FROM Employee 
GROUP BY salary*months
ORDER BY salary*months DESC
LIMIT 1;

# Method 2: MS SQL Server
SELECT TOP 1 salary*months, COUNT(*)
FROM Employee 
GROUP BY salary*months
ORDER BY salary*months DESC;
