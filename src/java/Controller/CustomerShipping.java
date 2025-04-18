package Controller;

import Dao.ShippingDAO;
import Entity.Shipping;
import DBContext.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class CustomerShipping extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy customer_id từ session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer_id") == null) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("logincontroller");
            return;
        }

        int customerId = (int) session.getAttribute("customer_id");

        try (Connection conn = new DBContext().getConnection()) {
            ShippingDAO shippingDAO = new ShippingDAO(conn);
            List<Shipping> shippingList = shippingDAO.getShippingByCustomerId(customerId);

            // Gửi danh sách đến JSP để hiển thị
            request.setAttribute("shippingList", shippingList);
            request.getRequestDispatcher("/CustomerPage/CustomerShipping.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response); // Hoặc xử lý riêng nếu cần
    }

    @Override
    public String getServletInfo() {
        return "Displays customer's shipping information";
    }
}
