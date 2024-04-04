---PRERAK PANDYA

----1. What is the cost of the costliest software development in Basic

SELECT MAX(DCOST) AS MAX_COST_BASIC FROM Software
WHERE DEVELOPIN = 'BASIC';

--2. Display details of Packages whose sales crossed the 2000 Mark.

SELECT * FROM Software
WHERE (DCOST+SCOST) > 2000

--3. Who are the Programmers who celebrate their Birthdays during the Current Month?

SELECT * FROM Programmer
WHERE MONTH(DOB) = MONTH(GETDATE())

--4. Display the Cost of Package Developed By each Programmer.

SELECT PNAME,SUM(DCOST) AS SUM_COST FROM Software
GROUP BY PNAME


--5. Display the sales values of the Packages Developed by each Programmer.

SELECT PNAME,SUM(SCOST) AS SUM_COST FROM Software
GROUP BY PNAME


--6. Display the Number of Packages sold by Each Programmer.

select PNAME,COUNT(SOLD) AS NUMBER_OF_SOLD from Software
GROUP BY PNAME

--7. Display each programmer’s name, costliest and cheapest Packages Developed by him or
--her.

SELECT S.PNAME, S.DEVELOPIN
FROM Software S
INNER JOIN (
    SELECT PNAME, MAX(DCOST + SCOST) AS Max_Cost, MIN(DCOST + SCOST) AS Min_Cost
    FROM Software
    GROUP BY PNAME
) AS MaxMin ON S.PNAME = MaxMin.PNAME 
            AND (S.DCOST + S.SCOST = MaxMin.Max_Cost OR S.DCOST + S.SCOST = MaxMin.Min_Cost);



--8. Display each institute name with the number of Courses, Average Cost per Course.

SELECT INSTITUTE,COUNT(COURSE) AS COUESES FROM Studies
GROUP BY INSTITUTE


--9. Display each institute Name with Number of Students.

SELECT INSTITUTE,COUNT(PNAME) AS STUDENT from Studies 
GROUP BY INSTITUTE

--10. List the programmers (form the software table) and the institutes they studied.

SELECT S.TITLE,S1.INSTITUTE
FROM Software S
INNER JOIN Studies S1 ON S.PNAME = S1.PNAME;

--11. How many packages were developed by students, who studied in institute that charge the
--lowest course fee?

SELECT COUNT(S.TITLE)AS MIN_FEE
FROM Software S 
INNER JOIN Studies S1 ON S.PNAME = S1.PNAME 
WHERE S1.COURSE_FEE = (SELECT MIN(COURSE_FEE) FROM Studies);

--12. What is the AVG salary for those whose software sales is more than 50,000/-.

select AVG(SALARY) AVG_SALARY from Programmer P
INNER JOIN Software S  ON P.PNAME = S.PNAME
WHERE DCOST+SCOST*SOLD > 50000

--13. Which language listed in prof1, prof2 has not been used to develop any package.

SELECT P.PROF1, P.PROF2 
FROM Programmer P 
INNER JOIN Software S ON P.PNAME = S.PNAME
WHERE P.PROF1 NOT IN (SELECT DEVELOPIN FROM Software)  
  AND P.PROF2 NOT IN (SELECT DEVELOPIN FROM Software);


--14. Display the total sales value of the software, institute wise.

SELECT SUM(SCOST) AS TOTAL_COST,INSTITUTE FROM Software S 
INNER JOIN Studies S1 ON S.PNAME = S1.PNAME
GROUP BY INSTITUTE

--15. Display the details of the Software Developed in C By female programmers of
--Pragathi.

SELECT * FROM Software S
INNER JOIN  Studies S1 ON S.PNAME = S1.PNAME 
INNER JOIN Programmer P ON S1.PNAME = P.PNAME
WHERE DEVELOPIN = 'C' AND GENDER = 'F' AND INSTITUTE = 'PRAGATHI'

--16. Display the details of the packages developed in Pascal by the Female Programmers.
SELECT *
FROM Software S 
INNER JOIN Programmer P ON S.PNAME = P.PNAME
WHERE S.DEVELOPIN = 'PASCAL' AND P.GENDER = 'F';


--17. Which language has been stated as the proficiency by most of the Programmers?

SELECT * FROM Programmer


--18. Who is the Author of the Costliest Package?

SELECT TOP 1 PNAME
FROM Software
ORDER BY (DCOST + SCOST * SOLD) DESC

--19. Which package has the Highest Development cost?

SELECT TOP 1 TITLE FROM Software
ORDER BY DCOST DESC


--20. Who is the Highest Paid Female COBOL Programmer?

SELECT S.PNAME FROM Programmer P
INNER JOIN
Software S ON S.PNAME = P.PNAME
WHERE GENDER = 'F' AND DEVELOPIN = 'COBOL'

--21. Display the Name of Programmers and Their Packages.

SELECT PNAME,SALARY FROM Programmer

--22. Display the Number of Packages in Each Language Except C and C++.

SELECT COUNT(*) AS NUMBER_OF_PACKAGES
FROM Programmer P
INNER JOIN Software S ON P.PNAME = S.PNAME
WHERE S.DEVELOPIN = 'C' OR S.DEVELOPIN = 'C++';


--23. Display AVG Difference between SCOST, DCOST for Each Package.

SELECT S.DEVELOPIN, AVG(S.SCOST + S.DCOST) AS Avg_Cost
FROM Programmer P
INNER JOIN Software S ON P.PNAME = S.PNAME
GROUP BY S.DEVELOPIN;


--24. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for
--Those Whose Cost has not yet been Recovered.
SELECT 
    P.PNAME AS Programmer,
    SUM(S.SCOST) AS Total_SCOST,
    SUM(S.DCOST) AS Total_DCOST,
    SUM(S.SCOST + S.DCOST - S.SOLD) AS Amount_To_Be_Recovered
FROM 
    Programmer P
INNER JOIN 
    Software S ON P.PNAME = S.PNAME
GROUP BY 
    P.PNAME
HAVING 
    SUM(S.SCOST + S.DCOST - S.SOLD) > 0;

--25. Who is the Highest Paid C Programmers?

SELECT TOP 1 P.PNAME,SUM(SALARY) AS HIGEST_SALARY FROM Programmer P
INNER JOIN Software S
ON P.PNAME = S.PNAME
WHERE DEVELOPIN = 'C' 
GROUP BY P.PNAME
ORDER BY HIGEST_SALARY DESC

--26. Who is the Highest Paid Female COBOL Programmer?

SELECT  P.PNAME FROM Programmer P
INNER JOIN Software S
ON P.PNAME = S.PNAME
WHERE GENDER = 'F'  AND DEVELOPIN = 'COBOL'

---------THANK YOU--------------------
------------PRERAK PANDYA-------------