
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