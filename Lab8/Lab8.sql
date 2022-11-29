/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Khánh Linh
   MSSV: 1812790
   Lớp: CTK42
*/
------------------------------------------------
Create database Lab08_QuanLySinhVien
go

use Lab08_QuanLySinhVien
go

create table KHOA
(MSKhoa nchar(2) primary key,
TenKhoa nvarchar(30) not null unique,
TenTat nchar(4) not null unique);

go
create table Lop
(MSLop nchar(4) primary key,
TenLop nvarchar(30) not null unique,
MSKhoa nchar(2) references KHOA(MSKhoa),
NienKhoa nchar(4) not null);

go
create table Tinh
(MSTinh nchar(2) primary key,
TenTinh nvarchar(20) not null unique);

go
create table MonHoc
(MSMH nchar(4) primary key,
TenMH nvarchar(30) not null,
HeSo tinyint not null);

go
create table SinhVien
(MSSV nchar(7) primary key,
Ho nvarchar(20) not null,
Ten nchar(10) not null,
NgaySinh date not null,
MSTinh nchar(2) references TINH(MSTinh),
NgayNhapHoc date not null,
MSLop nchar(4) references LOP(MSLop),
Phai bit not null,
DiaChi nvarchar(30) not null,
DienThoai nchar(10)
)
select * from SinhVien


go
create table BANGDIEM
(MSSV nchar(7) foreign key references SinhVien(MSSV),
MSMH nchar(4) foreign key references MonHoc(MSMH),
LanThi tinyint not null,
Diem float not null,
constraint PK primary key (MSSV, MSMH, LanThi));

Insert into KHOA Values('1','Cong nghe thong tin','CNTT')
Insert into KHOA Values('2','Dien tu vien thong','DTVT')
Insert into KHOA Values('3','Quan tri kinh doanh','QTKD')
Insert into KHOA Values('4','Cong nghe sinh hoc','CNSH')

Insert into Lop Values('98TH','Tin hoc khoa 1998','1','1998')
Insert into Lop Values('98VT','Vien thong khoa 1998','2','1998')
Insert into Lop Values('99QT','Quan tri khoa 1999','3','1999')
Insert into Lop Values('99TH','Tin hoc khoa 1999','1','1999')
Insert into Lop Values('99VT','Vien thong khoa 1999','2','1999')

Insert into Tinh Values('01','An Giang')
Insert into Tinh Values('02','TPHCM')
Insert into Tinh Values('03','Dong Nai')
Insert into Tinh Values('04','Long An')
Insert into Tinh Values('05','Hue')
Insert into Tinh Values('06','Ca Mau')

Insert into MonHoc Values('QA01','Kinh te vi mo','2')
Insert into MonHoc Values('QA02','Quan tri chat luong','3')
Insert into MonHoc Values('TA01','Nhap mon tin hoc','2')
Insert into MonHoc Values('TA02','Lap trinh co ban','3')
Insert into MonHoc Values('TB01','Cau truc du lieu','2')
Insert into MonHoc Values('TB02','Co so du lieu','2')
Insert into MonHoc Values('VA01','Dien tu co ban','2')
Insert into MonHoc Values('VA02','Mach so','3')
Insert into MonHoc Values('VB01','Truyen so lieu','3')
Insert into MonHoc Values('XA01','Vat ly dai cuong','2')

Insert into SinhVien Values('98TH001','Nguyen Van','An','8/6/1980','01','9/3/1998','98TH','1','12 Tran Hung Dao, Q.1','8234512')
Insert into SinhVien Values('98TH002','Le Thi','An','10/17/1979','01','9/3/1998','98TH','0','23 CMT8, Q.Tan Binh','0303234342')
Insert into SinhVien Values('98VT001','Nguyen Duc','Bình','11/25/1981','02','9/3/1998','98VT','1','245 Lac Long Quan, Q.11','8654323')
Insert into SinhVien Values('98VT002','Tran Ngoc','Anh','8/19/1980','02','9/3/1998','98VT','0','242 Tran Hung Dao, Q.1','')
Insert into SinhVien Values('99QT001','Nguyen Thi','Oanh','8/19/1973','04','10/5/1999','99QT','0','76 Hung Vuong, Q.5','0901656324')
Insert into SinhVien Values('99QT002','Le My','Hanh','5/20/1976','04','10/5/1999','99QT','0','12 Pham Ngoc Thach, Q.3','')
Insert into SinhVien Values('99TH001','Ly Van Hung','Dung','9/27/1981','03','10/5/1999','99TH','1','178 CMT8, Q. Tân Bình','7563213')
Insert into SinhVien Values('99TH002','Van Minh','Hoang','1/1/1981','04','10/5/1999','99TH','1','272 Ly Thuong Kiet, Q.10','8341234')
Insert into SinhVien Values('99TH003','Nguyen','Tuan','1/12/1980','03','10/5/1999','99TH','1','162 Tran Hung Dao, Q.5','')
Insert into SinhVien Values('99TH004','Tran Van','Minh','6/25/1981','04','10/5/1999','99TH','1','147 Dien Bien Phu, Q.3','7236754')
Insert into SinhVien Values('99TH005','Nguyen Thai','Minh','1/1/1980','04','10/5/1999','99TH','1','345 Le Dai Hanh, Q.11','')
Insert into SinhVien Values('99VT001','Le Ngoc','Mai','6/21/1982','01','10/5/1999','99VT','0','129 Tran Hung Dao, Q.1','0903124534')

