
-----------------PRERAK PANDYA------------------------

Create table Employee_Table (employee_id int PRIMARY KEY,
First_name varchar(50),Last_name varchar(50),Salary int,joinning_date DATETIME ,Department varchar(50))

select * from Employee_Table
--our table name and column name is ready now we are going to insert values

insert into Employee_Table (employee_id,First_name,Last_name,Salary,joinning_date,Department)
values(1,'Ankita','Arora',100000,'2020-02-14 9:00:00','HR'),
(2,'Veena','Verma',80000,'2011-06-15 9:00:00','Admin'),
(3,'Vishal','Sighal',300000,'2020-02-16 9:00:00','HR'),
(4,'Sushanth','Singh',500000,'2020-02-17 9:00:00','Admin'),
(5,'Bhupal','Bharti',500000,'2011-06-18 9:00:00','Admin'),
(6,'Dheeraj','Diwan',200000,'2011-06-19 9:00:00','Account'),
(7,'Karan','Kumar',75000,'2020-01-14 9:00:00','Acoount'),
(8,'Chandrika','Chauhan',90000,'2011-04-15 9:00:00','Admin')
--Inser Values Susscesfully

update Employee_Table
set Department = 'Account'
where Department = 'Acoount'
---Mistake in employee table so we correct using update function

Select * from Employee_Table

--Create second tyable called Bouns Tabled

CREATE TABLE Employee_bonus (
    employee_id INT,
    Bonus_amount INT,
    Bonus_date DATETIME,
    FOREIGN KEY (employee_id) REFERENCES Employee_Table(employee_id)
);--Create Table now insert value in table

Insert into Employee_bonus (employee_id,Bonus_amount,Bonus_date)
values
(1,5000,'2020-02-16 0:00:00'),
(2,3000,'2011-06-16 0:00:00'),
(3,4000,'2020-02-16 0:00:00'),
(1,4500,'2020-02-16 0:00:00'),
(2,3500,'2011-06-16 0:00:00')
-- insert value 

select * from Employee_bonus

---Create 3rd Table called Employee Title

CREATE TABLE  Employee_Title(employee_id int,employee_title varchar(50),Affective_date DATETIME, FOREIGN KEY (employee_id) REFERENCES Employee_Table(employee_id))
--created 3rd Table

insert into Employee_Title  (employee_id,employee_title,Affective_date)
values
(1,'Manager','2016-02-20 0:00:00'),
(2,'Excutive','2016-06-11 0:00:00'),
(8,'Excutive','2016-06-11 0:00:00'),
(5,'Manager','2016-06-11 0:00:00'),
(4,'Asst.Manager','2016-06-11 0:00:00'),
(7,'Excutive','2016-06-11 0:00:00'),
(6,'Lead','2016-06-11 0:00:00'),
(3,'Lead','2016-06-11 0:00:00')


Select * from Employee_bonus
Select * from Employee_Table
Select * from Employee_Title


--1 Display the “FIRST_NAME” from Employee table using the alias name as Employee_name.

SELECT FIRST_NAME FROM EMPLOYEE_TABLE

--2 Display “LAST_NAME” from Employee table in upper case.

SELECT FIRST_NAME FROM EMPLOYEE_TABLE

--3 Display unique values of DEPARTMENT from EMPLOYEE table.

SELECT DISTINCT(DEPARTMENT) FROM EMPLOYEE_TABLE

--4 Display the first three characters of LAST_NAME from EMPLOYEE table.

select SUBSTRING(Last_name,1,3) as last_name_first_3_characters from Employee_Table

--5 Display the unique values of DEPARTMENT from EMPLOYEE table and prints its length.

SELECT DISTINCT DEPARTMENT AS Unique_Department,
       CHARINDEX(' ', DEPARTMENT + ' ') - 1 AS Department_Length
FROM Employee_Table


--6 Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a single column AS FULL_NAME. a space char should separate them.

SELECT CONCAT(FIRST_NAME,' ',LAST_NAME)FROM EMPLOYEE_TABLE 

--7 DISPLAY all EMPLOYEE details from the employee table order by FIRST_NAME Ascending.

SELECT * FROM EMPLOYEE_TABLE
ORDER BY FIRST_NAME ASC

--8. Display all EMPLOYEE details order by FIRST_NAME Ascending and DEPARTMENT Descending.

SELECT * FROM EMPLOYEE_TABLE
ORDER BY FIRST_NAME ASC,DEPARTMENT DESC 

---9 Display details for EMPLOYEE with the first name as “VEENA” and “KARAN” from EMPLOYEE table.

SELECT * FROM EMPLOYEE_TABLE
WHERE FIRST_NAME = 'VEENA' OR  FIRST_NAME =  'KARAN'

---10 Display details of EMPLOYEE with DEPARTMENT name as “Admin”.

