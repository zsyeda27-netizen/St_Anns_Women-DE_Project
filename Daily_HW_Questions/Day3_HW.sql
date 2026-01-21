-- Day 3 SQL Homework Solutions

-- Q1: Find the Average, Maximum, and Minimum marks obtained in the Day 1 Exam.
SELECT 
    AVG(total_score) AS average_marks, 
    MAX(total_score) AS highest_marks, 
    MIN(total_score) AS lowest_marks 
FROM day_1_exam;

-- Q2: List the names of MBA students who scored above 35 on Day 2.
SELECT 
    r.full_name, 
    d.total_score 
FROM RSVP_New r
JOIN day_2_exam d ON r.hall_ticket_no = d.hall_ticket_no
WHERE r.department_name = 'Master of Business Administration (MBA)' 
AND d.total_score > 35;

-- Q3: Identify students whose Day 2 score was strictly higher than their Day 1 score.
SELECT 
    r.full_name, 
    d1.total_score AS day1, 
    d2.total_score AS day2 
FROM RSVP_New r
JOIN day_1_exam d1 ON r.hall_ticket_no = d1.hall_ticket_no
JOIN day_2_exam d2 ON r.hall_ticket_no = d2.hall_ticket_no
WHERE d2.total_score > d1.total_score;

-- Q4: Do passing students work faster? Join day_2_exam with qaday2 to find the average 'Total Time' for students who 'Pass' vs those who 'Fail'.
SELECT 
    d.result_status, 
    AVG(q."Total Time") AS avg_total_time 
FROM day_2_exam d
JOIN qaday2 q ON d.hall_ticket_no = q.hall_ticket_no
GROUP BY d.result_status;

-- Q5: Which students have NULLs in Q1 or Q2 but still passed the Day 2 exam?
SELECT 
    r.full_name 
FROM RSVP_New r
JOIN qaday2 q ON r.hall_ticket_no = q.hall_ticket_no
JOIN day_2_exam d ON r.hall_ticket_no = d.hall_ticket_no
WHERE (q.Q1 IS NULL OR q.Q2 IS NULL) 
AND d.result_status = 'Pass';

-- Q6: For each department, show the total number of registrations, total students who took Day 1, and total students who took Day 2.
SELECT 
    r.department_name, 
    COUNT(r.hall_ticket_no) AS registrations, 
    COUNT(d1.hall_ticket_no) AS attended_day1, 
    COUNT(d2.hall_ticket_no) AS attended_day2
FROM RSVP_New r
LEFT JOIN day_1_exam d1 ON r.hall_ticket_no = d1.hall_ticket_no
LEFT JOIN day_2_exam d2 ON r.hall_ticket_no = d2.hall_ticket_no
GROUP BY r.department_name;

-- Q7: Using the dob (Date of Birth) in RSVP_New, identify students born before the year 2000 as 'Senior Students' and those born in 2000 or later as 'Junior Students'.
SELECT 
    full_name, 
    dob, 
    CASE 
        WHEN dob < '2000-01-01' THEN 'Senior Student' 
        ELSE 'Junior Student' 
    END AS age_group
FROM RSVP_New;

-- Q8: Join day_2_exam with qaday2. Create a logic: If 'Total Time' is less than 1000 and 'Result' is 'Pass', label them as 'High Efficiency'. 
-- If they passed but took longer, label them as 'Hard Worker'. Else 'Needs Support'.
SELECT 
    d.hall_ticket_no, 
    d.result_status, 
    q."Total Time", 
    CASE 
        WHEN q."Total Time" < 1000 AND d.result_status = 'Pass' THEN 'High Efficiency'
        WHEN d.result_status = 'Pass' THEN 'Hard Worker'
        ELSE 'Needs Support'
    END AS efficiency_rank
FROM day_2_exam d
JOIN qaday2 q ON d.hall_ticket_no = q.hall_ticket_no;

-- Q9: Question 1 (Q1) finishing time logic.
-- < 15s: 'Quick to Fall in Love'
-- > 60s: 'Hard to Get'
-- NULL: 'Focusing on their Career'
-- Else: 'Waiting for the Right One'
SELECT 
    hall_ticket_no, 
    Q1, 
    CASE 
        WHEN Q1 < 15 THEN 'Quick to Fall in Love'
        WHEN Q1 > 60 THEN 'Hard to Get'
        WHEN Q1 IS NULL THEN 'Focusing on their Career'
        ELSE 'Waiting for the Right One'
    END AS love_logic
FROM qaday2;

-- Q10: Get the full details from RSVP_New for the student who got the absolute maximum score on Day 2. (using subquery)
SELECT * 
FROM RSVP_New 
WHERE hall_ticket_no IN (
    SELECT hall_ticket_no 
    FROM day_2_exam 
    WHERE total_score = (SELECT MAX(total_score) FROM day_2_exam)
);

-- Q11: Who registered for the class before 'AMENAH AHSAN'? (using subquery)
SELECT 
    full_name, 
    created_at 
FROM RSVP_New 
WHERE created_at < (
    SELECT created_at 
    FROM RSVP_New 
    WHERE full_name = 'AMENAH AHSAN'
    LIMIT 1
);

-- Q12: Show the details of students who are among the 5 fastest finishers of the Day 2 exam.
SELECT 
    r.* 
FROM RSVP_New r
JOIN qaday2 q ON r.hall_ticket_no = q.hall_ticket_no
ORDER BY q."Total Time" ASC
LIMIT 5;
