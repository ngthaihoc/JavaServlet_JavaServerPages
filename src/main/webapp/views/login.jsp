<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css?v=3">

        <div class="loginContainer">
            <div class="loginFormContainer">
                <div id="loginMainDiv">
                    <h2 class="text-uppercase fw-bold mb-4">Đăng Nhập</h2>

                    <c:if test="${not empty error}">
                        <div class="error-message">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth?action=login" method="post">
                        <div class="loginFormGroup">
                            <label for="loginId">Tên đăng nhập (ID)</label>
                            <input type="text" id="loginId" name="id" placeholder="Nhập ID của bạn" required>
                        </div>
                        <div class="loginFormGroup">
                            <label for="loginPassword">Mật khẩu</label>
                            <input type="password" id="loginPassword" name="password" placeholder="Nhập mật khẩu"
                                required>
                        </div>

                        <div class="loginFormGroup">
                            <label for="securityCode">Mã kiểm tra: <span
                                    class="fw-bold text-primary">ASM2026</span></label>
                            <input type="text" id="securityCode" name="securityCode"
                                placeholder="Nhập mã kiểm tra phía trên" required>
                        </div>

                        <div class="loginFormGroup">
                            <button type="submit" class="fw-bold">ĐĂNG NHẬP</button>
                        </div>
                    </form>

                    <div class="loginRegisterLink">
                        <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="fw-bold">Đăng
                                ký tại đây</a></p>
                    </div>
                </div>
            </div>
        </div>