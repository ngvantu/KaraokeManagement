CREATE DATABASE QLKaraoke
go
USE QLKaraoke
GO
/*
USE MASTER
DROP DATABASE QLKaraoke
*/



-------------------------------------------------------------------------------------------------------------------
---------------------------------------------------TẠO BẢNG--------------------------------------------------------

CREATE TABLE NHANVIEN(
	MANV INT IDENTITY(101,1) NOT NULL,
	HOTEN NVARCHAR(50),
	GIOITINH NVARCHAR(3) CHECK (GIOITINH IN (N'Nam', N'Nữ')),
	NGAYSINH DATE,
	DIACHI NVARCHAR(200),
	CMND VARCHAR(10) NOT NULL UNIQUE,
	SDT VARCHAR(12) NOT NULL UNIQUE,
	LUONG INT CHECK (LUONG >=0),
	CONSTRAINT PK_NHANVIEN PRIMARY KEY (MANV)
)

CREATE TABLE TAIKHOAN(
	MANV INT NOT NULL,
	TENTK VARCHAR(50) NOT NULL,
	MATKHAU VARCHAR(50) NOT NULL,
	CHUCVU VARCHAR (2) NOT NULL CHECK (CHUCVU IN ('QL','NV')),
	CONSTRAINT PK_TAIKHOAN PRIMARY KEY (TENTK)
)

CREATE TABLE KHACHHANG(
	MAKH INT IDENTITY(10001,1) NOT NULL,
	HOTEN NVARCHAR(50),
	GIOITINH NVARCHAR(5) CHECK (GIOITINH IN (N'Nam', N'Nữ')),
	NGAYSINH DATE,
	DIACHI NVARCHAR(200),
	CMND VARCHAR(10) NOT NULL UNIQUE,
	SDT VARCHAR(12) NOT NULL UNIQUE,
	CONSTRAINT PK_KHACHHANG PRIMARY KEY (MAKH)
)

CREATE TABLE LOAIPHONG(
	MALOAIPHONG INT IDENTITY(2001,1) NOT NULL,
	MOTA NVARCHAR(200),
	SUCCHUA INT CHECK(SUCCHUA >0),
	GIAPHONG INT CHECK(GIAPHONG >= 0),
	TENLOAI NVARCHAR(20)
	CONSTRAINT PK_LOAIPHONG PRIMARY KEY (MALOAIPHONG)
)

CREATE TABLE PHONGHAT(
	MAPHONG INT IDENTITY(1,1) NOT NULL,
	MALOAIPHONG INT,
	TINHTRANG NVARCHAR(50) CHECK (TINHTRANG IN (N'Đang sử dụng', N'Đã đặt trước', N'Còn trống')),
	CONSTRAINT PK_PHONGHAT PRIMARY KEY (MAPHONG)
)

CREATE TABLE DONTHANHTOAN(
	MADON INT IDENTITY(1,1) NOT NULL,
	MANV INT,
	MAKH INT,
	MAPHONG INT,
	GIAPHONG INT CHECK (GIAPHONG >=0),
	THOIGIANBD DATETIME,
	THOIGIANKT DATETIME,
	MAKM VARCHAR(10),
	TINHTRANG NVARCHAR(20) CHECK (TINHTRANG IN (N'Đã thanh toán', N'Chưa thanh toán')),
	CONSTRAINT PK_DONTHANHTOAN PRIMARY KEY (MADON)
)
-- Lưu ý: Thời gian bắt đầu < Thời gian kết thúc

CREATE TABLE LOAIDICHVU(
	MALOAIDV INT IDENTITY(301,1) NOT NULL,
	TENLOAIDV NVARCHAR(20),
	CONSTRAINT PK_LOAIDICHVU PRIMARY KEY (MALOAIDV)
)

CREATE TABLE DICHVU(
	MADV INT IDENTITY(3001,1) NOT NULL,
	MALOAIDV INT,
	TENDV NVARCHAR(50),
	DONGIA INT CHECK(DONGIA >=0),
	CONSTRAINT PK_DICHVU PRIMARY KEY (MADV)
)

