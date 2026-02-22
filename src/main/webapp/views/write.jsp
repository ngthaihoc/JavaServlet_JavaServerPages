<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-crud.css">

        <div class="crud-container">
            <h1 class="crud-header">VIẾT BÀI MỚI</h1>

            <c:if test="${not empty message}">
                <div class="success-message">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <div class="crud-form-container">
                <form action="${pageContext.request.contextPath}/write" method="post" enctype="multipart/form-data">
                    <div class="crud-form-group">
                        <label for="writeTitle">Tiêu đề:</label>
                        <input type="text" id="writeTitle" name="title" required placeholder="Nhập tiêu đề bài viết...">
                    </div>

                    <div class="crud-form-group">
                        <label for="categoryId">Danh mục:</label>
                        <select id="categoryId" name="categoryId" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="cat" items="${globalCategories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="crud-form-group">
                        <label for="imageFile">Ảnh bìa:</label>
                        <input type="file" id="imageFile" name="imageFile" accept="image/*">
                    </div>

                    <div class="crud-form-group">
                        <label for="writeContentTextarea">Nội dung:</label>
                        <textarea id="writeContentTextarea" name="content" required
                            placeholder="Nhập nội dung bài viết..."></textarea>
                    </div>

                    <div class="crud-button-group">
                        <button type="submit" name="action" value="draft" class="btn-secondary">Lưu nháp</button>
                        <button type="submit" name="action" value="publish" class="btn-success">Đăng bài</button>
                    </div>
                </form>
            </div>
        </div>