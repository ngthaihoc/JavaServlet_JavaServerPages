<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-crud.css">

        <c:set var="path" value="${pageContext.request.contextPath}/admin/categories"></c:set>

        <div class="crud-container">

            <div class="user-info" style="text-align: right; margin-bottom: 20px; color: #666;">
                Xin chào, <strong>${sessionScope.username}</strong>
                (${sessionScope.role})
                | <a href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
            </div>

            <nav id="adminNav" class="adminNav">
                <a href="${pageContext.request.contextPath}/admin/news" class="adminNavItem">QUẢN LÝ BÀI VIẾT</a>
                <c:if test="${sessionScope.role == 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/categories" class="adminNavItem active">QUẢN LÝ
                        LOẠI BÀI VIẾT</a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="adminNavItem">QUẢN LÝ NGƯỜI DÙNG</a>
                </c:if>
            </nav>
            <h1 class="crud-header">QUẢN LÝ DANH MỤC</h1>

            <%-- Hiển thị thông báo --%>
                <c:if test="${not empty message}">
                    <div class="${message.contains('thành công') ? 'success-message' : 'error-message'}">
                        ${message}
                    </div>
                </c:if>

                <div class="crud-form-container">
                    <form method="post">
                        <div class="crud-form-group">
                            <label for="id">ID (Để trống để tự tạo):</label>
                            <input type="text" name="id" value="${item.id}" placeholder="Auto-generated if empty" <c:if
                                test="${not empty item.id}">readonly style="background-color: #f8f9fa;"</c:if>>
                        </div>

                        <div class="crud-form-group">
                            <label for="name">Tên Loại Bài Viết:</label>
                            <input required type="text" name="name" value="${item.name}"
                                placeholder="Nhập tên danh mục">
                        </div>

                        <div class="crud-button-group">
                            <button formaction="${path}/create" class="btn-create">Thêm Mới</button>
                            <button formaction="${path}/update" class="btn-update">Cập Nhật</button>
                            <button formaction="${path}/delete" class="btn-delete"
                                onclick="return confirm('Bạn chắc chắn muốn xóa?')">Xóa</button>
                            <button formaction="${path}/reset" type="button" class="btn-reset"
                                onclick="window.location.href='${path}/reset'">Làm Mới</button>
                        </div>
                    </form>
                </div>

                <hr style="margin: 40px 0; border: 0; border-top: 1px solid #eee;">

                <div class="crud-table-container">
                    <h2 style="text-align: center; margin-bottom: 25px; color: #2d3748;">DANH SÁCH DANH MỤC</h2>
                    <table class="crud-table">
                        <thead>
                            <tr>
                                <th width="50" class="text-center">#</th>
                                <th width="150">ID</th>
                                <th>Tên Loại</th>
                                <th width="100" class="text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${list}" varStatus="vs">
                                <tr>
                                    <td class="text-center">${vs.count}</td>
                                    <td><strong>${c.id}</strong></td>
                                    <td>${c.name}</td>
                                    <td class="text-center">
                                        <div class="action-links">
                                            <a href="${path}/edit/${c.id}" class="btn-edit">Sửa</a>
                                            <a href="${path}/delete?id=${c.id}" class="btn-delete-small"
                                                onclick="return confirm('Bạn chắc chắn muốn xóa loại bài viết [${c.id}]?')">Xóa</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
        </div>