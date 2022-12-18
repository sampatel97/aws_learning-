-- 1. Display all the information of the Employee table.
SELECT * FROM cards_ingest.emp;

-- 2. Display unique Department names from Employee table.

SELECT DISTINCT job FROM cards_ingest.emp;

-- 3. List the details of the employees in ascending order of their salaries.

SELECT * FROM cards_ingest.emp
ORDER BY sal ASC;

-- 4. List the employees who joined before 1981.

SELECT * FROM cards_ingest.emp
WHERE hiredate < ('1981-1-1');

-- 5. List the employees who are joined in the year 1981

SELECT * FROM cards_ingest.emp
WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31';

-- 6. List the Empno, Ename, Sal, Daily Sal of all Employees in the ASC order of AnnSal. (Note devide sal/30 as annsal)

SELECT empno, ename, sal, sal/30 AS daily_sal, 12*sal AS annual_salary
FROM cards_ingest.emp
ORDER BY annual_salary ASC;

-- 7. List the employees who are working for the department name ACCOUNTING

SELECT * FROM cards_ingest.emp 
WHERE deptno IN
(SELECT deptno from cards_ingest.dept WHERE dname = 'ACCOUNTING');

-- 8. List the employees who does not belong to department name ACCOUNTING

SELECT * FROM cards_ingest.emp 
WHERE deptno IN
(SELECT deptno from cards_ingest.dept WHERE NOT dname = 'ACCOUNTING');


