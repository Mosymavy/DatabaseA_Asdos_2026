CREATE TABLE rooms (
    id            VARCHAR2(10) PRIMARY KEY,
    nama_ruangan  VARCHAR2(100) NOT NULL,
    lantai        NUMBER(2) NOT NULL
);

CREATE TABLE suspects (
    id         VARCHAR2(10) PRIMARY KEY,
    nama       VARCHAR2(100) NOT NULL,
    pekerjaan  VARCHAR2(100),
    alamat     VARCHAR2(200)
);

CREATE TABLE artifacts (
    id          VARCHAR2(10) PRIMARY KEY,
    nama        VARCHAR2(150) NOT NULL,
    nilai       NUMBER(15,2) NOT NULL,
    ruangan_id  VARCHAR2(10) NOT NULL,
    FOREIGN KEY (ruangan_id) REFERENCES rooms(id)
);

CREATE TABLE visitor_log (
    id            VARCHAR2(10) PRIMARY KEY,
    suspect_id    VARCHAR2(10) NOT NULL,
    waktu_masuk   TIMESTAMP NOT NULL,
    waktu_keluar  TIMESTAMP,
    ruangan_id    VARCHAR2(10) NOT NULL,
    FOREIGN KEY (suspect_id) REFERENCES suspects(id),
    FOREIGN KEY (ruangan_id) REFERENCES rooms(id)
);

CREATE TABLE security_logs (
    id           VARCHAR2(10) PRIMARY KEY,
    suspect_id   VARCHAR2(10) NOT NULL,
    ruangan_id   VARCHAR2(10) NOT NULL,
    waktu        TIMESTAMP NOT NULL,
    jenis_akses  VARCHAR2(30) NOT NULL,
    FOREIGN KEY (suspect_id) REFERENCES suspects(id),
    FOREIGN KEY (ruangan_id) REFERENCES rooms(id)
);

CREATE TABLE phone_records (
    id       VARCHAR2(10) PRIMARY KEY,
    dari_id  VARCHAR2(10) NOT NULL,
    ke_id    VARCHAR2(10) NOT NULL,
    waktu    TIMESTAMP NOT NULL,
    durasi   NUMBER(6) NOT NULL,
    FOREIGN KEY (dari_id) REFERENCES suspects(id),
    FOREIGN KEY (ke_id)   REFERENCES suspects(id)
);

CREATE TABLE witness_statements (
    id              VARCHAR2(10) PRIMARY KEY,
    saksi_id        VARCHAR2(10) NOT NULL,
    isi_keterangan  VARCHAR2(1000) NOT NULL,
    waktu           TIMESTAMP NOT NULL,
    FOREIGN KEY (saksi_id) REFERENCES suspects(id)
);

CREATE TABLE alibis (
    id          VARCHAR2(10) PRIMARY KEY,
    suspect_id  VARCHAR2(10) NOT NULL,
    lokasi      VARCHAR2(150) NOT NULL,
    waktu       TIMESTAMP NOT NULL,
    FOREIGN KEY (suspect_id) REFERENCES suspects(id)
);

CREATE TABLE bank_transactions (
    id          VARCHAR2(10) PRIMARY KEY,
    suspect_id  VARCHAR2(10) NOT NULL,
    jumlah      NUMBER(15,2) NOT NULL,
    tanggal     DATE NOT NULL,
    penerima    VARCHAR2(100) NOT NULL,
    FOREIGN KEY (suspect_id) REFERENCES suspects(id)
);

INSERT ALL
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R001', 'Main Lobby', 1)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R002', 'Textile Gallery', 1)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R003', 'Ceramics Gallery', 1)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R004', 'CCTV Control Room', 1)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R005', 'Painting Gallery', 2)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R006', 'Golden Crown Room', 2)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R007', 'Archive Room', 2)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R008', 'Restoration Lab', 2)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R009', 'Director Office', 3)
  INTO rooms (id, nama_ruangan, lantai) VALUES ('R010', 'Rooftop Cafe', 3)
SELECT * FROM dual;

