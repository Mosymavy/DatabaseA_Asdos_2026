-- GROUP FUNCTION
-- dia akan menggunakan seluruh baris untuk mencari hasil, dan menampilkannya dalam satu baris juga
-- dia akan mengabaikan variabel yang NULL

-- Fungsi-fungsi dasar
SELECT MAX(salary)
FROM employees;

SELECT MIN(salary)
FROM employees;

SELECT SUM(salary)
FROM employees;

SELECT AVG(salary)
FROM employees;

SELECT VARIANCE(salary)
FROM employees;

SELECT STDDEV(salary)
FROM employees;

-- Bisa juga digunakan untuk tanggal
SELECT MIN(hire_date)
FROM employees;

select * from wf_countries;

SELECT MIN(life_expect_at_birth)
   AS "Lowest Life Exp"
FROM wf_countries;

SELECT MAX(hire_date)
FROM employees;

SELECT MAX(life_expect_at_birth)
  AS "Highest Life Exp"
FROM WF_COUNTRIES;

-- Bisa juga digunakan untuk multiple statement
SELECT MAX(salary),MIN(salary),MIN(employee_id)
FROM employees
WHERE department_id = 60;

-- Tapi kalau menggunakan group function dengan single row function, dia akan menghasilkan error
SELECT COUNT(department_id), first_name
FROM employees;

-- Contoh penggunaan lainnya
SELECT SUM(area)
FROM wf_countries;

SELECT SUM(salary)
FROM employees
WHERE department_id = 90;

SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(area)
FROM wf_countries
WHERE region_id = 29;

SELECT SUM(salary), COUNT(salary),AVG(salary),
  MIN(salary), MAX(salary), Variance(salary), STDDEV(salary)
FROM employees;

SELECT ROUND(AVG(salary),2)
FROM EMPLOYEES
WHERE departement_id = 90;

SELECT ROUND(variance(life_expect_at_birth),4)
FROM wf_countries;

SELECT ROUND(STDDEV(life_expect_at_birth),4)
FROM wf_countries;

--8.2 COUNT, DISTINCT NVL
SELECT COUNT(job_id)
FROM employees;

SELECT COUNT(commission_pct)
FROM employees;

-- simbol bintang (*) bisa digunakan untuk select semua row (baik yang null maupun tidak)
SELECT COUNT(*)
FROM employees;

SELECT COUNT(commission_pct)
from employees;

SELECT COUNT(*)
FROM EMPLOYEES
WHERE hire_date < '01-Jan-1996';

SELECT job_id
FROM employees;

-- distinct menghilangkan row yang duplikat
SELECT DISTINCT job_id
FROM employees;

SELECT DISTINCT department_id
FROM employees;

-- Distinct bisa digunakan di dalam 2+ baris, maka akan mengecek satu per satu apakah dua baris tersebut
-- akan menghasilkan duplikat sesuai dengan keduanya. Pada distinct di 2+ baris, bisa terjadi ada
-- variabel duplikat yang muncul. Tetapi, jika dibandingkan di kolom lainnya, dia tidak duplikat. Jadi,
-- kalau distinct digunakan dalam 2+ baris, dia akan mengecek kalau baris itu memiliki kemiripan di dua
-- kolom itu.
SELECT DISTINCT job_id, department_id
FROM employees;

SELECT SUM(DISTINCT salary)
FROM employees
WHERE department_id = 90;

SELECT SUM(salary)
FROM employees
WHERE department_id = 90;

SELECT COUNT(DISTINCT job_id)
FROM employees;

SELECT COUNT(job_id)
FROM employees;

SELECT department_id, MAX(salary)
FROM employees;

--NVL
SELECT AVG(commision_pct)
FROM employees;

SELECT AVG(NVL(commision_pct, 0))
FROM employees;

--GROUP BY
--Menggunakan key sebagai acuan untuk menggunakan group function per keynya
--Single key yang digunakan harus dijadikan acuan dalam group by
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, employee_id,Max(salary),Min(salary)
FROM employees
GROUP BY department_id, employee_id
ORDER BY department_id ASC;

--Semua kolom di select harus dituliskan di group by,kecuali group functions
SELECT job_id, last_name, salary, MAX(COMMISSION_PCT)
FROM employees
GROUP BY job_id;

--Mencari jumlah department, dari seluruh kota yang ada
SELECT l.city, COUNT(d.department_id) AS "Jumlah Departmen"
FROM locations l, departments d
WHERE l.location_id = d.location_id
GROUP BY l.city
ORDER BY l.city;

