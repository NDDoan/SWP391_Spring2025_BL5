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

        HttpSession session = request.getSession();  // Không tạo session mới, sử dụng session hiện tại
        User users = (User) session.getAttribute("user");

        // Kiểm tra nếu người dùng chưa đăng nhập hoặc không phải khách hàng
        if (users == null || users.getRole_id() != 2) {
            response.sendRedirect("logincontroller");
            return;
        }

        int customerId = users.getUser_id();

        try (Connection conn = new DBContext().getConnection()) {
            ShippingDAO shippingDAO = new ShippingDAO(conn);
            String status = request.getParameter("status");
            List<Shipping> shippingList;

            // Tìm kiếm theo trạng thái nếu có
            if (status != null && !status.trim().isEmpty()) {
                shippingList = shippingDAO.getShippingByCustomerIdStatus(customerId, status);
            } else {
                shippingList = shippingDAO.getShippingByCustomerId(customerId);
            }

            // Đưa danh sách giao hàng vào request
            request.setAttribute("shippingList", shippingList);
            // Truyền tham số status vào lại view để duy trì trạng thái tìm kiếm
            request.setAttribute("statusFilter", status);

            // Forward request và response tới JSP
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
