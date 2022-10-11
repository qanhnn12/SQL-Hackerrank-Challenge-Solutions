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
