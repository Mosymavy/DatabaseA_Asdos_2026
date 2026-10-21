CREATE TABLE copy_dept AS SELECT * FROM departments;
CREATE TABLE copy_emp AS SELECT * FROM employees;
CREATE TABLE copy_emp_2 AS SELECT * FROM employees WHERE 1=0; -- WHERE 1=0 membuat tidak memasukkan data-data apa-apa, tetapi hanya memasukkan struktur tabel

DESCRIBE copy_dept;
DESCRIBE copy_emp;
DESCRIBE copy_emp2;

SELECT * FROM copy_dept;
SELECT * FROM copy_emp;
SELECT * FROM copy_emp_2;

INSERT INTO copy_dept VALUES (150, 'Business Analyst', 105, 1700);
INSERT INTO copy_dept VALUES (250, 'Digital', NULL, 1700);
INSERT INTO copy_dept (department_name,department_id,manager_id)
VALUES ('Human Resources', 130, 102);

SELECT USER, SYSDATE, TO_CHAR(SYSDATE, 'ddspth, month yyspth');
INSERT INTO copy_emp VALUES (307, USER , 'Felisia', 'YELLOW', '812.345.6789', SYSDATE, 'MK_REP', 4200, NULL, 100, 90, NULL);
INSERT INTO copy_emp VALUES (301, 'Grigorz', 'Polanski', 'gpolanski', NULL, TO_DATE('July 8, 2017', 'Month fmdd, yyyy'), 'IT_PROG', 4200, 0.10, 100, 90, null);

INSERT INTO copy_emp (employee_id, first_name, last_name, phone_number, hire_date, job_id, salary)
VALUES (302,'Grigorz','Polanski', '8586667641', '15-Jun-2017', 'IT_PROG', 4200);

