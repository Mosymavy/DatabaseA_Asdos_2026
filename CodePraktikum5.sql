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

SELECT last_name
FROM employees
WHERE job_id LIKE '%_R%';

-- NUMBER KONVERSION

SELECT TO_NUMBER('52.015000', '00.000000') AS "Number" FROM dual;

SELECT TO_NUMBER('53203', '99999') AS "Number" FROM dual;

SELECT TO_NUMBER(:v , '00.000000') AS "Number" FROM dual;

SELECT TO_NUMBER(:v, '999999') AS "Number" FROM dual;

SELECT last_name, bonus, TO_NUMBER(bonus,'9999') AS "Bonus"
FROM employees
WHERE department_id = 80;

-- NVL 
SELECT commission_pct, NVL(commission_pct, 100) FROM employees;

SELECT date_of_independence, NVL(date_of_independence, 'No date')
FROM wf_countries;

--NVL2
--NVL2 (argumen1, argumen2, argumen3)
--argumen1 mau cek dimana yg ada null, argumen2 itu replace jika tidak null
--argumen3 replace jika null

SELECT last_name, commission_pct, salary,
NVL2(commission_pct, salary + (salary * commission_pct), 0)
FROM employees
WHERE department_id IN(80,90);

SELECT last_name, salary, commission_pct,
NVL2(commission_pct, salary + (salary * commission_pct),salary)
AS income
FROM employees
WHERE department_id IN(80,90);