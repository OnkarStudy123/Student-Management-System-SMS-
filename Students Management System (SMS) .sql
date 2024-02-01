create database school;
use school;
-- Table for storing students
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    birthdate DATE,
    address VARCHAR(255)
);
-- Inserting sample data into Students table
INSERT INTO Students (student_id, name, birthdate, address)
VALUES
    (1, 'Rahul Jog',  '2000-01-01', '123 Main St'),
    (2, 'Samir Desai',  '2001-02-02', '456 Elm St'),
    (3, 'Roshan Singh', '1999-03-03', '789 Oak St');
    

    
-- Table for storing courses
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

-- Inserting sample data into Courses table
INSERT INTO Courses (course_id, name, description)
VALUES
    (1, 'Mathematics', 'Algebra, Geometry, Calculus'),
    (2, 'Science', 'Biology, Chemistry, Physics'),
    (3, 'History', 'World History, US History');


-- Table for storing enrollment
CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
-- Inserting sample data into Enrollment table
INSERT INTO Enrollment (enrollment_id, student_id, course_id, enrollment_date)
VALUES
    (1, 1, 1, '2023-01-15'),
    (2, 1, 2, '2023-01-15'),
    (3, 2, 1, '2023-01-15'),
    (4, 3, 3, '2023-01-15');

-- Table for storing grades
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    enrollment_id INT,
    grade DECIMAL(5, 2),
    FOREIGN KEY (enrollment_id) REFERENCES Enrollment(enrollment_id)
);

-- Inserting sample data into Grades table
INSERT INTO Grades (grade_id, enrollment_id, grade)
VALUES
    (1, 1, 85),
    (2, 2, 90),
    (3, 3, 88),
    (4, 4, 92);

-- Table for storing teachers
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(100)
);
-- Inserting sample data into Teachers table
INSERT INTO Teachers (teacher_id, name, department)
VALUES
    (1, 'Professor Adams', 'Mathematics'),
    (2, 'Professor Brown',  'Science'),
    (3, 'Professor Clark',  'History');
    

-- Retrive datas

SELECT * from Students;
SELECT * FROM Courses;
SELECT * FROM Enrollment;
SELECT * FROM Grades;
SELECT * FROM Teachers;



-- Retrieve the names of all students:

SELECT name FROM Students;

-- Retrieve the names of courses along with their descriptions:

SELECT name, description FROM Courses;

-- Retrieve the names of students along with the courses they are enrolled in:

SELECT s.name AS student_name, c.name AS course_name
FROM Students s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Retrieve the average grade for each course:

SELECT c.name AS course_name, AVG(g.grade) AS average_grade
FROM Courses c
JOIN Enrollment e ON c.course_id = e.course_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id
GROUP BY c.name;

-- Retrieve the names of teachers along with the departments they teach in:

SELECT name, department FROM Teachers;

-- Retrieve the count of students enrolled in each course:

SELECT c.name AS course_name, COUNT(e.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrollment e ON c.course_id = e.course_id
GROUP BY c.name;

-- Retrieve the highest grade achieved by each student:

SELECT s.name AS student_name, MAX(g.grade) AS highest_grade
FROM Students s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id
GROUP BY s.name;

-- Retrieve the names of students who have not enrolled in any course:

SELECT s.name AS student_name
FROM Students s
LEFT JOIN Enrollment e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- Retrieve the names of students along with their grades in a specific course (e.g., Mathematics):
SELECT s.name AS student_name, g.grade
FROM Students s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.name = 'Mathematics';

-- Retrieve the total number of enrolled students:

SELECT COUNT(DISTINCT student_id) AS total_enrolled_students
FROM Enrollment;


-- Retrieve the names of courses along with the number of enrolled students in each course:

SELECT c.name AS course_name, COUNT(DISTINCT e.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrollment e ON c.course_id = e.course_id
GROUP BY c.course_id;


-- Retrieve the names of courses along with the maximum and minimum grades achieved in each course:
SELECT c.name AS course_name, 
       MAX(g.grade) AS max_grade,
       MIN(g.grade) AS min_grade
FROM Courses c
JOIN Enrollment e ON c.course_id = e.course_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id
GROUP BY c.course_id;

-- Retrieve the names of students along with their enrollment dates:

SELECT s.name AS student_name, e.enrollment_date
FROM Students s
JOIN Enrollment e ON s.student_id = e.student_id;










