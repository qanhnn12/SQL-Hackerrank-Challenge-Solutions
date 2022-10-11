--MySQL
SELECT submission_date,

      (SELECT COUNT(DISTINCT hacker_id)
       FROM Submissions AS s2
       WHERE s2.submission_date = s1.submission_date
       AND (SELECT COUNT(DISTINCT submission_date)
            FROM Submissions AS s3
            WHERE s3.hacker_id = s2.hacker_id 
            AND s3.submission_date < s2.submission_date
            ) = DATEDIFF(s1.submission_date,'2016-03-01')),
                                  
      (SELECT hacker_id
       FROM Submissions AS s4
       WHERE s4.submission_date = s1.submission_date
       GROUP BY hacker_id
       ORDER BY COUNT(submission_id) DESC, hacker_id 
       LIMIT 1) AS h_id,
        
      (SELECT name
       FROM Hackers
       WHERE hacker_id = h_id)
        
FROM (SELECT DISTINCT submission_date FROM Submissions) AS s1;

--MS SQL Server
WITH ConsistentHackers AS (
	SELECT s.submission_date,
               s.hacker_id
	FROM Submissions s
      	WHERE s.submission_date = '2016-03-01'
      	UNION ALL
      	SELECT ADDDATE(ch.submission_date,1),
               s.hacker_id
      	FROM Submissions s
      	JOIN ConsistentHackers ch
      	ON s.hacker_id = ch.hacker_id
      	AND s.submission_date = ADDDATE(ch.submission_date,1))
,
ConsistencyCounts AS (
	SELECT ch.submission_date,
               COUNT(DISTINCT ch.hacker_id) AS ConsistentHackers
	FROM ConsistentHackers ch
      	GROUP BY ch.submission_date)
,
SubmissionsSummary AS (
	SELECT s.submission_date,
               s.hacker_id,
               ROW_NUMBER() OVER (PARTITION BY s.submission_date 
				  ORDER BY COUNT(*) DESC, s.hacker_id ASC
             ) AS ranking
    	FROM Submissions s
    	GROUP BY s.submission_date, s.hacker_id )

SELECT
    ss.submission_date,
    cc.ConsistentHackers,
    h.hacker_id,
    h.name
FROM SubmissionsSummary ss
JOIN ConsistencyCounts cc
    ON ss.submission_date = cc.submission_date
    AND ss.ranking = 1
JOIN Hackers h
    ON ss.hacker_id = h.hacker_id
ORDER BY ss.submission_date ASC;
