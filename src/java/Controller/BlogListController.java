package Controller;

import Dao.PostDao;
import EntityDto.PostDto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogListController", urlPatterns = {"/BlogList"})
public class BlogListController extends HttpServlet {

    private static final int PAGE_SIZE = 5;            // Số bài viết mỗi trang
    private static final int LATEST_BLOG_LIMIT = 5;    // Số bài viết mới ở sidebar

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PostDao dao = new PostDao();
        int page = 1;
        String pageParam = request.getParameter("page");

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {
            }
        }

        try {
            // Lấy danh sách bài viết theo phân trang
            List<PostDto> posts = dao.getPosts(
                    page,
                    PAGE_SIZE,
                    null, null,
                    "1", // status = true
                    null,
                    "created_at",
                    "DESC"
            );

            // Lấy bài viết mới nhất
            List<PostDto> latestPosts = dao.getPosts(
                    1,
                    LATEST_BLOG_LIMIT,
                    null, null,
                    "1",
                    null,
                    "created_at",
                    "DESC"
            );

            // Tổng số bài viết (có status=true)
            int totalPosts = dao.countPosts("1", null, null, null);
            int totalPages = (int) Math.ceil((double) totalPosts / PAGE_SIZE);

            // Truyền sang JSP
            request.setAttribute("blogs", posts);
            request.setAttribute("latestBlogs", latestPosts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tải danh sách bài viết.");
        }

        // Forward
        request.getRequestDispatcher("/CommonPage/BlogList.jsp").forward(request, response);
    }
}