INSERT ALL
  INTO suspects (id, nama, pekerjaan, alamat) VALUES ('S001', 'James Carter', 'Satpam Malam', 'Jl. Melati No. 12, Jakarta Barat')
  INTO suspects (id, nama, pekerjaan, alamat) VALUES ('S002', 'Emily Brooks', 'Kurator Museum', 'Jl. Anggrek No. 5, Jakarta Selatan')
  INTO suspects (id, nama, pekerjaan, alamat) VALUES ('S003', 'Victor Hale', 'Kolektor Barang Antik', 'Jl. Kenanga No. 88, Jakarta Pusat')
  INTO suspects (id, nama, pekerjaan, alamat) VALUES ('S004', 'Nora Bennett', 'Petugas Kebersihan', 'Jl. Mawar No. 20, Tangerang')
  INTO suspects (id, nama, pekerjaan, alamat) VALUES ('S005', 'Daniel Reed', 'Teknisi Restorasi', 'Jl. Cempaka No. 7, Depok')
  INTO suspects (id, nama, pekerjaan, alamat) VALUES ('S006', 'Olivia Grant', 'Pemandu Wisata', 'Jl. Dahlia No. 3, Bekasi')
  INTO suspects (id, nama, pekerjaan, alamat) VALUES ('S007', 'Richard Ashford', 'Direktur Museum', 'Jl. Pelita No. 45, Jakarta Selatan')
  INTO suspects (id, nama, pekerjaan, alamat) VALUES ('S008', 'Sophie Turner', 'Mahasiswi Seni', 'Jl. Kamboja No. 16, Bogor')
SELECT * FROM dual;

INSERT ALL
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V001', 'S003', TIMESTAMP '2026-10-15 20:45:00', TIMESTAMP '2026-10-15 21:35:00', 'R006')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V002', 'S008', TIMESTAMP '2026-10-15 19:10:00', TIMESTAMP '2026-10-15 20:30:00', 'R005')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V003', 'S006', TIMESTAMP '2026-10-15 18:30:00', TIMESTAMP '2026-10-15 20:00:00', 'R002')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V004', 'S002', TIMESTAMP '2026-10-15 20:00:00', TIMESTAMP '2026-10-15 22:30:00', 'R007')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V005', 'S004', TIMESTAMP '2026-10-15 20:30:00', TIMESTAMP '2026-10-15 21:30:00', 'R001')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V006', 'S001', TIMESTAMP '2026-10-15 20:00:00', TIMESTAMP '2026-10-15 23:00:00', 'R004')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V007', 'S005', TIMESTAMP '2026-10-15 19:00:00', TIMESTAMP '2026-10-15 21:40:00', 'R008')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V008', 'S005', TIMESTAMP '2026-10-15 21:40:30', TIMESTAMP '2026-10-15 21:58:00', 'R006')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V009', 'S007', TIMESTAMP '2026-10-15 19:30:00', TIMESTAMP '2026-10-15 22:15:00', 'R009')
  INTO visitor_log (id, suspect_id, waktu_masuk, waktu_keluar, ruangan_id) VALUES ('V010', 'S005', TIMESTAMP '2026-10-15 21:58:30', TIMESTAMP '2026-10-15 22:03:00', 'R001')
SELECT * FROM dual;

INSERT ALL
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL01', 'S006', 'R002', TIMESTAMP '2026-10-15 18:30:00', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL02', 'S005', 'R008', TIMESTAMP '2026-10-15 19:00:00', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL03', 'S008', 'R005', TIMESTAMP '2026-10-15 19:10:00', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL04', 'S007', 'R009', TIMESTAMP '2026-10-15 19:30:00', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL05', 'S006', 'R002', TIMESTAMP '2026-10-15 20:00:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL06', 'S002', 'R007', TIMESTAMP '2026-10-15 20:00:00', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL07', 'S001', 'R004', TIMESTAMP '2026-10-15 20:00:00', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL08', 'S008', 'R005', TIMESTAMP '2026-10-15 20:30:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL09', 'S004', 'R001', TIMESTAMP '2026-10-15 20:30:00', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL10', 'S003', 'R006', TIMESTAMP '2026-10-15 20:45:00', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL11', 'S002', 'R006', TIMESTAMP '2026-10-15 21:20:00', 'ditolak')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL12', 'S004', 'R001', TIMESTAMP '2026-10-15 21:30:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL13', 'S003', 'R006', TIMESTAMP '2026-10-15 21:35:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL14', 'S005', 'R008', TIMESTAMP '2026-10-15 21:40:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL15', 'S005', 'R006', TIMESTAMP '2026-10-15 21:40:30', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL16', 'S005', 'R006', TIMESTAMP '2026-10-15 21:58:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL17', 'S005', 'R001', TIMESTAMP '2026-10-15 21:58:30', 'masuk')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL18', 'S005', 'R001', TIMESTAMP '2026-10-15 22:03:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL19', 'S007', 'R009', TIMESTAMP '2026-10-15 22:15:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL20', 'S002', 'R007', TIMESTAMP '2026-10-15 22:30:00', 'keluar')
  INTO security_logs (id, suspect_id, ruangan_id, waktu, jenis_akses) VALUES ('SL21', 'S001', 'R004', TIMESTAMP '2026-10-15 23:00:00', 'keluar')
SELECT * FROM dual;

