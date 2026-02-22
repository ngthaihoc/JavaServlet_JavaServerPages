package hocng.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import hocng.dao.NewsDAO;
import hocng.daoImp.NewsDAOImpl;
import hocng.entity.NEWS;
import hocng.entity.USERS;

@WebServlet("/write")
@MultipartConfig
public class WriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NewsDAO newsDAO;

    public WriteServlet() {
        super();
        this.newsDAO = new NewsDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("view", "/views/write.jsp");
        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        USERS currentUser = (session != null) ? (USERS) session.getAttribute("user") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?message=Please log in to write an article.");
            return;
        }

        String action = request.getParameter("action");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String categoryId = request.getParameter("categoryId");

        NEWS article = new NEWS();
        article.setId(java.util.UUID.randomUUID().toString().substring(0, 8));
        article.setTitle(title);
        article.setContent(content);
        article.setCategoryId(categoryId);
        article.setAuthor(currentUser.getId());
        article.setPostedDate(new java.util.Date());
        article.setViewCount(0);
        article.setHome("publish".equals(action));

        Part imagePart = request.getPart("imageFile");
        if (imagePart != null && imagePart.getSize() > 0) {
            String uploadDIR = request.getServletContext().getRealPath("/assets/media");
            java.io.File uploadDirFile = new java.io.File(uploadDIR);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
            String savePath = uploadDIR + "/" + fileName;
            imagePart.write(savePath);
            article.setImage("/assets/media/" + fileName);
        }

        try {
            newsDAO.create(article);
            request.setAttribute("message",
                    "draft".equals(action) ? "Đã lưu bản nháp thành công!" : "Bài viết đã được đăng!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lưu bài viết.");
        }

        request.setAttribute("view", "/views/write.jsp");
        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }
}
