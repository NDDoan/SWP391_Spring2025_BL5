package controller;

import Dao.BlogDao;
import Entity.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "BlogDetailController", urlPatterns = {"/blog-detail"})
public class BlogDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("blog-list");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            BlogDao dao = new BlogDao();
            Blog blog = dao.getBlogById(id);

            if (blog == null) {
                response.sendRedirect("blog-list");
                return;
            }

            request.setAttribute("blog", blog);
            request.getRequestDispatcher("blog-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("blog-list");
        }
    }
}
