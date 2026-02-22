# Wellum - Hệ Thống Quản Lý BLog 

Dự án Assignment môn Java Servlet - Xây dựng website sử dụng Java Servlet và JSP.

## 🚀 Công Nghệ Sử Dụng
- **Ngôn ngữ:** Java 17+
- **Công nghệ Web:** Java Servlet 4.0, JSP, JSTL
- **Cơ sở dữ liệu:** Microsoft SQL Server
- **Máy chủ:** Apache Tomcat 9.0
- **Thư viện:** JDBC, Bootstrap 5, Font Awesome/Icons

## 🛠 Hướng Dẫn Triển Khai

### 1. Chuẩn bị Cơ sở dữ liệu
- Mở **SQL Server Management Studio (SSMS)**.
- Tạo một database mới tên là `Wellum`.
- Tìm file `src/main/resources/database/java3.sql` trong dự án, copy nội dung và chạy (Execute) trong database `Wellum` để tạo bảng và dữ liệu mẫu.

### 2. Cấu hình kết nối Database
- Mở file `src/main/java/hocng/utils/XJDBC.java`.
- Chỉnh sửa biến `DBURL_WINDOW_AUTH` để phù hợp với máy của bạn:
  - Thay `LAPTOPCUAWELLY` bằng tên Server SQL của bạn (hoặc `localhost`).
  - Đảm bảo SQL Server đã bật cổng `1433` và cho phép kết nối từ xa.
  - Dự án đang sử dụng **Windows Authentication**. Nếu bạn dùng tài khoản SQL (sa), hãy thay đổi chuỗi kết nối tương ứng.

### 3. Import dự án vào Eclipse/IntelliJ
- **Eclipse:** File -> Import -> General -> Existing Projects into Workspace.
- Trỏ đến thư mục `ASM`.
- Nhấn chuột phải vào dự án -> **Properties** -> **Project Facets** -> Đảm bảo chọn **Dynamic Web Module**.
- Cấu hình **Targeted Runtimes** là Apache Tomcat 9.0.

### 4. Chạy ứng dụng
- Chuột phải vào dự án -> **Run As** -> **Run on Server**.
- Chọn **Apache Tomcat 9.0**.
- Truy cập vào địa chỉ: `http://localhost:8080/ASM/home`

## 🔑 Tài Khoản Đăng Nhập Mẫu
- **Admin:** `admin` / `123`
- **Reporter:** `Nghia` / `123` (Hoặc các tài khoản trong bảng USERS)

## 📁 Cấu Trúc Thư Mục Chính
- `src/main/java/hocng/servlet`: Chứa các Servlet xử lý điều hướng.
- `src/main/java/hocng/daoImp`: Chứa các lớp thực thi truy vấn Database.
- `src/main/webapp/views`: Chứa các file giao diện JSP.
- `src/main/webapp/assets`: Chứa CSS, Hình ảnh và JS.
