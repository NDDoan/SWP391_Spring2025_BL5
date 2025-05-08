package Controller;

import Dao.BlogDao;
import EntityDto.PostDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet hiển thị danh sách bài viết với phân trang và tìm kiếm.
 */
@WebServlet(name = "BlogListController", urlPatterns = {"/BlogListController"})
public class BlogListController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BlogDao blogDao;

    @Override
    public void init() throws ServletException {
        super.init();
        blogDao = new BlogDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Handle search keyword if provided
            String keyword = request.getParameter("search");
            List<PostDto> blogList;
            if (keyword != null && !keyword.trim().isEmpty()) {
                blogList = blogDao.searchBlog(keyword);
                request.setAttribute("searchKeyword", keyword);
            } else {
                blogList = blogDao.getAllPublishedBlogs();
            }

            // Fetch newest posts, e.g., top 5
            List<PostDto> newestList = blogDao.getNewestBlogPosts(5);

            // Set attributes for JSP
            request.setAttribute("blogList", blogList);
            request.setAttribute("newestList", newestList);
        } catch (Exception e) {
            // Log exception (could use a logger)
            System.err.println("Error fetching blog list: " + e.getMessage());
            request.setAttribute("errorMessage", "Không thể tải danh sách bài viết.");
        }

        // Forward to JSP page for rendering
        request.getRequestDispatcher("/CommonPage/BlogList.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        // Clean up resources if necessary
        super.destroy();
    }
}
