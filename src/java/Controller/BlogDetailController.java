package controller;

import Dao.BlogDao;
import Entity.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "BlogDetailController", urlPatterns = {"/BlogDetail"})
public class BlogDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("BlogList");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            BlogDao dao = new BlogDao();
            Blog blog = dao.getBlogById(id);

            if (blog == null) {
                response.sendRedirect("BlogList");
                return;
            }

            request.setAttribute("blog", blog);
            request.getRequestDispatcher("BlogDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("BlogList");
        }
    }
}
