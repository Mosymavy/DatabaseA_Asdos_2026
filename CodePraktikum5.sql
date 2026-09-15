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

-- NUMBER CONVERSION

SELECT salary, TO_CHAR(salary, '$9,999') AS "Salary"
FROM employees;

SELECT salary, TO_CHAR(salary, '$99,999.99') AS "Salary"
FROM employees;

SELECT salary, TO_CHAR(salary, 'L99,999.99') AS "Salary"
FROM employees;

SELECT TO_CHAR(442, '9999999') FROM dual;
SELECT TO_CHAR(44223, '0000000') FROM dual;

SELECT TO_CHAR(:v, '0000999') FROM dual;


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

-- DATE CONVERSION

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