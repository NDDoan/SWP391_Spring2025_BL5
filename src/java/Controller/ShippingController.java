package Controller;

import Dao.ShippingDAO;
import Dao.UserDao;
import Entity.Shipping;
import Entity.User;
import DBContext.DBContext;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@WebServlet("/shipping")
public class ShippingController extends HttpServlet {

    private ShippingDAO shippingDAO;
    private UserDao userDao;

    @Override
    public void init() {
        try {
            Connection conn = new DBContext().getConnection();
            shippingDAO = new ShippingDAO(conn);
            userDao = new UserDao();
        } catch (Exception e) {
            throw new RuntimeException("Cannot connect to database", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("logincontroller");
            return;
        }

        try {
            if (user.getRole_id() == 1) {
                // ADMIN - quản lý đơn hàng
                String action = request.getParameter("action");
                if (action == null) {
                    listShipping(request, response);
                } else {
                    switch (action) {
                        case "edit":
                            showEditForm(request, response);
                            break;
                        case "delete":
                            deleteShipping(request, response);
                            break;
                        case "create":
                            showCreateForm(request, response);
                            break;
                        default:
                            listShipping(request, response);
                            break;
                    }
                }

            } else if (user.getRole_id() == 4) {
                // SHIPPER - xem đơn hàng được phân công

                String status =  request.getParameter("status");

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
                if (sortBy == null) {
                    sortBy = "shipping_id";
                }
                if (sortDir == null) {
                    sortDir = "asc";
                }
                int totalItems = shippingDAO.getTotalShippingCountId(user.getUser_id(), status);
                int totalPages = (int) Math.ceil((double) totalItems / limit);

                List<Shipping> list;
                list = shippingDAO.getShippingByStatusUserId(user.getUser_id(), status, sortBy, sortDir, offset, limit);
                String ShipOke = "shipper";
                request.setAttribute("ShipOke", ShipOke);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("shippingList", list);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/ManagerShipping/shippingList.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("logincontroller");
            }
        } catch (Exception e) {
            throw new ServletException("Error in doGet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("logincontroller");
            return;
        }

        String action = request.getParameter("action");

        try {
            if (user.getRole_id() == 1) {
                // ADMIN: thêm hoặc cập nhật đơn hàng
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String address = request.getParameter("shippingAddress");
                String status = request.getParameter("shippingStatus");
                String tracking = request.getParameter("trackingNumber");
                Date shippingDate = java.sql.Date.valueOf(request.getParameter("shippingDate"));
                Date estimatedDelivery = java.sql.Date.valueOf(request.getParameter("estimatedDelivery"));
                String notes = request.getParameter("deliveryNotes");
                int shipperId = Integer.parseInt(request.getParameter("shipperId"));

                Shipping s = new Shipping();
                s.setOrderId(orderId);
                s.setShippingAddress(address);
                s.setShippingStatus(status);
                s.setTrackingNumber(tracking);
                s.setShippingDate(shippingDate);
                s.setEstimatedDelivery(estimatedDelivery);
                s.setDeliveryNotes(notes);
                s.setUpdatedAt(new Date());
                s.setShipperId(shipperId);
                String idStr = request.getParameter("id");
                if (idStr == null || idStr.isEmpty()) {
                    shippingDAO.insertShipping(s);
                } else {
                    s.setId(Integer.parseInt(idStr));
                    shippingDAO.updateShipping(s);
                }

                response.sendRedirect("shipping");

            } else if (user.getRole_id() == 4 && "updateShippingStatus".equals(action)) {
                // SHIPPER cập nhật trạng thái đơn hàng

                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                shippingDAO.updateShippingStatus(id, status);
                response.sendRedirect("shipping");
            } else {
                response.sendRedirect("logincontroller");
            }
        } catch (Exception e) {
            throw new ServletException("Lỗi khi xử lý POST", e);
        }
    }

    private void listShipping(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
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

        // Tính offset
        // Lấy danh sách shipping theo trang
        List<Shipping> list = shippingDAO.getShippingByStatus(status, sortBy, sortDir, offset, limit);

        String ShipOke = "manager";
        request.setAttribute("ShipOke", ShipOke);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("shippingList", list);
        request.setAttribute("status", status);      // giữ lại filter
        request.setAttribute("sortBy", sortBy);      // giữ lại sort
        request.setAttribute("sortDir", sortDir);    // giữ lại sort

        RequestDispatcher dispatcher = request.getRequestDispatcher("/ManagerShipping/shippingList.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Shipping existing = shippingDAO.getShippingById(id);
        request.setAttribute("shipping", existing);
        try {
            List<User> shipperList = userDao.getUsersByRole(4);
            request.setAttribute("shipperList", shipperList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/ManagerShipping/editShipping.jsp");
        dispatcher.forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<User> shipperList = userDao.getUsersByRole(4);
            request.setAttribute("shipperList", shipperList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/ManagerShipping/createShipping.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteShipping(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        shippingDAO.deleteShipping(id);
        response.sendRedirect("shipping");
    }
}
