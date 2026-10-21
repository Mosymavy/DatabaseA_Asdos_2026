--SUBQUERY
SELECT hire_date FROM employees WHERE last_name = 'Vargas';

SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date > '09-July-1998';

SELECT first_name, last_name,hire_date
FROM employees
WHERE hire_date >
    (SELECT hire_date FROM employees WHERE last_name = 'Vargas')
ORDER BY last_name;

--Subquery and Null
SELECT last_name
FROM employees
WHERE department_id =
 (SELECT department_id
 FROM employees
 WHERE last_name = 'Grant');

SELECT last_name, job_id, department_id
FROM employees
WHERE department_id =
 (SELECT department_id
 FROM departments
 WHERE department_name = 'Marketing')
ORDER BY job_id;

SELECT last_name, job_id, salary, department_id
FROM employees
WHERE job_id =
 (SELECT job_id
 FROM employees
 WHERE employee_id = 141)
AND department_id =
 (SELECT department_id
 FROM departments
 WHERE location_id = 1500);

SELECT last_name, salary
FROM employees
WHERE salary <
 (SELECT AVG(salary)
 FROM employees);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
 (SELECT MIN(salary)
 FROM employees
 WHERE department_id = 50);

-- Error, karena lebih dari 1 employee ada di department 20.
SELECT first_name, last_name
FROM employees
WHERE salary =
 (SELECT salary
 FROM employees
 WHERE department_id = 20);

SELECT * FROM employees WHERE department_id = 20;

-- untuk mengambil isi dari data yang lebih dari 2, menggunakan IN
-- extract untuk mengambil variabel yang diinginkan dari tanggal, seperti to_char tapi lebih simple
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
 (SELECT EXTRACT(YEAR FROM hire_date)
 FROM employees
 WHERE department_id=90);

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY
 (SELECT EXTRACT(YEAR FROM hire_date)
 FROM employees
 WHERE department_id=90);

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ALL
 (SELECT EXTRACT(YEAR FROM hire_date)
 FROM employees
 WHERE department_id=90);

SELECT last_name, department_id FROM employees
WHERE department_id IN
    (SELECT department_id FROM departments WHERE location_id = 1700);

SELECT last_name, job_id
FROM employees 
WHERE job_id = 
    (SELECT job_id FROM jobs WHERE job_id = 'AD_VP')
ORDER BY job_id;

SELECT last_name, job_id, salary, department_id FROM employees
WHERE job_id =
    (SELECT job_id FROM employees WHERE employee_id = 141)
AND department_id =
    (SELECT department_id FROM departments WHERE location_id = 1500);

SELECT last_name, salary FROM employees
WHERE salary < 
    (SELECT AVG(salary) FROM employees);

SELECT last_name, employee_id FROM employees
WHERE employee_id IN
    (SELECT manager_id FROM employees);

SELECT last_name, employee_id FROM employees
WHERE employee_id <= ALL
    (SELECT manager_id FROM employees);

SELECT department_id, MIN(salary) FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
    (SELECT salary FROM employees WHERE department_id IN(10,20))
ORDER BY department_id;

SELECT last_name,employee_id, manager_id, department_id FROM employees
WHERE(manager_id, department_id) IN
    (SELECT manager_id, department_id FROM employees
    WHERE employee_id IN (149,174))
    AND employee_id NOT IN (149,174);

SELECT last_name, employee_id, manager_id, department_id FROM employees
    WHERE employee_id IN (149,174);

SELECT last_name, employee_id, manager_id, department_id FROM employees
WHERE manager_id IN
    (SELECT manager_id FROM employees WHERE employee_id In (149,174))
    AND department_id IN
    (SELECT department_id FROM employees WHERE employee_id IN (149,174))
    AND employee_id NOT IN (149,174);

SELECT first_name, last_name, job_id
FROM employees
WHERE job_id =
 (SELECT job_id
 FROM employees
 WHERE last_name = 'Ernst');

SELECT o.first_name, o.last_name, o.department_id, o.salary FROM employees o
WHERE o.salary >
    (SELECT AVG(i.salary) FROM employees i
    WHERE i.department_id = o.department_id);

SELECT last_name AS "Not A Manager" FROM employees emp
WHERE NOT EXISTS
    (SELECT * FROM employees mgr
    WHERE mgr.manager_id = emp.employee_id);

SELECT last_name AS "A Manager" FROM employees emp
WHERE EXISTS
    (SELECT * FROM employees mgr
    WHERE mgr.manager_id = emp.employee_id);

SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE emp.employee_id NOT IN
(SELECT mgr.manager_id
 FROM employees mgr);

WITH managers AS (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL)
SELECT last_name AS "Not A Manager" FROM employees
WHERE employee_id NOT IN
    (SELECT * FROM managers);