CREATE TABLE CHITIETDICHVU(
	MADON INT NOT NULL,
	STT INT NOT NULL,
	MADV INT,
	DONGIA INT CHECK (DONGIA >=0),
	SOLUONG INT CHECK (SOLUONG >=0),
	CONSTRAINT PK_CHITIETDICHVU PRIMARY KEY (MADON, STT)
)

CREATE TABLE KHUYENMAI(
	MAKM VARCHAR(10) NOT NULL,
	TENKM NVARCHAR(50),
	GIATRIKM INT CHECK (GIATRIKM >=0),
	THOIGIANBD DATE,
	THOIGIANKT DATE,
	CONSTRAINT PK_KHUYENMAI PRIMARY KEY (MAKM)
)
-- Lưu ý: Thời gian bắt đầu < Thời gian kết thúc
GO


-------------------------------------------------------------------------
ALTER TABLE TAIKHOAN ADD CONSTRAINT FK_TAIKHOAN_NHANVIEN FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV)

ALTER TABLE DONTHANHTOAN ADD CONSTRAINT FK_DONTHANHTOAN_NHANVIEN FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV)
ALTER TABLE DONTHANHTOAN ADD CONSTRAINT FK_DONTHANHTOAN_KHACHHANG FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH)
ALTER TABLE DONTHANHTOAN ADD CONSTRAINT FK_DONTHANHTOAN_PHONGHAT FOREIGN KEY (MAPHONG) REFERENCES PHONGHAT (MAPHONG)
ALTER TABLE DONTHANHTOAN ADD CONSTRAINT FK_DONTHANHTOAN_KHUYENMAI FOREIGN KEY (MAKM) REFERENCES KHUYENMAI (MAKM)

ALTER TABLE DICHVU ADD CONSTRAINT FK_DICHVU_LOAIDICHVU FOREIGN KEY (MALOAIDV) REFERENCES LOAIDICHVU (MALOAIDV)

ALTER TABLE CHITIETDICHVU ADD CONSTRAINT FK_CHITIETDICHVU_DONTHANHTOAN FOREIGN KEY (MADON) REFERENCES DONTHANHTOAN (MADON)
ALTER TABLE CHITIETDICHVU ADD CONSTRAINT FK_CHITIETDICHVU_DICHVU FOREIGN KEY (MADV) REFERENCES DICHVU (MADV)

ALTER TABLE dbo.PHONGHAT ADD CONSTRAINT FK_PHONGHAT_LOAIPHONG FOREIGN KEY (MALOAIPHONG) REFERENCES dbo.LOAIPHONG(MALOAIPHONG)

GO



-------------------------------------------------------------------------------------------------------------------
---------------------------------------------------DATA MẪU--------------------------------------------------------

--------------data for NHANVIEN------------------------
INSERT INTO dbo.NHANVIEN VALUES  ( N'Nguyễn Thanh Trí' , N'Nam' , '1997-02-03' , N'453 Lê Văn Sỹ' , '025113114' , '0935334000' ,  4000000)
INSERT INTO dbo.NHANVIEN VALUES  ( N'Nguyễn Văn Tú' , N'Nam' , '1997-12-29' , N'KTX Trần Hưng Đạo' , '291150550' , '0969795220' ,  5000000)
INSERT INTO dbo.NHANVIEN VALUES  ( N'Huỳnh Trọng Thoại' , N'Nữ' , '1997-01-30' , N'143 Cầu Giấy' , '028365444' , '0935845900' ,  5000000)
INSERT INTO dbo.NHANVIEN VALUES  ( N'Nhung Gumiho' , N'Nữ' , '1994-07-18' , N'31 Nơ Trang Long' , '145942153' , '0981322777' ,  4000000)
INSERT INTO dbo.NHANVIEN VALUES  ( N'Park Hang Seo' , N'Nam' , '1985-11-22' , N'37 Phú Mỹ Hưng' , '582699432' , '0981391354' ,  17000000)
GO

