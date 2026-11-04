CREATE TABLE my_cd_collection(
    cd_number NUMBER(3),
    title VARCHAR2(20),
    artist VARCHAR2(20),
    purchase_date DATE DEFAULT SYSDATE);

CREATE TABLE my_friends(
    first_name VARCHAR2(20),
    last_name VARCHAR2(30),
    email VARCHAR2(30),
    phone_num VARCHAR2(12),
    birth_date DATE);

SELECT table_name, status
FROM USER_TABLES;

SELECT table_name, status
FROM ALL_TABLES;

SELECT *
FROM user_indexes;

--CHARACTER
--  CHAR (fixed size, maximum 2000 characters)
--  VARCHAR2 (variable size, maximum 32,767 characters)
--  CLOB (variable size, maximum 128 terabytes)

--NUMBER
--  NUMBER (variable size, maximum precision 38 digits)

--DATE & TIME
--  DATE
--  TIMESTAMP ….
--  INTERVAL

--BINARY
--  RAW (variable size, maximum 2000 bytes)
--  BLOB (variable size, maximum 128 terabytes)

CREATE TABLE time_ex1
(exact_time TIMESTAMP);

INSERT INTO time_ex1
VALUES ('10-Jun-2017 10:52:29.123456');

INSERT INTO time_ex1
VALUES (SYSDATE);

INSERT INTO time_ex1
VALUES (SYSTIMESTAMP);

SELECT *
FROM time_ex1;


CREATE TABLE time_ex2
(time_with_offset TIMESTAMP WITH TIME ZONE);

INSERT INTO time_ex2
VALUES (SYSTIMESTAMP);

INSERT INTO time_ex2
VALUES ('10-Jun-2017 10:52:29.123456 AM +2:00');

SELECT *
FROM time_ex2;


CREATE TABLE time_ex3(
    first_column TIMESTAMP WITH TIME ZONE,
    second_column TIMESTAMP WITH LOCAL TIME ZONE
);

INSERT INTO time_ex3(first_column, second_column)
VALUES('15-Jul-2017 08:00:00 AM -07:00', '15-Nov-2007 08:00:00');

SELECT *
FROM time_ex3;


CREATE TABLE time_ex4
(loan_duration1 INTERVAL YEAR(3) TO MONTH,
    loan_duration2 INTERVAL YEAR(2) TO MONTH);

INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES (INTERVAL '120' MONTH(3),
    INTERVAL '3-6' YEAR TO MONTH);

SELECT SYSDATE + loan_duration1 AS "120 months from now",
    SYSDATE + loan_duration2 AS "3 years 6 months from now"
FROM time_ex4;


CREATE TABLE time_ex5
(day_duration1 INTERVAL DAY(3) TO SECOND,
    day_duration2 INTERVAL DAY(3) TO SECOND);

INSERT INTO time_ex5 (day_duration1, day_duration2)
VALUES (INTERVAL '25' DAY(2), INTERVAL '4 10:30:10' DAY TO SECOND);

SELECT SYSDATE + day_duration1 AS "25 Days from now",
    TO_CHAR(SYSDATE + day_duration2, 'dd-Mon-yyyy hh:mi:ss')
    AS "precise days and time from now"
FROM time_ex5;


ALTER TABLE my_cd_collection
    ADD (release_date DATE DEFAULT SYSDATE);

ALTER TABLE my_friends
    ADD (favorite_game VARCHAR2(30));


CREATE TABLE mod_emp(
    last_name VARCHAR2(20),
    salary NUMBER(8,2))

-- Untuk modifikasi hanya bisa dilakukan tergantung pada jumlah karakter pada data-data yang ada

-- Would be permitted only if columns were empty, or the largestname was 10 or less characters
ALTER TABLE mod_emp
    MODIFY (last_name VARCHAR2(10));

-- Would be permitted with or without data as column width increased
ALTER TABLE mod_emp
    MODIFY (last_name VARCHAR2(30));

-- Would be permitted with or without data as column precision increased
ALTER TABLE mod_emp
    MODIFY (salary NUMBER(10,2));

-- Would be permitted with or without data as only a DEFAULT value added
ALTER TABLE mod_emp
    MODIFY (salary NUMBER(8,2) DEFAULT 50);

--DROP COLUMN
ALTER TABLE my_cd_collection
DROP COLUMN release_date;

ALTER TABLE my_friends
DROP COLUMN favorite_game;

--SET UNUSED
ALTER TABLE copy_employees
SET UNUSED (email);

ALTER TABLE copy_employees
DROP UNUSED COLUMNS;

--DROP TABLE
DROP TABLE copy_employees;

--FLASHBACK
FLASHBACK TABLE copy_employees TO BEFORE DROP;

SELECT original_name, operation, droptime
FROM user_recyclebin;

DROP TABLE copy_employees PURGE;

RENAME my_cd_collection TO my_music;

TRUNCATE TABLE copy_employees;

COMMENT ON TABLE copy_employees
    IS 'Western Region only';

SELECT table_name, comments
FROM user_tab_comments;

SELECT employee_id,first_name ||' '|| last_name AS "NAME",
    versions_operation AS "OPERATION",
    versions_starttime AS "START_DATE",
    versions_endtime AS "END_DATE", salary
FROM copy_employees
    VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;

INSERT INTO copy_employees
VALUES (1, 'Natacha', 'Hansen', 'NHANSEN', '4412312341234',
    '07-SEP-1998', 'AD_VP', 12000, null, 100, 90, NULL);

SELECT employee_id,first_name ||' '|| last_name AS "NAME",
    versions_operation AS "OPERATION",
    versions_starttime AS "START_DATE",
    versions_endtime AS "END_DATE", salary
FROM employees
    VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;

UPDATE copy_employees
SET salary = 1
WHERE employee_id = 1;

SELECT employee_id,first_name ||' '|| last_name AS "NAME",
    versions_operation AS "OPERATION",
    versions_starttime AS "START_DATE",
    versions_endtime AS "END_DATE", salary
FROM employees
    VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;

DELETE from copy_employees
WHERE employee_id = 1;

SELECT employee_id,first_name ||' '|| last_name AS "NAME",
    versions_operation AS "OPERATION",
    versions_starttime AS "START_DATE",
    versions_endtime AS "END_DATE", salary
FROM employees
    VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;

SELECT employee_id, salary
FROM copy_employees
WHERE employee_id = 1;