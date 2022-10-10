# Method 1: MySQL & MS SQL Server
SELECT w.id, wp.age, w.coins_needed, w.power
FROM wands w
JOIN wands_property wp ON w.code = wp.code
WHERE is_evil = 0
AND w.coins_needed = (
    SELECT MIN(coins_needed)
    FROM wands w1
    JOIN wands_property wp1 ON w1.code = wp1.code
    WHERE w1.power = w.power 
    AND wp1.age = wp.age)
ORDER BY w.power DESC, wp.age DESC;

# Method 2: MS SQL Server
SELECT t.id, t.age, t.coins_needed, t.power
FROM (
    SELECT w.id, wp.age, w.coins_needed, w.power,
           ROW_NUMBER() OVER(PARTITION BY w.code, w.power 
                        ORDER BY w.power DESC, w.coins_needed) AS rn
    FROM Wands w
    JOIN Wands_Property wp ON w.code = wp.code
    WHERE is_evil = 0
    ) t
WHERE t.rn = 1
ORDER BY t.power DESC, t.age DESC;
