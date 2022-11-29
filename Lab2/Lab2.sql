/* Học phần: Cơ sở dữ liệu
   Ngày: 22/04/2020
   Người thực hiện: Nguyễn Khánh Linh
   MSSV: 1812790	
   Lớp: CTK42
*/
------------------------------------------------
create database Lab02_QuanlySanXuat

go

use Lab02_QuanlySanXuat

go
--Tạo bảng tổ sản xuất
create table ToSanXuat
(
MaTSX char(4) primary key, 
TenTSX nvarchar(10) not null unique 
)
go
--Tạo bảng công nhân
create table CongNhan
(
MACN char(5) primary key,
Ho nvarchar(20), 
Ten nvarchar(20), 
Phai nvarchar(10), 
NgaySinh date, 
MaTSX char(4) references ToSanXuat(MaTSX)
)
go

--Tạo bảng sản phẩm
create table SanPham
(
MaSP char(5) primary key, 
TenSP nvarchar(20) not null unique,
DVT nvarchar(10), 
TienCong float check(TienCong>0)
)
go
--Tạo bảng Thành phẩm
create table ThanhPham
(
MACN char(5) references CongNhan(MACN) , 
MaSP char(5) references SanPham(MASP), 
Ngay date, 
SoLuong int check (SoLuong >= 0)
primary key (MACN,MASP)
)
--chọn xem các bảng đã tạo
select * from CongNhan
select * from SanPham
select * from ToSanXuat
select * from ThanhPham

--đưa dữ liệu vào các table
--Nhập dữ liệu cho table ToSanXuat
insert into ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values('TS02',N'Tổ 2')
go
--Nhập dữ liệu cho Congnhan
set dateformat dmy
insert into CongNhan values('CN001',N'Nguyễn Trường',N'An',N'Nam','12/05/1981','TS01')
insert into CongNhan values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1980','TS01')   
insert into CongNhan values('CN003',N'Nguyễn Công',N'Thành',N'Nam','04/05/1981','TS02')  
insert into CongNhan values('CN004',N'Võ Hữu',N'Hạnh',N'Nam','15/02/1980','TS02')  
insert into CongNhan values('CN005',N'Lý Thanh',N'Hân',N'Nữ','03/12/1981','TS01') 

go

--Nhập duqx liệu cho sản phẩm
INSERT INTO SanPham VALUES ('SP001', N'Nồi đất', N'cái', 10000)
INSERT INTO SanPham VALUES ('SP002', N'Chén', N'cái', 2000)
INSERT INTO SanPham VALUES ('SP003', N'Bình gốm nhỏ', N'cái', 20000)
INSERT INTO SanPham VALUES ('SP004', N'Bình gốm lớn', N'cái', 25000)

--Nhập dữ liệu cho ThanhPham
set dateformat dmy
insert into ThanhPham values('CN001','SP001','01/02/2007',10)
insert into ThanhPham values('CN002','SP001','01/02/2007',5)
insert into ThanhPham values('CN003','SP002','10/01/2007',50)
insert into ThanhPham values('CN004', 'SP003' ,'12/01/2007', 10)
insert into ThanhPham values('CN005', 'SP002' ,'12/01/2007' ,100)
insert into ThanhPham values('CN002' ,'SP004' ,'13/02/2007' ,10)
insert into ThanhPham values('CN001' ,'SP003', '14/02/2007' ,15)
insert into ThanhPham values('CN003', 'SP001' ,'15/01/2007' ,20)
insert into ThanhPham values('CN003' ,'SP004', '14/02/2007' ,15)
insert into ThanhPham values('CN004', 'SP002', '30/01/2007' ,100)
insert into ThanhPham values('CN005', 'SP003', '01/02/2007' ,50)
insert into ThanhPham values('CN001', 'SP001', '20/02/2007', 30)


