--MySQL
---Method 1:
SET @prime = 1;
SET @divisor = 1;

SELECT GROUP_CONCAT(a SEPARATOR '&') 
FROM
    (SELECT @prime := @prime + 1 AS a       
    FROM information_schema.tables t1, information_schema.tables t2             
    LIMIT 1000) list_of_potential_primes
WHERE NOT EXISTS (
    SELECT * FROM
        (SELECT @divisor := @divisor + 1 AS b 
        FROM information_schema.tables t3, information_schema.tables t4
        LIMIT 1000) list_of_divisors
    WHERE MOD(a, b) = 0 AND a != b);

---Method 2:
WITH RECURSIVE cte(num) AS (
  SELECT 2
  UNION ALL 
  SELECT num+1 FROM cte
  WHERE num+1 < 1000
  )
  
SELECT GROUP_CONCAT(a.num SEPARATOR '&')        # a.num = prime
FROM cte a
WHERE NOT EXISTS (
   SELECT * 
   FROM cte b
   WHERE MOD(a.num, b.num)=0                    # b.num = divisor
   AND a.num != b.num )
    
    
--MS SQL Server
WITH cte(num) AS (
  SELECT 2
  UNION ALL 
  SELECT num+1 FROM cte
  WHERE num+1 < 1000
  )
  
SELECT STRING_AGG(a.num, '&')       # a.num = prime
FROM cte a
WHERE NOT EXISTS (
   SELECT * 
   FROM cte b
   WHERE a.num % b.num = 0          # b.num = divisor
   AND a.num != b.num )
OPTION (MAXRECURSION 1000);
    
