/* Học phần: cơ sở dữ liệu
   Người thực hiện: Nguyễn Khánh Linh
   MSSV:1812790
   Ngày: 09/06/2020
*/	
create database Lab6_QLy_HocVien
go 
use Lab6_QLy_HocVien
go
create table CaHoc
(Ca			tinyint primary key,
GioBatDau	Datetime,
GioKetThuc	Datetime
)
go
create table GiaoVien
(MSGV		char(4) primary key,
HoGV		nvarchar(20),
TenGV		nvarchar(10),
DienThoai	varchar(11)
)
go
create table Lop
(MaLop	char(4) primary key,
TenLop	nvarchar(30),
NgayKG	Datetime,
HocPhi	int,
Ca		tinyint references CaHoc(Ca),
SoTiet	int,
SoHV	int,
MSGV	char(4) references GiaoVien(MSGV)
)
go
create table HocVien
(MSHV		char(4) primary key,
Ho			nvarchar(20),
Ten			nvarchar(10),
NgaySinh	Datetime,
Phai		nvarchar(4),
MaLop		char(4) references Lop(MaLop)
)
go
create table HocPhi
(
SoBL	char(6) primary key,
MSHV	char(4) references HocVien(MSHV),
NgayThu Datetime,
SoTien	int,
NoiDung	nvarchar(50),
NguoiThu nvarchar(30)
)
go
-------------------
select * from CaHoc
select * from GiaoVien
select * from Lop
select * from HocVien
select * from HocPhi

go

CREATE PROC usp_ThemCaHoc
	@ca tinyint, @giobd Datetime, @giokt Datetime
As
	If exists(select * from CaHoc where Ca = @ca) --kiểm tra có trùng khóa chính (Ca) 
		print N'Đã có ca học ' +@ca+ N' trong CSDL!'
	Else
		begin
			insert into CaHoc values(@ca, @giobd, @giokt)
			print N'Thêm ca học thành công.'
		end

go
exec usp_ThemCaHoc 1,'7:30','10:45'
exec usp_ThemCaHoc 2,'13:30','16:45'
exec usp_ThemCaHoc 3,'17:30','20:45'

go
CREATE PROC usp_ThemGiaoVien
@MSGV		char(4) ,
@HoGV		nvarchar(20),
@TenGV		nvarchar(10),
@DienThoai	varchar(11)
as
	if exists(select *from GiaoVien where MSGV=@MSGV)
		print 'Da co giao vien' +@MSGV+' trong csdl'
	else
		begin
			insert into GiaoVien values(@MSGV,@HoGV,@TenGV,@DienThoai)
			print'Them giao vien thanh cong'
		end

go
exec usp_ThemGiaoVien 'G001',N'Lê Hoàng',N'Anh','858936'
exec usp_ThemGiaoVien 'G002',N'Nguyễn Ngọc',N'Lan', '845623'
exec usp_ThemGiaoVien 'G003',N'Trần Minh',N'Hùng', '823456'
exec usp_ThemGiaoVien 'G004',N'Võ Thanh',N'Trung', '841256'

go
select *from GiaoVien
go

CREATE PROC usp_ThemLopHoc
@MaLop	char(4) ,/*khoa chinh*/
@TenLop	nvarchar(30),
@NgayKG	Datetime,
@HocPhi	int,
@Ca		tinyint, /*references CaHoc(Ca),khoa ngoai bang cahoc*/
@SoTiet	int,
@SoHV	int,
@MSGV	char(4) /*references GiaoVien(MSGV)*/

as
	if exists( select *from CaHoc where @Ca=Ca)	 and exists(select *from GiaoVien where @MSGV = MSGV)
		begin
			if exists( select *from Lop where @MaLop = MaLop)
				print'da co ma lop ' +@MaLop
			else
				begin
					insert into Lop values(@MaLop,@TenLop,@NgayKG,@HocPhi,@Ca,@SoTiet,@SoHV,@MSGV)
					print 'them thanh cong'
				end
		end
	else
			if not exists(select *from CaHoc where @Ca = Ca)
				print'khong tim thay ca hoc '+convert(int ,@Ca)
			else
				print'khong tim thay ma gv '+@MSGV
			
-----nhaap lieu
go
set dateformat dmy
go
exec usp_ThemLopHoc 'A075',N'Access 2-4-6','18/12/2008', 150000,3,60,3,'G003'
exec usp_ThemLopHoc 'E114',N'Excel 3-5-7','02/01/2008', 120000,1,45,3,'G003'
exec usp_ThemLopHoc 'A115',N'Excel 2-4-6','22/01/2008', 120000,3,45,0,'G001'
exec usp_ThemLopHoc 'W123',N'Word 2-4-6','18/02/2008', 100000,3,30,1,'G001'
exec usp_ThemLopHoc 'W124',N'Word 3-5-7','01/03/2008', 100000,1,30,0,'G002'

--exec usp_ThemLopHoc 'A090',N'Access 2-4-6','18/12/2008', 150000,8,60,3,'G003'

go
select *from Lop

go
CREATE PROC usp_ThemHocVien
@MSHV		char(4), --primary key,
@Ho			nvarchar(20),
@Ten			nvarchar(10),
@NgaySinh	Datetime,
@Phai		nvarchar(4),
@MaLop		char(4)-- references Lop(MaLop)

