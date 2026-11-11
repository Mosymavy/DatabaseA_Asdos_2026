CREATE TABLE clients_raw (
  client_number NUMBER(4),
  first_name VARCHAR2(14),
  last_name VARCHAR2(13)
);

INSERT INTO clients_raw VALUES (1001, 'Smith', NULL);
INSERT INTO clients_raw VALUES (1001, 'Johnson', 'Johnson');

SELECT * FROM clients_raw;

DROP TABLE clients_raw;

CREATE TABLE clients_col_level(
  client_number NUMBER(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
  last_name VARCHAR2(14),
  email VARCHAR2(80)
);

CREATE TABLE clients_col_level (
  client_number NUMBER(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
  last_name VARCHAR2(14) CONSTRAINT clients_last_name_nn NOT NULL,
  email VARCHAR2(80)  CONSTRAINT clients_email_uk UNIQUE
);

INSERT INTO clients_col_level VALUES (1001, 'Smith', 'smith@example.com');
INSERT INTO clients_col_level VALUES (1002, 'Johnson', null);

SELECT * FROM clients_col_level;
DROP TABLE clients_col_level;

CREATE TABLE clients_table_level (
  client_number NUMBER(6) NOT NULL,
  first_name VARCHAR2(20),
  last_name VARCHAR2(20),
  phone VARCHAR2(20),
  email VARCHAR2(10) NOT NULL,
  CONSTRAINT clients_phone_email_uk UNIQUE (email, phone)
);

INSERT INTO clients_table_level VALUES (2001, 'Alice', 'Brown', '0812', 'alice@a.com');
INSERT INTO clients_table_level VALUES (2002, 'Bob', 'Green', '0812', 'alice@a.com');

SELECT * FROM clients_table_level;
DROP TABLE clients_table_level;

CREATE TABLE copy_job_history (
  employee_id NUMBER(6, 0),
  start_date DATE,
  job_id VARCHAR2(10),
  department_id NUMBER(4,0),
  CONSTRAINT copy_jhist_id_st_date_pk PRIMARY KEY (employee_id, start_date)
);

INSERT INTO copy_job_history VALUES (101, DATE'2023-01-01', 'DEV01', 10);
INSERT INTO copy_job_history VALUES (102, DATE'2022-05-15', 'HR01', 20);

SELECT * FROM copy_job_history;
DROP TABLE copy_job_history;

CREATE TABLE copy_departments(
  department_id NUMBER(4,0) CONSTRAINT c_dept_dept_id_pk PRIMARY KEY,
  department_name VARCHAR2(30)
);

INSERT INTO copy_departments VALUES (10, 'Development');
INSERT INTO copy_departments VALUES (20, 'HR');

CREATE TABLE copy_employees (
    employee_id   NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
    first_name    VARCHAR2(20),
    last_name     VARCHAR2(25),
    department_id NUMBER(4,0) CONSTRAINT cdept_dept_id_fk
                  REFERENCES copy_departments(department_id) ON DELETE CASCADE,
    email         VARCHAR2(25)
);

INSERT INTO copy_employees VALUES (101, 'Alice', 'Smith', 10, 'alice@company.com');
INSERT INTO copy_employees VALUES (102, 'Bob', 'Johnson', 20, 'bob@company.com');

SELECT e.employee_id, e.first_name, e.last_name, d.department_name
FROM copy_employees e
JOIN copy_departments d ON e.department_id = d.department_id;

DROP TABLE copy_employees;
DROP TABLE copy_departments;

CREATE TABLE emp_sal (
  employee_id NUMBER(6,0),
  salary NUMBER(8,2) CONSTRAINT employees_min_sal_ck CHECK (SALARY > 0)
);

INSERT INTO emp_sal VALUES (101, 5000);

SELECT * FROM emp_sal;
DROP TABLE emp_sal;

CREATE OR REPLACE VIEW view_euro_countries AS
SELECT country_id AS ID, country_name AS Country, capitol AS "Capitol City", location
FROM wf_countries
WHERE location LIKE '%Europe';

SELECT * FROM view_euro_countries;
DROP VIEW view_euro_countries;

CREATE OR REPLACE VIEW view_euro_countries_join AS
SELECT c.country_id, c.country_name, c.capitol,r.region_name
FROM wf_countries c
JOIN wf_world_regions r USING (region_id)
WHERE location LIKE '%Europe';

SELECT * FROM view_euro_countries_join;
DROP VIEW view_euro_countries_join;

CREATE OR REPLACE VIEW view_high_pop AS
SELECT region_id, MAX(population) AS "Highest Population"
FROM WF_COUNTRIES
GROUP BY region_id;


SELECT * FROM view_high_pop;
DROP VIEW view_high_pop;

CREATE OR REPLACE VIEW view_dept50 AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM COPY_EMP
WHERE department_id = 50
WITH CHECK OPTION;

SELECT * FROM view_dept50;
DROP VIEW view_dept50;

CREATE OR REPLACE VIEW view_dept50_ro AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM COPY_EMP
WHERE department_id = 50
WITH READ ONLY;

SELECT * FROM view_dept50_ro;
DROP VIEW view_dept50_ro;

CREATE OR REPLACE VIEW view_row AS
SELECT rownum AS "Longest Employed", last_name, hire_date
FROM employees
WHERE rownum <= 3
ORDER BY hire_date;

SELECT * FROM view_row;
DROP VIEW view_row;

ALTER TABLE employees
ADD CONSTRAINT emp_id_pk PRIMARY KEY (employee_id);

ALTER TABLE employees
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
 REFERENCES departments (department_id) ON DELETE CASCADE;

ALTER TABLE copy_departments
DISABLE CONSTRAINT c_dept_dept_id_pk CASCADE;

ALTER TABLE copy_departments
ENABLE CONSTRAINT c_dept_dept_id_pk;

SELECT constraint_name, table_name, constraint_type, status
FROM USER_CONSTRAINTS
WHERE table_name ='COPY_EMPLOYEES';