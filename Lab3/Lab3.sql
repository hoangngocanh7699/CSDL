/* Học phần: Cơ sở dữ liệu
   Ngày: 27/04/2020
   Người thực hiện: Nguyễn Khánh Linh
   MSSV: 1812790	
   Lớp: CTK42
*/
------------------------------------------------
create database Lab03_QuanLyNhapXuatHangHoa

go

use Lab03_QuanLyNhapXuatHangHoa

go
--Tạo bảng hàng hóa
create table HANGHOA 
(
MAHH char(5) primary key, 
TENHH nvarchar(30), 
DVT nvarchar(20), 
SOLUONGTON int
)

go

--tạo bảng đối tác
create table DOITAC
(
MADT char(5) primary key, 
TENDT nvarchar(20), 
DIACHI nvarchar(40), 
DIENTHOAI nvarchar(10)
)

go
--tạo bảng khả năng cung cấp
create table KHANANGCC
(
MADT char(5) references DOITAC, 
MAHH char(5)references HANGHOA,
primary key(MADT,MAHH)
)

go
--tạo bảng hóa đơn
create table HOADON
(
SOHD char(5) primary key, 
NGAYLAPHD date, 
MADT char(5) references DOITAC, 
TONGTG nvarchar(20)
)

go
--tạo bảng chi tiết hóa đơn
create table CT_HOADON
(
SOHD char(5) references HOADON, 
MAHH char(5) references HANGHOA, 
DONGIA  int, 
SOLUONG int
primary key(SOHD,MAHH)
)
select *from HANGHOA
select *from DOITAC
select *from KHANANGCC
select *from HOADON
select *from CT_HOADON

--Tạo bảng Hàng hóa

insert into HANGHOA values('CPU01',N'CPU INTEL,CELERON 600 BOX', N'CÁI',5)
insert into HANGHOA values('CPU02',N'CPU INTEL,PIII 700', N'CÁI',10)
insert into HANGHOA values('CPU03',N'CPU AMD K7 ATHL,ON 600', N'CÁI',8)
insert into HANGHOA values('HDD01',N'HDD 10.2 GB QUANTUM', N'CÁI',10)  
insert into HANGHOA values('HDD02',N'HDD 13.6 GB SEAGATE', N'CÁI',15)  
insert into HANGHOA values('HDD03',N'HDD 20 GB QUANTUM', N'CÁI',6) 
insert into HANGHOA values('KB01',N'KB GENIUS', N'CÁI',12) 
insert into HANGHOA values('KB02',N'KB MITSUMIMI', N'CÁI',5) 
insert into HANGHOA values('MB01',N'GIGABYTE CHIPSET INTEL', N'CÁI',10) 
insert into HANGHOA values('MB02',N'ACOPR BX CHIPSET VIA', N'CÁI',10)
insert into HANGHOA values('MB03',N'INTEL PHI CHIPSET INTEL', N'CÁI',10)  
insert into HANGHOA values('MB04',N'ECS CHIPSET SIS', N'CÁI',10) 
insert into HANGHOA values('MB05',N'ECS CHIPSET VIA', N'CÁI',10)  
insert into HANGHOA values('MNT01',N'SAMSUNG 14" SYNCMASTER', N'CÁI',5)  
insert into HANGHOA values('MNT02',N'LG 14"', N'CÁI',5)
insert into HANGHOA values('MNT03',N'ACER 14"', N'CÁI',8) 
insert into HANGHOA values('MNT04',N'PHILIPS 14"', N'CÁI',6) 
insert into HANGHOA values('MNT05',N'VIEWSONIC 14"', N'CÁI',7)  

--tạo bảng đối tác
insert into DOITAC values('CC001',N'Cty TNC',N'176 BTX Q1 - TPHCM','08.8250259')
insert into DOITAC values('CC002',N'Cty Hoàng Long',N'15A TTT Q1 – TP. HCM','08.8250898')  
insert into DOITAC values('CC003',N'Cty Hợp Nhất',N'152 BTX Q1 – TP.HCM','08.8252376')
insert into DOITAC values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp. Đà Lạt','063.831129')
insert into DOITAC values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang','058590270')
insert into DOITAC values('K0003',N'Trần nhật Duật',N'Lê Lợi TP. Huế','054.848376')  
insert into DOITAC values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi nghĩa- TP. Đà lạt','063.823409')

--tạo bảng khả năng cc
insert into KHANANGCC values('CC001','CPU01')
insert into KHANANGCC values('CC001','HDD03')
insert into KHANANGCC values('CC001','KB01')
insert into KHANANGCC values('CC001','MB02')
insert into KHANANGCC values('CC001','MB04')
insert into KHANANGCC values('CC001','MNT01')
insert into KHANANGCC values('CC002','CPU01')
insert into KHANANGCC values('CC002','CPU02')
insert into KHANANGCC values('CC002','CPU03')
insert into KHANANGCC values('CC002','KB02')
insert into KHANANGCC values('CC002','MB01')
insert into KHANANGCC values('CC002','MB05')
insert into KHANANGCC values('CC002','MNT03')
insert into KHANANGCC values('CC003','HDD01')
insert into KHANANGCC values('CC003','HDD02')
insert into KHANANGCC values('CC003','HDD03')
insert into KHANANGCC values('CC003','MB03')

