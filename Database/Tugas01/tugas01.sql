drop database warung;

create database if not exists warung;

use warung;

-- BUAT TABLE pelanggan
create table if not exists pelanggan (
	kode		varchar(6) primary key,
    nama		varchar(50),
    kd_kelamin	varchar(1),
    alamat 		varchar(100),
    kd_kota		varchar(1)
);

-- BUAT TABLE kelamin
create table if not exists kelamin (
	kode	varchar(1) primary key,
    jenis	varchar(7)
);

-- BUAT TABLE kota
create table kota (
	kode	varchar(1) primary key,
    nama	varchar(10)
);

-- BUAT TABLE produk
create table if not exists produk (
	kode		varchar(4) primary key,
    nama		varchar(40),
    kd_satuan	varchar(1),
    stok 		int,
    harga		int
);

-- BUAT TABLE satuan
create table if not exists satuan (
	kode	varchar(1) primary key,
    bentuk	varchar(15)
);

-- BUAT TABLE penjualan
create table penjualan (
	no_jual varchar(4) primary key,
	tgl_jual date,
	kd_pelanggan varchar(6)
);

-- BUAT TABLE detail_penjualan
create table detail_penjualan (
	no_jual varchar(4),
	kd_produk varchar(4),
	jumlah int
);



alter table pelanggan 
	add foreign key (kd_kelamin) references kelamin(kode),
    add foreign key (kd_kota) references kota(kode);
    
alter table produk add foreign key (kd_satuan) references satuan(kode);

alter table penjualan
	add foreign key (kd_pelanggan) references pelanggan(kode);

alter table detail_penjualan
	add primary key (no_jual, kd_produk),
    add foreign key (no_jual) references penjualan(no_jual),
 	add foreign key (kd_produk) references produk(kode);




-- INSERT kelamin
DELIMITER //
CREATE PROCEDURE sp_ins_kel (
	sp_kode varchar(1),
    sp_jenis varchar(7)
)
BEGIN
	INSERT kelamin VALUES (sp_kode, sp_jenis);
END //
DELIMITER ;

-- UPDATE kelamin
DELIMITER //
CREATE PROCEDURE sp_upd_kel (
	sp_kode VARCHAR(1),
	sp_jenis VARCHAR(7)
)
BEGIN
	UPDATE kelamin
	SET jenis = sp_jenis
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- DELETE kelamin
DELIMITER //
CREATE PROCEDURE sp_del_kel (
	sp_kode VARCHAR(1)
)
BEGIN
	DELETE FROM kelamin
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- ACTION
call sp_ins_kel (1, 'Pria');
call sp_ins_kel (2, 'Wanita');


-- INSERT kota
DELIMITER //
CREATE PROCEDURE sp_ins_kota (
	sp_kode varchar(1),
    sp_nama varchar(15)
)
BEGIN
	INSERT kota VALUES (sp_kode, sp_nama);
END //
DELIMITER ;

-- UPDATE kota
DELIMITER //
CREATE PROCEDURE sp_upd_kota (
	sp_kode VARCHAR(1),
	sp_nama VARCHAR(15)
)
BEGIN
	UPDATE kota
	SET nama = sp_nama
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- DELETE kota
DELIMITER //
CREATE PROCEDURE sp_del_kota (
	sp_kode VARCHAR(1)
)
BEGIN
	DELETE FROM kota
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- ACTION
call sp_ins_kota (1, 'Jakarta');
call sp_ins_kota (2, 'Bandung');
call sp_ins_kota (3, 'Surabaya');


-- INSERT pelanggan
DELIMITER //
CREATE PROCEDURE sp_ins_pel (
	sp_kode varchar(6),
    sp_nama varchar(50),
    sp_kd_kel varchar(1),
    sp_alamat varchar(100),
    sp_kd_kota varchar(1)
)
BEGIN
	INSERT pelanggan VALUES (sp_kode, sp_nama, sp_kd_kel, sp_alamat, sp_kd_kota);
END //
DELIMITER ;

