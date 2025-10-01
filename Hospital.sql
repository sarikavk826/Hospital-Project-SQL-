Show Databases ;
use new_schema;
Show Tables;

Create Table Hospital_Data (
ID int primary key,
Hospital_Name varchar (50),
Location varchar (50),
Department varchar (50),
Doctors_Count int,
Patients_Count int,
Admission_Date Date,
Discharge_Date Date,
Medical_Expenses Decimal (10,2));

Select * from Hospital_Data;
# 1. Total Number of Patients
# Write an SQL query to find the total number of patients across all hospitals.

Create view Total_number_of_patients As 
Select sum(Patients_Count) 
from Hospital_Data;

Select * from Total_number_of_patients;

# Average Number of Doctors per Hospital
SELECT Hospital_Name, AVG(Doctors_Count) AS avg_doctors 
FROM Hospital_Data 
GROUP BY Hospital_Name
;

# Top 3 Departments with the Highest Number of Patients
Select Department, sum(Patients_Count) As Total_Patients
FROM Hospital_Data
Group by Department
Order by Total_Patients desc
limit 3 ;

# Hospital with the Maximum Medical Expenses
Select Hospital_Name, Round(sum(Medical_Expenses),2) AS Total_medical_expenses
FROM Hospital_Data
Group by Hospital_Name
Order by Total_medical_expenses desc
Limit 5 ;

# Daily Average Medical Expenses
# Calculate the average medical expenses per day for each hospital.
Select Hospital_Name, Round(Avg(Medical_Expenses),2)/30 AS Average_medical_expenses
FROM Hospital_Data
Group by Hospital_Name
Order by Average_medical_expenses desc;

SELECT 
    Hospital_Name, 
    ROUND(SUM(Medical_Expenses) / SUM(DATEDIFF(Discharge_Date, Admission_Date)), 2) AS Daily_Average_Medical_Expenses
FROM Hospital_Data
WHERE Discharge_Date > Admission_Date
GROUP BY Hospital_Name
ORDER BY Daily_Average_Medical_Expenses DESC;

# Longest Hospital Stay
# Find the patient with the longest stay by calculating the difference between
# Discharge Date and Admission Date.

SELECT Hospital_Name, Location,
datediff(Discharge_Date, Admission_Date ) AS Stay_Days
FROM Hospital_Data
Order by Stay_Days desc;

# Total Patients Treated Per City
Select  Location, sum(Patients_Count) As Total_sum
FROM Hospital_Data
Group by Location;

# Average Length of Stay Per Department
Select  Department, Round(Avg(datediff(Discharge_Date,Admission_Date)),2) AS Avg_stay
FROM Hospital_Data
Group by Department;

# Department with the Lowest Number of Patients

Select Department, sum(Patients_Count) As Total_Patients
From Hospital_Data
Group by Department
Order by Total_Patients;


# Monthly Medical Expenses Report
SELECT 
    DATE_FORMAT(Admission_Date, '%Y-%m') AS Month,
    SUM(Medical_Expenses) AS Total_Medical_Expenses
FROM Hospital_Data
GROUP BY Month
ORDER BY Month;



