--MySQL & MS SQL Server
# Method 1: 
SELECT f1.X, f1.Y
FROM Functions f1, Functions f2
WHERE f1.X = f2.Y
AND f2.X = f1.Y
AND f1.X <= f1.Y
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X)>1 or f1.X<f1.Y
ORDER BY f1.X 

# Method 2:
SELECT f1.X, f1.Y 
FROM Functions f1
JOIN Functions f2 ON f1.X=f2.Y AND f1.Y=f2.X
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X)>1 or f1.X<f1.Y
ORDER BY f1.X 