as
	if exists(select *from Lop where @MaLop = MaLop)
		begin
				if exists(select *from HocVien where @MSHV = MSHV)
					print'da co ' +@MSHV
				else
					begin
						insert into HocVien values(@MSHV,@Ho,@Ten,@NgaySinh,@Phai,@MaLop)
						print'Them thanh cong'
					end
		end
	else
		if not exists(select *from Lop where @MaLop = MaLop)
		print 'khong co '+@MaLop+ ' trong csdl'

---nhap lieu

go
exec usp_ThemHocVien '0001',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A075'
exec usp_ThemHocVien '0002',N'Nguyễn Thị', N'Mai', '20/04/1988',N'Nữ', 'A075'
exec usp_ThemHocVien '0003',N'Lê Ngọc', N'Tuấn', '10/06/1984',N'Nam', 'A075'
exec usp_ThemHocVien '0004',N'Vương Tuấn', N'Vũ', '25/03/1979',N'Nam', 'E114'
exec usp_ThemHocVien '0005',N'Lý Ngọc', N'Hân', '01/12/1985',N'Nữ', 'E114'
exec usp_ThemHocVien '0006',N'Trần Mai', N'Linh', '04/06/1980',N'Nữ', 'E114'
exec usp_ThemHocVien '0007',N'Nguyễn Ngọc', N'Tuyết', '12/05/1986',N'Nữ', 'W123'
go
select *from HocVien

go
CREATE PROC usp_ThemHocPhi
@SoBL	char(6) ,--primary key,
@MSHV	char(4),-- references HocVien(MSHV),
@NgayThu Datetime,
@SoTien	int,
@NoiDung	nvarchar(50),
@NguoiThu nvarchar(30)

as
	if exists(select *from HocVien where @MSHV = MSHV)-- khoa ngoai
		begin
			if exists(select *from HocPhi where @SoBL = SoBL)--khoa chinh
				print 'da co '+@SoBL
			else
				begin
					insert into HocPhi values (@SoBL,@MSHV,@NgayThu,@SoTien,@NoiDung,@NguoiThu)
					print'them thanh cong'
				end
		end
	else
		if not exists(select *from HocVien where @MSHV = MSHV)-- khoa ngoai
		print'khong tim thay ' +@MSHV

--nhap lieu
go
exec usp_ThemHocPhi 'A07501','0001','16/12/2008',150000,'HP Access 2-4-6', N'Lan' 
exec usp_ThemHocPhi 'A07502','0002','16/12/2008',100000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi 'A07503','0003','18/12/2008',150000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi 'A07504','0002','15/01/2009',50000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi 'E11401','0004','02/01/2008',120000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi 'E11402','0005','02/01/2008',120000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi 'E11403','0006','02/01/2008',80000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi 'W12301','0007','18/02/2008',100000,'HP Word 2-4-6', N'Lan'


--------------------HÀM SINH MÃ & CÁCH SỬ DỤNG----------------
---1. Viết hàm sinh mã cho giáo viên mới---

------------------CÀI ĐẶT RÀNG BUỘC TOÀN VẸN----------------
/*4a) Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó 
(RBTV liên thuộc tính)*/
select *from CaHoc
create trigger tr_CaHoc1
on CaHoc for insert,update
as
	if UPDATE(GioBatDau) or UPDATE(GioKetThuc)
	begin
		if exists(select*from inserted i where i.GioKetThuc<i.GioBatDau)
			raiserror (N'Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó',15,1)
			rollback tran
	end
go	
-----thử nghiệm hoạt động của trigger tr_CaHoc_ins_upd_GioBD_GioKT----
insert into CaHoc values(4,'17:00','15:30')
--Update CaHoc set GioKetThuc = '5:45' where ca = 1

select *from Lop


/* 4b): Số học viên của 1 lớp không quá 30 và đúng bằng số học viên thuộc lớp đó. 
(RBTV do thuộc tính tổng hợp)*/
create trigger trg_Lop_ins_upd
on Lop for insert,update
AS
if Update(MaLop) or Update(SoHV)
Begin
	if exists(select * from inserted i where i.SOHV>30) 
	begin
		raiserror (N'Số học viên của một lớp không quá 30',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
	if exists (select * from inserted l 
	              where l.SOHV <> (select count(MSHV)  -----khong bang
									from HocVien 
									where HocVien.Malop = l.Malop))
	begin
		raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
End
Go
-- Thử nghiệm 
select * from Lop
Set dateformat dmy
go
insert into Lop values('P001',N'Photoshop','1/11/2018',250000,1,100,0,'G004')
update Lop set SoHV = 5 where MaLop = 'P001'

--6a) Hàm tính tổng số học phí đã thu được của một lớp khi biết mã lớp. 
create function fn_TongTien(@malop char (4)) returns int
as
	begin
		declare @tong int
		select @tong  = sum(SoTien) from HocPhi,HocVien where @malop =HocVien.MaLop and HocPhi.MSHV=HocVien.MSHV 
		return @tong
	end
--- thu nghiem ham-------
print dbo.fn_TongTien('A075')

--6b) Hàm tính tổng số học phí thu được trong một khoảng thời gian cho trước. 
create function fn_TongHocPhi(@bd datetime,@kt datetime) returns int
as
	begin
		declare @tong int
		select @tong = sum(SoTien) from HocPhi where NgayThu between @bd and @kt
		return @tong
	end
--- thu nghiem ham-------
set dateformat dmy
print dbo.fn_TongHocPhi('1/1/2008','15/1/2008')
select *from HocPhi