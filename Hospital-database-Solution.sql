-- Create Database
CREATE DATABASE HospitalData;

--Create Table
CREATE TABLE Hospitals (
	Hospital_id SERIAL PRIMARY KEY,
	Hospital_Name VARCHAR(50),
	Location VARCHAR(30),
	Department VARCHAR(30),
	Docters_Count INT,
	Patients_Count INT,
	Admission_Date DATE,
	Discharge_Date DATE,
	Medical_Expenses NUMERIC(10,2)
);

SELECT * FROM Hospitals;


--Import Data Into Hospitals Table

COPY Hospitals(Hospital_Name,Location,Department,Docters_Count,Patients_Count,Admission_Date,Discharge_Date,Medical_Expenses)
FROM 'G:\MySQL\CSV File\Hospital_Data.csv'
CSV HEADER;


--Total Number of Patients

SELECT SUM(Patients_Count) AS Total_Patients
FROM Hospitals;


--Average Number of Doctors per Hospital

SELECT DISTINCT Hospital_Name,
AVG (Docters_Count) AS Avg_Numberof_Docters
FROM Hospitals
GROUP BY Hospital_Name;


--Top 3 Departments with the Highest Number of Patients

SELECT Hospital_Name, Department, Patients_Count
FROM Hospitals ORDER BY Patients_Count DESC
LIMIT 3;


--Hospital with the Maximum Medical Expenses

SELECT Hospital_name, Medical_expenses
FROM Hospitals ORDER BY Medical_expenses DESC LIMIT 1;


--Daily Average Medical Expenses

SELECT Admission_date, AVG (Medical_expenses) AS Daily_avg_Medicalexpenses
FROM Hospitals
GROUP BY Admission_date ORDER BY Admission_date;


--Longest Hospital Stay

SELECT hospital_name, admission_date, discharge_date,
	(discharge_date - admission_date) AS stay_length
FROM Hospitals
ORDER BY stay_length DESC LIMIT 1;


--Total Patients Treated Per City

SELECT Location AS City, SUM(Patients_Count) AS Total_Patients
FROM Hospitals
GROUP BY Location ORDER BY Total_Patients DESC;


--Average Length of Stay Per Department

SELECT department, AVG(discharge_date - admission_date) AS stay_length
FROM Hospitals
GROUP BY department
ORDER BY stay_length;


--Identify the Department with the Lowest Number of Patients

SELECT Department, SUM (Patients_Count) AS Total_Patients 
FROM Hospitals
GROUP BY Department ORDER BY Total_Patients ASC LIMIT 1;


--Monthly Medical Expenses Report

SELECT TO_CHAR(admission_date, 'MM-YYYY') AS month,
SUM(medical_expenses) AS total_expenses
FROM Hospitals
GROUP BY month
ORDER BY month;

