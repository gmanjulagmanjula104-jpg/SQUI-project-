-- ============================================================
-- SQL QUERY ANSWERS: QUESTIONS 13 TO 34
-- Schema used:
-- departments, students, faculty, course, course_offering,
-- enrollment, attendance, marks
-- MySQL-compatible syntax
-- ============================================================

-- ============================================================
-- BASIC LEVEL
-- ============================================================

-- 13. Display all student details.
SELECT *
FROM students;


-- 14. Display all courses offered by the Computer Science department.
SELECT c.*
FROM course c
JOIN departments d
    ON c.d_id = d.d_id
WHERE d.d_name = 'Computer Science';


-- 15. Display all faculty members.
SELECT *
FROM faculty;


-- 16. Display students studying in the Electronics department.
SELECT s.*
FROM students s
JOIN departments d
    ON s.d_id = d.d_id
WHERE d.d_name = 'Electronics';


-- 17. Display all registered courses for student S101.
-- NOTE: In the sample data provided earlier, student IDs are S001-S020.
-- If S101 exists in a larger dataset, this query works directly.
SELECT c.*
FROM enrollment e
JOIN course c
    ON e.c_id = c.c_id
WHERE e.s_id = 'S101';


-- ============================================================
-- INTERMEDIATE LEVEL
-- ============================================================

-- 18. Display the faculty handling Database Systems.
-- If the actual course name is 'Database Management' in the sample data,
-- use that value. If your database has 'Database Systems', this query
-- works without modification.
SELECT DISTINCT f.*
FROM faculty f
JOIN course_offering co
    ON f.f_id = co.f_id
JOIN course c
    ON co.c_id = c.c_id
WHERE c.c_name = 'Database Systems';

-- For the sample data created earlier, the equivalent is:
-- SELECT DISTINCT f.*
-- FROM faculty f
-- JOIN course_offering co ON f.f_id = co.f_id
-- JOIN course c ON co.c_id = c.c_id
-- WHERE c.c_name = 'Database Management';


-- 19. Calculate total marks obtained by every student.
SELECT
    s.rollno AS student_id,
    s.name,
    SUM(
        COALESCE(m.mid1, 0) +
        COALESCE(m.mid2, 0) +
        COALESCE(m.external, 0)
    ) AS total_marks
FROM students s
LEFT JOIN marks m
    ON s.rollno = m.s_id
GROUP BY s.rollno, s.name;


-- 20. Display students scoring more than 85 marks.
-- Here, "marks" means total marks for a course:
-- Mid1 (40) + Mid2 (40) + External (60) = 140.
SELECT
    s.rollno AS student_id,
    s.name,
    c.c_name AS course,
    (m.mid1 + m.mid2 + m.external) AS total_marks
FROM students s
JOIN marks m
    ON s.rollno = m.s_id
JOIN course c
    ON m.c_id = c.c_id
WHERE (m.mid1 + m.mid2 + m.external) > 85;


-- 21. Display attendance percentage of every student.
SELECT
    s.rollno AS student_id,
    s.name,
    ROUND(
        SUM(a.c_attended) * 100.0 / NULLIF(SUM(a.c_held), 0),
        2
    ) AS attendance_percentage
FROM students s
LEFT JOIN attendance a
    ON s.rollno = a.s_id
GROUP BY s.rollno, s.name;


-- 22. Count the number of students in each department.
SELECT
    d.d_id,
    d.d_name,
    COUNT(s.rollno) AS student_count
FROM departments d
LEFT JOIN students s
    ON d.d_id = s.d_id
GROUP BY d.d_id, d.d_name;


-- 23. Display average marks for every course.
SELECT
    c.c_id,
    c.c_name,
    ROUND(
        AVG(m.mid1 + m.mid2 + m.external),
        2
    ) AS average_marks
FROM course c
LEFT JOIN marks m
    ON c.c_id = m.c_id
GROUP BY c.c_id, c.c_name;


-- 24. Find the student with the highest marks in each course.
-- MySQL 8+ solution using RANK(), which also returns ties.
WITH RankedMarks AS (
    SELECT
        m.c_id,
        m.s_id,
        (m.mid1 + m.mid2 + m.external) AS total_marks,
        RANK() OVER (
            PARTITION BY m.c_id
            ORDER BY (m.mid1 + m.mid2 + m.external) DESC
        ) AS rnk
    FROM marks m
)
SELECT
    c.c_id,
    c.c_name,
    s.rollno AS student_id,
    s.name,
    rm.total_marks