--1) Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen, NgaySinh, Phai (xếp thứ tự tăng dần của tên tổ sản xuất , Tên của công nhân).
select ToSanXuat.TenTSX, CongNhan.Ho + ' '+CongNhan.Ten as HoTen, CongNhan.NgaySinh,CongNhan.Phai
from ToSanXuat,CongNhan
order by ToSanXuat.TenTSX,CongNhan.Ten
--2) Liệt kê các thành phẩm mà công nhân ‘Nguyễn Trường An’ đã làm được gồm các thông tin: TenSP, Ngay, SoLuong, ThanhTien (xếp theo thứ tự tăng dần của ngày).
select SanPham.TenSP, ThanhPham.Ngay, ThanhPham.SoLuong, ThanhPham.SoLuong * SanPham.TienCong as ThanhTien
from SanPham, ThanhPham,CongNhan
where CongNhan.MACN=ThanhPham.MACN and 
	  SanPham.MaSP =ThanhPham.MaSP and 
	  CongNhan.Ho=N'Nguyễn Trường' and CongNhan.Ten='An'
	  order by ThanhPham.Ngay 
--3.1) Liệt kê các nhân viên --(không)-- sản xuất sản phẩm ‘Bình gốm lớn’.
select *--CongNhan.MACN,Ho,Ten, Phai,NgaySinh,MaTSX/*,SanPham.MaSP,Ngay,SoLuong*/,TenSP,DVT,TienCong
from CongNhan,ThanhPham ,SanPham
where CongNhan.MACN =ThanhPham.MACN and
	  ThanhPham.MaSP = SanPham.MaSP and
	  not SanPham.TenSP='Bình gốm lớn' 


--3.2) Liệt kê các nhân viên sản xuất sản phẩm ‘Bình gốm lớn’.
select CongNhan.MACN,CongNhan.MaTSX,CongNhan.Ho,CongNhan.Ten,CongNhan.Phai,CongNhan.NgaySinh,SanPham.TenSP
from CongNhan,SanPham,ThanhPham
where CongNhan.MACN=ThanhPham.MACN and 
      ThanhPham.MaSP=SanPham.MaSP and
	  SanPham.TenSP=N'Bình gốm lớn'

--4) Liệt kê thông tin các công nhân có sản xuất cả ‘Nồi đất’ và ‘Bình gốm nhỏ’.
select CongNhan.MACN,CongNhan.MaTSX,CongNhan.Ho,CongNhan.Ten,CongNhan.Phai,CongNhan.NgaySinh
from CongNhan,SanPham,ThanhPham
where CongNhan.MACN=ThanhPham.MACN and 
      ThanhPham.MaSP=SanPham.MaSP and
	  SanPham.TenSP=N'Bình gốm nhỏ' and SanPham.TenSP=N'Nồi đất'

/*select A.MACN,Ho +' '+Ten as HoTen,MaTSX
from CongNhan A,ThanhPham B,SanPham C
where A.MACN=B.MACN and B.MaSP=C.MaSP and TenSP=N'Nồi đất'
		and	 a.MACN in(select D.MACN
						from ThanhPham D, SanPham E
						where	 D.MaSP=E.MaSP and	 TenSP=N'Bình gốm nhỏ'*/
--5) Thống kê Số luợng công nhân theo từng tổ sản xuất.
select TenTSX, count(CongNhan.MACN) as SoLuongCongNhan --count là hàm đếm tổng số lượng dữ liệu trong các ô
from CongNhan,ToSanXuat
where CongNhan.MaTSX = ToSanXuat.MaTSX
group by ToSanXuat.TenTSX

/*select	A.MaTSX,TenTSX,count(MACN), as SoLuongCN
from ToSanXuat A,CongNhan B
where A.MaTSX=B.MaTSX
group by a.MaTSX,TenTSX*/

