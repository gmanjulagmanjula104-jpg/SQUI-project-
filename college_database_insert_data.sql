-- Sample data for the college database
-- 20+ records for every table

USE college_db;

-- =========================
-- DEPARTMENTS (20)
-- =========================
INSERT INTO departments (d_id, d_name, block_name, hod_name) VALUES
('D001','Computer Science','Block A','Dr. Ravi Kumar'),
('D002','Information Technology','Block B','Dr. Priya Sharma'),
('D003','Electronics','Block C','Dr. Suresh Rao'),
('D004','Electrical Engineering','Block D','Dr. Anil Reddy'),
('D005','Mechanical Engineering','Block E','Dr. Mahesh Kumar'),
('D006','Civil Engineering','Block F','Dr. Lakshmi Devi'),
('D007','Artificial Intelligence','Block G','Dr. Kiran Rao'),
('D008','Data Science','Block H','Dr. Neha Singh'),
('D009','Cyber Security','Block I','Dr. Arun Kumar'),
('D010','Chemical Engineering','Block J','Dr. Vijay Rao'),
('D011','Biotechnology','Block K','Dr. Meena Reddy'),
('D012','Aerospace Engineering','Block L','Dr. Rajesh Kumar'),
('D013','Automobile Engineering','Block M','Dr. Srinivas Rao'),
('D014','Robotics','Block N','Dr. Swathi Rao'),
('D015','Mathematics','Block O','Dr. Geetha Devi'),
('D016','Physics','Block P','Dr. Ramesh Babu'),
('D017','Management Studies','Block Q','Dr. Kavitha Rao'),
('D018','IoT Engineering','Block R','Dr. Naveen Kumar'),
('D019','Software Engineering','Block S','Dr. Harsha Vardhan'),
('D020','Environmental Engineering','Block T','Dr. Deepa Sharma');

-- =========================
-- STUDENTS (20)
-- =========================
INSERT INTO students (rollno, name, phn, email, year_, d_id) VALUES
('S001','Rahul Reddy','9876500001','rahul@example.com',4,'D001'),
('S002','Sneha Rao','9876500002','sneha@example.com',3,'D002'),
('S003','Arjun Kumar','9876500003','arjun@example.com',2,'D003'),
('S004','Priya Reddy','9876500004','priya@example.com',4,'D004'),
('S005','Karthik Rao','9876500005','karthik@example.com',3,'D005'),
('S006','Ananya Sharma','9876500006','ananya@example.com',2,'D006'),
('S007','Vivek Kumar','9876500007','vivek@example.com',4,'D007'),
('S008','Divya Singh','9876500008','divya@example.com',3,'D008'),
('S009','Rohit Reddy','9876500009','rohit@example.com',2,'D009'),
('S010','Keerthi Rao','9876500010','keerthi@example.com',4,'D010'),
('S011','Manoj Kumar','9876500011','manoj@example.com',3,'D011'),
('S012','Pooja Sharma','9876500012','pooja@example.com',2,'D012'),
('S013','Sai Kiran','9876500013','saikiran@example.com',4,'D013'),
('S014','Harini Reddy','9876500014','harini@example.com',3,'D014'),
('S015','Nikhil Rao','9876500015','nikhil@example.com',2,'D015'),
('S016','Lakshmi Kumar','9876500016','lakshmi@example.com',4,'D016'),
('S017','Varun Singh','9876500017','varun@example.com',3,'D017'),
('S018','Aishwarya Rao','9876500018','aishwarya@example.com',2,'D018'),
('S019','Tarun Reddy','9876500019','tarun@example.com',4,'D019'),
('S020','Bhavya Sharma','9876500020','bhavya@example.com',3,'D020');

-- =========================
-- FACULTY (20)
-- =========================
INSERT INTO faculty (f_id, f_name, salary, designation, d_id) VALUES
('F001','Dr. Ramesh Kumar',85000,'Professor','D001'),
('F002','Dr. Sunitha Rao',78000,'Associate Professor','D002'),
('F003','Dr. Mohan Reddy',72000,'Assistant Professor','D003'),
('F004','Dr. Kavya Sharma',80000,'Professor','D004'),
('F005','Dr. Prakash Rao',76000,'Associate Professor','D005'),
('F006','Dr. Sangeetha Devi',70000,'Assistant Professor','D006'),
('F007','Dr. Naveen Reddy',90000,'Professor','D007'),
('F008','Dr. Meghana Rao',82000,'Professor','D008'),
('F009','Dr. Ajay Kumar',74000,'Assistant Professor','D009'),
('F010','Dr. Bhaskar Rao',79000,'Associate Professor','D010'),
('F011','Dr. Anusha Reddy',71000,'Assistant Professor','D011'),
('F012','Dr. Raj Kumar',88000,'Professor','D012'),
('F013','Dr. Teja Rao',73000,'Assistant Professor','D013'),
('F014','Dr. Swathi Kumar',81000,'Associate Professor','D014'),
('F015','Dr. Geetha Sharma',75000,'Professor','D015'),
('F016','Dr. Rakesh Babu',77000,'Associate Professor','D016'),
('F017','Dr. Kavitha Devi',83000,'Professor','D017'),
('F018','Dr. Naresh Rao',69000,'Assistant Professor','D018'),
('F019','Dr. Harsha Kumar',86000,'Professor','D019'),
('F020','Dr. Deepa Singh',70000,'Assistant Professor','D020');

