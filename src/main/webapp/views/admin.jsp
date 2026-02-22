<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">

<div class="adminContainer">
    <%-- Hiển thị thông tin user --%>
    <div class="user-info" style="text-align: right; margin-bottom: 20px; color: #666;">
        Xin chào, <strong>${sessionScope.username}</strong> 
        (${sessionScope.role}) 
        | <a href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
    </div>

    <%-- Thanh điều hướng của trang Admin --%>
    <nav id="adminNav" class="adminNav">
<div class="adminNavItem" onclick="window.location.href='${pageContext.request.contextPath}/admin/news'">QUẢN LÝ BÀI VIẾT</div>
        
        <%-- Chỉ hiển thị với admin --%>
        <c:if test="${sessionScope.role == 'admin'}">
           <div class="adminNavItem" onclick="window.location.href='${pageContext.request.contextPath}/admin/categories'">
                 QUẢN LÝ LOẠI BÀI VIẾT	
            </div>
            <div class="adminNavItem" onclick="showSection('adminQuanLyNguoiDung', this)">QUẢN LÝ NGƯỜI DÙNG</div>
            <div class="adminNavItem" onclick="showSection('adminQuanLyNewsletter', this)">QUẢN LÝ NEWSLETTER</div>
        </c:if>
    </nav>

    
            
            <%-- Nội dung quản lý bài viết --%>
            <table class="adminDataTable">
                <!-- ... existing table content ... -->
            </table>
        </div>
    </div>


    <%-- Các mục chỉ dành cho admin --%>
    <c:if test="${sessionScope.role == 'admin'}">
        <%-- Mục 2: Quản lý loại bài viết --%>
        <div id="adminQuanLyLoaiBaiViet" class="adminContentSection" style="display:none;">
            <div class="adminContentCard">
                <h2 class="adminSectionTitle">QUẢN LÝ LOẠI BÀI VIẾT</h2>
                <p>Chức năng quản lý loại bài viết (chỉ dành cho Admin).</p>
            </div>
        </div>
        
        <%-- Mục 3: Quản lý người dùng --%>
        <div id="adminQuanLyNguoiDung" class="adminContentSection" style="display:none;">
            <div class="adminContentCard">
                <h2 class="adminSectionTitle">QUẢN LÝ NGƯỜI DÙNG</h2>
                <p>Chức năng quản lý người dùng (chỉ dành cho Admin).</p>
            </div>
        </div>
        
        <%-- Mục 4: Quản lý Newsletter --%>
        <div id="adminQuanLyNewsletter" class="adminContentSection" style="display:none;">
            <div class="adminContentCard">
                <h2 class="adminSectionTitle">QUẢN LÝ NEWSLETTER</h2>
                <p>Chức năng quản lý newsletter (chỉ dành cho Admin).</p>
            </div>
        </div>
    </c:if>
</div>

<script>
    function showSection(sectionId, element) {
        // Ẩn tất cả các section
        document.querySelectorAll('.adminContentSection').forEach(section => {
            section.style.display = 'none';
        });
        // Hiển thị section được chọn
        const section = document.getElementById(sectionId);
        if (section) {
            section.style.display = 'block';
        }

        // Xóa class 'active' khỏi tất cả các tab
        document.querySelectorAll('.adminNavItem').forEach(item => {
            item.classList.remove('active');
        });
        // Thêm class 'active' vào tab được click
        element.classList.add('active');
    }

    function toggleForm(formId) {
        const form = document.getElementById(formId);
        if (form) {
            form.style.display = (form.style.display === 'block') ? 'none' : 'block';
        }
    }

    // Ẩn các tab không có quyền truy cập khi trang load
    document.addEventListener('DOMContentLoaded', function() {
        <c:if test="${sessionScope.role != 'admin'}">
            // Ẩn các section admin nếu không phải admin
            document.getElementById('adminQuanLyLoaiBaiViet').style.display = 'none';
            document.getElementById('adminQuanLyNguoiDung').style.display = 'none';
            document.getElementById('adminQuanLyNewsletter').style.display = 'none';
        </c:if>
    });
</script>