-- UPDATE pelanggan
DELIMITER //
CREATE PROCEDURE sp_upd_pel (
	sp_kode VARCHAR(6),
	sp_nama VARCHAR(50),
	sp_kd_kel VARCHAR(1),
	sp_alamat VARCHAR(100),
	sp_kd_kota VARCHAR(1)
)
BEGIN
	UPDATE pelanggan
	SET nama = sp_nama,
		kd_kelamin = sp_kd_kel,
		alamat = sp_alamat,
		kd_kota = sp_kd_kota
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- DELETE pelanggan
DELIMITER //
CREATE PROCEDURE sp_del_pel (
	sp_kode VARCHAR(6)
)
BEGIN
	DELETE FROM pelanggan
	WHERE kode = sp_kode;
END //
DELIMITER ;


-- ACTION
call sp_ins_pel ('PLG001', 'Mohammad', 1, 'Priok', 1);
call sp_ins_pel ('PLG002', 'Naufal', 1, 'Cilincing', 1);
call sp_ins_pel ('PLG003', 'Atila', 1, 'Bojongsoang', 2);
call sp_ins_pel ('PLG004', 'Tsalsa', 2, 'Buah Batu', 2);
call sp_ins_pel ('PLG005', 'Damay', 2, 'Gubeng', 3);
call sp_ins_pel ('PLG006', 'Tsaniy', 1, 'Darmo', 3);
call sp_ins_pel ('PLG007', 'Nabila', 2, 'Lebak Bulus', 1);

-- CALL sp_upd_pel('PLG001', 'Muhammad', '1', 'Sunter', '1');



-- INSERT satuan
DELIMITER //
CREATE PROCEDURE sp_ins_sat (
	sp_kode varchar(1),
    sp_bentuk varchar(10)
)
BEGIN
	INSERT satuan VALUES (sp_kode, sp_bentuk);
END //
DELIMITER ;

-- UPDATE satuan
DELIMITER //
CREATE PROCEDURE sp_upd_sat (
	sp_kode VARCHAR(1),
	sp_bentuk VARCHAR(15)
)
BEGIN
	UPDATE satuan
	SET bentuk = sp_bentuk
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- DELETE satuan
DELIMITER //
CREATE PROCEDURE sp_del_sat (
	sp_kode VARCHAR(1)
)
BEGIN
	DELETE FROM satuan
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- ACTION
call sp_ins_sat ('1', 'Bungkus');
call sp_ins_sat ('2', 'Pak');
call sp_ins_sat ('3', 'Botol');


-- INSERT produk
DELIMITER //
CREATE PROCEDURE sp_ins_prod (
	sp_kode varchar(4),
    sp_nama varchar(40),
    sp_bentuk varchar(1),
    sp_jumlah int,
    sp_harga int
)
BEGIN
	INSERT produk VALUES (sp_kode,sp_nama, sp_bentuk, sp_jumlah, sp_harga);
END //
DELIMITER ;

-- UPDATE produk
DELIMITER //
CREATE PROCEDURE sp_upd_prod (
	sp_kode VARCHAR(4),
	sp_nama VARCHAR(40),
	sp_kd_satuan VARCHAR(1),
	sp_stok INT,
	sp_harga INT
)
BEGIN
	UPDATE produk
	SET nama = sp_nama,
		kd_satuan = sp_kd_satuan,
		stok = sp_stok,
		harga = sp_harga
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- DELETE produk
DELIMITER //
CREATE PROCEDURE sp_del_prod (
	sp_kode VARCHAR(4)
)
BEGIN
	DELETE FROM produk
	WHERE kode = sp_kode;
END //
DELIMITER ;

-- ACTION 
call sp_ins_prod ('P001', 'Indomie', 1, 10, 3000);
call sp_ins_prod ('P002', 'Roti', 2, 3, 18000);
call sp_ins_prod ('P003', 'Kecap', 3, 8, 4700);
call sp_ins_prod ('P004', 'Saos Tomat', 3, 8, 5800);
call sp_ins_prod ('P005', 'Bihun', 1, 5, 3500);
call sp_ins_prod ('P006', 'Sikat Gigi', 2, 5, 15000);
call sp_ins_prod ('P007', 'Pasta Gigi', 2, 7, 10000);
call sp_ins_prod ('P008', 'Saos Sambal', 3, 5, 7300);


