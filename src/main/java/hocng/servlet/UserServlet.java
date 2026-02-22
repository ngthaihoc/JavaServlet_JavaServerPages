package hocng.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hocng.dao.UsersDAO;
import hocng.daoImp.UsersDAOImpl;
import hocng.entity.USERS;

@WebServlet({ "/admin/users", "/admin/users/create", "/admin/users/update", "/admin/users/delete",
        "/admin/users/edit/*", "/admin/users/reset" })
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UsersDAO dao;

    public UserServlet() {
        super();
        this.dao = new UsersDAOImpl();
    }

    private USERS getUserFromRequest(HttpServletRequest request) {
        USERS user = new USERS();
        user.setId(request.getParameter("id"));
        user.setPassword(request.getParameter("password"));
        user.setFullname(request.getParameter("fullname"));
        user.setMobile(request.getParameter("mobile"));
        user.setEmail(request.getParameter("email"));

        String roleParam = request.getParameter("role");
        user.setRole("true".equals(roleParam) || "1".equals(roleParam));

        String genderParam = request.getParameter("gender");
        user.setGender("true".equals(genderParam) || "1".equals(genderParam));

        String birthdayStr = request.getParameter("birthday");
        if (birthdayStr != null && !birthdayStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                user.setBirthday(sdf.parse(birthdayStr));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        String pathInfo = request.getPathInfo();
        boolean editMode = false;

        if (action.contains("/edit") && pathInfo != null && pathInfo.length() > 1) {
            String id = pathInfo.substring(1);
            edit(request, response, id);
            editMode = (request.getAttribute("item") != null
                    && ((hocng.entity.USERS) request.getAttribute("item")).getId() != null);
        } else if (action.contains("/delete")) {
            delete(request, response);
            findAll(request, response);
        } else if (action.equals("/admin/users/reset") || (pathInfo != null && pathInfo.equals("/reset"))) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        } else {
            findAll(request, response);
        }

        request.setAttribute("editMode", editMode);
        request.setAttribute("view", "/views/admin/users-crud.jsp");
        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }

    private void findAll(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<USERS> list = dao.findAll();
            request.setAttribute("list", list);
            if (request.getAttribute("item") == null) {
                request.setAttribute("item", new USERS());
            }
        } catch (Exception e) {
            request.setAttribute("message", "Lỗi hiển thị danh sách: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response, String id) {
        try {
            USERS user = dao.findById(id);
            if (user != null) {
                request.setAttribute("item", user);
            } else {
                request.setAttribute("message", "Không tìm thấy người dùng có ID: " + id);
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
        String action = request.getServletPath();

        try {
            if (action.equals("/admin/users/create")) {
                create(request, response);
            } else if (action.equals("/admin/users/update")) {
                update(request, response);
            } else if (action.equals("/admin/users/delete")) {
                delete(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("message", "Thực hiện thất bại: " + e.getMessage());
            e.printStackTrace();
        }

        findAll(request, response);
        request.setAttribute("view", "/views/admin/users-crud.jsp");
        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response) {
        USERS entity = getUserFromRequest(request);
        try {
            if (dao.findById(entity.getId()) != null) {
                throw new RuntimeException("ID đã tồn tại. Vui lòng nhập ID khác.");
            }
            dao.create(entity);
            request.setAttribute("message", "Thêm mới thành công!");
            request.setAttribute("item", new USERS());
        } catch (Exception e) {
            request.setAttribute("message", "Lỗi Thêm mới: " + e.getMessage());
            request.setAttribute("item", entity);
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) {
        USERS entity = getUserFromRequest(request);
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
            request.setAttribute("message", "Xóa thành công người dùng ID: " + id);
            request.setAttribute("item", new USERS());
        } catch (Exception e) {
            request.setAttribute("message", "Lỗi Xóa: Không thể xóa người dùng này. " + e.getMessage());
            request.setAttribute("item", getUserFromRequest(request));
        }
    }
}
