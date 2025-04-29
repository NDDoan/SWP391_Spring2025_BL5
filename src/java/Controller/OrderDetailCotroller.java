package Controller;

import Dao.OrderDao;
import EntityDto.OrderDto;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.PrintWriter;
import java.sql.*;

public class OrderDetailCotroller extends HttpServlet {
    
    private OrderDao orderDAO = new OrderDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdStr);
        
        // Lấy thông tin chi tiết đơn hàng từ OrderDao
        OrderDto order = orderDAO.getOrderById(orderId);
        
        // Trả về thông tin đơn hàng dưới dạng JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("{");
        out.println("\"orderId\": \"" + order.getOrderId() + "\",");
        out.println("\"orderDate\": \"" + order.getOrderDate() + "\",");
        out.println("\"productNames\": \"" + String.join(", ", order.getProductNames()) + "\",");
        out.println("\"totalCost\": \"" + order.getTotalCost() + "\",");
        out.println("\"status\": \"" + order.getStatus() + "\"");
        out.println("}");
    }
}
