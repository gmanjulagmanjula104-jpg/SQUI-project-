CREATE TABLE departments (
    d_id VARCHAR(20) PRIMARY KEY,
    d_name VARCHAR(30) NOT NULL UNIQUE,
    block_name VARCHAR(30),
    hod_name VARCHAR(30)
);

CREATE TABLE students (
    rollno VARCHAR(30) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phn VARCHAR(11) UNIQUE,
    email VARCHAR(30) UNIQUE,
    year_ INT NOT NULL CHECK (year_ BETWEEN 1 AND 4),
    d_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (d_id) REFERENCES departments(d_id)
);

CREATE TABLE faculty (
    f_id VARCHAR(30) PRIMARY KEY,
    f_name VARCHAR(30) NOT NULL,
    salary INT CHECK (salary > 0),
    designation VARCHAR(20),
    d_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (d_id) REFERENCES departments(d_id)
);

CREATE TABLE course (
    c_id VARCHAR(20) PRIMARY KEY,
    c_name VARCHAR(30) NOT NULL,
    credits INT CHECK (credits > 0),
    d_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (d_id) REFERENCES departments(d_id)
);

CREATE TABLE course_offering (
    offering_id INT PRIMARY KEY,
    c_id VARCHAR(20) NOT NULL,
    f_id VARCHAR(30) NOT NULL,
    semester INT NOT NULL CHECK (semester >= 1),
    FOREIGN KEY (c_id) REFERENCES course(c_id),
    FOREIGN KEY (f_id) REFERENCES faculty(f_id),
    UNIQUE (c_id, f_id, semester)
);

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    s_id VARCHAR(30) NOT NULL,
    c_id VARCHAR(20) NOT NULL,
    semester INT NOT NULL CHECK (semester >= 1),
    FOREIGN KEY (s_id) REFERENCES students(rollno),
    FOREIGN KEY (c_id) REFERENCES course(c_id),
    UNIQUE (s_id, c_id, semester)
);

CREATE TABLE attendance (
    s_id VARCHAR(30),
    c_id VARCHAR(20),
    c_held INT NOT NULL CHECK (c_held >= 0),
    c_attended INT NOT NULL CHECK (c_attended >= 0 AND c_attended <= c_held),
    PRIMARY KEY (s_id, c_id),
    FOREIGN KEY (s_id) REFERENCES students(rollno),
    FOREIGN KEY (c_id) REFERENCES course(c_id)
);

CREATE TABLE marks (
    s_id VARCHAR(30),
    c_id VARCHAR(20),
    mid1 INT CHECK (mid1 BETWEEN 0 AND 40),
    mid2 INT CHECK (mid2 BETWEEN 0 AND 40),
    external INT CHECK (external BETWEEN 0 AND 60),
    PRIMARY KEY (s_id, c_id),
    FOREIGN KEY (s_id) REFERENCES students(rollno),
    FOREIGN KEY (c_id) REFERENCES course(c_id)
);
