--MySQL
SET @number = 0;
SELECT REPEAT('* ', @number := @number + 1) 
FROM information_schema.tables
WHERE @number < 20;

--MS SQL Server
DECLARE @number INT = 1; 
WHILE @number <=20 
    BEGIN PRINT(REPLICATE('* ',@number));
    SET @number = @number + 1; 
END;
