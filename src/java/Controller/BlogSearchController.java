package Controller;

import Dao.BlogDao;
import Entity.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogSearchController", urlPatterns = {"/BlogSearch"})
public class BlogSearchController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect("BlogList"); // nếu không có từ khóa thì quay lại blog list
            return;
        }

        BlogDao blogDao = new BlogDao();

        // Tìm kiếm bài viết theo từ khóa trong tiêu đề hoặc nội dung
        List<Blog> searchResults = blogDao.searchBlogsByKeyword(keyword);

        // Lấy các blog mới nhất để hiển thị sidebar
        List<Blog> latestBlogs = blogDao.getLatestBlogs(5);

        // Gửi dữ liệu sang JSP
        request.setAttribute("keyword", keyword);
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("latestBlogs", latestBlogs);

        request.getRequestDispatcher("/CommonPage/BlogSearch.jsp").forward(request, response);
    }
}
