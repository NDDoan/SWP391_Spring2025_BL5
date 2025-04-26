package Controller;

import Dao.OrderDao;
import Entity.User;
import EntityDto.OrderDto;
import EntityDto.OrderItemDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/orderlist")
public class OrderList extends HttpServlet {

    private final OrderDao orderDAO = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User users = (User) session.getAttribute("user");

            if (users == null || (users.getRole_id() != 1 && users.getRole_id() != 5)) {
                response.sendRedirect("logincontroller");
                return;
            }
            String action = request.getParameter("action");
            if (action != null &&action.equals("detail")) {
                showDetail(request, response);
            } else {
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
                    sortBy = "order_id";
                }
                if (sortDir == null || sortDir.isEmpty()) {
                    sortDir = "asc";
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

                int orderId = 0;
                if (orderIdStr != null && !orderIdStr.isEmpty()) {
                    orderId = Integer.parseInt(orderIdStr);
                }

                // Gọi DAO để lấy dữ liệu
                orders = orderDAO.getOrdersFiltered(timestampFrom, timestampTo, orderId, sortBy, sortDir, offset, pageSize, status);
                totalItems = orderDAO.countFilteredOrders(timestampFrom, timestampTo, orderId, status);

                int totalPages = (int) Math.ceil((double) totalItems / pageSize);

                // Gửi dữ liệu đến JSP
                request.setAttribute("orders", orders);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("status", status);
                request.setAttribute("orderId", orderIdStr);
                request.setAttribute("startDate", fromDateStr);
                request.setAttribute("endDate", toDateStr);
                request.setAttribute("sortBy", sortBy);
                request.setAttribute("sortDir", sortDir);

                request.getRequestDispatcher("/AdminPage/OrderList.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException("Không thể lấy dữ liệu đơn hàng", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (orderIdStr != null && status != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                orderDAO.updateOrderStatus(orderId, status);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Sau khi cập nhật xong, redirect về lại danh sách
        response.sendRedirect("orderlist");
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            int orderId = Integer.parseInt(orderIdParam);

            OrderDto order = orderDAO.getOrderById(orderId); // Lấy đơn hàng
            List<OrderItemDto> orderItems = orderDAO.getOrderItemsByOrderId(orderId); // Lấy sản phẩm trong đơn

            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.getRequestDispatcher("/AdminPage/OrderDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect("OrderList"); // Không có orderId thì quay về danh sách
        }
    }

    @Override
    public String getServletInfo() {
        return "Order List Controller";
    }
}
