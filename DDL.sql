/*************CRETAE DATABASE *************/
USE master
GO
DROP DATABASE IF EXISTS db_IT_scholsrship_programme
BEGIN
    CREATE DATABASE db_IT_scholsrship_programme
END
GO
--USE  
USE db_IT_scholsrship_programme
GO
/*************CRETAE TABLE *************/
CREATE TABLE Courses
(
	CourseID INT NOT NULL,
	CourseName NVARCHAR(50) NOT NULL,
	PRIMARY KEY (CourseID)
)
GO

CREATE TABLE Exams
(
	ExamID INT NOT NULL,
	ExamName NVARCHAR(50) NOT NULL,
	PRIMARY KEY (ExamID)
)
GO

CREATE TABLE Modules
(
	ModuleID INT NOT NULL,
	ModuleName NVARCHAR(50) NOT NULL,
	PRIMARY KEY (ModuleID)
)
GO

CREATE TABLE CourseModules
(
	CourseID INT NOT NULL REFERENCES Courses(CourseID),
	ModuleID INT NOT NULL REFERENCES Modules(ModuleID),
	PRIMARY KEY (CourseID,ModuleID)
)
GO


CREATE TABLE Trainees
(
	TraineeID INT NOT NULL,
	TraineeName NVARCHAR(50) NOT NULL,
	CourseID INT NOT NULL,
	PRIMARY KEY (TraineeID),
	FOREIGN KEY (CourseID) REFERENCES Courses (CourseID),
)
GO

CREATE TABLE ExamResults
(
	ExamID INT NOT NULL,
	ExamVerdict NVARCHAR(50) NOT NULL,
	TraineeID INT NOT NULL,
	PRIMARY KEY (ExamID,TraineeID ),
	FOREIGN KEY (TraineeID) REFERENCES Trainees (TraineeID),
	FOREIGN KEY (ExamID) REFERENCES Exams (ExamID)
)
GO

/*************CRETAE INDEX *************/
CREATE INDEX txTrainees
ON Trainees(TraineeName)
GO
CREATE PROC spInsertCourse @c_name NVARCHAR(50), @c_id INT OUTPUT
                           						
AS

SELECT @c_id=ISNULL(MAX (CourseID),0)+1 FROM Courses
BEGIN TRY
       INSERT INTO Courses(CourseID,CourseName)
	   VALUES(@c_id,@c_name)
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO

/*******CREATE PROCEDURE DATA UPDATE TABLE *******/
CREATE PROC spUpdateCourse @c_id INT,
                            @c_name NVARCHAR(50)
                           
							
AS
BEGIN TRY
       Update Courses
	   SET CourseName= @c_name
	   WHERE CourseID=@c_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
CREATE PROC spDeleteCourse @c_id INT
                           
                           
							
AS
BEGIN TRY
       Delete Courses
	   
	   WHERE CourseID=@c_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
--------------------------------------------------------------
CREATE PROC spInsertModule

@m_name NVARCHAR(50),@m_id INT OUTPUT
                           						
AS

SELECT @m_id=ISNULL(MAX (ModuleID),0)+1 FROM Modules
BEGIN TRY
       INSERT INTO Modules(ModuleID,ModuleName)
	   VALUES(@m_id,@m_name)
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO

--CREATE PROCEDURE DATA UPDATE TABLE--
CREATE PROC spUpdateModule @m_id INT,
                            @m_name NVARCHAR(50)
                           
							
AS
BEGIN TRY
       Update Modules
	   SET ModuleName= @m_name
	   WHERE ModuleID=@m_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
CREATE PROC spDeleteModule @m_id INT
                           
                           
							
AS
BEGIN TRY
       Delete Modules
	   
	   WHERE ModuleID=@m_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
---------------------------------------------------------------
CREATE PROC spInsertExam

@e_name NVARCHAR(50),@e_id INT OUTPUT
                           						
AS

SELECT @e_id=ISNULL(MAX (ExamID),0)+1 FROM Exams
BEGIN TRY
       INSERT INTO Exams(ExamID,ExamName)
	   VALUES(@e_id,@e_name)
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO

--CREATE PROCEDURE DATA UPDATE TABLE--
CREATE PROC spUpdateExam @e_id INT,
                            @e_name NVARCHAR(50)
                           
							
