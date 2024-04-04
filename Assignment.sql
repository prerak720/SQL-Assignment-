---Prerak Pandya-------


---1. Display the names of the highest paid programmers for each Language.

WITH MaxSalaryPerLanguage AS (
    SELECT 
        PROF1 AS Language,
        MAX(SALARY) AS MaxSalary
    FROM 
        PROGRAMMER
    GROUP BY 
        PROF1
)

SELECT 
    p.PNAME AS Programmer_Name,
    p.PROF1 AS Language,
    p.SALARY AS Salary
FROM 
    PROGRAMMER p
JOIN 
    MaxSalaryPerLanguage msl ON p.PROF1 = msl.Language AND p.SALARY = msl.MaxSalary;



---2. Display the details of those who are drawing the same salary.

SELECT 
    p.PNAME AS Programmer_Name,
    p.PROF1 AS Language,
    p.SALARY AS Salary,
    p.DOB AS Date_of_Birth,
    p.GENDER AS Gender
FROM 
    PROGRAMMER p
JOIN 
    (
        SELECT 
            SALARY,
            COUNT(*) AS NumProgrammers
        FROM 
            PROGRAMMER
        GROUP BY 
            SALARY
        HAVING 
            COUNT(*) > 1
    ) same_salary ON p.SALARY = same_salary.SALARY
ORDER BY 
    p.SALARY DESC, p.PNAME;


---3. Who are the programmers who joined on the same day?

SELECT 
    p1.PNAME AS Programmer1_Name,
    p2.PNAME AS Programmer2_Name,
    p1.DOJ AS Date_of_Joining
FROM 
    PROGRAMMER p1
JOIN 
    PROGRAMMER p2 ON p1.PNAME < p2.PNAME AND p1.DOJ = p2.DOJ
ORDER BY 
    p1.DOJ, p1.PNAME;


---4. Who are the programmers who have the same Prof2?

SELECT 
    p1.PNAME AS Programmer1_Name,
    p2.PNAME AS Programmer2_Name,
    p1.DOJ AS Date_of_Joining
FROM 
    PROGRAMMER p1
JOIN 
    PROGRAMMER p2 ON p1.PNAME < p2.PNAME AND p1.DOJ = p2.DOJ
ORDER BY 
    p1.DOJ, p1.PNAME;


---5. How many packages were developed by the person who developed the cheapest package,
---where did he/she study?

SELECT 
    s.PNAME AS Cheapest_Developer,
    COUNT(*) AS Num_Packages_Developed,
    st.INSTITUTE AS Institute_Studied_At
FROM 
    SOFTWARE s
JOIN 
    STUDIES st ON s.PNAME = st.PNAME
WHERE 
    s.PNAME = (
        SELECT 
            TOP 1 PNAME 
        FROM 
            SOFTWARE 
        ORDER BY 
            DCOST ASC
    )
GROUP BY 
    s.PNAME, st.INSTITUTE;
