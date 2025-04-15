package Controller;

import Dao.UserDao;
import Entity.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/logincontroller"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/UserPage/Login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Validate email
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("errorMessage", "Invalid email format.");
            request.getRequestDispatcher("/UserPage/Login.jsp").forward(request, response);
            return;
        }

        // Validate password
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Password cannot be empty.");
            request.getRequestDispatcher("/UserPage/Login.jsp").forward(request, response);
            return;
        }

        UserDao userDAO = new UserDao();
        User user = userDAO.login(email, password);

        if (user != null) {
            // Lưu user vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Xử lý "Remember Me"
            if ("on".equals(rememberMe)) {
                Cookie cookie = new Cookie("rememberedEmail", email);
                cookie.setMaxAge(7 * 24 * 60 * 60);
                response.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("rememberedEmail", "");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }

            // Chuyển trang theo vai trò
            int roleId = user.getRole_id();
            if (roleId == 2) {
                response.sendRedirect(request.getContextPath() + "/UserPage/HomePage.jsp");
            } else if (roleId == 1 || roleId == 4) {
                response.sendRedirect(request.getContextPath() + "/ShippingController");
            } else {
                response.sendRedirect(request.getContextPath() + "/UserPage/Home.jsp");
            }

        } else {
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("/UserPage/Login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
