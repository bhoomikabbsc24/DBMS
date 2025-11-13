-- ======================================================================
-- Lab Experiment – GROUP BY, HAVING, ORDER BY and INDEXING
-- ======================================================================

-- Objective:
-- 1. To understand and apply the SQL GROUP BY clause to group rows based on column values and perform aggregate operations.
-- 2. To explore the HAVING clause for filtering grouped data post aggregation.
-- 3. To use the ORDER BY clause to sort query results in ascending or descending order.
-- 4. To implement Indexing in SQL for improving query performance.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE HospitalDB;
USE HospitalDB;

-- ======================================================================
-- Step 2: Create Tables
-- Create the relational schema for Patients and Visits.

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    visit_date DATE,
    doctor_id INT,
    diagnosis VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
DESC Patients;
DESC Visits;
-- OUTPUT:
-- (After creating tables, run DESC Patients; and DESC Visits; to verify structure.)
-- WRITE YOUR OUTPUT BELOW
patient_id	int	NO	PRI		auto_increment
patient_name	varchar(50)	YES			
age	int	YES			
gender	varchar(10)	YES		

-- visits 	
visit_id	int	NO	PRI		auto_increment
patient_id	int	YES	MUL		
visit_date	date	YES			
doctor_id	int	YES			
diagnosis	varchar(100)	YES			
treatment_cost	decimal(10,2)	YES			

-- ======================================================================
-- Step 3: Insert Sample Data
-- Insert sample records into both tables.
-- Add at least 5 patients and 8–10 visit records with varying diagnoses and treatment costs.
-- WRITE YOUR QUERIES BELOW
INSERT INTO Patients (patient_name, age, gender) VALUES
('Amit Sharma', 35, 'Male'),
('Priya Nair', 28, 'Female'),
('Rahul Verma', 42, 'Male'),
('Sneha Rao', 31, 'Female'),
('Karan Patel', 50, 'Male');

INSERT INTO Visits (patient_id, visit_date, doctor_id, diagnosis, treatment_cost) VALUES
(1, '2025-01-15', 101, 'Fever', 150.00),
(1, '2025-03-10', 102, 'Flu', 250.00),
(2, '2025-02-12', 103, 'Fracture', 800.00),
(3, '2025-03-18', 104, 'Diabetes Check', 300.00),
(3, '2025-04-22', 105, 'Blood Pressure', 200.00),
(4, '2025-05-09', 101, 'Allergy', 180.00),
(4, '2025-06-15', 103, 'Flu', 270.00),
(5, '2025-07-05', 104, 'Diabetes Check', 400.00),
(5, '2025-08-20', 105, 'Fever', 120.00),
(2, '2025-09-10', 102, 'Cold', 160.00);
SELECT * FROM Patients;
SELECT * FROM Visits;

-- OUTPUT:
-- (Run SELECT * FROM Patients; and SELECT * FROM Visits; to verify inserted data.)
-- WRITE YOUR OUTPUT BELOW
1	Amit Sharma	35	Male
2	Priya Nair	28	Female
3	Rahul Verma	42	Male
4	Sneha Rao	31	Female
5	Karan Patel	50	Male

1	1	2025-01-15	101	Fever	150.00
2	1	2025-03-10	102	Flu	250.00
3	2	2025-02-12	103	Fracture	800.00
4	3	2025-03-18	104	Diabetes Check	300.00
5	3	2025-04-22	105	Blood Pressure	200.00
6	4	2025-05-09	101	Allergy	180.00
7	4	2025-06-15	103	Flu	270.00
8	5	2025-07-05	104	Diabetes Check	400.00
9	5	2025-08-20	105	Fever	120.00
10	2	2025-09-10	102	Cold	160.00
										
                    


-- ======================================================================
-- QUICK INTRODUCTION (for notes)
-- GROUP BY: Groups rows sharing a value and performs aggregate functions like SUM(), COUNT(), AVG().
-- HAVING: Filters grouped data after aggregation.
-- ORDER BY: Sorts query results (ASC by default, DESC for descending order).
-- INDEXING: Improves query performance by creating a quick lookup on key columns.

-- ======================================================================
-- STUDENT ACTIVITY TASKS
-- ======================================================================

-- Task 1: Grouping Data by Diagnosis
-- Group the data based on diagnosis and calculate the average treatment cost for each diagnosis.
-- WRITE YOUR QUERY BELOW
SELECT 
    diagnosis, 
    AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis;

-- OUTPUT:
-- WRITE YOUR OUTPUT BELOW
Fever	135.000000
Flu	260.000000
Fracture	800.000000
Diabetes Check	350.000000
Blood Pressure	200.000000
Allergy	180.000000
Cold	160.000000


-- ======================================================================
-- Task 2: Filtering with HAVING Clause
-- Filter the grouped data to show only diagnoses where the average treatment cost is greater than 200.
-- WRITE YOUR QUERY BELOW
SELECT 
    diagnosis, 
    AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis
HAVING AVG(treatment_cost) > 200;

-- OUTPUT:
-- WRITE YOUR OUTPUT BELOW
Flu	260.000000
Fracture	800.000000
Diabetes Check	350.000000


-- ======================================================================
-- Task 3: Sorting the Results
-- Sort the results from Task 1 in descending order of average treatment cost.
-- WRITE YOUR QUERY BELOW
SELECT 
    diagnosis, 
    AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis
ORDER BY avg_cost DESC;

-- OUTPUT:
-- WRITE YOUR OUTPUT BELOW
Fracture	800.000000
Diabetes Check	350.000000
Flu	260.000000
Blood Pressure	200.000000
Allergy	180.000000
Cold	160.000000
Fever	135.000000


-- ======================================================================
-- Task 4: Optimizing with Indexes
-- Create an index on the patient_id column in the Visits table to improve performance.
-- Then run a query that retrieves all visits for a particular patient.
-- WRITE YOUR QUERIES BELOW
CREATE INDEX idx_patient_id ON Visits(patient_id);
SHOW INDEX FROM Visits;
SELECT * FROM Visits WHERE patient_id = 3;

-- OUTPUT:
-- (Verify index creation using SHOW INDEX FROM Visits;)
-- WRITE YOUR OUTPUT BELOW
4	3	2025-03-18	104	Diabetes Check	300.00
5	3	2025-04-22	105	Blood Pressure	200.00
					


-- ======================================================================
-- END OF EXPERIMENT
-- ======================================================================
