-- JOIN: Menggabungkan dua tabel menjadi satu tabel

SELECT * FROM employees;
SELECT * FROM jobs;

-- Menggabungkan kolom di dua tabel yang menghasilkan nama sama dan value
SELECT * FROM employees NATURAL JOIN jobs;

-- Menggabungkan semua kombinasi baris yang ada dari dua tabel
-- Misal: Jika tabel employees punya 20 rows dan departments punya tabel 8 rows
-- maka CROSS JOIN akan mengembalikan 160 rows
SELECT * FROM employees CROSS JOIN jobs;

SELECT first_name, last_name, job_id, job_title
FROM employees NATURAL JOIN jobs
WHERE department_id > 80;

SELECT department_name, city
FROM departments NATURAL JOIN locations;

SELECT last_name, department_name
FROM employees CROSS JOIN departments;

-- Di Natural Join, jika di dua tabel ada dua kolom dengan nama yang sama tetapi tipe data berbeda,
-- maka join akan menghasilkan error. Untuk menghindari ini, maka dapat digunaka USING.

--USING: Menentukan kolom yang mana yang harus digunakan untuk JOIN

SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id);

SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id)
WHERE last_name = 'Higgins';

SELECT last_name, job_title
FROM employees JOIN jobs USING (job_id);

-- ON: Jika dua kolom pada dua tabel menggunakan nama yang berbeda, tetapi ingin kita gabung, kita
-- dapat menggunakan ON untuk menggabungkannya.

SELECT last_name, job_title
FROM employees e JOIN jobs J  -- Disini artinya e sebagai alias pada employees, dan J sebagai alias jobs
    ON (e.job_id = J.job_id); -- Dan disini menggunakan alias tersebut untuk menentukan join. Bisa menggunakan beda kolom.

SELECT last_name, job_title
FROM employees e JOIN jobs J
    ON (e.job_id = J.job_id)
WHERE last_name LIKE 'H%';

-- Menggunakan ON pada operator yang tidak memiliki kolom korespondesi dengan tabel lainnya
-- Misalkan ingin menentukan grade, namun dengan perkiraan yang berada di tabel lain
SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees JOIN job_grades
    ON (salary BETWEEN lowest_sal AND highest_sal);

SELECT * FROM job_grades;
SELECT * FROM employees;

--JOINING THREE TABLES (bisa menggunakan using dan on)
SELECT last_name, department_name AS "Department" , city
FROM employees JOIN departments USING (department_id)
    JOIN locations USING (location_id);
-- disini artinya employees akan join departments menggunakan id department terlebih dahulu,
-- lalu department akan join locations menggunakan id location.

SELECT last_name, department_name AS "Department" , city
FROM employees e JOIN departments d ON (d.department_id = e.department_id)
    JOIN locations l ON (d.location_id = l.location_id);

SELECT last_name, department_name AS "Department" , city
FROM departments d JOIN employees e ON (d.department_id = e.department_id)
    JOIN locations l ON (d.location_id = l.location_id);

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

-- 6.3 Inner versus Outer Joins

--LEFT OUTER JOIN
-- Mempertahankan data yang ada pada tabel sebelah kiri 
-- Pada contoh di bawah yang menjadi tabel kiri adalah employees

SELECT e.last_name, d.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
    ON (e.department_id = d.department_id);

--RIGHT OUTER JOIN
-- Mempertahankan data yang ada pada tabel sebelah kanan
-- Pada contoh di bawah yang menjadi tabel kanan adalah departments

SELECT e.last_name, d.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
    ON (e.department_id = d.department_id);

--FULL OUTER JOIN 
--Mempertahankan data yang ada pada kedua tabel

SELECT e.last_name, d.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
    ON (e.department_id = d.department_id);

SELECT last_name, e.job_id AS "Job", jh.job_id AS "Old job ", end_date
FROM employees e LEFT OUTER JOIN job_history jh
    ON (e.employee_id = jh.employee_id);

--6.4 Self Joins and Hierarchical Queries

SELECT worker.last_name || ' Works for ' || manager.last_name
    AS "Works for"
FROM employees worker JOIN employees manager
    ON (worker.manager_id = manager.employee_id);

SELECT * FROM employees;

--SELF JOIN : Membuat tabel dapat join dengan sendiri

SELECT worker.last_name, worker.manager_id, manager.last_name
    AS "Manager name"
FROM employees worker JOIN employees manager
    ON (worker.manager_id = manager.employee_id);

-- HIERARCHICAL QUERIES : Mengambil data berdasarkan relasi antar baris atau hubungan bertingkat

SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100 -- Baris yang digunakan sebagai root untuk pohon yang dibentuk
CONNECT BY PRIOR employee_id = manager_id; -- Menjelaskan bagaimana bentuk join pada baris

SELECT employee_id, last_name, job_id, manager_id, LEVEL
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id
ORDER BY level;

SELECT last_name ||' reports to ' || PRIOR last_name AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;

SELECT LEVEL, last_name||' reports to '|| -- LEVEL: Menentukan berapa banyak hirarki akan traverse.
PRIOR last_name AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;

SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_') AS "Org Chart"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;

-- Bottom Up Hierarchical Queries: 
SELECT LPAD(last_name, LENGTH(last_name) + (LEVEL*2)-2, '_') AS ORG_CHART
FROM employees
START WITH last_name = 'Grant'
CONNECT BY employee_id = PRIOR manager_id;

SELECT last_name || ' reports to ' || PRIOR last_name AS "Walk Top Down", LEVEL
FROM EMPLOYEES
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id
ORDER BY level;

SELECT last_name
FROM employees
WHERE last_name != 'Higgins'
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id;

SELECT last_name
FROM employees
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id
AND last_name;

--EQUI JOIN
SELECT employees.last_name, employees.job_id, jobs.job_title
FROM employees, jobs 
WHERE employees.job_id = jobs.job_id;

--is the same with
SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.job_id = j.job_id);

SELECT employees.last_name, departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT last_name, e.job_id, job_title 
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND department_id = 80;

--CARTESIAN PRODUCT JOIN
SELECT employees.last_name, departments.department_name
FROM employees, departments;

SELECT employees.last_name, employees.job_id, jobs.job_title
FROM employees, jobs 
WHERE employees.job_id = jobs.JOB_ID
AND employees.department_id = 80;

SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

--NON-EQUI JOIN
SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees, JOB_GRADES
WHERE (salary BETWEEN lowest_sal AND highest_sal);

--LEFT OUTER JOIN
SELECT e.last_name, d.department_id, d.department_name
FROM employees e, departments d 
WHERE e.department_id = d.department_id(+);

--setara dengan
SELECT e.last_name, d.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

--RIGHT OUTER JOIN
SELECT e.last_name, d.department_id, d.department_name
FROM employees e, departments d 
WHERE e.department_id(+) = d.department_id;

--setara dengan
SELECT e.last_name, d.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);

--FULL OUTER JOIN TIDAK BISA MENGUNAKAN SYNTAX INI (AKAN MENGHASILKAN ERROR)
SELECT e.last_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id(+); --Akan menghasilkan error

--JADI YANG FULL OUTER JOIN HANYA BISA YANG
SELECT e.last_name, d.department_id, d.department_name
FROM employees e
FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);