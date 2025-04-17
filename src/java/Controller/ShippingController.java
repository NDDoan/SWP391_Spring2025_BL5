package Controller;

import Dao.ShippingDAO;
import Entity.Shipping;
import DBContext.DBContext;
import Entity.User;

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

    @Override
    public void init() {
        try {
            Connection conn = new DBContext().getConnection();
            shippingDAO = new ShippingDAO(conn);
        } catch (Exception e) {
            throw new RuntimeException("Cannot connect to database", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession session = request.getSession();
        User users = (User) session.getAttribute("user");

        if (users == null || users.getRole_id() != 1) {
            response.sendRedirect("logincontroller");
            return;
        }
        String action = request.getParameter("action");

        try {
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
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listShipping(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String status = request.getParameter("status");

        List<Shipping> list;
        if (status != null && !status.isEmpty()) {
            list = shippingDAO.getShippingByStatus(status);
            request.setAttribute("statusFilter", status);
        } else {
            list = shippingDAO.getAllShipping();
        }

        request.setAttribute("shippingList", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/ManagerShipping/shippingList.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Shipping existing = shippingDAO.getShippingById(id);
        request.setAttribute("shipping", existing);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/ManagerShipping/editShipping.jsp");
        dispatcher.forward(request, response);
    }
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/ManagerShipping/createShipping.jsp");
        dispatcher.forward(request, response);
    }
    private void deleteShipping(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        shippingDAO.deleteShipping(id);
        response.sendRedirect("shipping");
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
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String address = request.getParameter("shippingAddress");
            String status = request.getParameter("shippingStatus");
            String tracking = request.getParameter("trackingNumber");
            Date shippingDate = java.sql.Date.valueOf(request.getParameter("shippingDate"));
            Date estimatedDelivery = java.sql.Date.valueOf(request.getParameter("estimatedDelivery"));
            String notes = request.getParameter("deliveryNotes");

            Shipping s = new Shipping();
            s.setOrderId(orderId);
            s.setShippingAddress(address);
            s.setShippingStatus(status);
            s.setTrackingNumber(tracking);
            s.setShippingDate(shippingDate);
            s.setEstimatedDelivery(estimatedDelivery);
            s.setDeliveryNotes(notes);
            s.setUpdatedAt(new Date());

            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                shippingDAO.insertShipping(s);
            } else {
                s.setId(Integer.parseInt(idStr));
                shippingDAO.updateShipping(s);
            }

            response.sendRedirect("shipping");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
