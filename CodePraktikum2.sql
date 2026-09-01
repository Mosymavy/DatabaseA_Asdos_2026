--Pertemuan 3 Praktikum

--Section 3
--Logical Conditions

--AND, OR, NOT

--AND
--Kedua kondisi harus dipenuhi

SELECT last_name, hire_date, job_id
FROM employees
WHERE hire_date > '01-Jan-1998' AND job_id LIKE 'SA%';

--OR 
--Salah satu kondisi harus dipenuhi sedangkan satunya tidak harus
--Hanya perlu salah satu kondisi yang bernilai besar

SELECT department_name, manager_id, location_id
FROM departments
WHERE location_id = 2500 OR manager_id = 124;

--NOT
--kondisi menjadi inverted atau dibalik

SELECT department_name, location_id
FROM departments
WHERE location_id NOT IN (1700,1800);

SELECT first_name, last_name
FROM departments
WHERE department_id NOT BETWEEN 30 AND 70;

--Ada aturan dimana SQL akan menjalankan perintah berdasarkan urutan
-- 1. Aritmatika + - * /
-- 2. Concatenation (hello || world)
-- 3. Komparasi <, <=, >, >=
-- 4. IS (NOT) NULL, LIKE, (NOT) IN
-- 5. (NOT) BETWEEN
-- 6. NOT
-- 7. AND
-- 8. OR

SELECT last_name || ' ' || salary*1.05 AS "Employee Raise",
department_id, first_name, last_name
FROM employees
WHERE department_id IN (50,80) OR
    first_name LIKE 'C%' AND last_name LIKE '%s%';

--jika ingin OR yang dijalankan terlebih dahulu maka menggunakan tanda kurung 

SELECT last_name || ' ' || salary * 1.05 AS "Employee Raise",
department_id, first_name, last_name
FROM employees
WHERE (department_id IN (50,80) OR first_name LIKE 'C%')
    AND last_name LIKE '%s%';

SELECT last_name || ' ' || salary * 1.05 as "Employee Raise",
department_id, first_name, last_name
FROM employees
WHERE (department_id IN (50,80) AND first_name LIKE 'C%')
    OR last_name LIKE '%s%';


--unsorted
SELECT last_name, hire_date
FROM employees

--Sorting Rows
SELECT last_name, hire_date
FROM employees
ORDER BY hire_date;

--Jika ingin dibalik urutannya menjadi terbaru ke terawal maka menggunakan DESC
SELECT last_name, hire_date
FROM employees
ORDER BY hire_date DESC;

--Bisa juga mengurutkan dengan alias
SELECT last_name, hire_date
AS "Date Started"
FROM employees
ORDER BY hire_date;

SELECT last_name, hire_date
AS "Date Started"
FROM employees
ORDER BY "Date Started";

--Bisa juga diurutkan dengan kolom lain yang tidak ditampilkan
SELECT employee_id, first_name, hire_date
FROM employees
WHERE employee_id < 105
ORDER BY last_name;

--dengan last_name
SELECT employee_id, first_name, hire_date, last_name
FROM employees
WHERE employee_id < 105
ORDER BY last_name;

--Urutan yang dikerjakan SQL
-- FROM, WHERE, SELECT, ORDER

--Bisa juga mengurutkan dengan multiple colums
SELECT department_id, last_name
FROM employees
WHERE department_id <= 50
ORDER BY last_name, department_id;

SELECT department_id, last_name
FROM employees
WHERE department_id <= 50
ORDER BY department_id;

SELECT department_id, last_name
FROM employees
WHERE department_id <= 50
ORDER BY department_id DESC, last_name DESC;

--Section 4
--Single Row Function

--DUAL 

--DUAL digunakan untuk membuat statement SELECT dan eksekusi function tanpa berhubungan dengan tabel database
--atau bisa dikatakan sebagai tabel dummy

SELECT (319/29) + 12
FROM dual;


--Single Row Function

--Case-Manipulation Functoins
--LOWER, UPPER, INITCAP

--LOWER
--Konversi semua huruf ke huruf kecil

SELECT last_name
FROM employees
WHERE LOWER(last_name) = 'abel';

SELECT LOWER(last_name)
FROM employees;

--UPPER
--Konversi semua huruf ke huruf besar

SELECT last_name
FROM employees
WHERE UPPER(last_name) = 'ABEL';

SELECT UPPER(last_name)
FROM employees;

--INITCAP
--Konversi semua huruf ke huruf besar pada huruf pertama pada setiap kata dan huruf kecil untuk huruf lainnya

SELECT last_name
FROM employees
WHERE INITCAP(last_name) = 'Abel';

SELECT INITCAP(last_name)
FROM employees;


--Character Manipulation Functions
--CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD, TRIM, REPLACE

--CONCAT
--Menggabungkan beberapa string hingga menjadi satu string

SELECT CONCAT('Hello','World')
FROM DUAL;

SELECT first_name, last_name, CONCAT(first_name, last_name)
FROM employees;

--SUBSTR
--Mengembalikan karakter yang ditentukan dari suatu string

SELECT SUBSTR('HelloWorld',1,5) -- (Struktur: String, posisi awal, (opsional) panjang karakter)
FROM DUAL;

SELECT SUBSTR('HelloWorld',6)
FROM DUAL;

SELECT last_name, SUBSTR(last_name,1,3)
FROM employees;

--LENGTH
--Mengembalikan panjang karakter dari suatu string

SELECT LENGTH('HelloWorld')
FROM DUAL;

SELECT last_name, LENGTH(last_name)
FROM employees;

--INSTR
--Mengembalikan index karakter yang ditentukan pada string

SELECT INSTR('HelloWorld','W') -- (Struktur: String, karakter)
FROM DUAL;

