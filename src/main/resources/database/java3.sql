-- Tạo database
CREATE DATABASE Wellum;
GO

USE Wellum;
GO


	CREATE TABLE CATEGORIES (
		Id VARCHAR(10) PRIMARY KEY,
		Name NVARCHAR(100) NOT NULL
	);
	GO

	CREATE TABLE USERS (
		Id VARCHAR(50) PRIMARY KEY,
		Password VARCHAR(100) NOT NULL,
		Fullname NVARCHAR(100) NOT NULL,
		Birthday DATE,
		Gender BIT, -- 1: Nam, 0: Nữ
		Mobile VARCHAR(15),	
		Email VARCHAR(100),
		Role BIT -- 1: Quản trị, 0: Phóng viên
	);
	GO

	CREATE TABLE NEWS (
		Id VARCHAR(10) PRIMARY KEY,
		Title NVARCHAR(255) NOT NULL,
		Content NTEXT,
		Image VARCHAR(255),
		PostedDate DATETIME DEFAULT GETDATE(),
		Author VARCHAR(50) NOT NULL,
		ViewCount INT DEFAULT 0,
		CategoryId VARCHAR(10) NOT NULL,
		Home BIT DEFAULT 0, -- 1: Hiển thị trang chủ, 0: Không hiển thị
		FOREIGN KEY (Author) REFERENCES USERS(Id),
		FOREIGN KEY (CategoryId) REFERENCES CATEGORIES(Id)
	);
	GO

	CREATE TABLE NEWSLETTERS (
		Email VARCHAR(100) PRIMARY KEY,
		Enabled BIT DEFAULT 1 -- 1: Còn hiệu lực, 0: Không hiệu lực
	);
	GO

	-- Chèn dữ liệu mẫu cho bảng CATEGORIES
	INSERT INTO CATEGORIES (Id, Name) VALUES
	('CAT001', N'Thời sự'),
	('CAT002', N'Kinh tế'),
	('CAT003', N'Văn hóa'),
	('CAT004', N'Giải trí'),
	('CAT005', N'Thể thao');
	GO

	-- Chèn dữ liệu mẫu cho bảng USERS
	INSERT INTO USERS (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES
	('admin', '123456', N'Quản Trị Viên', '1990-01-01', 1, '0912345678', 'admin@abcnews.com', 1),
	('pv001', '123456', N'Nguyễn Văn A', '1992-05-15', 1, '0912345679', 'pva@abcnews.com', 0),
	('pv002', '123456', N'Trần Thị B', '1993-08-20', 0, '0912345680', 'ttb@abcnews.com', 0),
	('pv003', '123456', N'Lê Văn C', '1991-03-10', 1, '0912345681', 'lvc@abcnews.com', 0);
	GO

	-- Chèn dữ liệu mẫu cho bảng NEWS
	INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
	('NEW001', N'Tin thời sự số 1', N'Nội dung tin thời sự số 1...', 'images/news1.jpg', GETDATE(), 'pv001', 150, 'CAT001', 1),
	('NEW002', N'Tin kinh tế số 1', N'Nội dung tin kinh tế số 1...', 'images/news2.jpg', GETDATE(), 'pv002', 89, 'CAT002', 1),
	('NEW003', N'Tin văn hóa số 1', N'Nội dung tin văn hóa số 1...', 'images/news3.jpg', GETDATE(), 'pv001', 45, 'CAT003', 0),
	('NEW004', N'Tin giải trí số 1', N'Nội dung tin giải trí số 1...', 'images/news4.jpg', GETDATE(), 'pv003', 120, 'CAT004', 1),
	('NEW005', N'Tin thể thao số 1', N'Nội dung tin thể thao số 1...', 'images/news5.jpg', GETDATE(), 'pv002', 200, 'CAT005', 1),
	('NEW006', N'Tin thời sự số 2', N'Nội dung tin thời sự số 2...', 'images/news6.jpg', GETDATE(), 'pv001', 75, 'CAT001', 0),
	('NEW007', N'Tin kinh tế số 2', N'Nội dung tin kinh tế số 2...', 'images/news7.jpg', GETDATE(), 'pv003', 95, 'CAT002', 1);
	GO

	-- Chèn dữ liệu mẫu cho bảng NEWSLETTERS
	INSERT INTO NEWSLETTERS (Email, Enabled) VALUES
	('reader1@gmail.com', 1),
	('reader2@yahoo.com', 1),
	('reader3@hotmail.com', 1);
	GO

-- Tạo các index để tối ưu hiệu suất truy vấn
CREATE INDEX IX_NEWS_CategoryId ON NEWS(CategoryId);
CREATE INDEX IX_NEWS_Author ON NEWS(Author);
CREATE INDEX IX_NEWS_PostedDate ON NEWS(PostedDate DESC);
CREATE INDEX IX_NEWS_ViewCount ON NEWS(ViewCount DESC);
CREATE INDEX IX_NEWS_Home ON NEWS(Home);
GO

-- Tạo stored procedure để lấy tin hot nhất
CREATE PROCEDURE sp_GetHotNews
    @TopCount INT = 5
AS
BEGIN
    SELECT TOP(@TopCount) * 
    FROM NEWS 
    ORDER BY ViewCount DESC;
END;
GO

-- Tạo stored procedure để lấy tin mới nhất
CREATE PROCEDURE sp_GetLatestNews
    @TopCount INT = 5
AS
BEGIN
    SELECT TOP(@TopCount) * 
    FROM NEWS 
    ORDER BY PostedDate DESC;
END;
GO

-- Tạo stored procedure để tăng lượt xem
CREATE PROCEDURE sp_IncreaseViewCount
    @NewsId VARCHAR(10)
AS
BEGIN
    UPDATE NEWS 
    SET ViewCount = ViewCount + 1 
    WHERE Id = @NewsId;
END;
GO

-- Tạo stored procedure để lấy tin theo loại
CREATE PROCEDURE sp_GetNewsByCategory
    @CategoryId VARCHAR(10)
AS
BEGIN
    SELECT * 
    FROM NEWS 
    WHERE CategoryId = @CategoryId 
    ORDER BY PostedDate DESC;
END;
GO

-- Tạo stored procedure để lấy tin trang chủ
CREATE PROCEDURE sp_GetHomeNews
AS
BEGIN
    SELECT * 
    FROM NEWS 
    WHERE Home = 1 s
    ORDER BY PostedDate DESC;
END;
GO

-- Tạo view để hiển thị thông tin tin tức đầy đủ
CREATE VIEW vw_NewsDetails AS
SELECT 
    n.Id,
    n.Title,
    n.Content,
    n.Image,
    n.PostedDate,
    n.Author,
    u.Fullname AS AuthorName,
    n.ViewCount,
    n.CategoryId,
    c.Name AS CategoryName,
    n.Home
FROM NEWS n
INNER JOIN USERS u ON n.Author = u.Id
INNER JOIN CATEGORIES c ON n.CategoryId = c.Id;
GO

select * from CATEGORIES
select * from NEWS
select * from NEWSLETTERS
select * from USERS

DELETE NEWS WHERE Id = 'a0ecb8d5'