-- INSERT penjualan
DELIMITER //
CREATE PROCEDURE sp_ins_penj (
	sp_no_jual varchar(4),
    sp_tgl date,
    sp_kd_pel varchar(6)
)
BEGIN
	INSERT penjualan VALUES (sp_no_jual,sp_tgl, sp_kd_pel);
END //
DELIMITER ;

-- UPDATE penjualan
DELIMITER //
CREATE PROCEDURE sp_upd_penj (
	sp_no_jual VARCHAR(4),
	sp_tgl DATE,
	sp_kd_pel VARCHAR(6)
)
BEGIN
	UPDATE penjualan
	SET tgl_jual = sp_tgl,
		kd_pelanggan = sp_kd_pel
	WHERE no_jual = sp_no_jual;
END //
DELIMITER ;

-- DELETE penjualan
DELIMITER //
CREATE PROCEDURE sp_del_penj (
	sp_no_jual VARCHAR(4)
)
BEGIN
	DELETE FROM penjualan
	WHERE no_jual = sp_no_jual;
END //
DELIMITER ;

-- ACTION
call sp_ins_penj ('J001', '2025-09-08', 'PLG003');
call sp_ins_penj ('J002', '2025-09-08', 'PLG007');
call sp_ins_penj ('J003', '2025-09-09', 'PLG002');


-- INSERT detail_penjualan
DELIMITER //
CREATE PROCEDURE sp_ins_detail_penj (
	sp_no_jual varchar(4),
    sp_kd_prod varchar(4),
    sp_jmlh int
)
BEGIN
	INSERT detail_penjualan VALUES (sp_no_jual,sp_kd_prod, sp_jmlh);
END //
DELIMITER ;

-- UPDATE detail_penjualan
DELIMITER //
CREATE PROCEDURE sp_upd_detail_penj (
	sp_no_jual VARCHAR(4),
	sp_kd_prod VARCHAR(4),
	sp_jmlh INT
)
BEGIN
	UPDATE detail_penjualan
	SET jumlah = sp_jmlh
	WHERE no_jual = sp_no_jual AND kd_produk = sp_kd_prod;
END //
DELIMITER ;

-- DELETE detail_penjualan
DELIMITER //
CREATE PROCEDURE sp_del_detail_penj (
	sp_no_jual VARCHAR(4),
	sp_kd_prod VARCHAR(4)
)
BEGIN
	DELETE FROM detail_penjualan
	WHERE no_jual = sp_no_jual AND kd_produk = sp_kd_prod;
END //
DELIMITER ;

-- ACTION
call sp_ins_detail_penj ('J001', 'P001', 2);
call sp_ins_detail_penj ('J001', 'P003', 1);
call sp_ins_detail_penj ('J001', 'P004', 1);
call sp_ins_detail_penj ('J002', 'P006', 3);
call sp_ins_detail_penj ('J002', 'P007', 1);
call sp_ins_detail_penj ('J003', 'P001', 5);
call sp_ins_detail_penj ('J003', 'P004', 2);
call sp_ins_detail_penj ('J003', 'P008', 2);
call sp_ins_detail_penj ('J003', 'P003', 1);

-- VIEW ALL DATA TABLE PENJUALAN
CREATE OR REPLACE VIEW vw_penjualan AS
SELECT p.tgl_jual, p.no_jual, pel.nama, prod.nama as nama_produk, dp.jumlah
FROM penjualan p
JOIN detail_penjualan dp ON p.no_jual = dp.no_jual
JOIN pelanggan pel ON p.kd_pelanggan = pel.kode
JOIN produk prod ON dp.kd_produk = prod.kode;
-- ACTION
SELECT * FROM vw_penjualan;

