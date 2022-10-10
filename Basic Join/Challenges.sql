# Method 1: MySQL & MS SQL Server
SELECT h.hacker_id, h.name, COUNT(*) AS c_cnt         # c_cnt = the number of challenges completed by each student
FROM Hackers h
JOIN Challenges c ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id, h.name
HAVING c_cnt = (                                      # Students with same c_cnt, if c_cnt = the maximum of challenges completed, include those students 
  SELECT MAX(t1.cnt)
  FROM (
	  SELECT hacker_id, COUNT(*) as cnt
	  FROM Challenges
	  GROUP BY hacker_id
	    ) t1
      )
OR c_cnt IN (                                        # Students with same c_cnt, if c_cnt != the maximum of challenges completed, exclude those students 
  SELECT t2.cnt
  FROM (
	  SELECT hacker_id, COUNT(*) as cnt
	  FROM Challenges
	  GROUP BY hacker_id
        ) t2
  GROUP BY t2.cnt
  HAVING COUNT(t2.cnt) = 1
  )
ORDER BY c_cnt DESC, h.hacker_id


# Method 2: MS SQL Server
SELECT hacker_id, name, c_cnt
FROM (
    SELECT hacker_id, name, c_cnt,
           COUNT(*) OVER(PARTITION BY c_cnt) AS same_cnt,
           MAX(c_cnt) OVER() AS max_cnt
    FROM (
        SELECT h.hacker_id, h.name, COUNT(*) AS c_cnt
        FROM Hackers h
        JOIN Challenges c ON h.hacker_id = c.hacker_id
        GROUP BY h.hacker_id, h.name
        ) t1
        ) t2
WHERE c_cnt = max_cnt
OR  (c_cnt != max_cnt AND same_cnt = 1)
ORDER BY c_cnt DESC, hacker_id;    