INSERT INTO copy_emp (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES (301,'Katie','Hernandez', 'khernandez','8586667641', TO_DATE('July 8, 2017', 'Month fmdd, yyyy'), 'MK_REP',4200);

INSERT INTO copy_emp (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES (303,'Angelina','Wright', 'awright','4159982010', TO_DATE('July 10, 2017 17:20', 'Month fmdd, yyyy HH24:MI'), 'MK_REP', 3600);

SELECT * FROM copy_emp;

SELECT first_name, last_name, TO_CHAR(hire_date, 'dd-Mon-YYYY HH24:MI') As "Date and Time"
FROM copy_employees
WHERE employee_id = 303;

INSERT INTO sales_reps(id, name, salary, commission_pct)
 SELECT employee_id, last_name, salary, commission_pct
 FROM employees
 WHERE job_id LIKE '%REP%';

INSERT INTO copy_emp_2 SELECT * FROM copy_emp WHERE last_name = 'Polanski';

SELECT * FROM copy_emp_2;

UPDATE copy_dept SET department_name = 'Pemasaran' WHERE department_id = 20;
UPDATE copy_dept SET department_name = 'Pengiriman', manager_id = 101 WHERE department_id = 50;

UPDATE copy_emp SET phone_number = '123456' WHERE employee_id = 303;

UPDATE copy_emp SET phone_number = '654321', last_name = 'Jones' WHERE employee_id >= 303;

SELECT * FROM copy_dept;

UPDATE copy_employees SET salary = (SELECT salary FROM copy_employees WHERE employee_id = 100)
WHERE employee_id = 101;

UPDATE copy_emp SET
  salary = (SELECT salary FROM copy_employees WHERE employee_id = 205),
  job_id = (SELECT job_id FROM copy_employees WHERE employee_id = 205)
WHERE employee_id = 206;

UPDATE copy_employees SET
salary = (SELECT salary FROM employees WHERE employee_id = 205)
WHERE employee_id = 202;

UPDATE copy_emp SET  
  salary = (SELECT salary FROM employees WHERE last_name = 'King'),
  job_id = (SELECT job_id FROM employees WHERE last_name = 'Kochhar'),
  hire_date = (SELECT hire_date FROM employees WHERE last_name = 'Whalen')
WHERE employee_id = 102;

ALTER TABLE copy_employees
ADD (department_name varchar2(30) NOT NULL);

UPDATE copy_emp e SET e.department_name =
 (SELECT d.department_name FROM departments d WHERE e.department_id = d.department_id);

DELETE from copy_emp WHERE employee_id = 303;

DELETE FROM copy_emp
WHERE department_id =
 (SELECT department_id FROM departments WHERE department_name = 'Shipping');

DELETE FROM copy_employees e WHERE e.manager_id IN
 (SELECT d.manager_id FROM employees d HAVING count (d.department_id) < 2 GROUP BY d.manager_id);

DELETE FROM copy_emp WHERE department_id = 80;
DELETE FROM copy_emp_2;
DROP TABLE copy_emp_2;

DELETE FROM copy_dept WHERE department_id = (
  SELECT department_id FROM departments WHERE department_name = 'Accounting');

SELECT * FROM copy_dept;

SELECT e.employee_id, e.salary, d.department_name
FROM employees e JOIN departments d USING (department_id)
WHERE job_id = 'ST_CLERK' AND location_id = 1500 FOR UPDATE
ORDER BY e.employee_id;


CREATE TABLE my_employees (
 hire_date DATE DEFAULT SYSDATE,
 first_name VARCHAR2(15),
 last_name VARCHAR2(15)
);

INSERT INTO my_employees(hire_date, first_name, last_name)
VALUES(DEFAULT, 'Angelina','Wright');

INSERT INTO my_employees(first_name, last_name)
VALUES('Angelina','Wright'); -- tanpa default

UPDATE my_employees
SET hire_date = DEFAULT
WHERE last_name = 'Wright';

MERGE INTO copy_emp c USING employees e ON (c.employee_id = e.employee_id)
WHEN MATCHED THEN UPDATE
 SET c.last_name = e.last_name,
 c.department_id = e.department_id
WHEN NOT MATCHED THEN INSERT
 VALUES(e.employee_id, e.last_name, e.department_id);

INSERT ALL
 INTO my_employees
 VALUES (hire_date, first_name, last_name)
 INTO copy_my_employees
 VALUES (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;

INSERT ALL
 WHEN call_format IN ('tlk','txt','pic') THEN
 INTO all_calls
  VALUES (caller_id, call_timestamp, call_duration, call_format)
 WHEN call_format IN ('tlk','txt') THEN
 INTO police_record_calls
  VALUES (caller_id, call_timestamp, recipient_caller)
 WHEN call_duration < 50 AND call_type = 'tlk' THEN
 INTO short_calls
  VALUES (caller_id, call_timestamp, call_duration)
 WHEN call_duration > = 50 AND call_type = 'tlk' THEN
 INTO long_calls
  VALUES (caller_id, call_timestamp, call_duration)
SELECT caller_id, call_timestamp, call_duration, call_format,
 recipient_caller
FROM calls
WHERE TRUNC(call_timestamp ) = TRUNC(SYSDATE);

CREATE TABLE copy_emp_2 AS SELECT * FROM employees WHERE 
department_id > 100;

MERGE INTO copy_emp_2 c USING employees e
ON (c.employee_id = e.employee_id)
WHEN MATCHED THEN UPDATE SET
  c.last_name = e.last_name, c.department_id = e.department_id, c.salary = e.salary
WHEN NOT MATCHED THEN INSERT
  (employee_id, first_name, last_name, email, phone_number, hire_date,
   job_id, salary, commission_pct, manager_id, department_id)
VALUES
  (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number,
   e.hire_date, e.job_id, e.salary, e.commission_pct, e.manager_id, e.department_id);

SELECT * FROM copy_emp_2;

--INSERT ALL
INSERT ALL
  INTO copy_emp VALUES (307, USER, 'Felisia', 'YELLOW', '821.345.6789', SYSDATE, 'MK_REP', 4200, null, 100, 90,null) 
  INTO copy_emp VALUES (301, 'Grigorz', 'Polanski', 'gpolanski', NULL, TO_DATE('July 8 2017', 'Month fmdd, yyyy'), 'IT_PROG', 4200, 0.10, 100, 90,null)
SELECT * FROM dual;

CREATE TABLE mahasiswa (
  npm CHAR(5) PRIMARY KEY,
  nama VARCHAR2 (50) NOT NULL,
  tgl_lahir DATE,
  jenis_kel VARCHAR2 (10)
);

desc mahasiswa;

INSERT INTO mahasiswa VALUES ('99999', 'Felisia', sysdate, 'Perempuan');

CREATE TABLE df (
  id NUMBER (10) PRIMARY KEY,
  description VARCHAR2 (50) NOT NULL
);

select * from df;

CREATE SEQUENCE dept_seq START WITH 100 INCREMENT BY 1 MAXVALUE 105;

INSERT INTO df VALUES (dept_seq.nextval, 'Just DESCRIPTION');
ALTER SEQUENCE dept_seq MAXVALUE 110;

--hapus duplicat berdasarkan primary key
DELETE FROM mahasiswa
WHERE npm = '9999';

--data dictionary
SELECT table_name, status FROM user_tables;
SELECT  * FROM user_objects WHERE object_type = 'SEQUENCE';

--waktu
CREATE TABLE time_ex1 (extract_time TIMESTAMP);
INSERT INTO time_ex1 VALUES (SYSTIMESTAMP);

CREATE TABLE time_ex2 (time_with_offset TIMESTAMP WITH TIME ZONE);
INSERT INTO time_ex2 VALUES (SYSTIMESTAMP);
SELECT * FROM time_ex2;

--ALTER TABLE
describe mahasiswa;
ALTER TABLE mahasiswa ADD (sekolah_asal VARCHAR2(50), kode_prodi NUMBER(5),email VARCHAR2(30));
ALTER TABLE mahasiswa MODIFY (nama VARCHAR2(30));
ALTER TABLE mahasiswa DROP COLUMN email;
ALTER TABLE mahasiswa DROP (sekolah_asal, kode_prodi);
ALTER TABLE mahasiswa SET UNUSED (jenis_kel);
ALTER TABLE mahasiswa DROP UNUSED COLUMNS;

--DDL LAIN
CREATE TABLE copy_emp_temp AS SELECT * FROM employees;
DROP TABLE copy_emp_temp;
FLASHBACK TABLE copy_emp_temp TO BEFORE DROP;
RENAME copy_emp_temp TO emp;
TRUNCATE TABLE emp;
COMMENT ON TABLE employees IS 'Ini table employee';

--clean up 
DROP TABLE copy_debt;
DROP TABLE copy_emp;
DROP TABLE copy_emp_2;
DROP TABLE df;
DROP TABLE time_ex1;
DROP TABLE time_ex2;
DROP TABLE time_ex5;
DROP TABLE time_ex6;
DROP TABLE emp;
DROP TABLE mahasiswa;