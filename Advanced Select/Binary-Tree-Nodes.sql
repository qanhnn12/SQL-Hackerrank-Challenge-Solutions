--MySQL & MS SQL Server
SELECT
    CASE WHEN P IS NULL THEN CONCAT(N, ' Root')
         WHEN N IN (SELECT DISTINCT P 
                    FROM BST 
                    WHERE P IS NOT NULL) THEN CONCAT(N, ' Inner')
    ELSE CONCAT(N, ' Leaf') END
FROM BST
ORDER BY N;
