--MySQL & MS SQL Server
SELECT s.NAme
FROM Students s
JOIN Friends f ON s.ID = f.Friend_ID
JOIN Packages p1 ON s.ID = p1.ID
JOIN Packages p2 ON f.Friend_ID = p2.ID
WHERE p1.Salary < p2.Salary
ORDER BY p2.Salary;