--------------data for TAIKHOAN
INSERT INTO dbo.TAIKHOAN VALUES  ( 101,'NV001', '123456', 'NV')
INSERT INTO dbo.TAIKHOAN VALUES  ( 102,'QL001', '123456', 'QL')
INSERT INTO dbo.TAIKHOAN VALUES  ( 103,'NV003', '123456', 'NV')
INSERT INTO dbo.TAIKHOAN VALUES  ( 104,'NV004', '123456', 'NV')
INSERT INTO dbo.TAIKHOAN VALUES  ( 105,'NV005', '123456', 'NV')
GO

--------------data for KHACHHANG-----------------------------------
INSERT INTO dbo.KHACHHANG (HOTEN ,GIOITINH ,NGAYSINH ,DIACHI ,CMND ,SDT) VALUES 
( N'Bích Thị Nụ', N'Nữ', '1990-02-25', N'123 An Dương Vương', '148526111', '0954852655' ),
( N'Linda Trần', N'Nữ', '1991-05-30', N'58 Lý Thái Tổ', '354848448', '0964845141' ),
( N'Kevin Khánh', N'Nam', '1993-08-21', N'117/21 Bàn Cờ, Q3 TPHCM', '421554644', '01887016541' ),
( N'Nguyễn Sơn Tùng', N'Nam', '1992-12-11', N'54/15 Nguyễn Đình Chiểu, Q3 TPHCM', '753951842', '0986275319' )
GO

--------------data for LOAIPHONG----------------------------------
INSERT INTO dbo.LOAIPHONG ( TENLOAI, MOTA, SUCCHUA, GIAPHONG ) VALUES
( N'Thường', N'2 loa lớn, 1 màn hình 58 inch', 10, 150000 ),
( N'VIP', N'4 loa lớn, 2 màn hình 58 inch, chọn bài bằng giọng nói', 16, 300000 ),
( N'Sự kiện', N'4 loa lớn, 2 màn hình 58 inch, có nhân viên hỗ trợ riêng', 20, 500000 )
GO

--------------data for PHONGHAT------------------------------------
INSERT INTO dbo.PHONGHAT(MALOAIPHONG,  TINHTRANG) VALUES 
(2001, N'Còn trống'),
(2002, N'Còn trống'),
(2003, N'Còn trống'),
(2001, N'Đang sử dụng')
GO

--------------data for LOAIDICHVU----------------------------------
INSERT INTO dbo.LOAIDICHVU VALUES 
( N'Đồ ăn'),
( N'Đồ uống'),
( N'Khác')
GO

--------------data for DICHVU--------------------------------------
INSERT INTO dbo.DICHVU ( MALOAIDV, TENDV, DONGIA ) VALUES 
( 301, N'Nui xào bò', 25000 ),
( 302, N'Mì xào trứng chiên', 20000 ),
( 302, N'Sting dâu', 12000 ),
( 302, N'Bò húc', 14000 ),
( 303, N'Khăn lạnh', 5000 ),
( 301, N'Trái cây', 35000 ),
( 302, N'Nước suối', 8000 )
GO


--------------data for KHUYENMAI-----------------------------------
INSERT INTO dbo.KHUYENMAI ( MAKM , TENKM , GIATRIKM , THOIGIANBD ,THOIGIANKT ) VALUES  
( 'VALEN2018', N'Valentine 2018', 50000, '2018-02-13', '2018-02-15' ),
( 'SN2018', N'Kỷ niệm 1 năm hoạt động', 100000, '2018-05-19', '2018-05-26' ),
( 'GS2018', N'Giáng sinh 2018', 50000, '2018-12-22', '2018-12-29' ),
( 'SNVV2018', N'Sinh nhật vui vẻ', 50000, '2018-01-01', '2018-12-31')
GO



