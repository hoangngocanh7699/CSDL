﻿------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 15/10/2019
   Người thực hiện: Tạ Thị Thu Phượng
*/
------------------------------------------------
--lenh tao CSDL
CREATE DATABASE Lab01_QuanLyNhanVien
go
--lenh su dyng CSDL
use Lab01_QuanLyNhanVien
--lenh tao cac bang
create table ChiNhanh
(MSCN	char(2) primary key, -- khai bao MSCN là khóa chính
TenCN	nvarchar(30) not null unique
)
go
create table NhanVien
(
MANV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10)	not null,
Ngaysinh	datetime,
NgayVaoLam	datetime,
MSCN	char(2)	references ChiNhanh(MSCN) -- khai bao MSCN là khóa ngoại tham chiếu đến khóa chính MSCN của quan hệ ChiNhanh 
)
go
create table KyNang
(MSKN	char(2) primary key,
TenKN	nvarchar(30) not null
)
go
create table NhanVienKyNang
(
MANV char(4) references NhanVien(MANV),
MSKN char(2) references KyNang(MSKN),
MucDo	tinyint check(MucDo between 1 and 9)--check(MucDo>=1 and MucDo<=9)
primary key(MANV,MSKN) --khai báo khóa chính gồm nhiều thuộc tính
)
--xem cac bang
select * from ChiNhanh
select * from NhanVien
select * from KyNang
select * from NhanVienKyNang

--Nhap du lieu cho cac bang
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình thạnh')
--xem bảng Chi nhanh
select * from ChiNhanh
--Nhap bang Kynang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--xem bảng KyNang
select * from KyNang
--Nhap bang NhanVien
set dateformat dmy --Khai báo định dạng ngày tháng 
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
insert into NhanVien values('0008',N'Lê Văn',N'Minh','10/06/1968','02/05/1988','01')
--xem bang nhanvien
select * from NhanVien
--nhap bang nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)
insert into NhanVienKyNang values('0007','04',3)

select * from NhanVienKyNang
---------------------------------------------------
select * from NhanVien where MSCN='01'
--liet ke cac nhan vien ho 'lê'
select * from NhanVien where Ho like N'Lê%' and MSCN='01'
--danh sach cac nhan vien sinh sau 1975
select * from NhanVien where YEAR(ngaysinh)>1975
select GETDATE()
--------------
select manv,ho+' '+ten As HoTen,YEAR(GETDATE())-YEAR(ngayvaolam)as SoNamCT
from NhanVien
----------
select manv,ho+' '+ten As HoTen,mscn, YEAR(GETDATE())-YEAR(ngayvaolam)as SoNamCT
from NhanVien
where YEAR(GETDATE())-YEAR(ngayvaolam)>20
-----------
select nhanvien.*, ChiNhanh.*
from NhanVien,ChiNhanh
where Nhanvien.mscn=Chinhanh.mscn
---------
select a.*, b.*
from NhanVien a,ChiNhanh b
where a.mscn=b.mscn
--1b
select Ho+' '+Ten as HoTen, Ngaysinh, NgayVaoLam, Tencn
from NhanVien A, ChiNhanh B
where	A.MSCN = B.mscn
order by TenCN, Ten, ho
--1c
select Ho+' '+Ten as HoTen,TenKN,mucdo
from NhanVien A, NhanVienkynang B,  KyNang C
where	A.manv = B.MANV and B.MSKN = C.MSKN and TenKN = 'word'
--1d
select tenkn,mucdo
from NhanVien a, NhanVienKyNang b, KyNang c
where A.manv = B.MANV and B.MSKN = C.MSKN 
		and Ho = N'Lê Anh' and Ten = N'Tuấn'
		--and Ho+' '+Ten = N'Lê Anh Tuấn'


--2b:Liệt kê các nhân viên sử dụng được 'word' và 'excel' (Phép giao)
select b.MANV,Ho+' '+Ten as HoTen, tencn
from ChiNhanh a, NhanVien b, NhanVienKyNang c, KyNang d
where a.mscn = b.mscn and b.manv = c.MANV and c.MSKN = d.MSKN 
	  and TenKN = 'excel' 
	  and b.MANV IN (select e.MANV
					 from NhanVienKyNang e, KyNang f
					 where e.MSKN = f.MSKN and TenKN = 'word')
	---
	select * from NhanVien
--Liệt kê các nhân viên không sử dụng access (Phép hiệu)
select b.MANV,Ho+' '+Ten as HoTen
from NhanVien b
where b.MANV NOT IN (select e.MANV
					 from NhanVienKyNang e, KyNang f
					 where e.MSKN = f.MSKN and TenKN = 'ACCESS')
	---
