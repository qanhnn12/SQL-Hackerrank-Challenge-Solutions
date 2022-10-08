--MySQL & MS SQL Server
SELECT 
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
FROM (
    SELECT 
        Name, 
        Occupation,
        ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
    ) tmp
GROUP BY rn;

--MS SQL Server
SELECT 
  [Doctor], [Professor], [Singer], [Actor]
FROM (
  SELECT 
    Name, Occupation,
    ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
  FROM Occupations ) AS tmp
PIVOT (
  MAX(Name) FOR Occupation IN ([Doctor], [Professor], [Singer], [Actor])) AS pvt;
