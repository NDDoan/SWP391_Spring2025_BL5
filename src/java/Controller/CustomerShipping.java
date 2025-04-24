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
            String sortBy = request.getParameter("sortBy");
            String sortDir = request.getParameter("sortDir");
            int page = 1;
            int limit = 5; // Số đơn hàng mỗi trang

            // Parse trang hiện tại
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            int offset = (page - 1) * limit;
            // Mặc định nếu không chọn
            if (sortBy == null || sortBy.isEmpty()) {
                sortBy = "shipping_id";
            }
            if (sortDir == null || sortDir.isEmpty()) {
                sortDir = "asc";
            }

            // Tổng số đơn hàng sau khi lọc
            int totalItems = shippingDAO.getTotalShippingCount(status);
            int totalPages = (int) Math.ceil((double) totalItems / limit);

            List<Shipping> shippingList;

            // Tìm kiếm theo trạng thái nếu có
        
                shippingList = shippingDAO.getShippingByCustomerIdStatus(customerId, status, sortBy, sortDir, offset, limit);
          

            // Đưa danh sách giao hàng vào request
            request.setAttribute("shippingList", shippingList);
            // Truyền tham số status vào lại view để duy trì trạng thái tìm kiếm
            request.setAttribute("status", status);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("sortBy", sortBy);      // giữ lại sort
            request.setAttribute("sortDir", sortDir);
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
