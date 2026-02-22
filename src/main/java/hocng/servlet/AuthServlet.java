package hocng.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hocng.dao.UsersDAO;
import hocng.daoImp.UsersDAOImpl;
import hocng.entity.USERS;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO usersDAO;

	public AuthServlet() {
		super();
		this.usersDAO = new UsersDAOImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if ("logout".equals(action)) {
			processLogout(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/login");
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		if ("login".equals(action)) {
			processLogin(request, response);
		} else if ("register".equals(action)) {
			processRegister(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/login");
		}
	}

	private void processLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String password = request.getParameter("password");

		try {
			USERS user = usersDAO.findById(id);

			if (user != null && user.getPassword().equals(password)) {
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("username", user.getFullname());
				session.setAttribute("role", user.isRole() ? "admin" : "reporter");

				if (user.isRole()) {
					response.sendRedirect(request.getContextPath() + "/admin/news");
				} else {
					response.sendRedirect(request.getContextPath() + "/home");
				}
			} else {
				request.setAttribute("error", "ID hoặc mật khẩu không đúng!");
				request.setAttribute("view", "/views/login.jsp");
				request.getRequestDispatcher("/layout.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Đã xảy ra lỗi hệ thống: " + e.getMessage());
			request.setAttribute("view", "/views/login.jsp");
			request.getRequestDispatcher("/layout.jsp").forward(request, response);
		}
	}

	private void processLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		response.sendRedirect(request.getContextPath() + "/home");
	}

	private void processRegister(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		try {
			USERS existingUser = usersDAO.findById(username);
			if (existingUser != null) {
				request.setAttribute("error", "Username đã tồn tại!");
				request.setAttribute("view", "/views/register.jsp");
				request.getRequestDispatcher("/layout.jsp").forward(request, response);
				return;
			}

			USERS newUser = new USERS();
			newUser.setId(username);
			newUser.setPassword(password);
			newUser.setEmail(email);
			newUser.setFullname(username);
			newUser.setRole(false);

			usersDAO.create(newUser);

			request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
			request.setAttribute("view", "/views/login.jsp");
			request.getRequestDispatcher("/layout.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Đã xảy ra lỗi khi đăng ký: " + e.getMessage());
			request.setAttribute("view", "/views/register.jsp");
			request.getRequestDispatcher("/layout.jsp").forward(request, response);
		}
	}
}