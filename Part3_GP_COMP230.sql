DROP DATABASE STACK;
CREATE DATABASE STACK;
USE STACK;

-- 1. MANAGER
CREATE TABLE Manager (
    ManagerID   VARCHAR(10) UNIQUE,
    Name        VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20),
    Email       VARCHAR(100) PRIMARY KEY,
    Address     VARCHAR(100),
    City        VARCHAR(50)
);

-- 2. DEPARTMENT
CREATE TABLE Department (
    DeptID      VARCHAR(10) UNIQUE,
    DeptName    VARCHAR(50) NOT NULL,
    ManagerID   VARCHAR(10),
	FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID)
);

-- 3. STAFF
CREATE TABLE Staff (
    StaffID     VARCHAR(10) UNIQUE,
    Name        VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20),
    Email       VARCHAR(100) PRIMARY KEY,
    Address     VARCHAR(100),
    City        VARCHAR(50),
    DeptID      VARCHAR(10),
	FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 4. STUDENT
CREATE TABLE Student (
    StudentID   INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20),
    Email       VARCHAR(100)
);

CREATE VIEW StudentView AS
SELECT
    StudentID,
    CONCAT('ST', LPAD(StudentID, 3, '0')) AS SID,
    Name,
    PhoneNumber,
    Email
FROM Student;

-- 5. COURSE
CREATE TABLE Course (
    CourseID    VARCHAR(10) UNIQUE,
    CourseName  VARCHAR(100) NOT NULL,
    CourseType  VARCHAR(30)  NOT NULL
);