INSERT ALL
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A001', 'Golden Crown of Majapahit', 15000000000, 'R006')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A002', 'Royal Scepter of Sriwijaya', 4200000000, 'R006')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A003', 'Batik Tulis Keraton 1890', 850000000, 'R002')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A004', 'Songket Palembang Benang Emas', 620000000, 'R002')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A005', 'Ming Dynasty Blue Vase', 3200000000, 'R003')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A006', 'Celadon Porcelain Set', 1100000000, 'R003')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A007', 'Portrait of a Javanese Princess', 7500000000, 'R005')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A008', 'Landscape of Mount Merapi', 2300000000, 'R005')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A009', 'Lontar Manuscript Negarakertagama', 5000000000, 'R007')
  INTO artifacts (id, nama, nilai, ruangan_id) VALUES ('A010', 'Keris Pusaka Mataram (dalam restorasi)', 2800000000, 'R008')
SELECT * FROM dual;

INSERT ALL
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P001', 'S003', 'S005', TIMESTAMP '2026-10-10 14:05:00', 900)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P002', 'S003', 'S005', TIMESTAMP '2026-10-14 22:15:00', 480)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P003', 'S004', 'S005', TIMESTAMP '2026-10-15 16:30:00', 25)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P004', 'S008', 'S002', TIMESTAMP '2026-10-15 17:30:00', 90)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P005', 'S002', 'S003', TIMESTAMP '2026-10-15 18:00:00', 600)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P006', 'S006', 'S004', TIMESTAMP '2026-10-15 19:00:00', 35)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P007', 'S007', 'S002', TIMESTAMP '2026-10-15 19:45:00', 120)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P008', 'S004', 'S001', TIMESTAMP '2026-10-15 19:50:00', 30)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P009', 'S003', 'S005', TIMESTAMP '2026-10-15 21:30:00', 45)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P010', 'S001', 'S007', TIMESTAMP '2026-10-15 21:41:00', 40)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P011', 'S005', 'S003', TIMESTAMP '2026-10-15 22:05:00', 20)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P012', 'S007', 'S001', TIMESTAMP '2026-10-15 22:21:00', 180)
  INTO phone_records (id, dari_id, ke_id, waktu, durasi) VALUES ('P013', 'S005', 'S003', TIMESTAMP '2026-10-16 07:30:00', 120)
SELECT * FROM dual;

INSERT ALL
  INTO witness_statements (id, saksi_id, isi_keterangan, waktu) VALUES ('W001', 'S004',
    'Saya membersihkan lobi dari pukul 20.30 sampai 21.30. Sekitar pukul 20.35 saya melihat Sophie melewati lobi menuju halaman depan. Selama saya berada di lobi, tidak ada orang lain yang keluar masuk gedung lewat pintu utama.',
    TIMESTAMP '2026-10-16 09:00:00')
  INTO witness_statements (id, saksi_id, isi_keterangan, waktu) VALUES ('W002', 'S006',
    'Pukul 21.50 saya menunggu rombongan tamu di halaman depan museum bersama Sophie. Sekitar pukul 22.03 seorang pria berseragam teknisi biru tua keluar dari lobi dengan tergesa-gesa membawa tas hitam panjang, lalu memasukkannya ke bagasi van abu-abu. Saya tidak melihat wajahnya dengan jelas. Van itu pergi ke arah selatan sekitar pukul 22.05.',
    TIMESTAMP '2026-10-16 09:30:00')
  INTO witness_statements (id, saksi_id, isi_keterangan, waktu) VALUES ('W003', 'S008',
    'Saya mengaku berbohong soal alibi. Saya meninggalkan Painting Gallery pukul 20.30, bukan masih di sana, karena takut dianggap bolos dari tugas sketsa. Saya keluar lewat lobi lalu duduk di halaman depan sampai sekitar pukul 22.15, awalnya sendirian lalu bersama Olivia. Pukul 22.03 saya juga melihat seorang teknisi membawa tas hitam panjang ke sebuah van.',
    TIMESTAMP '2026-10-16 10:00:00')
  INTO witness_statements (id, saksi_id, isi_keterangan, waktu) VALUES ('W004', 'S001',
    'Pukul 21.37 layar CCTV Golden Crown Room tiba-tiba mati. Saya mencoba reset beberapa kali dan baru berhasil menyalakannya kembali pukul 22.02. Pukul 21.41 saya menelepon Pak Richard untuk melapor. Saya tidak meninggalkan CCTV Control Room sampai pukul 23.00.',
    TIMESTAMP '2026-10-16 10:30:00')
  INTO witness_statements (id, saksi_id, isi_keterangan, waktu) VALUES ('W005', 'S007',
    'Pak James melapor pukul 21.41 bahwa CCTV Golden Crown Room mati. Saya minta dia mencoba reset karena saya masih menerima telepon dari donatur. Saya keluar dari kantor pukul 22.15, melewati Golden Crown Room, dan melihat etalase mahkota kosong. Saya langsung memerintahkan gedung dikunci. Daniel Reed memang punya akses malam ke ruangan itu karena ikut memeriksa permata mahkota, akses berlaku sampai pukul 22.00.',
    TIMESTAMP '2026-10-16 11:00:00')
  INTO witness_statements (id, saksi_id, isi_keterangan, waktu) VALUES ('W006', 'S002',
    'Pukul 21.20 saya mencoba masuk ke Golden Crown Room untuk memeriksa kelembaban etalase, tetapi kartu akses saya ditolak. Akses malam hanya diberikan kepada direktur, satpam, dan teknisi restorasi. Saya kembali ke Archive Room dan mengkatalog lontar sampai pukul 22.30. Pukul 18.00 saya menelepon Pak Victor untuk membahas penilaian koleksi pribadinya, itu urusan pekerjaan biasa.',
    TIMESTAMP '2026-10-16 11:30:00')
  INTO witness_statements (id, saksi_id, isi_keterangan, waktu) VALUES ('W007', 'S003',
    'Saya hanya mengagumi Golden Crown sebagai tamu undangan selama hampir satu jam, lalu turun ke Rooftop Cafe pukul 21.35 dan tinggal di sana sampai acara bubar. Saya kenal Daniel Reed karena pernah meminta saran perawatan barang antik, jadi wajar kalau kami sering bertelepon. Uang yang saya transfer ke Daniel adalah biaya jasa konsultasi restorasi koleksi pribadi saya.',
    TIMESTAMP '2026-10-16 13:00:00')
  INTO witness_statements (id, saksi_id, isi_keterangan, waktu) VALUES ('W008', 'S005',
    'Saya bekerja di Restoration Lab sepanjang malam menyelesaikan restorasi keris pusaka dan tidak keluar sebelum pukul 22.00. Setelah itu saya langsung pulang. Saya tidak tahu apa-apa soal CCTV maupun mahkota.',
    TIMESTAMP '2026-10-16 14:00:00')