--------------data for DONTHANHTOAN--------------------------------
INSERT INTO dbo.DONTHANHTOAN ( MANV ,MAKH , MAPHONG ,GIAPHONG , THOIGIANBD ,THOIGIANKT ,MAKM ,TINHTRANG) VALUES 
( 101, 10001, 1, 150000, '2018-05-19 09:00:00', '2018-05-19 11:00:00', NULL, N'Đã thanh toán' ),
( 102, 10002, 2, 300000, '2018-05-12 08:00:00', '2018-05-12 14:00:00', NULL, N'Đã thanh toán' ),
( 103, 10003, 3, 500000, '2018-05-19 12:00:00', '2018-05-19 15:00:00', NULL, N'Chưa thanh toán' ),
( 101, 10004, 2, 300000, '2018-05-13 14:00:00', '2018-05-13 17:00:00', 'SNVV2018', N'Đã thanh toán' )
GO


--------------data for CHITIETDICHVU-------------------------------
INSERT INTO dbo.CHITIETDICHVU ( MADON, STT, MADV, DONGIA, SOLUONG ) VALUES 
( 1, 1, 3001, 25000, 2 ),
( 1, 2, 3002, 20000, 3 ),
( 1, 3, 3005, 5000, 1 ),
( 2, 1, 3002, 20000, 5 ),
( 2, 2, 3007, 8000, 8 ),
( 3, 1, 3004, 14000, 3 ),
( 3, 2, 3003, 12000, 1 )
GO



SELECT * FROM dbo.NHANVIEN
SELECT * FROM dbo.TAIKHOAN
SELECT * FROM dbo.KHACHHANG

SELECT * FROM dbo.LOAIPHONG
SELECT * FROM dbo.PHONGHAT

SELECT * FROM dbo.LOAIDICHVU
SELECT * FROM dbo.DICHVU

SELECT * FROM dbo.KHUYENMAI

SELECT * FROM dbo.DONTHANHTOAN
SELECT * FROM dbo.CHITIETDICHVU
GO





-----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------PROCEDURE----------------------------------------------------------------

--==========================================BNguoiDung==========================================
CREATE PROC timTaiKhoan @tentk VARCHAR(50), @matkhau VARCHAR(50)
AS
	BEGIN
		SELECT *
		FROM dbo.TAIKHOAN
		WHERE TENTK = @tentk and MATKHAU = @matkhau
	END
GO

CREATE PROC capNhatTaiKhoan @tendn VARCHAR(50), @matkhau VARCHAR(50)
AS
	BEGIN
		UPDATE dbo.TAIKHOAN
		SET MATKHAU = @matkhau
		WHERE TENTK = @tendn
	END
GO


--==========================================BNhanVien==========================================

CREATE PROC layThongTinNhanVienTheoMaNV @manv INT
AS
	BEGIN
		SELECT *
		FROM dbo.NHANVIEN
		WHERE MANV = @manv
	END
GO


CREATE PROC layThongTinNhanVienTheoTen @tennv NVARCHAR(50)
AS
	BEGIN
		SELECT *
		FROM dbo.NHANVIEN
		WHERE HOTEN LIKE '%' + @tennv + '%'
	END
GO


CREATE PROC layThongTinTatCaNhanVien
AS
	BEGIN
		SELECT * FROM dbo.NHANVIEN
	END
GO


CREATE PROC themNhanVien @hoten NVARCHAR(50), @gioitinh NVARCHAR(3), @ngaysinh VARCHAR(100), @diachi NVARCHAR(200), @cmnd VARCHAR(10), @sdt VARCHAR(12), @luong INT, @tendn VARCHAR(50), @matkhau VARCHAR(50)
AS
	BEGIN
		INSERT INTO dbo.NHANVIEN ( HOTEN ,GIOITINH ,NGAYSINH ,DIACHI ,CMND ,SDT ,LUONG )
		VALUES  ( @hoten, @gioitinh, @ngaysinh, @diachi, @cmnd, @sdt, @luong)
		DECLARE @manv INT
		SET @manv = (SELECT TOP(1) MANV FROM dbo.NHANVIEN ORDER BY MANV DESC)
		INSERT INTO dbo.TAIKHOAN VALUES ( @manv,@tendn,@matkhau,'NV')
	END
GO


