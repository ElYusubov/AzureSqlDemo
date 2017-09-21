-- Create Person table

CREATE TABLE Person
(
PersonId   INT IDENTITY PRIMARY KEY,
FirstName   NVARCHAR(128) NOT NULL,
MiddelInitial NVARCHAR(10),
LastName   NVARCHAR(128) NOT NULL,
DateOfBirth   DATE NOT NULL
)

-- Create Student table

CREATE TABLE Student
(
StudentId INT IDENTITY PRIMARY KEY,
PersonId  INT REFERENCES Person (PersonId),
Email   NVARCHAR(256)
)

-- Create Course table

CREATE TABLE Course
(
CourseId  INT IDENTITY PRIMARY KEY,
Name   NVARCHAR(50) NOT NULL,
Teacher   NVARCHAR(256) NOT NULL
) 

-- Create Credit table

CREATE TABLE Credit
(
StudentId   INT REFERENCES Student (StudentId),
CourseId   INT REFERENCES Course (CourseId),
Grade   DECIMAL(5,2) CHECK (Grade <= 100.00),
Attempt   TINYINT,
CONSTRAINT  [UQ_studentgrades] UNIQUE CLUSTERED
(
StudentId, CourseId, Grade, Attempt
)
)


--- Load Data
--- Follow the load data instructions



--- Query Loaded Data

-- Find the students taught by Dominick Pope who have a grade higher than 75%
SELECT  person.FirstName,
person.LastName,
course.Name,
credit.Grade
FROM  Person AS person
INNER JOIN Student AS student ON person.PersonId = student.PersonId
INNER JOIN Credit AS credit ON student.StudentId = credit.StudentId
INNER JOIN Course AS course ON credit.CourseId = course.courseId
WHERE course.Teacher = 'Pamela Burch' 
AND Grade > 75


-- Find all the courses in which Noe Coleman has ever enrolled
SELECT  course.Name,
course.Teacher,
credit.Grade
FROM  Course AS course
INNER JOIN Credit AS credit ON credit.CourseId = course.CourseId
INNER JOIN Student AS student ON student.StudentId = credit.StudentId
INNER JOIN Person AS person ON person.PersonId = student.PersonId
WHERE person.FirstName = 'Monica'
AND person.LastName = 'Roth'

