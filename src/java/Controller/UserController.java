package Controller;

import Dao.UserDao;
import Entity.User;
import Util.HashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/user")
public class UserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User users = (User) session.getAttribute("user");

        if (users == null || users.getRole_id() == 2) {
            response.sendRedirect("logincontroller");
            return;
        }
        String action = request.getParameter("action");
        UserDao dao = new UserDao();

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = dao.getUserById(id);
            request.setAttribute("editUser", user);
        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect("user"); // Không có id hợp lệ
                return;
            }

            try {
                int id = Integer.parseInt(idStr);
                User user = dao.getUserById(id);
                if (user != null) {
                    user.setIs_active(!user.isIs_active());
                    dao.updateUser(user);
                }
                response.sendRedirect("user");
            } catch (NumberFormatException e) {
                response.sendRedirect("user"); // Xử lý khi id không hợp lệ
            }
            return;
        } else if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Map<String, Object> result = dao.getUserByIdWithRole(id);
            User user = (User) result.get("user");
            String roleName = (String) result.get("role_name");

            request.setAttribute("user", user);
            request.setAttribute("roleName", roleName);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/AdminPage/UserDetail.jsp").forward(request, response);
            return;
        }

        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");

        if (sortBy == null || sortOrder == null) {
            sortBy = "user_id"; // Default sort by ID
            sortOrder = "asc"; // Default sort order ascending
        }

        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = ""; // Default to empty string if no search query
        }
        String roleFilter = request.getParameter("roleFilter");
        if (roleFilter == null) {
            roleFilter = ""; // Default to empty string if no role is selected
        }
        String genderFilter = request.getParameter("genderFilter");
        if (roleFilter == null) {
            roleFilter = ""; // Default to empty string if no role is selected
        }
        int page = 1;
        int limit = 5;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * limit;
        List<User> userList = null;
        String Useroke = null;
        if (users.getRole_id() == 1) {
            userList = dao.getFilteredUsers(keyword, roleFilter, offset, limit, sortBy, sortOrder,genderFilter);
            Useroke = "manager";
        } else if (users.getRole_id() == 5) {
            userList = dao.getFilteredCustomer(keyword, roleFilter, offset, limit, sortBy, sortOrder,genderFilter);
            Useroke = "staff";
        }
        int totalUsers = dao.countFilteredUsers(keyword, roleFilter);
        int totalPages = (int) Math.ceil((double) totalUsers / limit);

        request.setAttribute("Useroke", Useroke);
        request.setAttribute("userList", userList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("roleFilter", roleFilter);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/AdminPage/UserList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User users = (User) session.getAttribute("user");

        if (users == null || users.getRole_id() != 1) {
            response.sendRedirect("logincontroller");
            return;
        }
        int id = request.getParameter("user_id") != null && !request.getParameter("user_id").isEmpty()
                ? Integer.parseInt(request.getParameter("user_id")) : 0;

        String name = request.getParameter("full_name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone_number");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        int role = Integer.parseInt(request.getParameter("role_id"));
        boolean isActive = "true".equals(request.getParameter("is_active"));
        boolean isVerified = "true".equals(request.getParameter("is_verified"));
        String hashedPassword = HashUtil.hashPassword(password);
        UserDao dao = new UserDao();

        if (id > 0) {
            // Update
            User user = dao.getUserById(id);
            user.setFull_name(name);
            user.setGender(gender);
            user.setEmail(email);
            user.setPhone_number(phone);
            user.setAddress(address);
            user.setRole_id(role);
            user.setIs_active(isActive);
            user.setIs_verified(isVerified);
            dao.updateUser(user);
        } else {
            // Insert
            // User newUser = new User(name, gender, email, "12345", phone, address, role, isActive, isVerified);
            User insertUser = new User(100, name, gender, email, hashedPassword, phone, address, null, role, isActive, isVerified, null, null, null, null, null);
            dao.insertUser(insertUser);
        }

        response.sendRedirect("user");
    }
}
