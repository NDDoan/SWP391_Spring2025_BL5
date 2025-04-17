package Controller;

import Dao.UserDao;
import Entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


@WebServlet("/user")
public class UserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDao dao = new UserDao();

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = dao.getUserById(id);
            request.setAttribute("editUser", user);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteUser(id);
            response.sendRedirect("user");
            return;
        }

        List<User> userList = dao.getAllUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/AdminPage/UserList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = request.getParameter("user_id") != null && !request.getParameter("user_id").isEmpty()
                ? Integer.parseInt(request.getParameter("user_id")) : 0;

        String name = request.getParameter("full_name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone_number");
        String address = request.getParameter("address");
        int role = Integer.parseInt(request.getParameter("role_id"));
        boolean isActive = request.getParameter("is_active") != null;
        boolean isVerified = request.getParameter("is_verified") != null;

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
            User newUser = new User(name, gender, email, "123456", phone, address, role, isActive, isVerified);
            dao.insertUser(newUser);
        }

        response.sendRedirect("user");
    }
}
