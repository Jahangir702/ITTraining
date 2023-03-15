--USE  
USE db_IT_scholsrship_programme
GO
--INSERT DATA INTO THE TABLE--
INSERT INTO Courses
VALUES	(101, 'c#.net'),
		(102, 'php'),
		(103, 'jee')
GO

SELECT *
FROM Courses
GO

INSERT INTO Exams
VALUES	(201, 'midmonth 1'),
		(202, 'Monthly '),
		(203, 'midmonth 2')
GO

SELECT * 
FROM Exams
GO

INSERT INTO Modules
VALUES 
(301, 'sql'),
(302, 'html'),
(303, 'ap.net'),
(307, 'windows 11')
GO

SELECT * 
FROM Modules
GO

INSERT INTO CourseModules
VALUES	
(101, 301),
(101, 302),
(102, 301),
(103, 307)
GO

SELECT * 
FROM CourseModules
GO

Insert Into Trainees values
(501,'arif',101),
(502,'santo',103),
(503,'pavel',102)

SELECT * 
FROM Trainees
GO

Insert Into ExamResults Values
(202,'Passed',503),
(201,'Failed',502),
(203,'Passed',501)

SELECT * 
FROM ExamResults
GO

---Queries Added--




 --1 Inner join



SELECT        c.CourseName,  cm.ModuleID, t.TraineeID, t.TraineeName, ex.ExamName, er.ExamVerdict
FROM Courses c
INNER JOIN  CourseModules cm ON c.CourseID = cm.CourseID 
INNER JOIN Trainees t ON c.CourseID = t.CourseID 
INNER JOIN ExamResults er ON t.TraineeID = er.TraineeID 
INNER JOIN Exams ex ON er.ExamID = ex.ExamID
GO


 --2 Inner join + filter



SELECT        c.CourseName,  cm.ModuleID, t.TraineeID, t.TraineeName, ex.ExamName, er.ExamVerdict
FROM Courses c
INNER JOIN  CourseModules cm ON c.CourseID = cm.CourseID 
INNER JOIN Trainees t ON c.CourseID = t.CourseID 
INNER JOIN ExamResults er ON t.TraineeID = er.TraineeID 
INNER JOIN Exams ex ON er.ExamID = ex.ExamID
WHERE c.CourseID = 101
GO




 --3 Inner join + filter
 


SELECT        c.CourseName,  cm.ModuleID, t.TraineeID, t.TraineeName, ex.ExamName, er.ExamVerdict
FROM Courses c
INNER JOIN  CourseModules cm ON c.CourseID = cm.CourseID 
INNER JOIN Trainees t ON c.CourseID = t.CourseID 
INNER JOIN ExamResults er ON t.TraineeID = er.TraineeID 
INNER JOIN Exams ex ON er.ExamID = ex.ExamID
WHERE t.TraineeID = 501
GO


--4 Left + right outer join



SELECT        c.CourseName, m.ModuleName, t.TraineeName, ex.ExamName, er.ExamVerdict
FROM            ExamResults er
INNER JOIN
                         Exams ex ON er.ExamID = ex.ExamID 
RIGHT OUTER JOIN
                         Trainees t ON er.TraineeID = t.TraineeID 
RIGHT OUTER JOIN
                         Courses  c ON t.CourseID = c.CourseID 
LEFT OUTER JOIN
                         CourseModules cm ON c.CourseID = cm.CourseID
LEFT OUTER JOIN
                         Modules m ON m.ModuleID = cm.ModuleID
GO


--5 changed 5 to CTE


WITH v as
(
SELECT c.CourseID, c.CourseName,t.TraineeID, t.TraineeName,  m.ModuleName
FROM Trainees t 
RIGHT OUTER JOIN
                         Courses  c ON t.CourseID = c.CourseID 
LEFT OUTER JOIN
                         CourseModules cm ON c.CourseID = cm.CourseID
LEFT OUTER JOIN
                         Modules m ON m.ModuleID = cm.ModuleID
)
SELECT v.CourseName, v.ModuleName, v.TraineeName, ex.ExamName, er.ExamVerdict
FROM            ExamResults er
INNER JOIN
                         Exams ex ON er.ExamID = ex.ExamID 
