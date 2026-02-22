package hocng.filter;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import hocng.dao.CategoriesDAO;
import hocng.daoImp.CategoriesDAOImpl;
import hocng.entity.CATEGORIES;

@WebFilter("/*")
public class GlobalDataFilter implements Filter {

    private CategoriesDAO categoryDAO;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        categoryDAO = new CategoriesDAOImpl();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String uri = httpRequest.getRequestURI();

        if (!uri.contains("/assets/")) {
            try {
                List<CATEGORIES> categories = categoryDAO.findAll();
                request.setAttribute("globalCategories", categories);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