-- =========================
-- COURSE (20)
-- =========================
INSERT INTO course (c_id, c_name, credits, d_id) VALUES
('C001','Database Management',4,'D001'),
('C002','Operating Systems',4,'D001'),
('C003','Computer Networks',3,'D002'),
('C004','Digital Electronics',4,'D003'),
('C005','Power Systems',4,'D004'),
('C006','Thermodynamics',3,'D005'),
('C007','Structural Engineering',4,'D006'),
('C008','Machine Learning',4,'D007'),
('C009','Data Analytics',3,'D008'),
('C010','Cyber Security',4,'D009'),
('C011','Process Engineering',3,'D010'),
('C012','Genetic Engineering',4,'D011'),
('C013','Aerodynamics',4,'D012'),
('C014','Automobile Design',3,'D013'),
('C015','Robotics Fundamentals',4,'D014'),
('C016','Discrete Mathematics',3,'D015'),
('C017','Engineering Physics',3,'D016'),
('C018','IoT Systems',4,'D018'),
('C019','Software Architecture',4,'D019'),
('C020','Environmental Science',3,'D020');

-- =========================
-- COURSE_OFFERING (20)
-- =========================
INSERT INTO course_offering (offering_id, c_id, f_id, semester) VALUES
(1,'C001','F001',7),
(2,'C002','F001',7),
(3,'C003','F002',5),
(4,'C004','F003',4),
(5,'C005','F004',6),
(6,'C006','F005',5),
(7,'C007','F006',6),
(8,'C008','F007',7),
(9,'C009','F008',5),
(10,'C010','F009',7),
(11,'C011','F010',5),
(12,'C012','F011',4),
(13,'C013','F012',6),
(14,'C014','F013',5),
(15,'C015','F014',6),
(16,'C016','F015',3),
(17,'C017','F016',2),
(18,'C018','F018',5),
(19,'C019','F019',7),
(20,'C020','F020',4);

-- =========================
-- ENROLLMENT (20)
-- =========================
INSERT INTO enrollment (enrollment_id, s_id, c_id, semester) VALUES
(1,'S001','C001',7),
(2,'S001','C002',7),
(3,'S002','C003',5),
(4,'S003','C004',4),
(5,'S004','C005',6),
(6,'S005','C006',5),
(7,'S006','C007',6),
(8,'S007','C008',7),
(9,'S008','C009',5),
(10,'S009','C010',7),
(11,'S010','C011',5),
(12,'S011','C012',4),
(13,'S012','C013',6),
(14,'S013','C014',5),
(15,'S014','C015',6),
(16,'S015','C016',3),
(17,'S016','C017',2),
(18,'S018','C018',5),
(19,'S019','C019',7),
(20,'S020','C020',4);

-- =========================
-- ATTENDANCE (20)
-- =========================
INSERT INTO attendance (s_id, c_id, c_held, c_attended) VALUES
('S001','C001',45,40),
('S001','C002',42,36),
('S002','C003',40,35),
('S003','C004',44,38),
('S004','C005',46,42),
('S005','C006',40,34),
('S006','C007',48,43),
('S007','C008',45,41),
('S008','C009',42,37),
('S009','C010',46,39),
('S010','C011',40,32),
('S011','C012',44,40),
('S012','C013',45,36),
('S013','C014',42,38),
('S014','C015',48,44),
('S015','C016',40,35),
('S016','C017',38,34),
('S018','C018',44,39),
('S019','C019',46,41),
('S020','C020',40,33);

-- =========================
-- MARKS (20)
-- =========================
INSERT INTO marks (s_id, c_id, mid1, mid2, external) VALUES
('S001','C001',35,37,52),
('S001','C002',30,34,48),
('S002','C003',32,35,50),
('S003','C004',28,31,45),
('S004','C005',36,38,55),
('S005','C006',29,33,47),
('S006','C007',34,36,51),
('S007','C008',38,39,58),
('S008','C009',31,34,49),
('S009','C010',35,36,54),
('S010','C011',27,30,44),
('S011','C012',37,36,56),
('S012','C013',30,32,48),
('S013','C014',34,35,52),
('S014','C015',39,38,59),
('S015','C016',31,33,46),
('S016','C017',28,30,43),
('S018','C018',36,37,55),
('S019','C019',38,39,57),
('S020','C020',29,32,47);

-- =========================================================
-- END OF SAMPLE DATA
-- =========================================================