CREATE PROC xoaNhanVien @manv int
AS
	BEGIN
		DELETE FROM dbo.TAIKHOAN
		WHERE MANV = @manv
		DELETE FROM dbo.NHANVIEN
		WHERE MANV = @manv
	END
GO


CREATE PROC capNhatNhanVien @manv INT, @hoten NVARCHAR(50), @gioitinh NVARCHAR(3), @ngaysinh VARCHAR(100), @diachi NVARCHAR(200), @cmnd VARCHAR(10), @sdt VARCHAR(12), @luong INT, @tendn VARCHAR(50), @matkhau VARCHAR(50)
AS
	BEGIN
		UPDATE dbo.NHANVIEN
		SET HOTEN = @hoten, GIOITINH = @gioitinh, NGAYSINH = @ngaysinh, DIACHI = @diachi, CMND = @cmnd, SDT = @sdt, LUONG = @luong
		WHERE MANV = @manv
		UPDATE dbo.TAIKHOAN
		SET MATKHAU = @matkhau
		WHERE MANV = @manv
	END
GO



--==========================================BKhachHang==========================================
CREATE PROC layTatCaKhachHang
AS
	BEGIN
		SELECT * FROM dbo.KHACHHANG
	END
GO


CREATE PROC layKhachHangTheoMa @makh INT
AS
	BEGIN
		SELECT * 
		FROM dbo.KHACHHANG
		WHERE MAKH = @makh
	END
GO


CREATE PROC themKhachHang @hoten NVARCHAR(50), @gioitinh NVARCHAR(3), @ngaysinh VARCHAR(100), @diachi NVARCHAR(200), @cmnd VARCHAR(10), @sdt VARCHAR(12)
AS
	BEGIN
		INSERT INTO dbo.KHACHHANG ( HOTEN ,GIOITINH ,NGAYSINH ,DIACHI ,CMND ,SDT )
		VALUES  ( @hoten, @gioitinh, @ngaysinh, @diachi, @cmnd, @sdt)
	END
GO


CREATE PROC capNhatKhachHang @makh INT, @hoten NVARCHAR(50), @gioitinh NVARCHAR(3), @ngaysinh VARCHAR(100), @diachi NVARCHAR(200), @cmnd VARCHAR(10), @sdt VARCHAR(12)
AS
	BEGIN
		UPDATE dbo.KHACHHANG
		SET HOTEN = @hoten, GIOITINH = @gioitinh, NGAYSINH = @ngaysinh, DIACHI = @diachi, CMND = @cmnd, SDT = @sdt
		WHERE MAKH = @makh
	END
GO


CREATE PROC xoaKhachHang @makh INT
AS
	BEGIN
		DELETE FROM dbo.KHACHHANG
		WHERE MAKH = @makh
	END
GO



--==========================================BDonThanhToan==========================================
CREATE PROC layTatCaDonThanhToan
AS
	BEGIN
		SELECT * FROM dbo.DONTHANHTOAN
	END
GO


CREATE PROC layDonThanhToanTheoMaDon @madon INT
AS
	BEGIN
		SELECT * 
		FROM dbo.DONTHANHTOAN
		WHERE MADON = @madon
	END
GO


CREATE PROC themDonThanhToan @manv INT, @makh INT, @maphong INT, @giaphong INT, @tgbd VARCHAR(100), @tgkt VARCHAR(100), @makm VARCHAR(10), @tinhtrang NVARCHAR(20)
AS
	BEGIN
		INSERT INTO dbo.DONTHANHTOAN ( MANV ,MAKH , MAPHONG ,GIAPHONG , THOIGIANBD ,THOIGIANKT ,MAKM ,TINHTRANG )
		VALUES  ( @manv, @makh, @maphong, @giaphong, @tgbd, @tgkt, @makm, @tinhtrang )
	END
GO


CREATE PROC capNhatDonThanhToan @madon INT, @manv INT, @makh INT, @maphong INT, @giaphong INT, @tgbd VARCHAR(100), @tgkt VARCHAR(100), @makm VARCHAR(10), @tinhtrang NVARCHAR(20)
AS
	BEGIN
		UPDATE dbo.DONTHANHTOAN
		SET MANV = @manv, MAKH = @makh, MAPHONG = @maphong, GIAPHONG = @giaphong, THOIGIANBD = @tgbd, THOIGIANKT = @tgkt, MAKM = @makm, TINHTRANG = @tinhtrang
		WHERE MADON = @madon
	END
