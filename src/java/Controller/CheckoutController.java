///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//
//package Controller;
//
//import Dao.CartDao;
//import Entity.CartItem;
//import Entity.User;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.util.List;
//
///**
// *
// * @author nguye
// */
//@WebServlet("/checkout")
//public class CheckoutController extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//        
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp");
//            return;
//        }
//
//        CartDao cartDao = new CartDao();
//        int cartId = cartDao.getCartIdByUserId(user.getUser_id());
//        List<CartItem> cartItems = cartDao.getCartItemsByCartId(cartId);
//        double total = cartDao.getTotalOrderPrice(cartId);
//
//        request.setAttribute("cartItems", cartItems);
//        request.setAttribute("totalOrderPrice", total);
//        request.getRequestDispatcher("/UserPage/checkout.jsp").forward(request, response);
//    }
//}
