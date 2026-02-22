package hocng.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import hocng.dao.CategoriesDAO;
import hocng.dao.NewsDAO;
import hocng.daoImp.CategoriesDAOImpl;
import hocng.daoImp.NewsDAOImpl;
import hocng.entity.CATEGORIES;
import hocng.entity.NEWS;

@WebServlet({ "/admin/news", "/admin/news/edit/*", "/admin/news/create", "/admin/news/update", "/admin/news/delete",
		"/admin/news/reset" })
@MultipartConfig
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private NewsDAO newsDAO;
	private CategoriesDAO categoryDAO;

	public NewsServlet() {
		super();
		this.newsDAO = new NewsDAOImpl();
		this.categoryDAO = new CategoriesDAOImpl();
	}

	private void loadNewsData(HttpServletRequest request) {
		List<CATEGORIES> categories = categoryDAO.findAll();
		request.setAttribute("categories", categories);

		List<NEWS> newsList = newsDAO.findAll();
		request.setAttribute("list", newsList);
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		NEWS formNews = new NEWS();
		String message = "";
		String error = "";

		String path = request.getServletPath();
		String pathInfo = request.getPathInfo();
		boolean editMode = false;

		if ("GET".equalsIgnoreCase(request.getMethod())) {
			try {
				if (path.contains("/edit") && pathInfo != null && pathInfo.length() > 1) {
					String id = pathInfo.substring(1);
					formNews = newsDAO.findById(id);
					if (formNews == null) {
						error = "Không tìm thấy bài viết với ID: " + id;
						formNews = new NEWS();
					} else {
						editMode = true;
					}
				} else if (pathInfo != null && pathInfo.equals("/reset")) {
					response.sendRedirect(request.getContextPath() + "/admin/news");
					return;
				} else if (path.contains("/delete")) {
					String idToDelete = request.getParameter("id");
					if (idToDelete != null && !idToDelete.trim().isEmpty()) {
						newsDAO.deleteById(idToDelete);
						message = "Xóa bài viết thành công!";
					} else {
						error = "ID bài viết không hợp lệ!";
					}
					formNews = new NEWS();
				}
			} catch (Exception e) {
				e.printStackTrace();
				error = "Lỗi xử lý yêu cầu GET: " + e.getMessage();
			}
		} else if ("POST".equalsIgnoreCase(request.getMethod())) {
			try {
				if (request.getParameter("id") != null)
					formNews.setId(request.getParameter("id"));
				if (request.getParameter("title") != null)
					formNews.setTitle(request.getParameter("title"));
				if (request.getParameter("content") != null)
					formNews.setContent(request.getParameter("content"));
				if (request.getParameter("image") != null)
					formNews.setImage(request.getParameter("image"));
				if (request.getParameter("author") != null && !request.getParameter("author").isEmpty()) {
					formNews.setAuthor(request.getParameter("author"));
				} else {
					javax.servlet.http.HttpSession session = request.getSession();
					hocng.entity.USERS currentUser = (hocng.entity.USERS) session.getAttribute("user");
					if (currentUser != null) {
						formNews.setAuthor(currentUser.getId());
					} else {
						formNews.setAuthor("admin");
					}
				}
				if (request.getParameter("categoryId") != null)
					formNews.setCategoryId(request.getParameter("categoryId"));

				String viewCountStr = request.getParameter("viewCount");
				if (viewCountStr != null && !viewCountStr.isEmpty()) {
					try {
						formNews.setViewCount(Integer.parseInt(viewCountStr));
					} catch (NumberFormatException e) {
						formNews.setViewCount(0);
					}
				}

				if (isMultipartContent(request)) {
					Part imagePart = request.getPart("imageFile");
					if (imagePart != null && imagePart.getSize() > 0) {
						String uploadDIR = request.getServletContext().getRealPath("/assets/media");
						String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
						String savePath = uploadDIR + "/" + fileName;
						imagePart.write(savePath);
						formNews.setImage("/assets/media/" + fileName);
					}
				}

				String homeParam = request.getParameter("home");
				formNews.setHome("on".equals(homeParam));

				if (formNews.getViewCount() == null) {
					formNews.setViewCount(0);
				}

				if (path.contains("create")) {
					if (formNews.getId() == null || formNews.getId().trim().isEmpty()) {
						formNews.setId(java.util.UUID.randomUUID().toString().substring(0, 8));
					}
					formNews.setPostedDate(new java.util.Date());
					newsDAO.create(formNews);
					message = "Thêm bài viết thành công!";
					formNews = new NEWS();
				} else if (path.contains("update")) {
					NEWS oldNews = newsDAO.findById(formNews.getId());
					if (oldNews != null) {
						formNews.setPostedDate(oldNews.getPostedDate());
					}
					newsDAO.update(formNews);
					message = "Cập nhật bài viết thành công!";
				} else if (path.contains("delete")) {
					String idToDelete = request.getParameter("id");
					if (idToDelete != null && !idToDelete.trim().isEmpty()) {
						newsDAO.deleteById(idToDelete);
						message = "Xóa bài viết thành công!";
					} else {
						error = "ID bài viết không hợp lệ!";
					}
					formNews = new NEWS();
				}

			} catch (Exception e) {
				e.printStackTrace();
				error = "Lỗi xử lý form: " + e.getMessage();
			}
		}

		loadNewsData(request);

		request.setAttribute("item", formNews);
		request.setAttribute("editMode", editMode);
		request.setAttribute("message", message);
		request.setAttribute("error", error);

		request.setAttribute("view", "/views/admin/news-crud.jsp");
		request.getRequestDispatcher("/layout.jsp").forward(request, response);
	}

	private boolean isMultipartContent(HttpServletRequest request) {
		String contentType = request.getContentType();
		return contentType != null && contentType.toLowerCase().startsWith("multipart/");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		service(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		service(request, response);
	}
}