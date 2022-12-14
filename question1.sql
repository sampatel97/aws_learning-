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

-- 7. List the employees who are working for the department name ACCOUNTING

-- 8. List the employees who does not belong to department name ACCOUNTING