FROM RankedMarks rm
JOIN course c
    ON rm.c_id = c.c_id
JOIN students s
    ON rm.s_id = s.rollno
WHERE rm.rnk = 1;


-- ============================================================
-- ADVANCED LEVEL
-- ============================================================

-- 25. Find students registered for more than one course.
SELECT
    s.rollno AS student_id,
    s.name,
    COUNT(DISTINCT e.c_id) AS course_count
FROM students s
JOIN enrollment e
    ON s.rollno = e.s_id
GROUP BY s.rollno, s.name
HAVING COUNT(DISTINCT e.c_id) > 1;


-- 26. Find students whose attendance is below 75%.
SELECT
    s.rollno AS student_id,
    s.name,
    ROUND(
        SUM(a.c_attended) * 100.0 / NULLIF(SUM(a.c_held), 0),
        2
    ) AS attendance_percentage
FROM students s
JOIN attendance a
    ON s.rollno = a.s_id
GROUP BY s.rollno, s.name
HAVING
    SUM(a.c_attended) * 100.0 / NULLIF(SUM(a.c_held), 0) < 75;


-- 27. Display department-wise toppers.
-- Toppers are calculated using total marks across all recorded courses.
WITH StudentTotals AS (
    SELECT
        s.rollno AS student_id,
        s.name,
        s.d_id,
        SUM(m.mid1 + m.mid2 + m.external) AS total_marks
    FROM students s
    JOIN marks m
        ON s.rollno = m.s_id
    GROUP BY s.rollno, s.name, s.d_id
),
RankedStudents AS (
    SELECT
        st.*,
        RANK() OVER (
            PARTITION BY st.d_id
            ORDER BY st.total_marks DESC
        ) AS rnk
    FROM StudentTotals st
)
SELECT
    d.d_id,
    d.d_name,
    rs.student_id,
    rs.name,
    rs.total_marks
FROM RankedStudents rs
JOIN departments d
    ON rs.d_id = d.d_id
WHERE rs.rnk = 1;


-- 28. Find courses having more than 30 enrolled students.
-- This assumes a larger dataset as stated in the question.
SELECT
    c.c_id,
    c.c_name,
    COUNT(DISTINCT e.s_id) AS enrolled_students
FROM course c
JOIN enrollment e
    ON c.c_id = e.c_id
GROUP BY c.c_id, c.c_name
HAVING COUNT(DISTINCT e.s_id) > 30;


-- 29. Display students who scored above the average marks of their department.
-- Department average = average total marks of students in that department.
WITH StudentTotals AS (
    SELECT
        s.rollno AS student_id,
        s.name,
        s.d_id,
        SUM(m.mid1 + m.mid2 + m.external) AS total_marks
    FROM students s
    JOIN marks m
        ON s.rollno = m.s_id
    GROUP BY s.rollno, s.name, s.d_id
),
DepartmentAverages AS (
    SELECT
        d_id,
        AVG(total_marks) AS department_average
    FROM StudentTotals
    GROUP BY d_id
)
SELECT
    st.student_id,
    st.name,
    d.d_name AS department,
    st.total_marks,
    ROUND(da.department_average, 2) AS department_average
FROM StudentTotals st
JOIN DepartmentAverages da
    ON st.d_id = da.d_id
JOIN departments d
    ON st.d_id = d.d_id
WHERE st.total_marks > da.department_average;


-- 30. Find faculty members teaching more than one course.
SELECT
    f.f_id,
    f.f_name,
    COUNT(DISTINCT co.c_id) AS course_count
FROM faculty f
JOIN course_offering co
    ON f.f_id = co.f_id
GROUP BY f.f_id, f.f_name
HAVING COUNT(DISTINCT co.c_id) > 1;


