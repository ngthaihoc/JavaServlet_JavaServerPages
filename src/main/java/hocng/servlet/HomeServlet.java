package hocng.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hocng.dao.NewsDAO;
import hocng.daoImp.NewsDAOImpl;
import hocng.entity.NEWS;

@WebServlet({ "/home", "/admin", "/login", "/register" })
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NewsDAO newsDAO;

	public HomeServlet() {
		super();
		this.newsDAO = new NewsDAOImpl();
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("GET".equalsIgnoreCase(request.getMethod())) {
			String urlString = request.getRequestURI();

			if (urlString.endsWith("/write")) {
				urlString = "/views/write.jsp";
			} else if (urlString.endsWith("/home") || urlString.endsWith("/")) {
				try {
					List<NEWS> latestNews = newsDAO.findAll();
					if (latestNews != null && !latestNews.isEmpty()) {
						request.setAttribute("latestNews", latestNews);
					} else {
						request.setAttribute("latestNews", java.util.Collections.emptyList());
					}
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("latestNews", java.util.Collections.emptyList());
				}
				urlString = "/views/main.jsp";
			} else {
				if (urlString.contains("login")) {
					urlString = "/views/login.jsp";
					String message = request.getParameter("message");
					if (message != null) {
						if ("Please login".equals(message)) {
							request.setAttribute("error", "Vui lòng đăng nhập để tiếp tục!");
						} else {
							request.setAttribute("message", message);
						}
					}
				} else if (urlString.contains("register")) {
					urlString = "/views/register.jsp";
				} else if (urlString.contains("admin")) {
					urlString = "/views/admin.jsp";
					response.sendRedirect(request.getContextPath() + "/admin/news");
					return;
				} else {
					urlString = "/views/main.jsp";
				}
			}

			request.setAttribute("view", urlString);
			request.getRequestDispatcher("/layout.jsp").forward(request, response);
		} else {
			super.service(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		service(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		String email = request.getParameter("email");
		String name = request.getParameter("displayName");
		String subjectMail = "Đăng ký Newletter";
		String content = "Cảm ơn," + name
				+ " vì bạn đã đăng ký Newletter của bọn mình. Bạn sẽ nhận được Newletter sớm thui!!!.";

		try {
			List<NEWS> latestNews = newsDAO.findAll();
			request.setAttribute("latestNews", latestNews);

			hocng.utils.sendMail.sendEmail(email, subjectMail, content);
			request.setAttribute("message", "Gửi mail thành công!");
		} catch (Exception e) {
			request.setAttribute("message", "Không thể gửi mail: " + e.getMessage());
			e.printStackTrace();
		}
		request.setAttribute("view", "/views/main.jsp");
		request.getRequestDispatcher("/layout.jsp").forward(request, response);
	}
}