RIGHT JOIN v ON er.TraineeID = v.TraineeID
GO


--6 Not match in 5


SELECT        c.CourseName, m.ModuleName, t.TraineeName, ex.ExamName, er.ExamVerdict
FROM            ExamResults er
INNER JOIN
                         Exams ex ON er.ExamID = ex.ExamID 
RIGHT OUTER JOIN
                         Trainees t ON er.TraineeID = t.TraineeID 
RIGHT OUTER JOIN
                         Courses  c ON t.CourseID = c.CourseID 
LEFT OUTER JOIN
                         CourseModules cm ON c.CourseID = cm.CourseID
LEFT OUTER JOIN
                         Modules m ON m.ModuleID = cm.ModuleID
WHERE m.ModuleID IS NULL
GO


--7 change 6 to sub-query


SELECT       c.CourseName, m.ModuleName, t.TraineeName, ex.ExamName, er.ExamVerdict
FROM            ExamResults er
INNER JOIN
                         Exams ex ON er.ExamID = ex.ExamID 
RIGHT OUTER JOIN
                         Trainees t ON er.TraineeID = t.TraineeID 
RIGHT OUTER JOIN
                         Courses  c ON t.CourseID = c.CourseID 
LEFT OUTER JOIN
                         CourseModules cm ON c.CourseID = cm.CourseID
LEFT OUTER JOIN
                         Modules m ON m.ModuleID = cm.ModuleID
WHERE cm.ModuleID  IN (SELECT ModuleID FROM  CourseModules)
GO


--8 aggregate


SELECT     c.CourseName, COUNT(t.TraineeID )  'trainecount'
FROM  Courses c 
LEFT OUTER JOIN Trainees t ON c.CourseID = t.CourseID
GROUP BY c.CourseName
GO


--9 aggregate + having


SELECT     c.CourseName, COUNT(t.TraineeID )  'trainecount'
FROM  Courses c 
LEFT OUTER JOIN Trainees t ON c.CourseID = t.CourseID
GROUP BY c.CourseName
HAVING c.CourseName = 'C#'
GO

--10 functions windowing


SELECT     c.CourseName, 
COUNT(t.TraineeID ) OVER(Order BY c.CourseID)  'trainecount',
ROW_NUMBER() OVER(Order BY c.CourseID)  '#',
RANK() OVER(Order BY c.CourseID)  'rank',
DENSE_RANK() OVER(Order BY c.CourseID)  'dense rank',
NTILE(2) OVER(Order BY c.CourseID)  'nitle'
FROM  Courses c 
LEFT OUTER JOIN Trainees t ON c.CourseID = t.CourseID
GO

--11 CASE


SELECT  Trainees.TraineeName, Exams.ExamName, 
CASE 
WHEN ExamResults.ExamVerdict = 'Passed' THEN 'Yes'
ELSE 'No'
END AS 'Passed?'
FROM  Trainees 
INNER JOIN
ExamResults ON Trainees.TraineeID = ExamResults.TraineeID 
INNER JOIN
Exams ON ExamResults.ExamID = Exams.ExamID
GO

--Test Procedures
DECLARE @id INT
exec spInsertCourse 'C#', @id OUTPUT

exec spInsertCourse 'HTML', @id OUTPUT

exec spInsertCourse 'Web Development', @id OUTPUT
go
exec spUpdateCourse 3, 'HTML5'
go
select * from Courses
go
DECLARE @id INT
exec spInsertModule 'T-SQL', @id OUTPUT

exec spInsertModule 'SQL Server', @id OUTPUT

exec spInsertModule 'C# Base', @id OUTPUT
GO
select * from modules
GO
DECLARE @id INT
exec spInsertExam 'Mid-Term', @id OUTPUT

exec spInsertExam 'Final1',@id OUTPUT

GO

--test view


select * from vTraineeInfo
GO
--test function

SELECT dbo.fnScalar(1)
go
select * from fnTable(1)
GO