Insert into BANGDIEM Values('98TH001','TA01','1','8.5')
Insert into BANGDIEM Values('98TH001','TA02','1','8')
Insert into BANGDIEM Values('98TH001','TB01','1','7')
Insert into BANGDIEM Values('98TH002','TA01','1','4')
Insert into BANGDIEM Values('98TH002','TA01','2','5.5')
Insert into BANGDIEM Values('98TH002','TB01','1','7.5')
Insert into BANGDIEM Values('98VT001','VA01','1','4')
Insert into BANGDIEM Values('98VT001','VA01','2','5')
Insert into BANGDIEM Values('98VT002','VA02','1','7.5')
Insert into BANGDIEM Values('99QT001','QA01','1','7')
Insert into BANGDIEM Values('99QT001','QA02','1','6.5')
Insert into BANGDIEM Values('99QT002','QA01','1','8.5')
Insert into BANGDIEM Values('99QT002','QA02','1','9')
Insert into BANGDIEM Values('99TH001','TA01','1','4')
Insert into BANGDIEM Values('99TH001','TA01','2','6')
Insert into BANGDIEM Values('99TH001','TB01','1','6.5')
Insert into BANGDIEM Values('99TH002','TB01','1','10')
Insert into BANGDIEM Values('99TH002','TB02','1','9')
Insert into BANGDIEM Values('99TH003','TA02','1','7.5')
Insert into BANGDIEM Values('99TH003','TB01','1','3')
Insert into BANGDIEM Values('99TH003','TB01','2','6')
Insert into BANGDIEM Values('99TH003','TB02','1','8')
Insert into BANGDIEM Values('99TH004','TB02','1','2')
Insert into BANGDIEM Values('99TH004','TB02','2','4')
Insert into BANGDIEM Values('99TH004','TB02','3','3')

select *
from KHOA

select *
from Lop
/*
select COUNT(A.MSKhoa)
from Lop A,KHOA B
where A.MSKhoa=B.MSKhoa
group by A.MSKhoa*/
select *
from Tinh

select *
from MonHoc

select *
from SinhVien

select *
from BANGDIEM
select MSSV,MSMH,LanThi,Diem
from BANGDIEM
group by MSSV,MSMH,LanThi,Diem
having Diem >=all(select Diem from	 BANGDIEM)
---------Truy vấn đơn giản
select *
from SinhVien A,BANGDIEM B
where A.MSSV=B.MSSV and b.Diem =(select MAX(Diem)  from BANGDIEM)
--1) Liệt kê MSSV, Họ, Tên, Địa chỉ của tất cả các sinh viên
select MSSV,Ho,Ten,DiaChi
from SinhVien
--2) Liệt kê MSSV, Họ, Tên, MS Tỉnh của tất cả các sinh viên. Sắp xếp kết quả theo MS
--tỉnh, trong cùng tỉnh sắp xếp theo họ tên của sinh viên.
select MSSV,Ho,Ten,MSLop
from SinhVien
order by MSTinh,Ho,Ten
--3) Liệt kê các sinh viên nữ của tỉnh Long An
select MSSV,Ho,Ten,Tinh.TenTinh,Phai
from SinhVien ,Tinh
where  SinhVien.MSTinh=Tinh.MSTinh and SinhVien.MSTinh = '04' and Phai = '0'
--4) Liệt kê các sinh viên có sinh nhật trong tháng giêng.
select MSSV,Ho,Ten,DiaChi,NgaySinh
from SinhVien
where month(NgaySinh) = '01'
--5) Liệt kê các sinh viên có sinh nhật nhằm ngày 1/1.
select MSSV,Ho,Ten,DiaChi,NgaySinh
from SinhVien
where month(NgaySinh) = '01' and day(NgaySinh) = '01'
--6) Liệt kê các sinh viên có số điện thoại.
select *
from SinhVien
where  DienThoai != ''				
--7) Liệt kê các sinh viên có số điện thoại di động.
select *
from SinhVien
where DienThoai like '0%'	
--8) Liệt kê các sinh viên tên ‘Minh’ học lớp ’99TH’
select *
from SinhVien
where MSLop = '99TH' and Ten = N'Minh'
--9) Liệt kê các sinh viên có địa chỉ ở đường ‘Tran Hung Dao’
select *
from SinhVien
where DiaChi like '%Tran Hung Dao%'
--10) Liệt kê các sinh viên có tên lót chữ ‘Van’ (không liệt kê người họ ‘Van’)
select *
from SinhVien
where Ho like '% Van%'
--11) Liệt kê MSSV, Họ Ten (ghép họ và tên thành một cột), Tuổi của các sinh viên ở tỉnh
--Long An.
select MSSV, Ho +' '+Ten as HoTen, year(GETDATE()) - year(NgaySinh)  as Tuoi
from SinhVien
where MSTinh = '04'
--12) Liệt kê các sinh viên nam từ 23 đến 28 tuổi.
select MSSV, Ho +' '+Ten as HoTen, year(GETDATE()) - year(NgaySinh)  as Tuoi,Phai
from SinhVien
where Phai = '1' and year(GETDATE()) - year(NgaySinh) between 23 and 28
--13) Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh viên nữ từ 27 tuổi trở lên.
select MSSV, Ho +' '+Ten as HoTen, year(GETDATE()) - year(NgaySinh)  as Tuoi,Phai
from SinhVien
where Phai = '1' and year(GETDATE()) - year(NgaySinh) >=32
or	Phai = '0' and year(GETDATE()) - year(NgaySinh) >=27

