package Controller;

import Dao.OrderDao;
import Entity.User;
import EntityDto.OrderDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

public class OrderList extends HttpServlet {

    private final OrderDao orderDAO = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User users = (User) session.getAttribute("user");

        if (users == null || (users.getRole_id() != 1 && users.getRole_id() != 5)) {
            response.sendRedirect("logincontroller");
            return;
        }

        // Lấy các tham số lọc
        String orderIdStr = request.getParameter("orderId");
        String status = request.getParameter("status");
        String fromDateStr = request.getParameter("startDate");
        String toDateStr = request.getParameter("endDate");
        String sortBy = request.getParameter("sortBy");
        String sortDir = request.getParameter("sortDir");

        // Xử lý ngày
        Timestamp timestampFrom = null;
        Timestamp timestampTo = null;
        try {
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                LocalDate fromLocalDate = LocalDate.parse(fromDateStr);
                timestampFrom = Timestamp.valueOf(fromLocalDate.atStartOfDay());
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                LocalDate toLocalDate = LocalDate.parse(toDateStr);
                timestampTo = Timestamp.valueOf(toLocalDate.plusDays(1).atStartOfDay()); // inclusive
            }
        } catch (DateTimeParseException e) {
            System.out.println("Lỗi parse ngày: " + e.getMessage());
        }

        // Mặc định sort
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "created_at";
        }
        if (sortDir == null || sortDir.isEmpty()) {
            sortDir = "desc";
        }

        // Phân trang
        int page = 1;
        int pageSize = 5;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * pageSize;

        List<OrderDto> orders;
        int totalItems = 0;

        try {
            if (orderIdStr != null && !orderIdStr.isEmpty()) {
                int orderId = Integer.parseInt(orderIdStr);
                OrderDto order = orderDAO.getOrderById(orderId);
                if (order != null) {
                    orders = List.of(order);
                    totalItems = 1;
                } else {
                    orders = List.of();
                }
            } else {
                orders = orderDAO.getOrdersFiltered(timestampFrom, timestampTo, status, sortBy, sortDir, offset, pageSize);
                totalItems = orderDAO.countFilteredOrders(timestampFrom, timestampTo, status); // thêm hàm này trong DAO
            }

            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            // Gửi dữ liệu đến JSP
            request.setAttribute("orders", orders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("statusFilter", status);
            request.setAttribute("orderId", orderIdStr);
            request.setAttribute("startDate", fromDateStr);
            request.setAttribute("endDate", toDateStr);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortDir", sortDir);

            request.getRequestDispatcher("/AdminPage/OrderList.jsp").forward(request, response);
        } catch (Exception ex) {
            throw new ServletException("Không thể lấy dữ liệu đơn hàng", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Order List Controller";
    }
}