--Tạo bảng hóa đơn
set dateformat dmy
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('N0001','25/01/2006','CC001') 
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('N0002','01/05/2006','CC002')
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('X0001','12/05/2006','K0001')  
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('X0002','16/06/2006','K0002')  
insert into HOADON(SOHD,NGAYLAPHD,MADT) values('X0003','20/04/2006','K0001')  

select * from HOADON

--Tạo bảng	CT_HoaDon
insert into CT_HOADON values('N0001','CPU01','63','10')
insert into CT_HOADON values('N0001','HDD03','97','7')
insert into CT_HOADON values('N0001','KB01','3','5')
insert into CT_HOADON values('N0001','MB02','57','5')
insert into CT_HOADON values('N0001','MNT01','112','2')
insert into CT_HOADON values('N0002','CPU02','115','3')
insert into CT_HOADON values('N0002','KB02','5','7')
insert into CT_HOADON values('N0002','MNT03','111','5')
insert into CT_HOADON values('X0001','CPU01','67','2') 
insert into CT_HOADON values('X0001','HDD03','100','2')
insert into CT_HOADON values('X0001','KB01','5','2')
insert into CT_HOADON values('X0001','MB02','62','1')
insert into CT_HOADON values('X0002','CPU01','67','1')
insert into CT_HOADON values('X0002','KB02','7','3')
insert into CT_HOADON values('X0002','MNT01','115','2')  
insert into CT_HOADON values('X0003','CPU01','67','1')  
insert into CT_HOADON values('X0003','MNT03','115','2') 

select * from CT_HOADON

--1) Liệt kê các mặt hàng thuộc loại đĩa cứng.
select *
from HANGHOA
where MAHH like 'HDD%'
--2) Liệt kê các mặt hàng có số lượng tồn trên 10.
select *
from HANGHOA
where SOLUONGTON >10
--3) Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh
select *
from DOITAC
where MADT like 'CC%' and DIACHI like '%HCM' 
--4) Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm: 
--sohd; ngaylaphd; tên, địa chỉ, và điện thoại của nhà cung cấp; số mặt hàng
select B.NGAYLAPHD,A.TENDT,A.DIACHI,A.DIENTHOAI, COUNT(C.MAHH) as SoMatHang
from DOITAC A,HOADON B,CT_HOADON C
where a.MADT= B.MADT and B.SOHD=C.SOHD and  month( NGAYLAPHD)=5  and B.SOHD like 'N%' 
group by C.SOHD,NGAYLAPHD,TENDT,DIACHI,DIENTHOAI
--5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng.
select DOITAC.TENDT,HANGHOA.TENHH
from HANGHOA,DOITAC,KHANANGCC
where HANGHOA.MAHH = KHANANGCC.MAHH and KHANANGCC.MADT = DOITAC.MADT and HANGHOA.MAHH like 'HDD%'
--6) Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng.
select DOITAC.TENDT
from HANGHOA,DOITAC,KHANANGCC
where HANGHOA.MAHH = KHANANGCC.MAHH and KHANANGCC.MADT = DOITAC.MADT /*and KHANANGCC.MADT like 'CC%'*/ and KHANANGCC.MAHH like 'HDD%'
--7) Cho biết tên nhà cung cấp không cung cấp đĩa cứng.
select TENDT
from DOITAC
where DOITAC.MADT not in (select DOITAC.MADT
		   from DOITAC,HANGHOA,KHANANGCC
		   where DOITAC.MADT = KHANANGCC.MADT and KHANANGCC.MAHH = HANGHOA.MAHH and HANGHOA.MAHH like 'HDD%'



--8) Cho biết thông tin của mặt chưa bán được.
--9) Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng).
--10)Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất.
--11)Cho biết hóa đơn nhập nhiều mặt hàng nhất.
--12)Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
--13)Cho biết tên các mặt hàng không bán được trong tháng 6/2006
--14)Cho biết cửa hàng bán bao nhiêu mặt hàng
--15)Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp.
--16)Cho biết thông tin của khách hàng có giao dịch với của hàng nhiều nhất.
--17) Tính tổng doanh thu năm 2006.
--18)Cho biết loại mặt hàng bán chạy nhất.
--19) Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm: mahh, tenhh, dvt, tổng số lượng, tổng thành tiền.
--20) Liệt kê thông tin của mặt hàng có nhiều người mua nhất.
--21) Tính và cập nhật tổng trị giá của các hóa đơn.