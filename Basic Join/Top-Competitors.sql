--MySQL & MS SQL Server
SELECT t.hacker_id, t.name
FROM (
  SELECT 
    s.hacker_id, h.name, s.challenge_id, c.difficulty_level,
    s.score AS hacker_score, 
    d.score AS max_score
  FROM Submissions s
  JOIN Challenges c ON s.challenge_id = c.challenge_id
  JOIN Difficulty d ON d.difficulty_level = c.difficulty_level
  JOIN Hackers h ON h.hacker_id = s.hacker_id
  WHERE s.score = d.score
    ) t
GROUP BY t.hacker_id, t.name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, t.hacker_id;
