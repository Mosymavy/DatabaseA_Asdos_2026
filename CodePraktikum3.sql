SELECT SYSDATE FROM DUAL;

-- fm : untuk buang spasi sama angka 0 di depan, jika taruh fm di paling depan (misal, tanggal 02 diubah menjadi 2 jika ada fm)
-- th : menampilkan angka ordinal (first, second, third, dll)
-- sp : menampilkan angka secara berbentuk kata
-- month, nama, bulan yang lengkap
-- DD artinya tgl dalam angka, YYYY artinya thn dlm angka

-- YYYY             : Tahun full dalam angka (2067)
-- YEAR             : Tahun ditulis dalam kalimat (TWENTY-SIXTY-SEVEN)
-- MM               : Dua digit bulan (11)
-- MONTH            : Nama full bulan (SEPTEMBER)
-- MON              : Tiga huruf pada bulan (SEP)
-- DY               : Tiga huruf pada hari dalam minggu (WED)
-- DAY              : Nama full pada hari dalam minggu (WEDNESDAY)
-- DD               : Tanggal dalam bentuk angka (16)
-- DDth             : Tanggal dalam bentuk angka dengan ordinal (16th)
-- DDspth           : Tanggal dalam bentuk kalimat dengan ordinal (SIXTEENTH)
-- Ddspth           : Sama seperti diatas, tetapi dengan huruf depan besar dan lainnya kecil (Sixteenth)
-- ddspth           : Sama seperti diatas, tetapi semua huruf besar (sixteenth)
-- DDD / DD / D     : Hari dalam tahun, bulan, atau minggu (DDD: Hari dalam tahun, DD: Hari dalam bulan, D: Hari dalam minggu)
-- HH24:MI:SS AM    : Menampilkan jam (15:45:32 PM)
-- DD "of" MONTH    : Menampilkan tanggal dengan string (12 of October)

-- Bagian karakter dapat dimanipulasi dengan penulisan kapital pada bagian yang kita mau
-- Contoh: DAY akan menghasilkan semua huruf kapital, Day akan berbentuk seperti INITCAP, dan day akan menghasilkan semua huruf kecil.

SELECT hire_date, TO_CHAR(hire_date, 'fmDD-Mon-YY')
FROM employees;

SELECT SYSDATE, TO_CHAR (sysdate + 3, 'MM DD,YYYY')
FROM dual;

SELECT hire_date, TO_CHAR(hire_date,'fmMonth DD, YYYY')
FROM employees;

SELECT hire_date, TO_CHAR(hire_date, 'DD-MM-YYYY')
FROM employees;

SELECT SYSDATE, TO_CHAR(sysdate, 'Day, DD-MON-YYYY')
FROM dual;

