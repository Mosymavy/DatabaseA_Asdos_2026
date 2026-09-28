--Buatkan SQL Query untuk menampilkan ID lagu, judul, durasi, nomor CD, dan nomor track, dengan syarat ID event berada di 100!
SELECT s.id, s.title, s.duration, s.artist, t.cd_number, t.track
FROM d_songs s JOIN d_track_listings t ON (s.ID = t.song_id)
JOIN d_play_list_items p ON (s.ID = p.song_id)
WHERE event_id IN(100);

--Buatkan SQL Query untuk menampilkan nama lengkap dengan nama belakang semua kapital, email semua huruf kecil, tier berdasarkan salary, dan berapa lama karyawan tersebut sudah bekerja
--berdasarkan pengurangan dari tabel job_history, dengan syarat peringkat harus berada di C atau D, dan diurutkan. INGAT: Gunakan distinct dan tahun dibulatkan kebawah!
SELECT DISTINCT first_name || ' ' || UPPER(last_name) AS "Initial", LOWER(email) AS "email", grade_level AS "Tier", TRUNC((MONTHS_BETWEEN(end_date, start_date))/12) AS "Long stayed"
FROM employees JOIN job_grades ON (salary BETWEEN lowest_sal AND highest_sal)
JOIN job_history USING (employee_id)
WHERE grade_level IN('C', 'D')
ORDER BY "Long stayed" DESC;

--Buatkan SQL Query untuk menampilkan ID employee, hire_date, dan nama hari pada hire_date dalam bahasa Indonesia!
SELECT employee_id, hire_date, CASE(LOWER(TO_CHAR(hire_date, 'fmDay')))
    WHEN LOWER('monday') THEN 'Senin'
    WHEN LOWER('tuesday') THEN 'Selasa'
    WHEN LOWER('wednesday') THEN 'Rabu'
    WHEN LOWER('thursday') THEN 'Kamis'
    WHEN LOWER('friday') THEN 'Jumat'
    WHEN LOWER('saturday') THEN 'Sabtu'
    WHEN LOWER('sunday') THEN 'Minggu'
    ELSE 'None'
    END AS "Hari dalam bahasa Indonesia"
FROM employees;

--Melanjutkan yang sebelumnya, tambahkan tanggal, bulan, beserta tahun dalam bahasa Indonesia pada SQL Query!
SELECT employee_id, hire_date, CASE(LOWER(TO_CHAR(hire_date, 'fmDay')))
    WHEN LOWER('monday') THEN 'Senin'
    WHEN LOWER('tuesday') THEN 'Selasa'
    WHEN LOWER('wednesday') THEN 'Rabu'
    WHEN LOWER('thursday') THEN 'Kamis'
    WHEN LOWER('friday') THEN 'Jumat'
    WHEN LOWER('saturday') THEN 'Sabtu'
    WHEN LOWER('sunday') THEN 'Minggu'
    ELSE 'None'
    END || ', ' || TO_CHAR(hire_date, 'fmdd') || ' ' || CASE(TO_CHAR(hire_date, 'fmmm'))
    WHEN '1' THEN 'Januari'
    WHEN '2' THEN 'Februari'
    WHEN '3' THEN 'Maret'
    WHEN '4' THEN 'April'
    WHEN '5' THEN 'Mei'
    WHEN '6' THEN 'Juni'
    WHEN '7' THEN 'Juli'
    WHEN '8' THEN 'Agustus'
    WHEN '9' THEN 'September'
    WHEN '10' THEN 'Oktober'
    WHEN '11' THEN 'November'
    WHEN '12' THEN 'Desember'
    END || ' ' || TO_CHAR(hire_date, 'yyyy') AS "Hari & Tanggal dalam Indonesia"
FROM employees;

--Buatkan SQL Query untuk membuat bottom uphierarchial queries (urutan mengikuti contoh), dengan syarat menampilkan level sesuai pada gambar, nomor telepon dihilangkan titiknya, dan membuat kalimat statement pelaporan!
SELECT RPAD(first_name, LENGTH(first_name)+(LEVEL*3)-3,'^') AS "Org Chart", REPLACE(phone_number,'.') AS "Nomor Telepon", first_name || ' melaporkan ke ' || PRIOR(first_name) AS "Pelaporan"
FROM employees
START WITH first_name = 'William'
CONNECT BY employee_id = PRIOR manager_id;