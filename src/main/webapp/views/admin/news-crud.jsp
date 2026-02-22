<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-crud.css">

            <%-- ... phần CSS giữ nguyên ... --%>

                <c:set var="path" value="${pageContext.request.contextPath}/admin/news"></c:set>

                <div class="crud-container">

                    <div class="user-info" style="text-align: right; margin-bottom: 20px; color: #666;">
                        Xin chào, <strong>${sessionScope.username}</strong>
                        (${sessionScope.role})
                        | <a href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
                    </div>

                    <nav id="adminNav" class="adminNav">
                        <a href="${pageContext.request.contextPath}/admin/news" class="adminNavItem active">QUẢN LÝ BÀI
                            VIẾT</a>
                        <c:if test="${sessionScope.role == 'admin'}">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="adminNavItem">QUẢN LÝ
                                LOẠI BÀI VIẾT</a>
                            <a href="${pageContext.request.contextPath}/admin/users" class="adminNavItem">QUẢN LÝ NGƯỜI
                                DÙNG</a>
                        </c:if>
                    </nav>
                    <h1 class="crud-header">QUẢN LÝ BÀI VIẾT</h1>

                    <%-- Hiển thị thông báo --%>
                        <c:if test="${not empty message}">
                            <div class="success-message">${message}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="error-message">${error}</div>
                        </c:if>

                        <%-- 2 BUTTON RIÊNG BIỆT --%>
                            <div class="action-button-group">
                                <button class="btn-primary" onclick="showForm()" id="showFormBtn">
                                    Thêm Bài Viết Mới
                                </button>
                                <button class="btn-secondary" onclick="hideForm()" id="hideFormBtn">
                                    Ẩn Form
                                </button>
                                <button class="btn-info" onclick="window.location.href='${path}/reset'">
                                    Làm Mới
                                </button>
                            </div>

                            <%-- FORM THÊM/SỬA BÀI VIẾT --%>
                                <div id="newsForm" class="crud-form-container"
                                    style="display: ${editMode ? 'block' : 'none'};">
                                    <form method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="id" value="${item.id}">
                                        <input type="hidden" name="viewCount" value="${item.viewCount}">

                                        <%-- Thêm author field nếu cần --%>
                                            <input type="hidden" name="author"
                                                value="${item.author != null ? item.author : sessionScope.user.id}">

                                            <div class="crud-form-group">
                                                <label for="title">Tiêu đề:</label>
                                                <input type="text" id="title" name="title" value="${item.title}"
                                                    required placeholder="Nhập tiêu đề bài viết">
                                            </div>

                                            <div class="crud-form-group">
                                                <label for="content">Nội dung:</label>
                                                <textarea id="content" name="content" required
                                                    placeholder="Nhập nội dung bài viết">${item.content}</textarea>
                                            </div>

                                            <div class="crud-form-group">
                                                <label for="imageFile">Tải lên ảnh:</label>
                                                <input type="file" id="imageFile" name="imageFile" accept="image/*">

                                                <%-- Hiển thị ảnh hiện tại nếu có --%>
                                                    <c:if test="${not empty item.image}">
                                                        <div class="image-preview">
                                                            <p style="margin-bottom: 5px; color: #666;">Ảnh hiện tại:
                                                            </p>
                                                            <img src="${pageContext.request.contextPath}${item.image}"
                                                                alt="Article Image" style="max-width: 200px;">
                                                            <input type="hidden" name="image" value="${item.image}">
                                                        </div>
                                                    </c:if>
                                                    <%-- Nếu không có ảnh, vẫn giữ input text cho đường dẫn ảnh --%>
                                                        <c:if test="${empty item.image}">
                                                            <input type="text" name="image" value="${item.image}"
                                                                placeholder="/assets/media/image-path.jpg" class="mt-2">
                                                        </c:if>
                                            </div>

                                            <div class="crud-form-group">
                                                <label for="categoryId">Loại Bài Viết:</label>
                                                <select id="categoryId" name="categoryId" required>
                                                    <option value="">-- Chọn loại bài viết --</option>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <option value="${cat.id}" ${item.categoryId==cat.id ? 'selected'
                                                            : '' }>
                                                            ${cat.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="crud-form-group">
                                                <div class="checkbox-group">
                                                    <input type="checkbox" id="home" name="home" ${item.home ? 'checked'
                                                        : '' }>
                                                    <label for="home"
                                                        style="display: inline; font-weight: normal; margin: 0;">
                                                        Hiển thị trên trang chủ
                                                    </label>
                                                </div>
                                            </div>

                                            <div class="crud-button-group">
                                                <c:choose>
                                                    <c:when test="${empty item.id}">
                                                        <button type="submit" formaction="${path}/create"
                                                            class="btn-success">
                                                            Thêm Mới
                                                        </button>
                                                        <button type="button" class="btn-danger" onclick="hideForm()">
                                                            Hủy
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="submit" formaction="${path}/update"
                                                            class="btn-success">
                                                            Cập Nhật
                                                        </button>
                                                        <button type="button" class="btn-danger"
                                                            onclick="window.location.href='${path}'">
                                                            Hủy
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                    </form>
                                </div>

                                <hr style="margin: 40px 0; border: 0; border-top: 1px solid #eee;">

                                <%-- BẢNG DANH SÁCH BÀI VIẾT --%>
                                    <div class="crud-table-container">
                                        <h2
                                            style="text-align: center; margin-bottom: 25px; color: #2d3748; font-size: 1.5rem;">
                                            DANH SÁCH BÀI VIẾT</h2>
                                        <table class="crud-table">
                                            <thead>
                                                <tr>
                                                    <th width="60" class="text-center">ID</th>
                                                    <th>Tiêu đề bài viết</th>
                                                    <th width="120">Tác giả</th>
                                                    <th width="120">Loại bài</th>
                                                    <th width="120" class="text-center">Ngày đăng</th>
                                                    <th width="60" class="text-center">Lượt xem</th>
                                                    <th width="60" class="text-center">Trang chủ</th>
                                                    <th width="120" class="text-center">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="news" items="${list}">
                                                    <tr>
                                                        <td class="text-center"><strong>${news.id}</strong></td>
                                                        <td class="crud-title" title="${news.title}">
                                                            <a href="${pageContext.request.contextPath}/articles/${news.id}"
                                                                style="color: #007bff; text-decoration: none;"
                                                                target="_blank">
                                                                ${news.title}
                                                            </a>
                                                        </td>
                                                        <td>${news.author}</td>
                                                        <td>
                                                            <c:forEach var="cat" items="${categories}">
                                                                <c:if test="${news.categoryId == cat.id}">
                                                                    ${cat.name}
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td class="text-center">
                                                            <fmt:formatDate value="${news.postedDate}"
                                                                pattern="dd/MM/yyyy" />
                                                        </td>
                                                        <td class="text-center">${news.viewCount}</td>
                                                        <td class="text-center">
                                                            <c:choose>
                                                                <c:when test="${news.home}">
                                                                    <span
                                                                        style="color: #28a745; font-size: 1.2em;">●</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        style="color: #cbd5e0; font-size: 1.2em;">●</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <div class="action-links">
                                                                <a href="${path}/edit/${news.id}" class="btn-edit">
                                                                    Sửa
                                                                </a>
                                                                <a href="${path}/delete?id=${news.id}"
                                                                    class="btn-delete-small"
                                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết [${news.id}]?');">
                                                                    Xóa
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <c:if test="${empty list}">
                                                    <tr>
                                                        <td colspan="8"
                                                            style="text-align: center; color: #666; padding: 40px;">
                                                            Chưa có bài viết nào
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                </div>

                <script>
                    function showForm() {
                        document.getElementById('newsForm').style.display = 'block';
                        document.getElementById('showFormBtn').style.display = 'none';
                        document.getElementById('hideFormBtn').style.display = 'inline-block';
                    }

                    function hideForm() {
                        document.getElementById('newsForm').style.display = 'none';
                        document.getElementById('showFormBtn').style.display = 'inline-block';
                        document.getElementById('hideFormBtn').style.display = 'none';

                        // Reset form bằng cách reload trang
                        window.location.href = '${path}';
                    }

                    // Khởi tạo trạng thái ban đầu
                    document.addEventListener('DOMContentLoaded', function () {
                        const form = document.getElementById('newsForm');
                        const showBtn = document.getElementById('showFormBtn');
                        const hideBtn = document.getElementById('hideFormBtn');

                        <c:choose>
                            <c:when test="${editMode}">
                // Chế độ chỉnh sửa: hiữn form, ẩn nút "Ẩn Form", hiữn nút "Thêm"
                                form.style.display = 'block';
                                showBtn.style.display = 'none';
                                hideBtn.style.display = 'inline-block';
                            </c:when>
                            <c:otherwise>
                // Chế độ thêm mới: ẩn form, hiữn nút "Ẩn Form"
                                form.style.display = 'none';
                                showBtn.style.display = 'inline-block';
                                hideBtn.style.display = 'none';
                            </c:otherwise>
                        </c:choose>
                    });
                </script>