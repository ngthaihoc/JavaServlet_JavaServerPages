<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Wellum</title>
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap"
                    rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/layout.css">
            </head>

            <body>
                <header id="layoutNavbar" class="navbar navbar-expand-lg static-top shadow-sm">
                    <div class="container">
                        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                            WELLUM
                        </a>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-lg-center">
                                <li class="nav-item">
                                    <a class="nav-link text-uppercase fw-heavy"
                                        href="${pageContext.request.contextPath}/home">TRANG CHỦ</a>
                                </li>

                                <c:forEach var="cat" items="${globalCategories}" varStatus="loop">
                                    <c:if test="${loop.index < 3}">
                                        <li class="nav-item">
                                            <a class="nav-link text-uppercase"
                                                href="${pageContext.request.contextPath}/category/${cat.id}">
                                                ${cat.name}
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>

                                <c:if test="${globalCategories.size() > 3}">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle text-uppercase" href="#" role="button"
                                            data-bs-toggle="dropdown">
                                            XEM THÊM
                                        </a>
                                        <ul class="dropdown-menu shadow border-0">
                                            <c:forEach var="cat" items="${globalCategories}" varStatus="loop">
                                                <c:if test="${loop.index >= 3}">
                                                    <li>
                                                        <a class="dropdown-item"
                                                            href="${pageContext.request.contextPath}/category/${cat.id}">
                                                            ${cat.name}
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:if>
                            </ul>

                            <div class="d-flex align-items-center gap-2">
                                <form class="d-flex position-relative" action="${pageContext.request.contextPath}/home"
                                    method="get">
                                    <i
                                        class="bi bi-search position-absolute top-50 translate-middle-y ms-3 text-white"></i>
                                    <input
                                        class="form-control form-control-sm rounded-pill ps-5 bg-dark border-secondary text-white"
                                        type="search" name="q" placeholder="Tìm kiếm..." style="width: 150px;">
                                </form>

                                <a href="${pageContext.request.contextPath}/write"
                                    class="btn btn-sm btn-outline-success rounded-pill fw-heavy px-4">
                                    VIẾT BÀI
                                </a>

                                <c:if test="${not empty sessionScope.user and sessionScope.role == 'admin'}">
                                    <a href="${pageContext.request.contextPath}/admin"
                                        class="btn btn-sm btn-link text-warning text-decoration-none fw-heavy">
                                        QUẢN TRỊ
                                    </a>
                                </c:if>

                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <div class="dropdown">
                                            <a class="btn btn-sm btn-dark rounded-pill d-flex align-items-center gap-2 px-3 border-secondary"
                                                href="#" role="button" data-bs-toggle="dropdown">
                                                <i class="bi bi-person-circle fs-5 text-white"></i>
                                                <span class="fw-bold text-white">${sessionScope.username}</span>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                                <li><a class="dropdown-item text-danger fw-bold"
                                                        href="${pageContext.request.contextPath}/auth?action=logout">
                                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                                    </a></li>
                                            </ul>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login"
                                            class="btn btn-sm btn-dark rounded-pill px-3 border-secondary fw-bold text-white">
                                            Đăng nhập
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </header>

                <main>
                    <jsp:include page="${view}" />
                </main>

                <footer role="contentinfo">
                    <div class="container">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <h3 class="mb-4">Công ty cổ phần HocNguyen</h3>
                                <p class="mb-2">Trực thuộc <strong>Công ty Cổ Phần Wellum Việt Nam</strong></p>
                                <p>Chịu trách nhiệm nội dung: <strong>Nguyễn Thái Học</strong></p>
                            </div>
                            <div class="col-md-3">
                                <h3 class="mb-4">Liên hệ</h3>
                                <p class="mb-2">Email: <a
                                        href="mailto:ngthaihoc.vn@gmail.com">ngthaihoc.vn@gmail.com</a></p>
                                <p>Hotline: <a href="tel:0963672903">0963672903</a></p>
                            </div>
                            <div class="col-md-3 text-md-end">
                                <h3 class="mb-4">Bản quyền</h3>
                                <p class="mb-2">© 2025 <strong>WELLUM</strong></p>
                                <p>Phát triển bởi <strong>Welly Nguyen</strong></p>
                            </div>
                        </div>
                    </div>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>