-- 31. Generate a semester result sheet containing
-- Student ID, Name, Course, Total Marks, Grade,
-- and Attendance Percentage.
SELECT
    s.rollno AS student_id,
    s.name,
    c.c_name AS course,
    (m.mid1 + m.mid2 + m.external) AS total_marks,

    CASE
        WHEN (m.mid1 + m.mid2 + m.external) >= 126 THEN 'A+'
        WHEN (m.mid1 + m.mid2 + m.external) >= 112 THEN 'A'
        WHEN (m.mid1 + m.mid2 + m.external) >= 98 THEN 'B+'
        WHEN (m.mid1 + m.mid2 + m.external) >= 84 THEN 'B'
        WHEN (m.mid1 + m.mid2 + m.external) >= 70 THEN 'C'
        WHEN (m.mid1 + m.mid2 + m.external) >= 56 THEN 'D'
        ELSE 'F'
    END AS grade,

    ROUND(
        a.c_attended * 100.0 / NULLIF(a.c_held, 0),
        2
    ) AS attendance_percentage

FROM students s
JOIN marks m
    ON s.rollno = m.s_id
JOIN course c
    ON m.c_id = c.c_id
LEFT JOIN attendance a
    ON a.s_id = m.s_id
   AND a.c_id = m.c_id
ORDER BY s.rollno, c.c_id;


-- ============================================================
-- 32. Create a VIEW named StudentPerformance to display
-- consolidated student academic performance.
-- ============================================================

CREATE OR REPLACE VIEW StudentPerformance AS
SELECT
    s.rollno AS student_id,
    s.name,
    d.d_name AS department,
    c.c_id,
    c.c_name AS course,

    (m.mid1 + m.mid2 + m.external) AS total_marks,

    CASE
        WHEN (m.mid1 + m.mid2 + m.external) >= 126 THEN 'A+'
        WHEN (m.mid1 + m.mid2 + m.external) >= 112 THEN 'A'
        WHEN (m.mid1 + m.mid2 + m.external) >= 98 THEN 'B+'
        WHEN (m.mid1 + m.mid2 + m.external) >= 84 THEN 'B'
        WHEN (m.mid1 + m.mid2 + m.external) >= 70 THEN 'C'
        WHEN (m.mid1 + m.mid2 + m.external) >= 56 THEN 'D'
        ELSE 'F'
    END AS grade,

    ROUND(
        a.c_attended * 100.0 / NULLIF(a.c_held, 0),
        2
    ) AS attendance_percentage

FROM students s
JOIN departments d
    ON s.d_id = d.d_id
JOIN marks m
    ON s.rollno = m.s_id
JOIN course c
    ON m.c_id = c.c_id
LEFT JOIN attendance a
    ON a.s_id = m.s_id
   AND a.c_id = m.c_id;


-- View the consolidated performance:
SELECT *
FROM StudentPerformance;


-- ============================================================
-- 33. Transaction to update examination marks and demonstrate
-- COMMIT and ROLLBACK.
-- ============================================================

-- -------- COMMIT example --------
START TRANSACTION;

UPDATE marks
SET mid1 = 38,
    mid2 = 39,
    external = 57
WHERE s_id = 'S001'
  AND c_id = 'C001';

-- Check the updated value before committing.
SELECT *
FROM marks
WHERE s_id = 'S001'
  AND c_id = 'C001';

COMMIT;


-- -------- ROLLBACK example --------
START TRANSACTION;

UPDATE marks
SET mid1 = 20,
    mid2 = 20,
    external = 30
WHERE s_id = 'S001'
  AND c_id = 'C001';

-- Check the temporary change.
SELECT *
FROM marks
WHERE s_id = 'S001'
  AND c_id = 'C001';

-- Undo the UPDATE.
ROLLBACK;

-- Original committed values are restored.
SELECT *
FROM marks
WHERE s_id = 'S001'
  AND c_id = 'C001';


-- ============================================================
-- 34. Create an index on StudentID to improve query performance.
-- Your schema uses rollno as the StudentID in students and s_id
-- as the student foreign key in related tables.
-- ============================================================

-- Index on students.rollno:
-- NOTE: rollno is already PRIMARY KEY, so MySQL already has an
-- index on it. Therefore, creating another index on rollno is
-- redundant.
--
-- Better choice: index the foreign-key column s_id in enrollment.
CREATE INDEX idx_enrollment_student
ON enrollment(s_id);

-- Similarly, useful indexes for frequent student-based lookups:
CREATE INDEX idx_attendance_student
ON attendance(s_id);

CREATE INDEX idx_marks_student
ON marks(s_id);

-- ============================================================
-- END OF QUESTIONS 13-34
-- ============================================================