----------------------------------
select	b.MSCN, tencn, COUNT(manv) as SONV
from	nhanvien a, ChiNhanh b
where a.MSCN = b.MSCN
group by	b.mscn, tencn


---------------------------------
select		a.MANV, Ho+' '+Ten as HoTen, COUNT(mskn) as SoKN
from		NhanVien a, NhanVienKyNang b
where		a.MANV = b.MANV
group by	a.MANV,Ho, Ten
having		COUNT(mskn)>=3
order by	Ten,ho
---------------cho biet nhan vien gioi excel nhat--------
--cach 1
select	a.MANV, Ho+' '+Ten as HoTen, a.MSCN, TenCN, d.TenKN,c.mucdo
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and TenKN = 'excel' 
		and c.MucDo = (select MAX(e.mucdo)
						from NhanVienKyNang e, KyNang f
						where e.MSKN= f.MSKN and f.TenKN = 'excel')
--cach 2
select	a.MANV, Ho+' '+Ten as HoTen, a.MSCN, TenCN, d.TenKN,c.mucdo
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and TenKN = 'excel' 
		and c.MucDo >=all (select e.mucdo
						from NhanVienKyNang e, KyNang f
						where e.MSKN= f.MSKN and f.TenKN = 'excel')
---------------cho biet nhan vien gioi nhat cua tung ky nang--------
--cach 1
select	d.TenKN, a.MANV, Ho+' '+Ten as HoTen, a.MSCN, TenCN, c.mucdo
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and c.MucDo = (select MAX(e.mucdo)
						from NhanVienKyNang e
						where e.MSKN= d.MSKN)	
order by d.TenKN
---Tim chi nhanh co nhieu nhan vien nhat
select TenCN, count(manv) as SoNV
from NhanVien a, ChiNhanh b
where a.MSCN = b.MSCN
group by tencn
having	count(manv)>=all (select COUNT(c.manv)
							from NhanVien c
							group by c.MSCN)	
	--cach khac
select TenCN, count(manv) as SoNV
from NhanVien a, ChiNhanh b
where a.MSCN = b.MSCN
group by a.mscn, tencn
having	count(manv)= (select max(COUNT(c.manv))
							from NhanVien c
							group by c.MSCN)	
-------liệt kê nhân viên sử dụng được nhiều kỹ năng nhất------
select	Ho+' '+Ten as HoTen,TenCN, COUNT(c.mskn) as SoKN
from	NhanVien a, ChiNhanh b, NhanVienKyNang c
where	a.MSCN = b.MSCN and a.MANV = c.MANV
group by a.MANV, Ho, Ten, TenCN
having COUNT(c.mskn)>=all (select COUNT(d.mskn)
							from NhanVienKyNang d
							group by d.MANV)
							
---Liệt kê các nhân viên sử dụng được mọi (tất cả)kỹ năng-------------
select	a.MANV, +' '+Ten as HoTen,TenCN, COUNT(c.mskn) as SoKN
from	NhanVien a, ChiNhanh b, NhanVienKyNang c
where	a.MSCN = b.MSCN and a.MANV = c.MANV
group by a.MANV, Ho, Ten, TenCN
having COUNT(c.mskn)= (select count(mskn) 
						from kynang)
						
-------------Chèn thêm dữ liệu chạy thử truy vấn--------
insert into NhanVienKyNang values('0004','04',3)
insert into NhanVienKyNang values('0004','05',3)

insert into NhanVienKyNang values('0006','01',2)
insert into NhanVienKyNang values('0006','04',2)
--------------
select * from NhanVienKyNang where MSKN='01'
---cập nhật dữ liệu
update NhanVienKyNang
set MucDo = MucDo+1
where MSKN='01'
---xóa dữ liệu
delete NhanVienKyNang
where MANV = '0006' and MSKN ='04'
------tao bang nhan vien chi nhanh 1------
create table NVChiNhanh1
(manv char(4) primary key references nhanvien(manv),
HoTen nvarchar(30),
SoKyNang	tinyint 
)
---
--delete  from NVChiNhanh1
select * from NVChiNhanh1
----Chèn dữ liệu vào bảng NVChiNhanh1----------
insert into NVChiNhanh1(manv,HoTen, SoKyNang)
select		a.MANV, Ho+' '+Ten, COUNT(mskn)
from		NhanVien a, NhanVienKyNang b
where		a.MANV = b.manv and MSCN = '01'
group by	a.MANV, Ho, Ten

--------------------------
select * from Kynang

insert into KyNang values('06','Photoshop')

select TenKN
from NhanVienKyNang  right join KyNang on KyNang.MSKN = NhanVienKyNang.MSKN
where MANV is NULL

select TenKN
from KyNang  
where MSKN NOT IN (select mskn from NhanVienKyNang)
----------------------------------------------------------------------
