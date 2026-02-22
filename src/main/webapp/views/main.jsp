<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">

            <section class="mainBanner" aria-label="Banner">
                <div id="mainBannerDiv">
                    <img src="${pageContext.request.contextPath}/assets/media/7d527980982e11f0b9538ffc36f64168.jpg"
                        alt="Banner Wellum">
                </div>
            </section>

            <section id="mainContentSection" aria-labelledby="featuredTitle">
                <div id="mainContentContainer">
                    <div id="mainDivTextContent">
                        <h2 id="featuredTitle" style="color: rgb(183, 176, 176);">
                            NỔI BẬT NHẤT TRONG TUẦN
                        </h2>
                    </div>

                    <div id="mainDivContent" role="list">
                        <article class="mainContent" role="listitem">
                            <a href="${pageContext.request.contextPath}/articles/khong-self-help-thi-ai-help">
                                <div class="mainPic">
                                    <img src="${pageContext.request.contextPath}/assets/media/noibat1.jpg"
                                        alt="Không Self-help thì Ai help?">
                                </div>
                                <div class="mainTitle">
                                    <div class="mainRealTitle">Không Self-help thì Ai help?</div>
                                </div>
                            </a>
                        </article>

                        <article class="mainContent" role="listitem">
                            <a href="${pageContext.request.contextPath}/articles/aristotle-triet-hoc-la-thuc-hanh">
                                <div class="mainPic">
                                    <img src="${pageContext.request.contextPath}/assets/media/noibat2.jpg"
                                        alt="ARISTOTLE - TRIẾT HỌC LÀ THỰC HÀNH">
                                </div>
                                <div class="mainTitle">
                                    <div class="mainRealTitle">ARISTOTLE - TRIẾT HỌC LÀ THỰC HÀNH</div>
                                </div>
                            </a>
                        </article>

                        <article class="mainContent" role="listitem">
                            <a href="${pageContext.request.contextPath}/articles/nguoi-dan-ong-manh-me-nhat-the-gioi">
                                <div class="mainPic">
                                    <img src="${pageContext.request.contextPath}/assets/media/noibat3.jpg"
                                        alt="1121 phút về 'người đàn ông mạnh mẽ nhất thế giới'">
                                </div>
                                <div class="mainTitle">
                                    <div class="mainRealTitle">Mình học được gì sau 1121 phút tìm hiểu về "người đàn
                                        ông mạnh mẽ nhất thế giới"?</div>
                                </div>
                            </a>
                        </article>

                        <article class="mainContent" role="listitem">
                            <a href="${pageContext.request.contextPath}/articles/chinh-tri-vs-kinh-te-chu-nghia-trong-thuong">
                                <div class="mainPic">
                                    <img src="${pageContext.request.contextPath}/assets/media/noibat4.jpg"
                                        alt="Chính trị vs Kinh tế: sức hấp dẫn của chủ nghĩa trọng thương">
                                </div>
                                <div class="mainTitle">
                                    <div class="mainRealTitle">Chính trị vs Kinh tế: Sức hấp dẫn bí ẩn của chủ nghĩa
                                        trọng thương</div>
                                </div>
                            </a>
                        </article>

                        <article class="mainContent" role="listitem">
                            <a href="${pageContext.request.contextPath}/articles/ban-ve-su-thua-cuoc-trong-cuoc-song">
                                <div class="mainPic">
                                    <img src="${pageContext.request.contextPath}/assets/media/noibat5.jpg"
                                        alt="Bàn về sự thua cuộc trong cuộc sống">
                                </div>
                                <div class="mainTitle">
                                    <div class="mainRealTitle">Bàn về sự thua cuộc trong cuộc sống</div>
                                </div>
                            </a>
                        </article>
                    </div>
                </div>
            </section>

            <section class="mainContentPlus" aria-label="Nội dung chính">
                <div id="mainContentPlusContainer">
                    <section id="mainContentOne" aria-labelledby="listTitle">

                        <%-- Bắt đầu lặp qua danh sách latestNews --%>
                            <c:choose>
                                <c:when test="${not empty latestNews}">
                                    <c:forEach var="news" items="${latestNews}">
                                        <article class="mainContentOne">
                                            <a class="mainCardLink" href="${pageContext.request.contextPath}/articles/${news.id}">
                                                <div class="mainContentOnePic">

                                                    <c:choose>
                                                        <c:when test="${not empty news.image}">
                                                            <img src="${pageContext.request.contextPath}${news.image}"
                                                                alt="${news.title}"
                                                                onerror="this.src='${pageContext.request.contextPath}/assets/media/default-news.jpg'">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/assets/media/default-news.jpg"
                                                                alt="${news.title}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <div class="mainContentOneTitle">
                                                    <div class="mainTitleOne">${news.title}</div>
                                                    <p class="mainTenBaiVietOne">
                                                        <c:set var="content" value="${news.content}" />
                                                        <c:choose>
                                                            <c:when test="${not empty content}">
                                                                ${fn:length(content) > 120 ? fn:substring(content,
                                                                0, 120).concat('...') : content}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Nội dung đang được cập nhật...
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>

                                                    <div class="mainInfoTacGia">
                                                        <c:choose>
                                                            <c:when test="${not empty news.author}">
                                                                ${news.author}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Unknown Author
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </a>
                                        </article>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>

                                </c:otherwise>
                            </c:choose>
                            <%-- Kết thúc lặp --%>

                                <%-- Các bài viết mặc định (giữ nguyên) --%>
                                    <article class="mainContentOne">
                                        <a class="mainCardLink" href="${pageContext.request.contextPath}/articles/qua-khu-hien-tai-va-tuong-lai">
                                            <div class="mainContentOnePic">
                                                <img src="${pageContext.request.contextPath}/assets/media/Baiviet1-QuáKhứHiệnTạiVàTươngLai.jpg"
                                                    alt="QUÁ KHỨ HIỆN TẠI VÀ TƯƠNG LAI">
                                            </div>
                                            <div class="mainContentOneTitle">
                                                <div class="mainTitleOne">QUÁ KHỨ HIỆN TẠI VÀ TƯƠNG LAI</div>
                                                <p class="mainTenBaiVietOne">Con người chúng ta quá chú ý tới tương
                                                    lai và nhớ lại quá khứ nhưng ít ai...</p>
                                                <div class="mainInfoTacGia">THÁI HỌC</div>
                                            </div>
                                        </a>
                                    </article>

                                    <article class="mainContentOne">
                                        <a class="mainCardLink" href="${pageContext.request.contextPath}/articles/khi-ly-tri-cham-den-vo-nga">
                                            <div class="mainContentOnePic">
                                                <img src="${pageContext.request.contextPath}/assets/media/Baiviet2-KhiLýTríChạmĐếnVôNgã.jpg"
                                                    alt="KHI LÝ TRÍ CHẠM ĐẾN VÔ NGÃ">
                                            </div>
                                            <div class="mainContentOneTitle">
                                                <div class="mainTitleOne">KHI LÝ TRÍ CHẠM ĐẾN VÔ NGÃ</div>
                                                <p class="mainTenBaiVietOne">Con người chú ta điều chú ý đến mọi thứ
                                                    xung quanh nhưng có rất ít người dùng lí trí để làm việc đó....
                                                </p>
                                                <div class="mainInfoTacGia">THÁI HỌC</div>
                                            </div>
                                        </a>
                                    </article>

                                    <article class="mainContentOne">
                                        <a class="mainCardLink" href="${pageContext.request.contextPath}/articles/su-that-ve-may-man">
                                            <div class="mainContentOnePic">
                                                <img src="${pageContext.request.contextPath}/assets/media/Baiviet3-SựThậtVềMaiMắn.jpg"
                                                    alt="SỰ THẬT VỀ THỨ ĐƯỢC GỌI LÀ MAY MẮN">
                                            </div>
                                            <div class="mainContentOneTitle">
                                                <div class="mainTitleOne">SỰ THẬT VỀ THỨ ĐƯỢC GỌI LÀ MAI MẮN</div>
                                                <p class="mainTenBaiVietOne">Ai trong chúng ta cũng mong chờ thứ
                                                    được gọi là may mắn nhưng sẽ ra sao nếu ta không mong chờ việc
                                                    đó...</p>
                                                <div class="mainInfoTacGia">THÁI HỌC</div>
                                            </div>
                                        </a>
                                    </article>

                                    <article class="mainContentOne">
                                        <a class="mainCardLink" href="${pageContext.request.contextPath}/articles/viet-nam-nen-kinh-te-ven-bien">
                                            <div class="mainContentOnePic">
                                                <img src="${pageContext.request.contextPath}/assets/media/Baiviet4-ViệtNamVàĐặcTínhDễTổnThươngCủa1NềnKinhTếVenBiển.jpg"
                                                    alt="Việt Nam và nền kinh tế ven biển">
                                            </div>
                                            <div class="mainContentOneTitle">
                                                <div class="mainTitleOne">VIỆT NAM VÀ ĐẶC TÍNH DỄ TỔN THƯƠNG CỦA 1
                                                    NỀN KINH TẾ VEN BIỂN</div>
                                                <p class="mainTenBaiVietOne">Việt Nam chúng ta là 1 quốc gia có nền
                                                    kinh tế ven biển ổn định và dễ tổn thương tại sao...</p>
                                                <div class="mainInfoTacGia">THÁI HỌC</div>
                                            </div>
                                        </a>
                                    </article>

                                    <article class="mainContentOne">
                                        <a class="mainCardLink"
                                            href="${pageContext.request.contextPath}/articles/aristotle-3-sai-lam-cua-nha-nuoc-cong-hoa-plato">
                                            <div class="mainContentOnePic">
                                                <img src="${pageContext.request.contextPath}/assets/media/Baiviet5-AristotleĐãVạchTrần3SaiLầmChếtNgườiTrongNhàNướcCộngHoàCủaPlatoNhưThếNào.jpg"
                                                    alt="Aristotle và 3 sai lầm của Plato">
                                            </div>
                                            <div class="mainContentOneTitle">
                                                <div class="mainTitleOne">ARISTOTLE ĐÃ VẠCH TRẦN 3 SAI LẦM CHẾT
                                                    NGƯỜI TRONG NHÀ NƯỚC CỘNG HOÀ CỦA PLATO NHƯ THẾ NÀO?</div>
                                                <p class="mainTenBaiVietOne">Triết gia Aristotle đã vạch trần được 3
                                                    sai lầm chết người của nhà nước cộng hoà của Plato bằng...</p>
                                                <div class="mainInfoTacGia">THÁI HỌC</div>
                                            </div>
                                        </a>
                                    </article>

                                    <article class="mainContentOne">
                                        <a class="mainCardLink" href="${pageContext.request.contextPath}/articles/an-cu-lac-nghiep-hay-nguoc-lai">
                                            <div class="mainContentOnePic">
                                                <img src="${pageContext.request.contextPath}/assets/media/Baiviet6-HomentorSeaon2Tập1AnCưLạcNghiệpHayLạcNghiệpRồiMớiAnCư.jpg"
                                                    alt="An cư lạc nghiệp hay ngược lại">
                                            </div>
                                            <div class="mainContentOneTitle">
                                                <div class="mainTitleOne">AN CƯ LẠC NGHIỆP HAY LẠC NGHIỆP RỒI MỚI AN
                                                    CƯ</div>
                                                <p class="mainTenBaiVietOne">Nhiều người trong chúng ta có ý định an
                                                    cư rồi lạc nghiệp nhưng 1 vài người lại có ý định ngược lại...
                                                </p>
                                                <div class="mainInfoTacGia">THÁI HỌC</div>
                                            </div>
                                        </a>
                                    </article>

                                    <article class="mainContentOne">
                                        <a class="mainCardLink" href="${pageContext.request.contextPath}/articles/6-su-that-ve-xa-hoi-li-tuong-aristotle">
                                            <div class="mainContentOnePic">
                                                <img src="${pageContext.request.contextPath}/assets/media/Baiviet7-6SựThậtGâySốcVêXãHộiLíTưởngTừTriếtGiaAristotle.jpg"
                                                    alt="6 sự thật về xã hội lí tưởng - Aristotle">
                                            </div>
                                            <div class="mainContentOneTitle">
                                                <div class="mainTitleOne">6 SỰ THẬT GÂY SỐC VỀ XÃ HỘI LÍ TƯỞNG TỪ
                                                    TRIẾT GIA ARISTOTLE</div>
                                                <p class="mainTenBaiVietOne">Chúng ta hãy cùng tìm hiểu về 6 sự thật
                                                    về xã hội lí tưởng từ triết gia Aristotle...</p>
                                                <div class="mainInfoTacGia">THÁI HỌC</div>
                                            </div>
                                        </a>
                                    </article>

                                    <article class="mainContentOne">
                                        <a class="mainCardLink" href="${pageContext.request.contextPath}/articles/cach-dung-solver-trong-excel">
                                            <div class="mainContentOnePic">
                                                <img src="${pageContext.request.contextPath}/assets/media/Baiviet8-CáchDùngSolverTrongExcel.jpg"
                                                    alt="Cách dùng Solver trong Excel">
                                            </div>
                                            <div class="mainContentOneTitle">
                                                <div class="mainTitleOne">CÁCH DÙNG SOLVER TRONG EXCEL</div>
                                                <p class="mainTenBaiVietOne">Một số lỗi thường gặp khi dùng Solver
                                                    trong Excel và cách xử lý chi tiết...</p>
                                                <div class="mainInfoTacGia">THÁI HỌC</div>
                                            </div>
                                        </a>
                                    </article>
                    </section>

                    <aside id="mainContentTwo" aria-label="Đăng ký & Banner">
                        <div class="mainNewletterDiv">
                            <h2>Đăng ký nhận newsletter hàng tuần của chúng tôi</h2>
                            <h3>Nội dung giới thiệu newsletter</h3>

                            <form id="mainNewsletterForm" action="${pageContext.request.contextPath}/home"
                                method="post">
                                <h4><label for="newsletterEmail">Nhập email của bạn</label></h4>
                                <input type="email" id="mainNewsletterEmail" name="email" placeholder="email@domain.com"
                                    required>

                                <h4><label for="newsletterName">Chúng mình có thể gọi bạn là?</label></h4>
                                <input type="text" id="mainNewsletterName" name="displayName" placeholder="Tên hiển thị"
                                    maxlength="64">

                                <button>ĐĂNG KÝ</button>
                            </form>
                        </div>

                        <div id="mainContentTwoBanner">
                            <img src="${pageContext.request.contextPath}/assets/media/Screenshot 2025-10-03 151611.png"
                                alt="Chiến dịch nổi bật">
                        </div>
                    </aside>
                </div>
            </section>
