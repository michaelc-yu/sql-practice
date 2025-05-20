
-- 1. Find users who signed up after January 1, 2024
SELECT name, signup_date FROM users
WHERE signup_date > '2024-01-01';

-- 2. Find users who signed up in the year 2023
SELECT name, signup_date FROM users
WHERE signup_date >= '2023-01-01' AND signup_date < '2024-01-01';

-- 3. Show all courses created before the year 2018
SELECT title, created_at FROM courses
WHERE created_at < '2018-01-01';

-- 4. List all users who signed up in March 2025
SELECT name, signup_date FROM users
WHERE signup_date >= '2025-03-01'
AND signup_date < '2025-04-01';

-- 5. List users with Gmail addresses who signed up before 2024
SELECT name, email, signup_date FROM users
WHERE email LIKE '%@gmail.com'
AND signup_date < '2024-01-01';

-- 6. List courses with 'ML' in the title (case-sensitive) that were created in or after 2018
SELECT title, created_at FROM courses
WHERE title LIKE '%ML%'
AND created_at >= '2018-01-01';

-- 7. List the names of users who are enrolled in more than one course
SELECT name FROM users
WHERE id IN (
  SELECT user_id
  FROM enrollments
  GROUP BY user_id
  HAVING COUNT(*) > 1
);

-- 8. List each user's name and the titles of courses they enrolled in during 2024
SELECT 
  u.name AS user_name,
  c.title AS course_title
FROM users u
JOIN enrollments e
  ON u.id = e.user_id
JOIN courses c
  ON c.id = e.course_id
WHERE e.enrolled_at >= '2024-01-01' AND e.enrolled_at < '2025-01-01';

-- 9. List users who have enrolled in a course created before 2018
SELECT
  u.name AS user_name,
  c.title AS course_title,
  c.created_at AS course_created_at
FROM users u
JOIN enrollments e
  ON u.id = e.user_id
JOIN courses c
  ON c.id = e.course_id
WHERE c.created_at < '2018-01-01';

-- 10. List users who enrolled in a course before the course was created
SELECT
  u.name AS user_name,
  c.title AS course_title,
  e.enrolled_at AS enrolled_at,
  c.created_at AS created_at
FROM users u
JOIN enrollments e
  ON u.id = e.user_id
JOIN courses c
  ON c.id = e.course_id
WHERE e.enrolled_at < c.created_at;

-- 11. Show each course title along with how many users have enrolled in it
SELECT
  c.title AS course_title,
  COUNT(*) AS enrollment_count
FROM courses c
JOIN enrollments e
  ON c.id = e.course_id
GROUP BY c.id;

-- 12. List all distinct users who have enrolled in any course
SELECT
  DISTINCT u.name AS user_name
FROM users u
JOIN enrollments e
  ON u.id = e.user_id;

-- 13. List all courses (with or without enrollments) and how many users enrolled in each
SELECT
  c.title AS course_title,
  COUNT(e.user_id) AS enrollment_count
FROM courses c
LEFT JOIN enrollments e
  ON c.id = e.course_id
GROUP BY c.title;

-- 14. List all courses that have never been enrolled in
SELECT
  c.title AS course_title
FROM courses c
LEFT JOIN enrollments e
  ON c.id = e.course_id
WHERE e.user_id IS NULL;

-- 15. Find the names of users who are enrolled in the most popular course
SELECT
  u.name
FROM users u
JOIN enrollments e
  ON u.id = e.user_id
WHERE e.course_id = (
  SELECT course_id
  FROM enrollments
  GROUP BY course_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
);

-- 16. List all users who are not enrolled in any course
SELECT
  u.name AS user_name
FROM users u
WHERE u.id NOT IN (
  SELECT DISTINCT user_id FROM enrollments
);

-- 17. For each user, list their name and how many courses they are enrolled in
SELECT
  u.name AS user_name,
  COUNT(e.user_id) AS enrollment_count
FROM users u
JOIN enrollments e
  ON u.id = e.user_id
GROUP BY u.id;

-- 18. List all users who are enrolled in all courses created before 2019
SELECT
  u.name
FROM users u
JOIN enrollments e ON u.id = e.user_id
JOIN courses c ON c.id = e.course_id
WHERE c.created_at < '2019-01-01'
GROUP BY u.id, u.name
HAVING COUNT(DISTINCT c.id) = (
  SELECT COUNT(*) FROM courses WHERE created_at < '2019-01-01'
);

-- 19. List all course titles where more than one user has enrolled, and the title contains the word 'for' (case-insensitive)
SELECT
  c.title AS course_title, 
  COUNT(e.user_id) AS enrollment_count
FROM courses c
JOIN enrollments e
  ON c.id = e.course_id
WHERE LOWER(c.title) LIKE '%for%'
GROUP BY c.id
HAVING COUNT(DISTINCT e.user_id) > 1;

-- 20. Using a CTE, list users who enrolled in more than 1 course, along with how many courses they enrolled in
WITH user_counts AS (
  SELECT
    u.id AS user_id,
    u.name,
    COUNT(e.user_id) AS enrollment_count
  FROM users u
  JOIN enrollments e
    ON u.id = e.user_id
  GROUP BY u.id, u.name
)

SELECT name, enrollment_count
FROM user_counts
WHERE enrollment_count > 1;



