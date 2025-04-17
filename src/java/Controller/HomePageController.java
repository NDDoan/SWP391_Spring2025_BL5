//
//package controller;
//
//import Dao.PostDAO;
//import Dao.SliderDAO;
//import Entity.Post;
//import Entity.Slider;
//import dao.SliderDAO;
//import dao.PostDAO;
//import dao.ProductDAO;
//import model.Slider;
//import model.Post;
//import model.Product;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.Cookie;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//import java.sql.*;
//import java.util.List;
//
//@WebServlet(name = "HomePageServlet", urlPatterns = {"/home"})
//public class HomePageServlet extends HttpServlet {
//
//    // Database connection details
//    private static final String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=swp391_spring2025_bl5";
//    private static final String user = "your_user";
//    private static final String pass = "your_pass";
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            // Lấy dữ liệu từ cơ sở dữ liệu
//            Connection conn = DriverManager.getConnection(dbURL, user, pass);
//            SliderDAO sliderDAO = new SliderDAO(conn);
//            PostDAO postDAO = new PostDAO(conn);
//            ProductDAO productDAO = new ProductDAO(conn);
//
//            List<Slider> sliders = sliderDAO.getActiveSliders();
//            List<Post> hotPosts = postDAO.getFeaturedPosts();
//            List<Post> latestPosts = postDAO.getLatestPosts();
//            List<Product> featuredProducts = productDAO.getFeaturedProducts();
//
//            // Đưa dữ liệu vào request
//            request.setAttribute("sliders", sliders);
//            request.setAttribute("hotPosts", hotPosts);
//            request.setAttribute("latestPosts", latestPosts);
//            request.setAttribute("featuredProducts", featuredProducts);
//
//            conn.close();
//
//            // Chuyển hướng đến JSP hiển thị
//            RequestDispatcher dispatcher = request.getRequestDispatcher("/home.jsp");
//            dispatcher.forward(request, response);
//
//        } catch (Exception e) {
//            throw new ServletException("Error loading home page: " + e.getMessage());
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Xử lý post request nếu có
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "HomePageServlet: Handles home page logic";
//    }
//}