AS
BEGIN TRY
       Update Exams
	   SET ExamName= @e_name
	   WHERE ExamID=@e_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
CREATE PROC spDeleteExam @e_id INT
                           
                           
							
AS
BEGIN TRY
       Delete Exams
	   
	   WHERE ExamID=@e_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
-------------------------------------------------------------------
CREATE PROC spInsertExamResult
@e_id INT,
@e_verdict NVARCHAR(50),@t_id INT
                           						
AS

BEGIN TRY
       INSERT INTO ExamResults(ExamID, ExamVerdict, TraineeID)
	   VALUES(@e_id,@e_verdict, @t_id)
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO

--CREATE PROCEDURE DATA UPDATE TABLE--
CREATE PROC spUpdateExamResult @e_id INT,@t_id INT,
                            @e_verdict NVARCHAR(50)
                           
							
AS
BEGIN TRY
       Update ExamResults
	   SET ExamVerdict= @e_verdict
	   WHERE ExamID=@e_id and TraineeID=@t_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
CREATE PROC spDeleteExamResult @e_id INT, @t_id INT
                           
                           
							
AS
BEGIN TRY
       Delete ExamResults
	   
	   WHERE ExamID=@e_id and TraineeID=@t_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
--------------------------------------------------------------------------
--CREATE PROCEDURE DATA INSERT TO Trainees TABLE--
CREATE PROC spInsertTrainees 

@t_name NVARCHAR(40),@t_id INT OUTPUT
                           						
AS

SELECT @t_id=ISNULL(MAX (Traineeid),0)+1 FROM Trainees
BEGIN TRY
       INSERT INTO Trainees(TraineeID,Traineename)
	   VALUES(@t_id,@t_name)
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO

--CREATE PROCEDURE DATA UPDATE T TABLE--
CREATE PROC spUpdateTrainees @t_id INT,
                            @t_name NVARCHAR(40)
                           
							
AS
BEGIN TRY
       Update Trainees
	   SET TraineeName= @t_name
	   WHERE TraineeID=@t_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
CREATE PROC spDeleteTrainees @t_id INT
                           
                           
							
AS
BEGIN TRY
       Delete Trainees
	   
	   WHERE TraineeID=@t_id
END TRY
BEGIN CATCH
           ;
		   THROW 50001,'Error encountered',1
		   RETURN 0
END CATCH
GO
/*************VIEW *******************/
Create View vTraineeInfo
As
Select T.TraineeID, C.CourseName, E.ExamName, R.ExamVerdict 
from Trainees T
left join Courses C
on T.CourseID=C.CourseID
inner join ExamResults R
on T.TraineeID=R.TraineeID
inner join Exams E
on R.ExamID=E.ExamID
Go
--Function Scalar
Create Function fnScalar(@c_id int ) Returns int
As
Begin
	Declare @n int 
	Select @n = COUNT(*) from Trainees
	Where CourseID =@c_id
	Return @n
End
Go

--table function
Create Function fnTable(@c_id int) Returns Table
As
Return
(
	Select T.TraineeID, C.CourseName, E.ExamName, R.ExamVerdict 
	From Trainees T
	inner join Courses C
	on T.CourseID=C.CourseID
	inner join ExamResults R
	on T.TraineeID=R.TraineeID
	inner join Exams E
	on R.ExamID=E.ExamID
	Where C.CourseID=@c_id
)
GO

---Triggers ---------------
Create Trigger trInsertCourseModule
on CourseModules for Insert
As 
Begin
	Declare @id int
select @id=CourseID from inserted
	if exists
		(
			Select count(*), ModuleID from CourseModules
			Where CourseID =@id
			Group by ModuleID
			Having count(*) >12
		)
		Begin
			Rollback Transaction
			; 
			Throw 50001,'A course cannot have more than 12 module',1
		End
End
Go

CREATE trigger trDeleteModule
on Modules
AFTER DELETE
AS
BEGIN
	declare @m_id INT
	select @m_id=ModuleId from inserted
	delete  from CourseModules WHERE ModuleID=@m_id
END
GO
CREATE trigger trDeleteCourse
on Courses
AFTER DELETE
AS
BEGIN
	declare @c_id INT
	select @c_id=CourseID from inserted
	delete  from CourseModules WHERE CourseID=@c_id
END
GO
