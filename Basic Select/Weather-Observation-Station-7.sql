--MySQL
# Method 1:
SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(CITY) REGEXP '[aeiou]$';

# Method 2:
SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(CITY) RLIKE '[aeiou]$';

--MS SQL Server
SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(CITY) LIKE '[aeiou]$';