SELECT * FROM dual;

INSERT ALL
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL01', 'S001', 'CCTV Control Room',     TIMESTAMP '2026-10-15 21:45:00')
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL02', 'S002', 'Archive Room',          TIMESTAMP '2026-10-15 21:45:00')
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL03', 'S003', 'Rooftop Cafe',          TIMESTAMP '2026-10-15 21:45:00')
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL04', 'S004', 'Pantry Staf Lantai 1',  TIMESTAMP '2026-10-15 21:45:00')
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL05', 'S005', 'Restoration Lab',       TIMESTAMP '2026-10-15 21:45:00')
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL06', 'S006', 'Halaman Depan Museum',  TIMESTAMP '2026-10-15 21:45:00')
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL07', 'S007', 'Director Office',       TIMESTAMP '2026-10-15 21:45:00')
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL08', 'S008', 'Painting Gallery',      TIMESTAMP '2026-10-15 21:45:00')
  INTO alibis (id, suspect_id, lokasi, waktu) VALUES ('AL09', 'S005', 'Restoration Lab',       TIMESTAMP '2026-10-15 22:00:00')
SELECT * FROM dual;

INSERT ALL
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B001', 'S003',  500000000, DATE '2026-10-10', 'Daniel Reed')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B002', 'S003', 2000000000, DATE '2026-10-16', 'Daniel Reed')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B003', 'S005',   45000000, DATE '2026-09-28', 'PT Dana Cepat Finance')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B004', 'S005',  120000000, DATE '2026-10-11', 'PT Dana Cepat Finance')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B005', 'S005',  600000000, DATE '2026-10-17', 'PT Dana Cepat Finance')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B006', 'S002',    8500000, DATE '2026-10-01', 'Bank BTN Cicilan KPR')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B007', 'S003',  350000000, DATE '2026-10-08', 'Balai Lelang Nusantara')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B008', 'S007',  150000000, DATE '2026-10-12', 'Golden Dragon Casino')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B009', 'S007',   25000000, DATE '2026-10-05', 'Yayasan Pendidikan Seni')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B010', 'S001',    7500000, DATE '2026-10-12', 'Toko Elektronik Maju')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B011', 'S008',    6000000, DATE '2026-10-03', 'Kampus Seni Jakarta')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B012', 'S004',    3200000, DATE '2026-10-09', 'RSUD Tangerang')
  INTO bank_transactions (id, suspect_id, jumlah, tanggal, penerima) VALUES ('B013', 'S006',   12000000, DATE '2026-10-06', 'Bali Tour Agency')
SELECT * FROM dual;