GO


CREATE PROC xoaDonThanhToan @madon INT
AS
	BEGIN
		DELETE FROM dbo.DONTHANHTOAN
		WHERE MADON = @madon
	END
GO



CREATE PROC themDonDatPhong @makh INT, @maphong INT, @giaphong INT, @tgbd VARCHAR(100), @tinhtrang NVARCHAR(20)
AS
	BEGIN
		INSERT INTO dbo.DONTHANHTOAN ( MAKH , MAPHONG ,GIAPHONG , THOIGIANBD, TINHTRANG )
		VALUES  ( @makh, @maphong, @giaphong, @tgbd, @tinhtrang )
	END
GO


CREATE PROC capNhatDonDatPhong @madon INT, @makh INT, @maphong INT, @giaphong INT, @tgbd VARCHAR(100), @tinhtrang NVARCHAR(20)
AS
	BEGIN
		UPDATE dbo.DONTHANHTOAN
		SET MAKH = @makh, MAPHONG = @maphong, GIAPHONG = @giaphong, THOIGIANBD = @tgbd, TINHTRANG = @tinhtrang
		WHERE MADON = @madon
	END
GO


CREATE PROC xoaDonDatPhong @madon INT
AS
	BEGIN
		DELETE FROM dbo.DONTHANHTOAN
		WHERE MADON = @madon
	END
GO


--==========================================BKhuyenMai==========================================
CREATE PROC layTatCaKhuyenMai
AS
	BEGIN
		SELECT * FROM dbo.KHUYENMAI
	END
GO


CREATE PROC layKhuyenMaiTheoMa @makm VARCHAR(10)
AS
	BEGIN
		SELECT * 
		FROM dbo.KHUYENMAI
		WHERE MAKM = @makm
	END
GO


CREATE PROC themKhuyenMai @makm VARCHAR(10), @tenkm NVARCHAR(50), @giatri INT, @tgbd VARCHAR(100), @tgkt VARCHAR(100)
AS
	BEGIN
		INSERT INTO dbo.KHUYENMAI ( MAKM, TENKM, GIATRIKM, THOIGIANBD, THOIGIANKT )
		VALUES  ( @makm, @tenkm, @giatri, @tgbd, @tgkt )
	END
GO


CREATE PROC capNhatKhuyenMai @makm VARCHAR(10), @tenkm NVARCHAR(50), @giatri INT, @tgbd VARCHAR(100), @tgkt VARCHAR(100)
AS
	BEGIN
		UPDATE dbo.KHUYENMAI
		SET TENKM = @tenkm, GIATRIKM = @giatri, THOIGIANBD = @tgbd, THOIGIANKT = @tgkt
		WHERE MAKM = @makm
	END
GO


CREATE PROC xoaKhuyenMai @makm VARCHAR(10)
AS
	BEGIN
		DELETE FROM dbo.KHUYENMAI
		WHERE MAKM = @makm
	END
GO



--==========================================BPhongHat==========================================
CREATE PROC layThongTinTatCaPhongHat
AS
	BEGIN
		SELECT * FROM dbo.PHONGHAT
	END
GO


CREATE PROC layThongTinPhongHatTheoTinhTrang @tinhtrang NVARCHAR(50)
AS
	BEGIN
		SELECT * 
		FROM dbo.PHONGHAT
		WHERE TINHTRANG = @tinhtrang
	END
GO

CREATE PROC layThongTinPhongHatTheoMa @maphong INT
AS
	BEGIN
		SELECT * 
		FROM dbo.PHONGHAT
		WHERE MAPHONG = @maphong
	END
GO


CREATE PROC themPhongHat @maloai INT, @tinhtrang NVARCHAR(50)
AS
	BEGIN
		INSERT INTO dbo.PHONGHAT ( MALOAIPHONG,  TINHTRANG )
		VALUES  ( @maloai, @tinhtrang)
	END
