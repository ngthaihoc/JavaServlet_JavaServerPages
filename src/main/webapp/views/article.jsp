<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <style>
                .article-container {
                    max-width: 800px;
                    margin: 40px auto;
                    padding: 20px;
                    background-color: #fff;
                    border-radius: 8px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                }

                .article-header {
                    text-align: center;
                    margin-bottom: 30px;
                }

                .article-title {
                    font-size: 2.5rem;
                    font-weight: 700;
                    color: #333;
                    margin-bottom: 15px;
                    line-height: 1.2;
                }

                .article-meta {
                    font-size: 0.95rem;
                    color: #666;
                    display: flex;
                    justify-content: center;
                    gap: 15px;
                }

                .article-meta i {
                    margin-right: 5px;
                }

                .article-image {
                    width: 100%;
                    max-height: 500px;
                    object-fit: cover;
                    border-radius: 8px;
                    margin-bottom: 30px;
                }

                .article-content {
                    font-size: 1.15rem;
                    line-height: 1.8;
                    color: #444;
                    text-align: justify;
                }

                .article-content p {
                    margin-bottom: 20px;
                }

                .return-home {
                    display: inline-block;
                    margin-top: 30px;
                    text-decoration: none;
                    color: #007bff;
                    font-weight: 600;
                    transition: color 0.3s ease;
                }

                .return-home:hover {
                    color: #0056b3;
                }
            </style>

            <div class="article-container">
                <div class="article-header">
                    <h1 class="article-title">${article.title}</h1>
                    <div class="article-meta">
                        <span>
                            <i class="bi bi-person"></i> ${article.author != null ? article.author : "Unknown"}
                        </span>
                        <span>
                            <i class="bi bi-calendar"></i>
                            <fmt:formatDate value="${article.postedDate}" pattern="dd/MM/yyyy HH:mm" />
                        </span>
                        <span>
                            <i class="bi bi-eye"></i> ${article.viewCount} views
                        </span>
                    </div>
                </div>

                <c:if test="${not empty article.image}">
                    <img src="${pageContext.request.contextPath}${article.image}" alt="${article.title}"
                        class="article-image"
                        onerror="this.src='${pageContext.request.contextPath}/assets/media/default-news.jpg'">
                </c:if>

                <div class="article-content">
                    ${article.content}
                </div>

                <a href="${pageContext.request.contextPath}/home" class="return-home">
                    <i class="bi bi-arrow-left"></i> Trở về trang chủ
                </a>
            </div>