<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-crud.css">

            <c:set var="path" value="${pageContext.request.contextPath}/admin/users"></c:set>

            <div class="crud-container">

                <div class="user-info" style="text-align: right; margin-bottom: 20px; color: #666;">
                    Xin chào, <strong>${sessionScope.username}</strong>
                    (${sessionScope.role})
                    | <a href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
                </div>

                <nav id="adminNav" class="adminNav">
                    <a href="${pageContext.request.contextPath}/admin/news" class="adminNavItem">QUẢN LÝ BÀI VIẾT</a>
                    <c:if test="${sessionScope.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admin/categories" class="adminNavItem">QUẢN LÝ LOẠI
                            BÀI VIẾT</a>
                        <a href="${pageContext.request.contextPath}/admin/users" class="adminNavItem active">QUẢN LÝ
                            NGƯỜI DÙNG</a>
                    </c:if>
                </nav>

                <h1 class="crud-header">QUẢN LÝ NGƯỜI DÙNG</h1>

                <c:if test="${not empty message}">
                    <div class="${message.contains('thành công') ? 'success-message' : 'error-message'}">
                        ${message}
                    </div>
                </c:if>

                <div class="crud-form-container">
                    <form method="post">
                        <div style="display: flex; gap: 20px;">
                            <div style="flex: 1;">
                                <div class="crud-form-group">
                                    <label for="id">Tên Đăng Nhập (ID):</label>
                                    <input type="text" name="id" value="${item.id}" required <c:if
                                        test="${not empty item.id}">readonly style="background-color: #f8f9fa;"</c:if>>
                                </div>
                            </div>
                            <div style="flex: 1;">
                                <div class="crud-form-group">
                                    <label for="password">Mật Khẩu:</label>
                                    <input type="text" name="password" value="${item.password}" required>
                                </div>
                            </div>
                        </div>

                        <div style="display: flex; gap: 20px;">
                            <div style="flex: 1;">
                                <div class="crud-form-group">
                                    <label for="fullname">Họ và Tên:</label>
                                    <input type="text" name="fullname" value="${item.fullname}" required>
                                </div>
                            </div>
                            <div style="flex: 1;">
                                <div class="crud-form-group">
                                    <label for="birthday">Ngày Sinh:</label>
                                    <c:choose>
                                        <c:when test="${not empty item.birthday}">
                                            <input type="date" name="birthday"
                                                value="<fmt:formatDate value='${item.birthday}' pattern='yyyy-MM-dd'/>">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="date" name="birthday" value="">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div style="display: flex; gap: 20px;">
                            <div style="flex: 1;">
                                <div class="crud-form-group">
                                    <label for="gender">Giới Tính:</label>
                                    <select name="gender">
                                        <option value="true" ${item.gender ? 'selected' : '' }>Nam</option>
                                        <option value="false" ${!item.gender ? 'selected' : '' }>Nữ</option>
                                    </select>
                                </div>
                            </div>
                            <div style="flex: 1;">
                                <div class="crud-form-group">
                                    <label for="mobile">Số Điện Thoại:</label>
                                    <input type="text" name="mobile" value="${item.mobile}">
                                </div>
                            </div>
                        </div>

                        <div style="display: flex; gap: 20px;">
                            <div style="flex: 1;">
                                <div class="crud-form-group">
                                    <label for="email">Email:</label>
                                    <input type="email" name="email" value="${item.email}" required>
                                </div>
                            </div>
                            <div style="flex: 1;">
                                <div class="crud-form-group">
                                    <label for="role">Vai Trò:</label>
                                    <select name="role">
                                        <option value="true" ${item.role ? 'selected' : '' }>Admin</option>
                                        <option value="false" ${!item.role ? 'selected' : '' }>User (Reporter)</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="crud-button-group">
                            <button formaction="${path}/create" class="btn-create">Thêm Mới</button>
                            <button formaction="${path}/update" class="btn-update">Cập Nhật</button>
                            <button formaction="${path}/delete" class="btn-delete"
                                onclick="return confirm('Bạn chắc chắn muốn xóa?')">Xóa</button>
                            <button type="button" class="btn-reset" onclick="window.location.href='${path}/reset'">Làm
                                Mới</button>
                        </div>
                    </form>
                </div>

                <hr style="margin: 40px 0; border: 0; border-top: 1px solid #eee;">

                <div class="crud-table-container" style="overflow-x: auto;">
                    <h2 style="text-align: center; margin-bottom: 25px; color: #2d3748;">DANH SÁCH NGƯỜI DÙNG</h2>
                    <table class="crud-table">
                        <thead>
                            <tr>
                                <th width="50" class="text-center">#</th>
                                <th>ID</th>
                                <th>Họ Tên</th>
                                <th>Email</th>
                                <th width="100" class="text-center">Vai Trò</th>
                                <th width="100" class="text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${list}" varStatus="vs">
                                <tr>
                                    <td class="text-center">${vs.count}</td>
                                    <td><strong>${u.id}</strong></td>
                                    <td>${u.fullname}</td>
                                    <td>${u.email}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${u.role}">
                                                <span style="color: #e53e3e; font-weight: 700;">Admin</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #3182ce;">User</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="action-links">
                                            <a href="${path}/edit/${u.id}" class="btn-edit">Sửa</a>
                                            <a href="${path}/delete?id=${u.id}" class="btn-delete-small"
                                                onclick="return confirm('Bạn chắc chắn muốn xóa người dùng [${u.id}]?')">Xóa</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>