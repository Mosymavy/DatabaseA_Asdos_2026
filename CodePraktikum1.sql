SELECT * 
FROM employees;

SELECT employee_id, first_name, last_name
FROM employees;

SELECT first_name, last_name, job_id
FROM employees
WHERE first_name = 'Steven';

SELECT salary,last_name
FROM employees
WHERE last_name LIKE 'Abel';

SELECT *
FROM wf_countries;

SELECT country_id, country_name, region_id
FROM countries;

SELECT location_id, city, state_province
FROM locations;

SELECT *
FROM locations;

--ARIMATIK OPERATOR
SELECT last_name, salary, salary * 12
FROM employees;

SELECT last_name, salary, 12 * salary + 100
FROM employees;

SELECT last_name, salary, 12 * (salary + 100 )
FROM employees;

SELECT last_name, job_id, salary, commission_pct
FROM employees;

SELECT last_name, job_id, salary, commission_pct,
salary * commission_pct as comm
FROM employees;

--ALIAS
SELECT last_name AS name, commission_pct AS comm
FROM employees;

SELECT last_name "Name", salary*12 AS "Annual Salary"
FROM employees;

--SECTION 2
--DESCRIBE
DESCRIBE employees;


--CONCATENATION
SELECT department_id || department_name
FROM departments;

SELECT department_id, department_name
FROM departments;

SELECT department_id || ' ' || department_name
FROM departments;

-- CONCATEN DAN ALIAS
SELECT department_id || ' ' || department_name
AS "Department Info"
FROM departments;

--CONCAT DAN LITERAL VALUES (Kutip satu bisa diisi dengan kata kata)
SELECT last_name, salary
FROM employees;

SELECT last_name || ' has a monthly salary of ' || salary || ' dollars '
AS pay
FROM employees;

SELECT last_name || ' has a ' || 2 || ' year salary of '|| salary * 24 || ' dollars '
AS pay
FROM employees;

-- DISTINCT (menampilkan hasil tanpa duplikatnya)
SELECT DISTINCT department_id
FROM employees;

SELECT department_id
FROM employees;

-- COMPARISON DENGAN WHERE
SELECT employee_id, first_name, last_name
FROM employees
WHERE employee_id = 101;

SELECT employee_id, first_name, last_name, Hire_date
FROM employees
WHERE hire_date < '01-Jan-2000';


SELECT SYSDATE
FROM DUAL;

SELECT employee_id, first_name, last_name
FROM employees
WHERE hire_date < '1/1/2000'; -- setiap pc bisa berbeda-beda format tanggal

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary >= 6000;

SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE job_id = 'IT_PROG'; -- case sensitive

--BETWEEN ... AND ....
SELECT last_name, salary
FROM employees
WHERE salary between 9000 and 20000;

SELECT last_name, salary
FROM employees
WHERE salary >= 9000 AND salary <= 20000;

-- IN
SELECT city, state_province, country_id
FROM locations
WHERE country_id IN ('UK', 'CA');

SELECT city, state_province, country_id
FROM locations
WHERE country_id = 'UK' OR country_id = 'CA';

-- LIKE
-- _ = menandakan karakter bebas pada urutan, _ = 2 karakter pertama bebas
-- {char} = menandakan karakter yang harus pada urutannya
-- % = bebas di depan, maupun sisanya bebas

SELECT last_name
FROM employees
WHERE last_name LIKE '%n';

SELECT last_name
FROM employees
WHERE last_name LIKE '%r%';

SELECT last_name, Job_id
FROM employees
WHERE job_id LIKE '%_R%';

SELECT last_name, job_id
FROM employees;

SELECT last_name, job_id
FROM employees
WHERE job_id LIKE '%\_C%' ESCAPE '\';

-- IS NULL AND NOT NULL
SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

SELECT last_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;