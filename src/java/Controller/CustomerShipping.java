package Controller;

import Dao.ShippingDAO;
import Entity.Shipping;
import DBContext.DBContext;
import Entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/customershipping")
public class CustomerShipping extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("logincontroller"); // Redirect to login
            return;
        }

        User user = (User) session.getAttribute("user");
        int customerId = user.getUser_id();

        try (Connection conn = new DBContext().getConnection()) {
            ShippingDAO shippingDAO = new ShippingDAO(conn);
            List<Shipping> shippingList = shippingDAO.getShippingByCustomerId(customerId);

            request.setAttribute("shippingList", shippingList);
            request.getRequestDispatcher("/CustomerPage/CustomerShipping.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải thông tin giao hàng.");
            request.getRequestDispatcher("/CustomerPage/CustomerShipping.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Cho phép POST cũng trả về danh sách
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị thông tin giao hàng của khách hàng.";
    }
}