SELECT hire_date,TO_CHAR(hire_date, 'fmMonth dd, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmMonth ddth, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'Month dd, YYYY')
FROM employees;

-- FUNGSI SPTH : sebutin 1st jadi FIRST, first huruf besar
-- ddspth dan ddthsp menghasilkan hasil yang sama
SELECT TO_CHAR(hire_date, 'DDspth "of" Mon Year') FROM employees;
SELECT TO_CHAR(sysdate, 'Ddspth "of" Mon Year') FROM dual;
SELECT TO_CHAR(sysdate, 'ddspth "of" Mon Year') FROM dual;

--TO_CHAR pake jam
--hh = jam, mi = menit, ss = detik
-- am dan pm akan menghasilkan hasil yang sama
SELECT TO_CHAR(sysdate, 'hh:mi:ss am') FROM dual;
SELECT TO_CHAR(sysdate, 'hh:mi:ss pm') FROM dual;
SELECT TO_CHAR(sysdate, 'hh:mi') FROM dual;
SELECT TO_CHAR(sysdate, 'hh') FROM dual;

--TO_CHAR currency

-- 9    : Menampilkan angka yang ada (999999: 1234)
-- 0    : Menampilkan angka 0, baik pada awal maupun akhir (099999: 001234)
-- $    : Menampilkan simbol dollar ($) ($999999: $1234)
-- L    : Menampilkan mata uang negara lokal (L999999: FF1234)
-- .    : Menampilkan letak desimal (999999.99: 1234.00)
-- ,    : Menampilkan letak comma (999,999: 1,234)
-- MI   : Menampilkan angka minus di kanan (999999MI: 1234-)
-- PR   : Mengurungkan angka negatif (999999PR: <1234>)
-- EEEE : Menampilkan notasi scientific (99,999EEEE: 1,23E+03)
-- V    : Mengalikan dengan 10n kali (n = nomor dari 9 setelah V) (9999V99: 9999V99)
-- B    : Menampilkan angka nol sebagai blank, bukan 0 (B9999.99: 1234.00)

SELECT salary, TO_CHAR(salary, '$9,999') AS "Salary"
FROM employees;

SELECT salary, TO_CHAR(salary, '$99,999.99') AS "Salary"
FROM employees;

SELECT salary, TO_CHAR(salary, 'L99,999.99') AS "Salary"
FROM employees;

SELECT TO_CHAR(442, '9999999') FROM dual;
SELECT TO_CHAR(44223, '0000000') FROM dual;

SELECT TO_CHAR(:v, '0000999') FROM dual;

-- TO_NUMBER
-- 5.320 = angka apa yang kita punya
-- 9.999 = ikutin format dari 5.320
-- Format angka harus sesuai dengan jumlah angka yang dimiliki oleh tabel

SELECT TO_NUMBER('52.015000', '00.000000') AS "Number" FROM dual;
SELECT TO_NUMBER('53203', '99999') AS "Number" FROM dual;

SELECT last_name, bonus, TO_NUMBER(bonus,'9999') AS "Bonus"
FROM employees
WHERE department_id = 80;

--TO_DATE
SELECT TO_DATE('November 3, 2001', 'Month DD, yyyy') FROM dual;
SELECT TO_DATE('3 NOV, 2001', 'DD MON, YYYY') FROM dual;

--fx = harus spesifik/benar-benar sama (misal: jika ada 0 di depan (kalau misal 1 dijadikan 01), maka harus menggunakan fx)
SELECT TO_DATE('july312004', 'monthDDYYYY') as "Date" from dual;
SELECT TO_DATE('july 312004', 'fxmonth DDYYYY') as "Date" from dual;
SELECT TO_DATE('11 sep, 1965', 'fxdd mon, YYYY') as "Date" from dual;

-- RR: Sama dengan tahun, namun bedanya RR juka digunakan untuk menampilkan abad sebelumnya jika tahun kurang dari 50
-- YY: Selalu menampilkan dalam bentuk tahun 2000

SELECT TO_CHAR(SYSDATE, 'DD-MON-YY')
FROM dual;

SELECT hire_date, TO_CHAR(hire_date, 'DD-Mon-RRRR')
FROM employees;

SELECT TO_DATE('27-OCT-95','DD-Mon-RR') AS "Date" FROM dual;
SELECT TO_DATE('27-OCT-17','DD-Mon-RR') AS "Date" FROM dual;

SELECT commission_pct, NVL(commission_pct, 100) FROM employees;

SELECT date_of_independence, NVL(date_of_independence, 'No date')
FROM wf_countries;

--NVL: Jika menghasilkan value null, maka akan mengubah value tersebut dengan yang sudah ditentukan
SELECT last_name, NVL(commission_pct, 0)
FROM employees
WHERE department_id IN(80,90);

SELECT NVL(date_of_independence,'No date')
FROM wf_countries;

SELECT last_name, NVL(commission_pct, 0)*250 AS "Commission"
FROM employees
WHERE department_id IN(80,90);

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

--NULLIF: Membandingkan kedua ekspresi, jika keduanya sama maka akan menghasilkan null
-- namun jika tidak sama, maka akan mengembalikan argumen pertama

SELECT first_name,
LENGTH(first_name) AS "Length FN", last_name,
LENGTH(last_name) AS "Length LN",
NULLIF(LENGTH(first_name),LENGTH(last_name)) AS "Compare Them"
FROM employees;

SELECT commission_pct, salary,
NULLIF(commission_pct, salary)
FROM EMPLOYEES;

SELECT NULLIF(NULL,15) FROM DUAL;
-- ga bisa karena null tidak terdeteksi

SELECT NULLIF(15,NULL) FROM DUAL;

-- Coalesce cari sampai ga null
-- jika argumen1 tidak null, return argumen1
-- jika argumen1 null, lanjut ke argumen2,
-- argumen2 null, lanjut ke argumen3 dst

SELECT last_name, commission_pct, TO_NUMBER(bonus),
COALESCE(commission_pct, TO_NUMBER(bonus), 0) AS "Comm"
FROM employees
ORDER BY commission_pct;

-- CASE: Bentuk seperti statement if-then-else di C++

SELECT last_name, department_id,
CASE department_id
WHEN 90 THEN 'Management'
WHEN 80 THEN 'Sales'
WHEN 60 THEN 'IT'
ELSE 'Other dept'
END
AS "Department"
FROM employees;

SELECT first_name,last_name,manager_id,
CASE manager_id
WHEN 100 THEN 'Manager id nya 100'
WHEN 101 THEN 'Manager id nya 101'
WHEN 205 THEN 'Manager id nya 205'
WHEN 149 THEN 'Manager id nya 149'
ELSE 'Manager id lain'END
AS "Manager"
FROM employees;

--DECODE : Mirip dengan CASE, namun lebih simple
SELECT last_name, department_id,
DECODE(department_id, -- argumen yang ditentukan
90, 'Management', -- case (jika 90, maka 'Management'), dst.
80, 'Sales',
60, 'it',
'Other dept.')--else
AS "Department"
FROM employees;

--============================================================================--

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
CONNECT BY PRIOR employee_id = manager_id -- Menjelaskan bagaimana bentuk join pada baris

SELECT last_name ||' reports to ' || PRIOR last_name AS "Walk Top Down"
FROM employees
START WITH last_name = 'King' CONNECT BY PRIOR employee_id = manager_id;

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
START WITH last_name = 'Grant' CONNECT BY employee_id = PRIOR manager_id

SELECT last_name
FROM employees
WHERE last_name != 'Higgins'
START WITH last_name = 'Kochhar' CONNECT BY PRIOR employee_id = manager_id;

SELECT last_name
FROM employees
START WITH last_name = 'Kochhar' CONNECT BY PRIOR employee_id = manager_id
AND last_name 