--14) Liệt kê các sinh viên khi nhập học còn dưới 18 tuổi, hoặc đã trên 25 tuổi.
select MSSV, Ho +' '+Ten as HoTen, year(GETDATE()) - year(NgaySinh)  as Tuoi,Phai
from SinhVien
where  year(NgayNhapHoc) - year(NgaySinh) <=18
or year(GETDATE()) - year(NgaySinh) >=25
--15) Liệt kê danh sách các sinh viên của khóa 99 (MSSV có 2 ký tự đầu là ‘99’).
select *
from SinhVien
where MSSV like '99%'
--16) Liệt kê MSSV, Điểm thi lần 1 môn ‘Co so du lieu’ của lớp ’99TH’
select A.MSSV,B.LanThi,B.Diem,B.MSMH
from SinhVien A, BANGDIEM B
where A.MSSV = B.MSSV and
	B.MSMH = 'TB02' and A.MSLop like '99%' and b.LanThi = '1'
		
--17) Liệt kê MSSV, Họ tên của các sinh viên lớp ’99TH’ thi không đạt lần 1 môn ‘Co so
--du lieu’
select A.MSSV,B.LanThi,B.Diem,B.MSMH
from SinhVien A, BANGDIEM B
where A.MSSV = B.MSSV and
	B.MSMH = 'TB02' and A.MSLop like '99%' and b.LanThi = '1' and B.Diem < 4

--18) Liệt kê tất cả các điểm thi của sinh viên có mã số ’99TH001’ theo mẫu sau:
--MSMH TênMH Lầnthi Điểm
select B.MSMH,c.TenMH,B.LanThi,B.Diem
from SinhVien A,BANGDIEM B,MonHoc C
where a.MSSV = b.MSSV and B.MSMH = C.MSMH and a.MSSV = '99TH001'
--19) Liệt kê MSSV, họ tên, MSLop của các sinh viên có điểm thi lần 1 môn ‘Co so du
--lieu’ từ 8 điểm trở lên
select A.MSSV,A.Ho,A.Ten,A.MSLop
from SinhVien A, BANGDIEM B
where A.MSSV = B.MSSV and
	b.LanThi = '1' and b.Diem >=8
--20) Liệt kê các tỉnh không có sinh viên theo học
	select *
	from Tinh
	where MSTinh not in(select distinct MSTinh
						from SinhVien
						)
--21) Liệt kê các sinh viên hiện chưa có điểm môn thi nào.
select *
from SinhVien
where MSSV not in(select MSSV
				  from BANGDIEM
				  )

--Truy vấn gom nhóm
--22) Thống kê số lượng sinh viên ở mỗi lớp theo mẫu sau: MSLop, TenLop, SoLuongSV
select A.MSLop,B.TenLop,COUNT(MSSV)	AS SoLuong
from SinhVien A,Lop B
where A.MSLop = B.MSLop
group by A.MSLop,B.TenLop
select *from SinhVien
--23) Thống kê số lượng sinh viên ở mỗi tỉnh theo mẫu sau:
--MSTinh TênTỉnh SốSVNam SốSVNữ Tổngcộng
select A.MSTinh, A.TenTinh, count(case B.Phai when '1' then 1 else null end) as SoVSNam, count(case B.Phai when '0' then 1 else null end) as SoVSNu,COUNT(*) as SoLuong
from Tinh A, SinhVien B
where A.MSTinh =B.MSTinh
group by A.MSTinh,A.TenTinh

--24) Thống kê kết quả thi lần 1 môn ‘Co so du lieu’ ở các lớp, theo mẫu sau
select A.MSLop,A.TenLop,COUNT(case when B.Diem >='4' then 1 else null end) AS N'Số SV đạt',
						COUNT(case when B.Diem >='4' then 1 else null end)*100/COUNT(*) as N'Tỉ lệ đạt (%)',
						COUNT(case when B.Diem <'4' then 1 else null end) AS N'Số SV không đạt'
						,COUNT(case when B.Diem <'4' then 1 else null end)*100/COUNT(*) as N'Tỉ lệ không đạt'

from Lop A, BANGDIEM B, SinhVien C
where A.MSLop = C.MSLop and C.MSSV = B.MSSV
group by A.MSLop,A.TenLop

--25) Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu sau (điểm in ra của
--mỗi môn là điểm cao nhất trong các lần thi của môn đó):
