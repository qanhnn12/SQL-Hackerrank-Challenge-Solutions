-- MySQL
SELECT 
    ct.contest_id, ct.hacker_id, ct.name, 
    SUM(total_submissions), SUM(total_accepted_submissions),
    SUM(total_views), SUM(total_unique_views)
FROM Contests ct
JOIN Colleges cl ON ct.contest_id = cl.contest_id
JOIN Challenges chl ON cl.college_id = chl.college_id
LEFT JOIN (
	SELECT challenge_id, 
		SUM(total_views) AS total_views, 
		SUM(total_unique_views) AS total_unique_views
	FROM View_Stats 
	GROUP BY challenge_id) vs
ON chl.challenge_id = vs.challenge_id
LEFT JOIN (
	SELECT challenge_id, 
		SUM(total_submissions) AS total_submissions, 
		SUM(total_accepted_submissions) AS total_accepted_submissions
	FROM Submission_Stats 
	GROUP BY challenge_id) ss 
ON chl.challenge_id = ss.challenge_id
GROUP BY ct.contest_id, ct.hacker_id, ct.name
HAVING SUM(total_submissions) != 0 
OR SUM(total_accepted_submissions) != 0 
OR SUM(total_views) != 0 
OR SUM(total_unique_views) != 0
ORDER BY ct.contest_id;



--MS SQL Server
WITH VStats AS (
SELECT challenge_id, 
	SUM(total_views) AS total_views, 
	SUM(total_unique_views) AS total_unique_views
FROM View_Stats 
GROUP BY challenge_id)
,
SStats AS (
SELECT challenge_id, 
	SUM(total_submissions) AS total_submissions, 
	SUM(total_accepted_submissions) AS total_accepted_submissions
FROM Submission_Stats 
GROUP BY challenge_id)

SELECT 
    ct.contest_id, ct.hacker_id, ct.name, 
    SUM(total_submissions), SUM(total_accepted_submissions),
    SUM(total_views), SUM(total_unique_views)
FROM Contests ct
JOIN Colleges cl ON ct.contest_id = cl.contest_id
JOIN Challenges chl ON cl.college_id = chl.college_id
LEFT JOIN VStats vs ON chl.challenge_id = vs.challenge_id
LEFT JOIN SStats ss ON chl.challenge_id = ss.challenge_id
GROUP BY ct.contest_id, ct.hacker_id, ct.name
HAVING SUM(total_submissions) != 0 
OR SUM(total_accepted_submissions) != 0 
OR SUM(total_views) != 0 
OR SUM(total_unique_views) != 0
ORDER BY ct.contest_id;
