package controller;

import Dao.BlogDao;
import Entity.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogListController", urlPatterns = {"/blog-list"})
public class BlogListController extends HttpServlet {

    private static final int PAGE_SIZE = 5;  // Số blog mỗi trang
    private static final int LATEST_BLOG_LIMIT = 5; // Số blog mới nhất ở sidebar

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BlogDao dao = new BlogDao();

        // Lấy trang hiện tại
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        // Lấy dữ liệu từ DAO
        List<Blog> blogs = dao.getBlogs(page, PAGE_SIZE);
        List<Blog> latestBlogs = dao.getLatestBlogs(LATEST_BLOG_LIMIT);
        int totalBlogs = dao.countBlogs();
        int totalPages = (int) Math.ceil((double) totalBlogs / PAGE_SIZE);

        // Truyền dữ liệu sang JSP
        request.setAttribute("blogs", blogs);
        request.setAttribute("latestBlogs", latestBlogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Forward tới JSP
        request.getRequestDispatcher("blog-list.jsp").forward(request, response);
    }
}
