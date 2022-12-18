-- 1.SQL Query to print the number of employees per department in the organization
	-- Solution 1:
	
SELECT COUNT(*) AS no_of_emp_per_dept, deptno 
FROM cards_ingest.emp
GROUP BY deptno;

	-- Solution 2:

SELECT COUNT(dname) AS no_of_emp_per_dept, dname
FROM (SELECT * FROM cards_ingest.emp
	  INNER JOIN cards_ingest.dept
	  ON dept.deptno = emp.deptno) AS emp_info
GROUP BY dname;

-- 2.SQL Query to find the employee details who got second maximum salary

SELECT * FROM cards_ingest.emp
WHERE sal = (SELECT MAX(sal) FROM cards_ingest.emp 
			 WHERE sal < (SELECT MAX(sal) 
						  FROM cards_ingest.emp));

-- 3.SQL Query to find the employee details who got second maximum salary in each department

WITH salary_rank AS (
  SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno,  
	DENSE_RANK() OVER(PARTITION BY deptno 
					  ORDER BY sal DESC) AS sal_rank
  FROM cards_ingest.emp
)
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM salary_rank
WHERE sal_rank = 2;
  
-- 4.SQL Query to find the employee who got minimum salary in 2019

SELECT * FROM cards_ingest.emp
WHERE sal = (SELECT MIN(sal) FROM cards_ingest.emp);


-- 5.SQL query to select the employees getting salary greater than the average salary of the department that are working in

SELECT deptno, ename AS emp_sal_higher_than_avg FROM cards_ingest.emp AS e1
WHERE sal > (SELECT AVG(sal) 
			 FROM cards_ingest.emp AS e2
			WHERE e1.deptno = e2.deptno);
			
-- 6.SQL query to compute the group salary of all the employees .

SELECT job AS group_by_position, SUM(sal) AS group_salary
FROM cards_ingest.emp
GROUP BY job;

-- 7.SQL query to list the employees and name of employees reporting to each person.

SELECT e1.ename AS employee, e2.ename AS reporting_to
FROM cards_ingest.emp AS e1 
LEFT JOIN cards_ingest.emp AS e2
ON e1.mgr = e2.empno;

-- 8.SQL query to find the department with highest number of employees.

SELECT COUNT(*) AS dept_with_max_emp, deptno 
FROM cards_ingest.emp
GROUP BY deptno
ORDER BY dept_with_max_emp DESC
LIMIT 1;

