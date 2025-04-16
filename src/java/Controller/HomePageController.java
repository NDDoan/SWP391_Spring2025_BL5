package controller;

import Dao.SliderDAO;
import Entity.Slider;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet(name = "HomePageServlet", urlPatterns = {"/homepage"})
public class HomePageController extends HttpServlet {

    // Database connection details
    private static final String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=swp391_spring2025_bl5";
    private static final String user = "your_user";
    private static final String pass = "your_pass";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ cơ sở dữ liệu
            Connection conn = DriverManager.getConnection(dbURL, user, pass);
            SliderDAO sliderDAO = new SliderDAO(conn);
            

            List<Slider> sliders = sliderDAO.getActiveSliders();
            

            // Đưa dữ liệu vào request
            request.setAttribute("sliders", sliders);
            

            conn.close();

            // Chuyển hướng đến JSP hiển thị
            RequestDispatcher dispatcher = request.getRequestDispatcher("/home.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading home page: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý post request nếu có
    }

    @Override
    public String getServletInfo() {
        return "HomePageServlet: Handles home page logic";
    }
}
