-- Nomor 1
SELECT s.id, s.title, s.duration, s.artist, t.cd_number, t.track
FROM d_songs s JOIN d_track_listings t ON (s.ID = t.song_id)
JOIN d_play_list_items p ON (s.ID = p.song_id)
WHERE event_id IN(100);

-- Nomor 2
SELECT title,producer, year
FROM d_cds
WHERE producer NOT LIKE '%Records%' 
AND year between '2000' AND '2001'
order by year asc;

-- Nomor 3
SELECT DISTINCT first_name || ' ' || UPPER(last_name) AS "Initial", LOWER(email) AS "email", grade_level AS "Tier", TRUNC((MONTHS_BETWEEN(end_date, start_date))/12) AS "Long stayed"
FROM employees JOIN job_grades ON (salary BETWEEN lowest_sal AND highest_sal)
JOIN job_history USING (employee_id)
WHERE grade_level IN('C', 'D')
ORDER BY "Long stayed" DESC;

-- Nomor 4
SELECT COUNT(PRODUCER) AS "Jumlah lagu"
FROM D_CDS
WHERE PRODUCER = 'Old Town Records';

-- Nomor 5
SELECT TO_DATE('17/08/84', 'DD/MM/RR') AS "Date"
FROM DUAL;

-- Nomor 6
SELECT s.title AS "Judul Lagu", s.Artist "Artis", e.name AS "Nama event"
FROM d_songs s JOIN d_play_list_items p
  ON s.id = p.song_id
JOIN d_events e
  ON p.event_id = e.id
where s.type_code = :type;

-- Nomor 7
SELECT employee_id, hire_date, TO_CHAR(hire_date, 'fmdd') || ' ' || CASE(TO_CHAR(hire_date, 'fmmm'))
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
    END || ' ' || TO_CHAR(hire_date, 'yyyy') AS "Tanggal dalam Indonesia"
FROM employees;

-- Nomor 8
SELECT c.country_id as "ID Negara", c.country_name as "Nama Negara", l.language_id AS "ID Bahasa", l.language_name as "bahasa", NVL(sl.comments, 'Tidak ada komen') AS "Komen"
FROM wf_countries c JOIN WF_SPOKEN_LANGUAGES sl 
    ON c.country_id = sl.country_id
JOIN wf_languages l 
    ON sl.language_id = l.language_id
WHERE c.location = 'Eastern Asia';

-- Nomor 9
SELECT RPAD(first_name, LENGTH(first_name)+(LEVEL*3)-3,'^') AS "Org Chart", REPLACE(phone_number,'.') AS "Nomor Telepon", first_name || ' melaporkan ke ' || PRIOR(first_name) AS "Pelaporan"
FROM employees
START WITH first_name = 'William'
CONNECT BY employee_id = PRIOR manager_id;

-- Nomor 10
SELECT  s.TITLE AS TITLE, c.PRODUCER AS PRODUCER, c.YEAR AS YEAR
FROM D_SONGS s JOIN D_TRACK_LISTINGS t 
    ON s.ID = t.SONG_ID
JOIN D_CDS c 
    ON t.CD_NUMBER = c.CD_NUMBER
WHERE c.YEAR = 2000;