SELECT * FROM Employees WHERE commission_pct IS NULL;
SELECT * FROM Employees WHERE first_name LIKE 'B%';
SELECT * FROM Employees WHERE hire_date > TO_DATE('01-Jan-1982', 'DD-MON-YYYY');
SELECT * FROM Employees WHERE salary > 2000;
SELECT employee_id, department_id, salary FROM Employees WHERE employee_id = 7900;
SELECT * FROM Employees WHERE department_id = 20;
SELECT * FROM Employees WHERE department_id = 10 OR department_id = 30;
SELECT * FROM Employees WHERE salary > 1000 AND salary < 3000;
SELECT first_name, last_name, hire_date FROM Employees 
WHERE hire_date BETWEEN TO_DATE('20-02-1980', 'DD-MM-YYYY') AND TO_DATE('01-05-1980', 'DD-MM-YYYY')
ORDER BY hire_date ASC
SELECT first_name, last_name, hire_date FROM Employees WHERE EXTRACT(year from hire_date) = 1980;
SELECT first_name, last_name, Jobs.job_title FROM Employees INNER JOIN Jobs on Employees.job_id = Jobs.job_id WHERE manager_id IS NULL;
SELECT first_name, last_name, Jobs.job_title, salary FROM Employees INNER JOIN Jobs on Employees.job_id = Jobs.job_id;
WHERE job_title = 'Sales Representative' AND (salary != 1600 OR salary != 3000 OR salary != 1250);
SELECT department_name FROM Departments WHERE department_id = 10;
SELECT DISTINCT Jobs.job_title FROM Employees INNER JOIN Jobs on Employees.job_id = Jobs.job_id;
SELECT DISTINCT department_id, job_id FROM Employees;
SELECT DISTINCT manager_id FROM Employees;
SELECT MAX(salary) as maximum, MIN(salary) as minimum FROM Employees;
SELECT MAX(salary) as maximum, MIN(salary) as minimum FROM Employees GROUP BY department_id;
SELECT COUNT(*) as number_of_employees FROM Employees WHERE salary > 1500;
SELECT COUNT(*) as number_of_employees FROM Employees WHERE salary > 1500 GROUP BY department_id;
SELECT MAX(salary) as maximum FROM Employees WHERE department_id = 30;
SELECT * FROM Employees WHERE department_id = (SELECT department_id FROM Departments WHERE department_name = 'Sales');
SELECT * FROM Employees WHERE salary > (SELECT salary FROM Employees WHERE first_name = 'Blake');
SELECT * FROM Employees WHERE salary > (SELECT AVG(salary) FROM Employees);
SELECT * FROM Employees WHERE salary > (SELECT MAX(salary) FROM Employees WHERE department_id = 30);

SELECT first_name, last_name, Departments.department_name FROM Employees INNER JOIN Departments ON Departments.department_id = Employees.department_id;

SELECT DISTINCT Jobs.job_title, Locations.street_address FROM Employees 
INNER JOIN Jobs ON Jobs.job_id = Employees.job_id
INNER JOIN Departments ON Employees.department_id = Employees.department_id
INNER JOIN Locations ON Departments.location_id = Locations.location_id
WHERE Departments.department_id = 30;

SELECT Employees.first_name, Employees.last_name, Jobs.job_title, Departments.department_id, Departments.department_name FROM Employees 
INNER JOIN Jobs ON Jobs.job_id = Employees.job_id
INNER JOIN Departments ON Employees.department_id = Employees.department_id
INNER JOIN Locations ON Departments.location_id = Locations.location_id
WHERE Locations.city = 'Toronto';	

SELECT last_name, employee_id, 
(SELECT last_name FROM Employees WHERE employee_id = e.manager_id) as mgr_last_name, 
(SELECT employee_id FROM Employees WHERE employee_id = e.manager_id) as mgr_id
FROM Employees e