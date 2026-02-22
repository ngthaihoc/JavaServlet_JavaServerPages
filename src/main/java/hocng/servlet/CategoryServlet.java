package hocng.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hocng.dao.CategoriesDAO;
import hocng.daoImp.CategoriesDAOImpl;
import hocng.entity.CATEGORIES;

@WebServlet("/admin/categories/*")
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CategoriesDAO dao;

	public CategoryServlet() {
		super();
		this.dao = new CategoriesDAOImpl();
	}

	private CATEGORIES getCategoryFromRequest(HttpServletRequest request) {
		CATEGORIES category = new CATEGORIES();
		category.setId(request.getParameter("id"));
		category.setName(request.getParameter("name"));
		return category;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getPathInfo();

		if (action == null || action.isEmpty() || action.equals("/")) {
			findAll(request, response);
		} else if (action.startsWith("/edit/")) {
			String id = action.substring("/edit/".length());
			edit(request, response, id);
		} else if (action.equals("/delete")) {
			delete(request, response);
			findAll(request, response);
		} else if (action.equals("/reset")) {
			response.sendRedirect(request.getContextPath() + "/admin/categories");
			return;
		}

		request.setAttribute("view", "/views/admin/category-crud.jsp");
		request.getRequestDispatcher("/layout.jsp").forward(request, response);
	}

	private void findAll(HttpServletRequest request, HttpServletResponse response) {
		try {
			List<CATEGORIES> list = dao.findAll();
			request.setAttribute("list", list);
			if (request.getAttribute("item") == null) {
				request.setAttribute("item", new CATEGORIES());
			}
		} catch (Exception e) {
			request.setAttribute("message", "Lỗi hiển thị danh sách: " + e.getMessage());
			e.printStackTrace();
		}
	}

	private void edit(HttpServletRequest request, HttpServletResponse response, String id) {
		try {
			CATEGORIES category = dao.findById(id);
			if (category != null) {
				request.setAttribute("item", category);
			} else {
				request.setAttribute("message", "Không tìm thấy Loại bài viết có ID: " + id);
			}
			findAll(request, response);
		} catch (Exception e) {
			request.setAttribute("message", "Lỗi chỉnh sửa: " + e.getMessage());
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String action = request.getPathInfo();

		try {
			if (action.equals("/create")) {
				create(request, response);
			} else if (action.equals("/update")) {
				update(request, response);
			} else if (action.equals("/delete")) {
				delete(request, response);
			}
		} catch (Exception e) {
			request.setAttribute("message", "Thực hiện thất bại: " + e.getMessage());
			e.printStackTrace();
		}

		findAll(request, response);
		request.setAttribute("view", "/views/admin/category-crud.jsp");
		request.getRequestDispatcher("/layout.jsp").forward(request, response);
	}

	private void create(HttpServletRequest request, HttpServletResponse response) {
		CATEGORIES entity = getCategoryFromRequest(request);
		try {
			if (entity.getId() == null || entity.getId().trim().isEmpty()) {
				entity.setId(java.util.UUID.randomUUID().toString().substring(0, 8));
			} else {
				if (dao.findById(entity.getId()) != null) {
					throw new RuntimeException("ID đã tồn tại. Vui lòng nhập ID khác.");
				}
			}
			dao.create(entity);
			request.setAttribute("message", "Thêm mới thành công!");
			request.setAttribute("item", new CATEGORIES());
		} catch (Exception e) {
			request.setAttribute("message", "Lỗi Thêm mới: " + e.getMessage());
			request.setAttribute("item", entity);
		}
	}

	private void update(HttpServletRequest request, HttpServletResponse response) {
		CATEGORIES entity = getCategoryFromRequest(request);
		try {
			dao.update(entity);
			request.setAttribute("message", "Cập nhật thành công!");
			request.setAttribute("item", entity);
		} catch (Exception e) {
			request.setAttribute("message", "Lỗi Cập nhật: " + e.getMessage());
			request.setAttribute("item", entity);
		}
	}

	private void delete(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		try {
			dao.deleteById(id);
			request.setAttribute("message", "Xóa thành công loại bài viết ID: " + id);
			request.setAttribute("item", new CATEGORIES());
		} catch (Exception e) {
			request.setAttribute("message", "Lỗi Xóa: Không thể xóa loại bài viết này. " + e.getMessage());
			request.setAttribute("item", getCategoryFromRequest(request));
		}
	}
}