GO


CREATE PROC capNhatPhongHat @maphong INT, @maloai INT, @tinhtrang NVARCHAR(50)
AS
	BEGIN
		UPDATE dbo.PHONGHAT
		SET MALOAIPHONG = @maloai, TINHTRANG = @tinhtrang
		WHERE MAPHONG = @maphong
	END
GO


CREATE PROC xoaPhongHat @maphong INT
AS
	BEGIN
		DELETE FROM dbo.PHONGHAT
		WHERE MAPHONG = @maphong
	END
GO




--=======================================BLoaiPhongHat==========================================
CREATE PROC layThongTinTatCaLoaiPhongHat
AS
	BEGIN
		SELECT * FROM dbo.LOAIPHONG
	END
GO


CREATE PROC layThongTinLoaiPhongHatTheoSucChua @succhua INT
AS
	BEGIN
		SELECT * 
		FROM dbo.LOAIPHONG
		WHERE SUCCHUA >= @succhua
	END
GO

CREATE PROC layThongTinLoaiPhongHatTheoGiaPhong @giaphong INT
AS
	BEGIN
		SELECT * 
		FROM dbo.LOAIPHONG
		WHERE GIAPHONG = @giaphong
	END
GO


CREATE PROC layThongTinLoaiPhongHatTheoMa @maphong INT
AS
	BEGIN
		SELECT * 
		FROM dbo.LOAIPHONG
		WHERE MALOAIPHONG = @maphong
	END
GO


CREATE PROC themLoaiPhong @tenloai NVARCHAR(20), @giaphong INT, @succhua INT, @mota NVARCHAR(200)
AS
	BEGIN
		INSERT INTO dbo.LOAIPHONG (TENLOAI, GIAPHONG, SUCCHUA, MOTA)
		VALUES ( @tenloai, @giaphong, @succhua, @mota)
	END
GO


CREATE PROC capNhatLoaiPhong @maloai INT, @tenloai NVARCHAR(20), @giaphong INT, @succhua INT, @mota NVARCHAR(200)
AS
	BEGIN
		UPDATE dbo.LOAIPHONG
		SET TENLOAI = @tenloai, GIAPHONG = @giaphong, SUCCHUA = @succhua, MOTA = @mota
		WHERE MALOAIPHONG = @maloai
	END
GO


CREATE PROC xoaLoaiPhong @maloai INT
AS
	BEGIN
		DELETE FROM dbo.LOAIPHONG
		WHERE MALOAIPHONG = @maloai
	END
GO



--===========================================BDichVu=================================================
CREATE PROC layThongTinTatCaDichVu
AS
	BEGIN
		SELECT * FROM dbo.DICHVU
	END
GO


CREATE PROC layThongTinDichVuTheoDonGia @dongia INT
AS
	BEGIN
		SELECT * 
		FROM dbo.DICHVU
		WHERE DONGIA = @dongia
	END
GO

CREATE PROC layThongTinDichVuTheoTen @tendv NVARCHAR(50)
AS
	BEGIN
		SELECT * 
		FROM dbo.DICHVU
		WHERE TENDV = @tendv
	END
GO

CREATE PROC layThongTinDichVuTheoMa @madv INT
AS
	BEGIN
		SELECT * 
		FROM dbo.DICHVU
		WHERE MADV = @madv
	END
GO


CREATE PROC themDichVu @tenloai NVARCHAR(20), @dongia INT, @tendv NVARCHAR(50)
AS
	BEGIN
		DECLARE @maloaidv INT
		SET @maloaidv = (SELECT TOP(1) MALOAIDV FROM dbo.LOAIDICHVU WHERE TENLOAIDV = @tenloai)
		INSERT INTO dbo.DICHVU ( MALOAIDV, TENDV, DONGIA )
		VALUES  ( @maloaidv, @tendv, @dongia )
	END
GO


