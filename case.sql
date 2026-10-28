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