--6) Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được (Ho, Ten, TenSP, TongSLThanhPham, TongThanhTien).
select Ho ,Ten,TenSP,sum(ThanhPham.SoLuong) as TongSLThanhPham, sum(ThanhPham.SoLuong) * SanPham.TienCong as TongThanhTien 
from CongNhan,SanPham,ThanhPham  --SUM trả về tổng của một tập hợp
where SanPham.MaSP = ThanhPham.MaSP and	 CongNhan.MACN = ThanhPham.MACN
group by CongNhan.MACN,Ho,Ten,TenSP,SanPham.TienCong

--7) Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007
select sum(ThanhPham.SoLuong * SanPham.TienCong) as TongSoTienCong_1_2007
from CongNhan,SanPham,ThanhPham
where  SanPham.MaSP = ThanhPham.MaSP and
	   CongNhan.MACN = ThanhPham.MACN and
	   month(ThanhPham.Ngay) = 1 and YEAR(Ngay) =2007
	   
--8) Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2/2007
select
from ThanhPham A,SanPham B
where A.MaSP=B.MaSP and	 MONTH(Ngay) =2 and YEAR(Ngay)= 2007
group by  A.MaSP,TenSP
having sum(SoLuong)>=all (select SUM(SoLuong)
							from ThanhPham C
							where	MONTH(Ngay)=2 and YEAR(ngay)=2007
							group by C.MaSP)
--9) Cho biết công nhân sản xuất được nhiều ‘Chén’ nhất.
select top(1) CongNhan.Ho + ' ' + CongNhan.Ten as HoVaTen
from CongNhan,SanPham,ThanhPham
where CongNhan.MACN = ThanhPham.MACN and
	  ThanhPham.MaSP = SanPham.MaSP and
	  SanPham.TenSP =N'Chén'
--10) Tiền công tháng 2/2006 của công nhân viên có mã số ‘CN002’
select CongNhan.MACN,CongNhan.Ho,CongNhan.Ten,SanPham.TienCong * ThanhPham.SoLuong as TienCong
from CongNhan,ThanhPham,SanPham
where CongNhan.MACN = ThanhPham.MACN and
	  ThanhPham.MaSP = SanPham.MaSP and
	  month(ThanhPham.Ngay)='2' and CongNhan.MACN='CN002'
--11) Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên.
select	a.MACN,Ho,Ten,COUNT(distinct MaSP) 
from CongNhan a, ThanhPham b
where a.MACN=b.MACN
group by a.MACN,Ho,Ten
having COUNT(distinct MaSP)>=3
--12) Cập nhật giá tiền công của các loại bình gốm thêm 1000.
update SanPham set	TienCong = TienCong + 1000
where TenSP like  N'Bình gốm%'
select * from  SanPham
--13) Thêm bộ <’CN006’, ‘Lê Thị’, ‘Lan’, ‘Nữ’,’TS02’ > vào bảng CongNhan.
insert into CongNhan(MACN,Ho,Ten,Phai,MaTSX) values ('CN006', N'Lê Thị', N'Lan', N'Nữ','TS02')
select * from CongNhan
delete from CongNhan where MACN='CN006'

--III. Thủ tục & Hàm
--A. Viết các hàm sau:
--a. Tính tổng số công nhân của một tổ sản xuất cho trước
create function ufn_TongSoCongNhan(@MACN char(5))
return int
As	
Begin 
	declare @Tong
	select @Tong = count(CongNhan.MACN)
	from CongNhan
	where MACN = @MACN 
	
	end
--b. Tính tổng sản lượng sản xuất trong một tháng của một loại sản phẩm cho trước.
--c. Tính tổng tiền công tháng của một công nhân cho trước.
--d. Tính tổng thu nhập trong năm của một tổ sản xuất cho trước.
--e. Tính tổng sản lượng sản xuất của một loại sản phẩm trong một khoảng thời gian cho trước.
--B. Viết các thủ tục sau:
--a. In danh sách các công nhân của một tổ sản xuất cho trước.
--b. In bảng chấm công sản xuất trong tháng của một công nhân cho trước
--(bao gồm Tên sản phẩm, đơn vị tính, số lượng sản xuất trong tháng,  đơn giá, thành tiền).
