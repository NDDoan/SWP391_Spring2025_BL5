package Controller;

import Dao.CategoryDao;
import Dao.ProductDao;
import Dao.PostDao;
import Dao.SliderDAO;
import Entity.Slider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomepageController", urlPatterns = {"/home"})
public class HomePageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Khởi tạo DAO
            ProductDao productDao = new ProductDao();
            SliderDAO sliderDao = new SliderDAO();
            CategoryDao categoryDao = new CategoryDao();
            PostDao postDao = new PostDao();

            

            // Lấy danh sách slider
            List<Slider> sliders = sliderDao.getAllSliders();

            

            // Truyền dữ liệu sang JSP
            
            request.setAttribute("sliders", sliders);
            

            // Forward sang trang JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/UserPage/HomePage.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