SELECT * FROM EMPLOYEE_TABLE
WHERE DEPARTMENT = 'ADMIN'

---11 DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’.

SELECT * FROM EMPLOYEE_TABLE
WHERE FIRST_NAME LIKE '%V%'

---12 DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.

SELECT * FROM EMPLOYEE_TABLE
WHERE SALARY BETWEEN 100000 AND 500000

---13 Display details of the employees who have joined in Feb-2020.

SELECT *
FROM Employee_Table
WHERE YEAR(joinning_date) = '2020'
AND MONTH(joinning_date) = '2';


---14 Display employee names with salaries >= 50000 and <= 100000.

SELECT * FROM EMPLOYEE_TABLE
WHERE SALARY >= 50000 AND SALARY <= 100000

---15 Display the number of Employees for each department in the descenting order.

SELECT DEPARTMENT,COUNT(EMPLOYEE_ID) AS COUNT_  FROM EMPLOYEE_TABLE
GROUP BY DEPARTMENT 
ORDER BY COUNT_ DESC

---16 DISPLAY details of the EMPLOYEES who are also Managers.

SELECT *
FROM Employee_Table e
JOIN Employee_Title e2 ON e.employee_id = e2.employee_id
WHERE e2.employee_title = 'Manager';


---17 DISPLAY duplicate records having matching data in some fields of a table.

SELECT employee_id,First_name,Last_name,Salary,joinning_date,Department, COUNT(*)
FROM Employee_Table
GROUP BY employee_id,First_name,Last_name,Salary,joinning_date,Department
HAVING COUNT(*) > 1;


---18 Display only odd rows from a table.

SELECT * FROM (SELECT *,ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ROW_  FROM EMPLOYEE_TABLE) AS NUMBER_ROW
WHERE ROW_ % 2 = 1

---19 Clone a new table from EMPLOYEE table.

SELECT * INTO NEW FROM EMPLOYEE_TABLE

---20 DISPLAY the TOP 2 highest salary from a table. 

SELECT TOP 2 SALARY FROM EMPLOYEE_TABLE
ORDER BY SALARY DESC


---21. DISPLAY the list of employees with the same salary.

WITH SALARY_COUNT AS
(SELECT SALARY,COUNT(*)  AS COUNT_ FROM EMPLOYEE_TABLE 
GROUP BY SALARY)
SELECT * FROM EMPLOYEE_TABLE E JOIN SALARY_COUNT S ON E.SALARY = S.SALARY
WHERE S.COUNT_ > 1


---22 Display the second highest salary from a table.

WITH SALARY_RANK AS 
(SELECT SALARY,ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS RANK_ FROM EMPLOYEE_TABLE)
SELECT SALARY FROM SALARY_RANK WHERE RANK_ =2

---23 Display the first 50% records from a table.

SELECT * FROM (SELECT *,ROW_NUMBER() OVER (ORDER BY EMPLOYEE_ID DESC) AS RAW_  FROM EMPLOYEE_TABLE ) AS NUM 
WHERE RAW_ >= (SELECT COUNT(*)*0.5 FROM EMPLOYEE_TABLE)

---24. Display the departments that have less than 4 people in i

SELECT  DEPARTMENT,COUNT(*) AS COUNT_  FROM EMPLOYEE_TABLE
GROUP BY DEPARTMENT 
HAVING COUNT(*) < 4

---25. Display all departments along with the number of people in there.

SELECT COUNT(*) EMPLOYEE_COUNT ,DEPARTMENT FROM EMPLOYEE_TABLE
GROUP BY DEPARTMENT

---26 Display the name of employees having the highest salary in
---each department.

select max(Salary) max_salary,Department from Employee_Table
group by Department

---27 Display the names of employees who earn the highest salary. 

SELECT TOP 1 FIRST_NAME,LAST_NAME,MAX(SALARY) AS MAX_SALARY FROM EMPLOYEE_TABLE
GROUP BY FIRST_NAME,LAST_NAME

---28Diplay the average salaries for each department

SELECT AVG(SALARY) AS AVG_SALARY,DEPARTMENT FROM EMPLOYEE_TABLE 
GROUP BY DEPARTMENT


---29 display the name of the employee who has got maximum bonus

SELECT FIRST_NAME,LAST_NAME,MAX(BONUS_AMOUNT) AS MAX_BONUS FROM EMPLOYEE_BONUS E1 
INNER JOIN EMPLOYEE_TABLE E2
ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID
GROUP BY FIRST_NAME,LAST_NAME

---30 Display the first name and title of all the employees 

SELECT FIRST_NAME,E2.EMPLOYEE_TITLE FROM EMPLOYEE_TABLE E1
INNER JOIN EMPLOYEE_TITLE E2
ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID