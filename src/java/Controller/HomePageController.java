package Controller;

import Dao.CategoryDao;
import Dao.ProductDao;
import Entity.Category;
import Entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomepageController", urlPatterns = {"/HomePage"})
public class HomePageController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDao productDAO = new ProductDao();
        CategoryDao categoryDAO = new CategoryDao();

        
        List<Category> categories = categoryDAO.getAllCategories();

        
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("homepage.jsp").forward(request, response);
    }
}

