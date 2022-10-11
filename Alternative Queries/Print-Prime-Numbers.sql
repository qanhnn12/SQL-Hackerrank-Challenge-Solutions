--MySQL
SET @potential_prime = 1;
SET @divisor = 1;

SELECT GROUP_CONCAT(POTENTIAL_PRIME SEPARATOR '&') 
FROM
    (SELECT @potential_prime := @potential_prime + 1 AS POTENTIAL_PRIME       
    FROM information_schema.tables t1, information_schema.tables t2             # Since each information_schema.table has less than 1000 rows, use 2 tables
    LIMIT 1000) list_of_potential_primes
WHERE NOT EXISTS (
    SELECT * FROM
        (SELECT @divisor := @divisor + 1 AS DIVISOR 
        FROM information_schema.tables t3, information_schema.tables t4
        LIMIT 1000) list_of_divisors
    WHERE MOD(POTENTIAL_PRIME, DIVISOR) = 0 AND POTENTIAL_PRIME != DIVISOR);
    
    
--MS SQL Server
WITH cte(num) AS (
  SELECT 2
  UNION ALL 
  SELECT num+1 FROM cte
  WHERE num+1 < 1000
  )
  
SELECT STRING_AGG(a.num, '&')       # a.num = potential_prime
FROM cte a
WHERE NOT EXISTS (
   SELECT * 
   FROM cte b
   WHERE a.num % b.num = 0          # b.num = divisor
   AND a.num != b.num )
OPTION (MAXRECURSION 1000);
    