SELECT last_name, INSTR(last_name, 'a')
FROM employees;

--LPAD
--Memberikan simbol pada bagian kiri karakter yang kosong

SELECT LPAD('HelloWorld', 15, '-') -- (Struktur: String, jumlah karakter string, simbol yang dipilih)
FROM DUAL;

SELECT LPAD(last_name, 10, '*')
FROM employees;

--RPAD
--Memberikan simbol pada bagian kanan karakter yang kosong

SELECT RPAD('HelloWorld', 15, '-') -- (Struktur: String, jumlah karakter string, simbol yang dipilih)
FROM DUAL;

SELECT last_name, RPAD(last_name, 10, '*')
FROM employees;

--TRIM
--Menghapus karakter pada posisi yang dipilih (awal, akhir, atau awal & akhir)

SELECT TRIM(LEADING 'a' FROM 'abcba') -- Memilih karakter 'a' untuk dihapus, dengan LEADING sebagai awalan
FROM DUAL;

SELECT TRIM(TRAILING 'a' FROM 'abcba') -- Memilih karakter 'a' untuk dihapus, dengan TRAILING sebagai akhiran
FROM DUAL;

SELECT TRIM(BOTH 'a' FROM 'abcba') -- Memilih karakter 'a' untuk dihapus, dengan BOTH sebagai awalan dan akhiran
FROM DUAL;

--REPLACE
--Mengganti karakter dengan karakter yang dipilih pada string

SELECT REPLACE('JACK and JUE', 'J','BL') -- (Struktur: String, karakter yang akan diubah, karakter pengganti)
FROM DUAL;

SELECT REPLACE('JACK and JUE', 'J') -- Karena tidak ada karakter pengganti, maka huruf 'J' akan dihilangkan
FROM DUAL;

SELECT last_name, REPLACE(last_name, 'a', '*')
FROM employees;

--Menggunakan alias dengan function
SELECT last_Name, first_name, LOWER(last_name) || LOWER(SUBSTR(first_name,1,1)) AS "User Name"
FROM employees;

SELECT last_Name, first_name, LOWER(last_name) || LOWER(SUBSTR(first_name,1,1)) 
FROM f_staffs;

--Variabel Substitusi
--Ketika di-run, maka user harus input variabel yang harus diinput

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id = 10;

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id = :enter_dept_id; --Dengan ini, maka akan muncul pop up pada user yang mengharuskannya menginput value yang diinginkan

SELECT *
FROM employees
WHERE last_name = :l_name;


--Number Functions
--ROUND, TRUNC, MOD

--ROUND
--Membulatkan angka desimal (harusnya tau lah ya :])

SELECT ROUND(67.2)
FROM DUAL;

SELECT ROUND(67.69)
FROM DUAL;

SELECT ROUND(67.6867, 2) -- Angka 2 menunjukkan sampai angka desimal keberapa akan dibulatkan (disini angka kedua, sehingga hasil menjadi 67.69)
FROM DUAL;

--TRUNC
--Membulatkan angka desimal ke bawah

SELECT TRUNC(67.2)
FROM DUAL;

SELECT TRUNC(67.69)
FROM DUAL;

SELECT TRUNC(67.6867, 2) -- Sama seperti round untuk menunjukkan angka desimal yang dibulatkan
FROM DUAL;

--MOD
--Mendapatkan sisa dari pembagian

SELECT MOD(13,5) -- 13 dibagi 5 akan menghasilkan sisa 3
FROM DUAL;

SELECT country_name, airports, MOD(airports,2) AS "Mod Demo"
FROM wf_countries;

--SYSDATE
--Function untuk mengembalikan waktu terkini pada server database

SELECT SYSDATE
FROM DUAL;

--Menambahkan hari

SELECT last_name, hire_date, hire_date + 60
FROM employees;

--Menampilkan jumlah minggu sejak employee direkrut

SELECT last_name, hire_date, (SYSDATE-hire_date)/7
FROM employees;

--Mencari jumlah hari employee bekerja, lalu menjadikannya tahun

SELECT employee_id, end_date, start_date, (end_date - start_date)/365 AS "Tenure in last job"
FROM job_history;

--MONTHS_BETWEEN
--Jumlah bulan antara dua hari

SELECT last_name, hire_date, MONTHS_BETWEEN(SYSDATE, hire_date)
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE, hire_date) > 240;

--ADD_MONTHS
--Menambahkan bulan ke hari

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 12) AS "Next Year"
FROM DUAL;

--NEXT_DAY
--Mencari tanggal selanjutnya pada hari yang dipilih

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'Saturday') AS "Next Saturday" --Mengambil input tanggal dan hari yang ingin dicari
FROM DUAL;

--LAST_DAY
--Menampilkan hari terakhir pada bulan

SELECT SYSDATE, LAST_DAY(SYSDATE) AS "End of the Month"
FROM DUAL;

--ROUND
--Membulatkan minggu (menggunakan IW) / bulan / tahun

SELECT hire_date, ROUND(hire_date, 'Month')
FROM employees
WHERE department_id = 50;

SELECT hire_date, ROUND(hire_date, 'Year')
FROM employees
WHERE department_id = 50;

--TRUNC
--Membulatkan minggu (menggunakan IW) / bulan / tahun

SELECT hire_date, TRUNC(hire_date, 'Month')
FROM employees
WHERE department_id = 50;

SELECT hire_date, TRUNC(hire_date, 'Year')
FROM employees
WHERE department_id = 50;

--Contoh query penggunaan beberapa date functions

SELECT employee_id, hire_date, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS TENURE,
    ADD_MONTHS(hire_date,6) AS REVIEW,
    NEXT_DAY(hire_date, 'FRIDAY'), LAST_DAY(hire_date)
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE, hire_date) > 36;