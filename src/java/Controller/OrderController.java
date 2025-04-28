/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DBContext.DBContext;
import Dao.CartDao;
import Dao.OrderDao;
import Dao.ShippingDAO;
import Dao.UserDao;
import Entity.Shipping;
import Entity.CartItem;
import Entity.User;
import Entity.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nguye
 */
@WebServlet("/ordercontroller")
public class OrderController extends HttpServlet {

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

        if (users == null) {
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp"); // hoặc về trang đăng nhập
            return;
        }
        int userId = users.getUser_id();
        CartDao cartDao = new CartDao();
        int cartId = cartDao.getCartIdByUserId(userId);

        List<CartItem> cartItems = cartDao.getCartItemsByCartId(cartId);
        double totalOrderPrice = cartDao.getTotalOrderPrice(cartId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalOrderPrice", totalOrderPrice);

        request.getRequestDispatcher("/CustomerPage/OrderSuccess.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User users = (User) request.getSession().getAttribute("user");
        if (users == null) {
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp");
            return;
        }
        int userId = users.getUser_id();

        String shippingAddress = request.getParameter("shippingAddress");
        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập địa chỉ giao hàng.");
            request.getRequestDispatcher("/UserPage/Login.jsp").forward(request, response);
            return;
        }

        CartDao cartDao = new CartDao();
        int cartId = cartDao.getCartIdByUserId(userId);
        List<CartItem> cartItems = cartDao.getCartItemsByCartId(cartId);

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CartDetailController?error=empty");
            return;
        }
        double totalAmount = cartItems.stream()
                .mapToDouble(item -> item.getQuantity() * item.getPrice())
                .sum();
        // Create Order
        Orders order = new Orders(0, userId, "Pending", totalAmount, null, null);
        OrderDao orderDao = new OrderDao();
        int orderId = 0;
        try {
            orderId = orderDao.createOrder(order);
        } catch (Exception ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (orderId > 0) {
            for (CartItem item : cartItems) {
                try {
                    orderDao.createOrderItem(orderId, item);
                } catch (Exception ex) {
                    Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            // Create Shippi
            Shipping s = new Shipping(0, orderId, shippingAddress, "Pending", "123", null, null, null, null);
            try {
                shippingDAO.insertShippingoke(s);
            } catch (SQLException ex) {
                Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                // Clear cart
                cartDao.clearCart(cartId);
            } catch (Exception ex) {
                Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect(request.getContextPath() + "/CustomerPage/CartDetail.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/CartDetailController?error=orderfail");
        }
    }

    @Override
    public String getServletInfo() {
        return "OrderController";
    }

}
