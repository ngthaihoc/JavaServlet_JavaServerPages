<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css?v=3">

        <div class="registerContainer">
            <div class="registerFormContainer">
                <h2 class="text-uppercase fw-bold mb-4">Đăng Ký Tài Khoản</h2>

                <form action="${pageContext.request.contextPath}/auth?action=register" method="post">
                    <div class="registerFormGroup">
                        <label for="registerUsername">Tên người dùng</label>
                        <input type="text" id="registerUsername" name="username" placeholder="Nhập tên đăng nhập"
                            required>
                    </div>
                    <div class="registerFormGroup">
                        <label for="registerEmail">Email</label>
                        <input type="email" id="registerEmail" name="email" placeholder="Nhập địa chỉ email" required>
                    </div>
                    <div class="registerFormGroup">
                        <label for="registerPassword">Mật khẩu</label>
                        <input type="password" id="registerPassword" name="password" placeholder="Nhập mật khẩu"
                            required>
                    </div>
                    <div class="registerFormGroup">
                        <label for="registerConfirmPassword">Nhập lại mật khẩu</label>
                        <input type="password" id="registerConfirmPassword" name="confirmPassword"
                            placeholder="Xác nhận lại mật khẩu" required>
                    </div>

                    <div class="registerFormGroup">
                        <label for="regSecurityCode">Mã kiểm tra: <span
                                class="fw-bold text-success">WELLUM2025</span></label>
                        <input type="text" id="regSecurityCode" name="regSecurityCode"
                            placeholder="Nhập mã kiểm tra phía trên" required>
                    </div>

                    <div class="registerFormGroup">
                        <button type="submit" class="fw-bold">ĐĂNG KÝ NGAY</button>
                    </div>
                </form>

                <div class="registerLoginLink">
                    <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="fw-bold">Đăng nhập tại
                            đây</a></p>
                </div>
            </div>
        </div>