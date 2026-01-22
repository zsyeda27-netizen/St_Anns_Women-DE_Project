-- Day 4 SQL Homework Solutions

-- Q1: Find the names of students who improved their scores every single day (Day 3 > Day 2 AND Day 2 > Day 1). 
-- Also, display the name of the Month they were born in using a date function.
SELECT 
    r.full_name, 
    TO_CHAR(r.dob, 'FMMonth') AS birth_month, 
    d1.total_score AS day1, 
    d2.total_score AS day2, 
    d3.total_score AS day3
FROM RSVP_New r
JOIN day_1_exam d1 ON r.hall_ticket_no = d1.hall_ticket_no
JOIN day_2_exam d2 ON r.hall_ticket_no = d2.hall_ticket_no
JOIN day_3_exam d3 ON r.hall_ticket_no = d3.hall_ticket_no
WHERE d3.total_score > d2.total_score 
  AND d2.total_score > d1.total_score;

-- Q2: List the names and contact numbers of students who attended the Day 1 AND Day 2 exams, 
-- but EXCEPT those who showed up for Day 3.
SELECT 
    r.full_name, 
    r.contact_no
FROM RSVP_New r
JOIN day_1_exam d1 ON r.hall_ticket_no = d1.hall_ticket_no
JOIN day_2_exam d2 ON r.hall_ticket_no = d2.hall_ticket_no
EXCEPT
SELECT 
    r.full_name, 
    r.contact_no
FROM RSVP_New r
JOIN day_3_exam d3 ON r.hall_ticket_no = d3.hall_ticket_no;

-- Q3: Find the students who registered in the Morning (before 12:00 PM) 
-- and scored higher than the average class score of Day 3.
SELECT 
    r.full_name, 
    r.created_at, 
    d3.total_score
FROM RSVP_New r
JOIN day_3_exam d3 ON r.hall_ticket_no = d3.hall_ticket_no
WHERE r.created_at::TIME < '12:00:00'
  AND d3.total_score > (SELECT AVG(total_score) FROM day_3_exam)
ORDER BY d3.total_score DESC;

-- Q4: Create a master leaderboard. Combine the Hall Ticket Numbers and scores from all 3 days. 
-- Use a CASE statement to label them: if the combined score across all 3 days is >120, they are a 'GOAT', 
-- otherwise 'Rising Legend'
SELECT 
    r.hall_ticket_no, 
    (COALESCE(d1.total_score, 0) + COALESCE(d2.total_score, 0) + COALESCE(d3.total_score, 0)) AS total_points,
    CASE 
        WHEN (COALESCE(d1.total_score, 0) + COALESCE(d2.total_score, 0) + COALESCE(d3.total_score, 0)) > 120 THEN 'GOAT'
        ELSE 'Rising Legend'
    END AS final_status
FROM RSVP_New r
LEFT JOIN day_1_exam d1 ON r.hall_ticket_no = d1.hall_ticket_no
LEFT JOIN day_2_exam d2 ON r.hall_ticket_no = d2.hall_ticket_no
LEFT JOIN day_3_exam d3 ON r.hall_ticket_no = d3.hall_ticket_no
WHERE d1.total_score IS NOT NULL 
   OR d2.total_score IS NOT NULL 
   OR d3.total_score IS NOT NULL
ORDER BY total_points DESC;