-- 6. ASSIGNMENT
CREATE TABLE Assignment (
    AssignID    VARCHAR(10) UNIQUE,
    AssignType  VARCHAR(30) NOT NULL,
    MaxScore    INT(3),
    CourseID    VARCHAR(10),
	FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- 7. GRADE
CREATE TABLE Grade (
    GradeID     VARCHAR(10) UNIQUE,
    AssignID    VARCHAR(10),
    Score       INT(3),
	FOREIGN KEY (AssignID) REFERENCES Assignment(AssignID),
    StudentID   INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- 8. STUDENT-STAFF (bridge table)
CREATE TABLE StudentStaff (
    StudentID   INT,
    StaffID     VARCHAR(10),
	FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- 9. STUDENT-COURSE (bridge table)
CREATE TABLE StudentCourse (
    StudentID   INT,
    CourseID    VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


-- MANAGER (10 rows)
INSERT INTO Manager (ManagerID, Name, PhoneNumber, Email, Address, City) VALUES
('M01','Alice','604 555-0001','alice@email.com','123 Main Street','Abbotsford'),
('M02','Bob','604 555-0002','bob@email.com','45 Oak Avenue','Vancouver'),
('M03','Carol','604 555-0003','carol@email.com','78 Pine Road','Surrey'),
('M04','David','604 555-0004','david@email.com','10 Cedar Lane','Langley'),
('M05','Eva','604 555-0005','eva@email.com','55 Maple Blvd','Richmond'),
('M06','Frank','604 555-0006','frank@email.com','90 Birch Street','Burnaby'),
('M07','Grace','604 555-0007','grace@email.com','200 Elm Street','Chilliwack'),
('M08','Henry','604 555-0008','henry@email.com','300 Willow Way','Mission'),
('M09','Ian','604 555-0009','ian@email.com','400 Aspen Court','Kelowna'),
('M10','Julia','604 555-0010','julia@email.com','500 Spruce Drive','Kamloops');

-- DEPARTMENT (10 rows)
INSERT INTO Department (DeptID, DeptName, ManagerID) VALUES
('D01','Math','M01'),
('D02','Science','M02'),
('D03','History','M03'),
('D04','English','M04'),
('D05','Computer Science','M05'),
('D06','Physics','M02'),
('D07','Chemistry','M02'),
('D08','Biology','M03'),
('D09','Geography','M04'),
('D10','Art','M05');

-- STAFF (10 rows)
INSERT INTO Staff (StaffID, Name, PhoneNumber, Email, Address, City, DeptID) VALUES
('S001','Ben','604 555-1010','ben@email.com','456 Second Street','Mission','D01'),
('S002','Dan','604 555-1011','dan@email.com','875 Fir Street','Vancouver','D01'),
('S003','Ella','604 555-1012','ella@email.com','21 Lake Road','Surrey','D02'),
('S004','Fred','604 555-1013','fred@email.com','89 River Lane','Langley','D03'),
('S005','Gina','604 555-1014','gina@email.com','12 Hilltop Ave','Abbotsford','D04'),
('S006','Hank','604 555-1015','hank@email.com','77 Valley Rd','Chilliwack','D05'),
('S007','Ivy','604 555-1016','ivy@email.com','33 Forest Dr','Richmond','D06'),
('S008','Jack','604 555-1017','jack@email.com','19 Ocean Blvd','Burnaby','D07'),
('S009','Kate','604 555-1018','kate@email.com','64 Sunset St','Vancouver','D08'),
('S010','Liam','604 555-1019','liam@email.com','98 Sunrise St','Surrey','D09');

-- STUDENT (10 rows)
INSERT INTO Student (Name, PhoneNumber, Email) VALUES
('Colin','604 555-2001','colin@email.com'),
('Nina','604 555-2002','nina@email.com'),
('Omar','604 555-2003','omar@email.com'),
('Priya','604 555-2004','priya@email.com'),
('Quinn','604 555-2005','quinn@email.com'),
('Ravi','604 555-2006','ravi@email.com'),
('Sara','604 555-2007','sara@email.com'),
('Tom','604 555-2008','tom@email.com'),
('Uma','604 555-2009','uma@email.com'),
('Vik','604 555-2010','vik@email.com');

-- COURSE (10 rows)
INSERT INTO Course (CourseID, CourseName, CourseType) VALUES
('C001','Math 10','Online'),
('C002','Geography 11','In Class'),
('C003','English 10','Online'),
('C004','Biology 11','In Class'),
('C005','Chemistry 11','In Class'),
('C006','Physics 11','Online'),
('C007','History 10','In Class'),
('C008','Computer Science 11','Online'),
('C009','Art 10','In Class'),
('C010','Statistics 12','Online');

-- ASSIGNMENT (10 rows)
INSERT INTO Assignment (AssignID, AssignType, MaxScore, CourseID) VALUES
('A001','Test',50,'C001'),
('A002','Quiz',20,'C001'),
('A003','Project',100,'C002'),
('A004','Test',60,'C003'),
('A005','Lab',30,'C004'),
('A006','Quiz',25,'C005'),
('A007','Test',50,'C006'),
('A008','Project',100,'C007'),
('A009','Quiz',20,'C008'),
('A010','Test',50,'C009');

-- GRADE (10 rows)
INSERT INTO Grade (GradeID, AssignID, Score) VALUES
('G001','A001',48),
('G002','A002',19),
('G003','A003',92),
('G004','A004',55),
('G005','A005',27),
('G006','A006',23),
('G007','A007',45),
('G008','A008',88),
('G009','A009',18),
('G010','A010',49);

-- STUDENT–STAFF (10 rows)
INSERT INTO StudentStaff (StudentID, StaffID) VALUES
(1,'S001'),
(1,'S002'),
(2,'S003'),
(3,'S004'),
(4,'S005'),
(5,'S006'),
(6,'S007'),
(7,'S008'),
(8,'S009'),
(9,'S010');

-- STUDENT–COURSE (10 rows)
INSERT INTO StudentCourse (StudentID, CourseID) VALUES
(1,'C001'),
(1,'C002'),
(2,'C001'),
(3,'C003'),
(4,'C004'),
(5,'C005'),
(6,'C006'),
(7,'C007'),
(8,'C008'),
(9,'C009');
/*--------------------------------------------------------------------------------------------------*/
/*
Manager (ManagerID, Name, PhoneNumber, Email, Address, City)
Department (DeptID, DeptName, ManagerID)
Staff (StaffID, Name, PhoneNumber, Email, Address, City, DeptID)
Student (StudentID, Name, PhoneNumber, Email)
Course (CourseID, CourseName, CourseType)
Assignment (AssignID, AssignType, MaxScore, CourseID)
Grade (GradeID, AssignID, Score)
StudentStaff (StudentID, StaffID)
StudentCourse (StudentID, CourseID)
*/
-- Query 1: List each department, its manager, and the number of staff in that department.
USE STACK;
SELECT d.DeptName, m.Name AS Manager_name, COUNT(s.StaffID) AS Number_of_staff FROM Department d
JOIN Manager m ON d.ManagerID = m.ManagerID
JOIN Staff s ON d.DeptID = s.DeptID
GROUP BY d.DeptID, d.DeptName, m.ManagerID, m.Name
ORDER BY d.DeptID;

-- Query 2: Find all students who are taking more than 1 course.
USE STACK;
SELECT s.SID AS StudentID, s.Name, COUNT(sc.CourseID) AS TotalCourse FROM StudentView s
JOIN StudentCourse sc ON s.StudentID = sc.StudentID
JOIN Course c ON sc.CourseID = c.CourseID
GROUP BY s.StudentID, s.Name
HAVING COUNT(DISTINCT sc.CourseID) > 1;

-- Query 3: Show each staff member with the department name and the manager responsible for that department.
USE STACK;
SELECT s.StaffID, s.Name AS Staff_Name, d.DeptName, m.Name AS Reponsible_Manager FROM Staff s
JOIN Department d ON s.DeptID = d.DeptID
JOIN Manager m ON d.ManagerID = m.ManagerID
ORDER BY s.StaffID;

-- Query 4: List all students supervised by staff in the Math department.
SELECT DISTINCT s.SID AS StudentID, s.Name AS Student_Name FROM StudentView s
JOIN StudentStaff ss ON s.StudentID = ss.StudentID
JOIN Staff sf ON ss.StaffID = sf.StaffID
JOIN Department d ON sf.DeptID = d.DeptID
WHERE d.DeptName = 'Math';

-- Query 5: Find the highest score achieved in each assignment type.
SELECT a.AssignType, MAX(g.Score) AS HighestScore FROM Assignment a
JOIN Grade g ON a.AssignID = g.AssignID
GROUP BY a.AssignType;

-- Query 6: List all courses with the number of students enrolled in each course.
SELECT c.CourseName, COUNT(sc.StudentID) AS TotalStudents
FROM Course c
JOIN StudentCourse sc ON c.CourseID = sc.CourseID
GROUP BY c.CourseName;

-- Query 7: Display each student with their total score across all assignments.
SELECT s.SID AS StudentID, s.Name, SUM(g.Score) AS TotalScore
FROM StudentView s
JOIN StudentCourse sc ON s.StudentID = sc.StudentID
JOIN Assignment a ON sc.CourseID = a.CourseID
JOIN Grade g ON a.AssignID = g.AssignID
GROUP BY s.StudentID, s.Name;

-- Query 8: Find all staff who supervise more than one student.
SELECT ss.StaffID, s.Name, COUNT(ss.StudentID) AS TotalStudents
FROM StudentStaff ss
JOIN Staff s ON ss.StaffID = s.StaffID
GROUP BY ss.StaffID, s.Name
HAVING COUNT(ss.StudentID) > 1;

-- Query 9: List all assignments where the average score is higher than 95%.
SELECT a.AssignID, a.AssignType, AVG(g.Score), a.MaxScore FROM Assignment a
JOIN Grade g ON a.AssignID = g.AssignID
GROUP BY a.AssignID, a.AssignType, a.MaxScore
HAVING AVG(g.Score) > (a.MaxScore * 0.95);

-- Query 10: List all students along with how many assignments they have grades for.
SELECT s.SID AS StudentID, s.Name, COUNT(g.GradeID) AS TotalGradedAssignments FROM StudentView s
JOIN StudentCourse sc ON s.StudentID = sc.StudentID
JOIN Assignment a ON sc.CourseID = a.CourseID
JOIN Grade g ON a.AssignID = g.AssignID
GROUP BY s.StudentID, s.Name;

-- Query 11: List all courses with their total assignment weight, sorted from highest to lowest.
SELECT c.CourseName, SUM(a.MaxScore) AS TotalAssignmentWeight FROM Course c
JOIN Assignment a ON c.CourseID = a.CourseID
GROUP BY c.CourseName
ORDER BY TotalAssignmentWeight DESC;

-- Query 12: List students who have at least one grade above 90.
SELECT DISTINCT s.SID AS StudentID, s.Name FROM StudentView s
JOIN StudentCourse sc ON s.StudentID = sc.StudentID
JOIN Assignment a ON sc.CourseID = a.CourseID
JOIN Grade g ON a.AssignID = g.AssignID
WHERE g.Score > 90;

-- Query 13: Count how many courses each course type has.
SELECT CourseType, COUNT(CourseID) AS TotalCourses FROM Course
GROUP BY CourseType;

-- Query 14: List all students who are enrolled in at least one course that is an Online course.
SELECT s.SID AS StudentID, s.Name FROM StudentView s
WHERE EXISTS(
SELECT * FROM StudentCourse sc
JOIN Course c ON sc.CourseID = c.CourseID
WHERE sc.StudentID = s.StudentID
AND c.CourseType = 'Online');

-- Query 15: List departments that have no staff assigned.
SELECT d.DeptID, d.DeptName FROM Department d
WHERE NOT EXISTS (
SELECT * FROM Staff s
WHERE d.DeptID = s.DeptID);
