package hocng.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hocng.dao.NewsDAO;
import hocng.daoImp.NewsDAOImpl;
import hocng.entity.NEWS;

@WebServlet("/articles/*")
public class ArticleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NewsDAO newsDAO;

	public ArticleServlet() {
		super();
		this.newsDAO = new NewsDAOImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pathInfo = request.getPathInfo();

		if (pathInfo == null || pathInfo.equals("/")) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}

		String articleId = pathInfo.substring(1);

		try {
			NEWS article = newsDAO.findById(articleId);

			if (article != null) {
				if (article.getViewCount() == null)
					article.setViewCount(0);
				article.setViewCount(article.getViewCount() + 1);
				newsDAO.update(article);

				request.setAttribute("article", article);
				request.setAttribute("view", "/views/article.jsp");
				request.getRequestDispatcher("/layout.jsp").forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/home?error=ArticleNotFound");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}
