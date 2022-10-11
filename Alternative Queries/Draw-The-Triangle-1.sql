--MySQL
SET @number = 21;
SELECT REPEAT('* ', @number := @number - 1) 
FROM information_schema.tables;

--MS SQL Server
DECLARE @number INT = 20; 
WHILE @number >= 0 
    BEGIN PRINT(REPLICATE('* ',@number));
    SET @number = @number - 1; 
END;
