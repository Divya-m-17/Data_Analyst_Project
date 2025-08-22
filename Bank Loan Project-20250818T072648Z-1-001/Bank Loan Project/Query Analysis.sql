CREATE DATABASE bank_loan_db;

USE bank_loan_db;

SELECT * FROM bankloan;

DESCRIBE bankloan;

UPDATE bankloan 
SET issue_date = str_to_date(issue_date, "%d-%m-%Y");

ALTER TABLE bankloan
MODIFY COLUMN issue_date DATE;

UPDATE bankloan 
SET last_credit_pull_date = str_to_date(last_credit_pull_date, "%d-%m-%Y"),
last_payment_date = str_to_date(last_payment_date , "%d-%m-%Y"),
next_payment_date = str_to_date(next_payment_date, "%d-%m-%Y");

ALTER TABLE bankloan
MODIFY COLUMN last_credit_pull_date DATE;

ALTER TABLE bankloan
MODIFY COLUMN last_payment_date DATE;

ALTER TABLE bankloan
MODIFY COLUMN next_payment_date DATE;

ALTER TABLE bankloan
ADD PRIMARY KEY (id);


-- Busisness Requirements
SELECT COUNT(id) AS Total_Loan_Applications from bankloan;

SELECT COUNT(id) AS MTD_Total_Loan_Applications from bankloan
WHERE MONTH(issue_date) = 12;

SELECT COUNT(id) AS PMTD_Total_Loan_Applications from bankloan
WHERE MONTH(issue_date) = 11;



-- MoM = (MTD-PMTD)/PMTD

-- Total funded amount
SELECT sum(loan_amount) AS Total_Funded_Amount FROM bankloan;

SELECT sum(loan_amount) AS MTD_Total_Funded_Amount from bankloan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) =2021;

SELECT sum(loan_amount)  AS PMTD_Total_Funded_Amount from bankloan
WHERE MONTH(issue_date) = 11;

-- TOTAL AMOUNT RECEIVED
SELECT sum(total_payment) AS Total_Amount_Received FROM bankloan;

SELECT sum(total_payment) AS MTD_Total_Amount_Received from bankloan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) =2021;

SELECT sum(total_payment)  AS PMTD_Total_Amount_Received from bankloan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) =2021;

SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bankloan;

-- Good Loan Percentage

SELECT COUNT(id) AS Good_Loan_Applications FROM bankloan
where loan_status = "Fully Paid" OR loan_status ="Current";
            
SELECT 
    (COUNT(CASE WHEN loan_status ="Fully Paid" OR loan_status = "Current" THEN id END)*100)
    / Count(id) AS Good_Loan_percentage
from bankloan;

SELECT 
    loan_status,
    COUNT(id) as Loan_Count,
    Sum(total_payment) AS TOtal_Amount_Received,
    Sum(loan_amount) AS Total_Funded_Amount,
    avg(int_rate)*100 As Interest_rate,
    avg(dti)*100 as DTI
From bankloan
group by loan_status;


Select
    Month(issue_date) as Month_Number,
   Monthname(issue_date) as Month_name,
    COUNT(id) as Total_loan_applications,
    Sum(total_payment) AS TOtal_Amount_Received,
    Sum(loan_amount) AS Total_Funded_Amount
FROM bankloan
group by Month(issue_date), Monthname(issue_date)
order by Month(issue_date);
   