CREATE PROC capNhatDichVu @madv INT, @tenloaidv NVARCHAR(20), @dongia INT, @tendv NVARCHAR(50)
AS
	BEGIN
		DECLARE @maloaidv INT
		SET @maloaidv = (SELECT TOP(1) MALOAIDV FROM dbo.LOAIDICHVU WHERE TENLOAIDV = @tenloaidv)
		UPDATE dbo.DICHVU
		SET MALOAIDV = @maloaidv, DONGIA = @dongia, TENDV = @tendv
		WHERE MADV = @madv
	END
GO


CREATE PROC xoaDichVu @madv INT
AS
	BEGIN
		DELETE FROM dbo.DICHVU
		WHERE MADV = @madv
	END
GO




--===========================================BLoaiDichVu=============================================
CREATE PROC layThongTinTatCaLoaiDichVu
AS
	BEGIN
		SELECT * FROM dbo.LOAIDICHVU
	END
GO


CREATE PROC layThongTinLoaiDichVuTheoMa @maloaidv INT
AS
	BEGIN
		SELECT *
		FROM dbo.LOAIDICHVU
		WHERE MALOAIDV = @maloaidv
	END
GO


CREATE PROC layThongTinLoaiDichVuTheoTen @tenloaidv NVARCHAR(20)
AS
	BEGIN
		SELECT *
		FROM dbo.LOAIDICHVU
		WHERE TENLOAIDV = @tenloaidv
	END
GO


CREATE PROC themLoaiDichVu @tenloai NVARCHAR(20)
AS
	BEGIN
		INSERT INTO dbo.LOAIDICHVU ( TENLOAIDV )
		VALUES  ( @tenloai )
	END
GO


CREATE PROC capNhatLoaiDichVu @maloaidv INT, @tenloaidv NVARCHAR(20)
AS
	BEGIN
		UPDATE dbo.LOAIDICHVU
		SET TENLOAIDV = @tenloaidv
		WHERE MALOAIDV = @maloaidv
	END
GO


CREATE PROC xoaLoaiDichVu @maloaidv INT
AS
	BEGIN
		DELETE FROM dbo.LOAIDICHVU
		WHERE MALOAIDV = @maloaidv
	END
GO


--=========================================BChiTietDichVu=============================================
CREATE PROC layThongTinTatCaChiTietDichVu
AS
	BEGIN
		SELECT * FROM dbo.CHITIETDICHVU
	END
GO


CREATE PROC layThongTinChiTietDichVuTheoMaDonVaSTT @madon INT, @stt INT
AS
	BEGIN
		SELECT *
		FROM dbo.CHITIETDICHVU
		WHERE MADON = @madon AND STT = @stt
	END
GO


CREATE PROC layThongTinChiTietDichVuTheoMaDon @madon INT
AS
	BEGIN
		SELECT *
		FROM dbo.CHITIETDICHVU
		WHERE MADON = @madon
	END
GO


CREATE PROC themChiTietDichVu @madon INT, @madv INT, @dongia INT, @soluong INT
AS
	BEGIN
		DECLARE @stt INT
		DECLARE @temp INT
		SET @stt = 1
		SET @temp = (SELECT TOP(1) STT FROM dbo.CHITIETDICHVU WHERE MADON = 5 ORDER BY STT DESC)
		IF @temp >= 1
			SET @stt = @temp;
		INSERT INTO dbo.CHITIETDICHVU ( MADON, STT, MADV, DONGIA, SOLUONG )
		VALUES  ( @madon, @stt, @madv, @dongia, @soluong )
	END
GO


CREATE PROC capNhatChiTietDichVu @madon INT, @stt INT, @madv INT, @dongia INT, @soluong INT
AS
	BEGIN
		UPDATE dbo.CHITIETDICHVU
		SET DONGIA = @dongia, SOLUONG = @soluong
		WHERE MADON = @madon AND STT = @stt
	END
GO


CREATE PROC xoaChiTietDichVu @madon INT, @stt INT
AS
	BEGIN
		DELETE FROM dbo.CHITIETDICHVU
		WHERE MADON = @madon AND STT = @stt
	END
GO