--GROUP BY & WHERE
SELECT department_id, MAX(salary), last_name
FROM employees
WHERE last_name != 'King'
GROUP BY department_id, last_name
ORDER BY department_id;

SELECT department_id, MAX(salary)
FROM employees
WHERE NOT last_name = 'King'
GROUP BY department_id, last_name
ORDER BY department_id;

--GROUP BY & ROUND
SELECT d.department_name AS "Department Name", ROUND(AVG(e.salary)) as "Average Salary"
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY d.department_name;

--NESTING Group function, nesting group itu harus pakai GROUP BY function
SELECT MIN(salary) FROM employees
GROUP BY employee_id;

SELECT MIN(MIN(salary)) FROM employees
GROUP BY employee_id;

SELECT max(avg(salary))
FROM employees
GROUP BY department_id;

--HAVING CLAUSE
SELECT AVG(height) FROM students WHERE year_in_school = 10; -- akan error

SELECT department_id, MAX(salary)
FROM employees
WHERE COUNT(*) > 1 -- error
GROUP BY department_id;

--untuk group by, menggunakan having untuk mencari kondisi
SELECT department_id, MAX(salary), COUNT(department_id)
FROM employees
GROUP BY department_id
HAVING COUNT (*) > 1
ORDER BY department_id;

--Untuk penggunaan function yang dari single function, masih menggunakan where,
--tetapi untuk function yang digunakan dalam group function (misalkan jumlah data lebih 
--dari 10), menggunakan having.
SELECT department_id, MAX(salary)
FROM employees
WHERE last_name != 'King'
GROUP BY department_id;

--single row & group function
SELECT region_id, ROUND(AVG(population)) AS population
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

SELECT country_id, COUNT(language_id) AS "Number of languages"
FROM wf_spoken_languages
GROUP BY country_id;

--10.2
--TANPA ROLLUP
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY (department_id, job_id);

-- ROLLUP = melakukan penjumlahan berlapir terhadap argumen
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP (department_id, job_id);

-- CUBE = Mirip dengan roll up hanya saja dia menghitung semua argumen
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 50 
GROUP BY CUBE (department_id, job_id);

-- GROUPING SETS = Memberikan fungsionalitas untuk menghasilkan beberapa klausa GORUP BY di satu statement SELECT,
-- yang dimana tidak dibolehkan di syntax yang normal.
SELECT department_id, job_id, manager_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY GROUPING SETS
((job_id, manager_id),(department_id, job_id),
(department_id, manager_id));

SELECT department_id, job_id, SUM(salary),
 GROUPING(department_id) AS "Dept sub total",
 GROUPING(job_id) AS "Job sub total"
FROM employees
WHERE department_id < 50
GROUP BY CUBE (department_id, job_id);

--SET OPERATOR
-- UNION : Gbaung hasil dua query, harus duplikat (seperti union dalam matematika)
--UNION ALL : Gabung hasil dua query, tetap tampikan duplikat
--MINUS ( EXPEXT di beberapa rdbms lain) : ambil baris yang muncul di query pertama tapi tidak di kedua
--INTERSECT : ambil baris yang muncul di kedua query

SELECT hire_date, employee_id, job_id
FROM employees
UNION
SELECT TO_DATE(NULL), employee_id, job_id
FROM job_history;

SELECT location_id FROM locations
UNION
SELECT location_id FROM departments
ORDER BY location_id;

SELECT location_id FROM locations
UNION ALL
SELECT location_id FROM departments
ORDER BY location_id;

SELECT location_id FROM locations
INTERSECT
SELECT location_id FROM departments;

SELECT department_id FROM employees
MINUS
SELECT department_id FROM departments;

--CONTOH PENGGUNAAN
SELECT hire_date, employee_id, job_id
FROM employees
UNION
SELECT TO_DATE(NULL),employee_id, job_id
FROM job_history;

SELECT hire_date, employee_id, job_id
FROM employees
UNION
SELECT TO_DATE(NULL),employee_id, job_id
FROM job_history
ORDER BY employee_id; --tambah order by doang

SELECT hire_date, employee_id, TO_DATE(null) start_date,
 TO_DATE(null) end_date, job_id, department_id
FROM employees
UNION
SELECT TO_DATE(null), employee_id, start_date, end_date, job_id,
department_id
FROM job_history
ORDER BY employee_id;