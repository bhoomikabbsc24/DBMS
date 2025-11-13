-- ======================================================================
-- Lab Experiment – Implementation of Triggers in SQL
-- ======================================================================

-- Objective:
-- 1. To understand and create triggers in MySQL.
-- 2. To implement BEFORE and AFTER triggers for INSERT, UPDATE, and DELETE operations.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS SchoolDB;
CREATE DATABASE SchoolDB;
USE SchoolDB;

-- ======================================================================
-- Step 2: Create Tables
-- Create a Students table and a Logs table to record trigger actions.

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(50),
    Age INT,
    Marks DECIMAL(5,2)
);

CREATE TABLE StudentLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    ActionType VARCHAR(50),
    ActionDate DATETIME,
    Description VARCHAR(200)
);
DESC Students;
DESC StudentLogs;
-- OUTPUT:
-- (Run DESC Students; and DESC StudentLogs; to verify structure)
-- WRITE YOUR OUTPUT BELOW
StudentID	int	NO	PRI		auto_increment
StudentName	varchar(50)	YES			
Age	int	YES			
Marks	decimal(5,2)	YES			
-- output 
LogID	int	NO	PRI		auto_increment
ActionType	varchar(50)	YES			
ActionDate	datetime	YES			
Description	varchar(200)	YES			

-- ======================================================================
-- Task 1: BEFORE INSERT Trigger
-- Create a trigger to ensure that no student can be inserted with Marks greater than 100.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW
DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    IF NEW.Marks > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks cannot be greater than 100.';
    END IF;
END;
//
DELIMITER ;
INSERT INTO Students (StudentName, Age, Marks) VALUES ('John', 18, 105);
-- OUTPUT:
-- (Try inserting a record with Marks > 100 to verify validation)
-- WRITE YOUR OUTPUT BELOW
--  Marks cannot be greater than 100.	0.015 sec


-- ======================================================================
-- Task 2: AFTER INSERT Trigger
-- Create a trigger that inserts a log entry into StudentLogs whenever a new student is added.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW
DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES ('INSERT', NOW(), CONCAT('New student added: ', NEW.StudentName, ' with Marks = ', NEW.Marks));
END;
//
DELIMITER ;
INSERT INTO Students (StudentName, Age, Marks) VALUES ('Alice', 19, 90);
select * from StudentLogs;
-- OUTPUT:
-- (Insert a valid record and check StudentLogs for entries)
-- WRITE YOUR OUTPUT BELOW
1	INSERT	2025-10-28 12:24:58	New student added: Alice with Marks = 90.00



-- ======================================================================
-- Task 3: AFTER UPDATE Trigger
-- Create a trigger that logs any update made to a student’s marks.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW
DELIMITER //
CREATE TRIGGER after_student_update
AFTER UPDATE ON Students
FOR EACH ROW
BEGIN
    IF OLD.Marks <> NEW.Marks THEN
        INSERT INTO StudentLogs (ActionType, ActionDate, Description)
        VALUES ('UPDATE', NOW(), CONCAT('Marks updated for ', NEW.StudentName, 
                ' from ', OLD.Marks, ' to ', NEW.Marks));
    END IF;
END;
//
DELIMITER ;
UPDATE Students SET Marks = 95 WHERE StudentID = 1;
SELECT * FROM StudentLogs;
-- OUTPUT:
-- (Update marks of a student and verify the StudentLogs table)
-- WRITE YOUR OUTPUT BELOW
1	INSERT	2025-10-28 12:24:58	New student added: Alice with Marks = 90.00
2	UPDATE	2025-10-28 12:28:17	Marks updated for Alice from 90.00 to 95.00
			


-- ======================================================================
-- Task 4: AFTER DELETE Trigger
-- Create a trigger that logs when a student record is deleted.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW
DELIMITER //
CREATE TRIGGER after_student_delete
AFTER DELETE ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES ('DELETE', NOW(), CONCAT('Student deleted: ', OLD.StudentName, 
            ' who had Marks = ', OLD.Marks));
END;
//
DELIMITER ;
DELETE FROM Students WHERE StudentID = 1;
SELECT * FROM StudentLogs;
-- OUTPUT:
-- (Delete a student and check StudentLogs for the corresponding entry)
-- WRITE YOUR OUTPUT BELOW
1	INSERT	2025-10-28 12:24:58	New student added: Alice with Marks = 90.00
2	UPDATE	2025-10-28 12:28:17	Marks updated for Alice from 90.00 to 95.00
3	DELETE	2025-10-28 12:29:37	Student deleted: Alice who had Marks = 95.00
			


-- ======================================================================
-- END OF EXPERIMENT – Implementation of Triggers
-- ======================================================================
