-- Assumptions:
-- Table name: Students
-- Columns: student_name, score, result_status

-- Q1: Count how many students passed the exam.
SELECT COUNT(*) FROM Students WHERE result_status = 'Pass';

-- Q2: Find the average score of all students who failed.
SELECT AVG(score) FROM Students WHERE result_status = 'Fail';

-- Q3: Get the highest score among all students.
SELECT MAX(score) FROM Students;

-- Q4: Get the lowest score among passed students.
SELECT MIN(score) FROM Students WHERE result_status = 'Pass';

-- Q5: Sum the total marks of all students who scored above 40.
SELECT SUM(score) FROM Students WHERE score > 40;

-- Q6: Count students by result status for those who scored 35 or more.
SELECT result_status, COUNT(*) FROM Students WHERE score >= 35 GROUP BY result_status;

-- Q7: Find average score grouped by result status for students with scores between 30 and 40.
SELECT result_status, AVG(score) FROM Students WHERE score BETWEEN 30 AND 40 GROUP BY result_status;

-- Q8: Get maximum and minimum scores grouped by result status for students who scored less than 35.
SELECT result_status, MAX(score), MIN(score) FROM Students WHERE score < 35 GROUP BY result_status;

-- Q9: Count students grouped by result status for those whose names start with 'A'.
SELECT result_status, COUNT(*) FROM Students WHERE student_name LIKE 'A%' GROUP BY result_status;

-- Q10: Sum total scores grouped by result status for students who scored exactly 35, 40, or 45.
SELECT result_status, SUM(score) FROM Students WHERE score IN (35, 40, 45) GROUP BY result_status;

-- Q11: Count students by each score value, ordered by score descending.
SELECT score, COUNT(*) FROM Students GROUP BY score ORDER BY score DESC;

-- Q12: Show average score for each result status, ordered by average score.
SELECT result_status, AVG(score) as avg_score FROM Students GROUP BY result_status ORDER BY avg_score;

-- Q13: Count how many students got each score, only for scores above 30, ordered by frequency.
SELECT score, COUNT(*) as frequency FROM Students WHERE score > 30 GROUP BY score ORDER BY frequency;

-- Q14: Get total marks sum for each result status, ordered by sum.
SELECT result_status, SUM(score) as total_marks FROM Students GROUP BY result_status ORDER BY total_marks;

-- Q15: Find minimum score for each result status, ordered by min score.
SELECT result_status, MIN(score) as min_score FROM Students GROUP BY result_status ORDER BY min_score;

-- Q16: For passed students only, show count, average, max and min scores grouped by whether score is above 40.
SELECT 
    CASE WHEN score > 40 THEN 'Above 40' ELSE '40 or Below' END as score_range,
    COUNT(*) as student_count,
    AVG(score) as avg_score,
    MAX(score) as max_score,
    MIN(score) as min_score
FROM Students
WHERE result_status = 'Pass'
GROUP BY CASE WHEN score > 40 THEN 'Above 40' ELSE '40 or Below' END;

-- Q17: Count and average score for each result status, only for scores not equal to 35.
SELECT result_status, COUNT(*), AVG(score) FROM Students WHERE score != 35 GROUP BY result_status;

-- Q18: Group students by score ranges (0-20, 21-30, 31-40, 41-50) and show count for each range.
SELECT 
    CASE 
        WHEN score BETWEEN 0 AND 20 THEN '0-20'
        WHEN score BETWEEN 21 AND 30 THEN '21-30'
        WHEN score BETWEEN 31 AND 40 THEN '31-40'
        WHEN score BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Other'
    END as score_range,
    COUNT(*)
FROM Students
GROUP BY 
    CASE 
        WHEN score BETWEEN 0 AND 20 THEN '0-20'
        WHEN score BETWEEN 21 AND 30 THEN '21-30'
        WHEN score BETWEEN 31 AND 40 THEN '31-40'
        WHEN score BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Other'
    END;

-- Q19: For each result status, show count of students with scores greater than 30 and less than 40.
SELECT result_status, COUNT(*) FROM Students WHERE score > 30 AND score < 40 GROUP BY result_status;

-- Q20: Group by first letter of student name and show count and average score for each letter.
SELECT SUBSTRING(student_name, 1, 1) as first_letter, COUNT(*), AVG(score) FROM Students GROUP BY SUBSTRING(student_name, 1, 1);