-- VIEW ALL DATA TABLE PELANGGAN
CREATE OR REPLACE VIEW vw_pelanggan AS
SELECT pel.kode, pel.nama, kel.jenis as kelamin, pel.alamat, k.nama as kota
FROM pelanggan pel
JOIN kelamin kel ON pel.kd_kelamin = kel.kode
JOIN kota k ON pel.kd_kota = k.kode;
-- ACTION
SELECT * FROM vw_pelanggan;

-- VIEW ALL DATA TABLE PRODUK
CREATE OR REPLACE VIEW vw_produk AS
SELECT pr.kode, pr.nama, s.bentuk, pr.stok, pr.harga
FROM produk pr
JOIN satuan s ON pr.kd_satuan = s.kode; 
-- ACTION
SELECT * FROM vw_produk;

-- VIEW ALL DATA TRANSAKSI
CREATE OR REPLACE VIEW vw_transaksi_lengkap AS
SELECT
    p.no_jual,
    p.tgl_jual,
    pel.kode AS kd_pelanggan,
    pel.nama AS nama_pelanggan,
    k.jenis AS kelamin,
    pel.alamat,
    kt.nama AS kota,
    dp.kd_produk,
    pr.nama AS nama_produk,
    s.bentuk AS satuan,
    dp.jumlah,
    pr.harga,
    (dp.jumlah * pr.harga) AS total
FROM penjualan p
JOIN pelanggan pel ON p.kd_pelanggan = pel.kode
JOIN kelamin k ON pel.kd_kelamin = k.kode
JOIN kota kt ON pel.kd_kota = kt.kode
JOIN detail_penjualan dp ON p.no_jual = dp.no_jual
JOIN produk pr ON dp.kd_produk = pr.kode
JOIN satuan s ON pr.kd_satuan = s.kode;

-- ACTION
SELECT * FROM vw_transaksi_lengkap;


-- FUNC SHOW TOTAL PER no_jual
DELIMITER //
CREATE FUNCTION fn_total_penjualan(nota VARCHAR(4))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(dp.jumlah * pr.harga)
    INTO total
    FROM detail_penjualan dp
    JOIN produk pr ON dp.kd_produk = pr.kode
    WHERE dp.no_jual = nota;

    RETURN IFNULL(total, 0);
END //
DELIMITER ;

-- SHOW TOTAL PER HARI / TANGGAL
DELIMITER //
CREATE FUNCTION fn_total_penjualan_hari(p_tanggal DATE)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE total INT;
    SELECT SUM(dp.jumlah * pr.harga)
    INTO total
    FROM penjualan p 
    JOIN detail_penjualan dp ON p.no_jual = dp.no_jual
    JOIN produk pr ON dp.kd_produk = pr.kode
    WHERE p.tgl_jual = p_tanggal;
    
    RETURN IFNULL(total, 0);
END //
DELIMITER ;

SELECT fn_total_penjualan_hari('2025-09-09') AS total_penjualan_hari_ini;

-- SELECT fn_total_penjualan('J004') AS total_nota;
SELECT fn_total_penjualan('J001') AS total_nota;

-- SEARCH DATA BERDASARKAN TANGGAL
DELIMITER //
CREATE PROCEDURE sp_cari_tgl (IN sp_tgl DATE)
BEGIN
    SELECT * FROM vw_transaksi_lengkap
    WHERE tgl_jual = sp_tgl;
END //
DELIMITER ;

-- SEARCH DATA BERDASARKAN PELANGGAN
DELIMITER //
CREATE PROCEDURE sp_cari_pelanggan (IN sp_kd_pel VARCHAR(6))
BEGIN
    SELECT * FROM vw_transaksi_lengkap
    WHERE kd_pelanggan = sp_kd_pel;
END //
DELIMITER ;

-- SEARCH DATA BERDASARKAN no_jual
DELIMITER //
CREATE PROCEDURE sp_cari_nota (IN sp_nota VARCHAR(4))
BEGIN
    SELECT * FROM vw_transaksi_lengkap
    WHERE no_jual = sp_nota;
END //
DELIMITER ;


-- ACTION
CALL sp_cari_tgl('2025-09-08');

CALL sp_cari_pelanggan('PLG003');

CALL sp_cari_nota('J001');





