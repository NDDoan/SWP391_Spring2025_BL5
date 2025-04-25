package Controller;

import Dao.PostDao;
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

    private static final int PAGE_SIZE = 5;
    private static final int LATEST_BLOG_LIMIT = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PostDao dao = new PostDao();
        int page = 1;
        String pageParam = request.getParameter("page");
        String keyword = request.getParameter("keyword");

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        try {
            List<PostDto> posts;
            int totalPosts;
            int totalPages;

            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm bài viết theo keyword
                posts = dao.searchPostsByKeyword(keyword.trim());
                totalPosts = posts.size();
                totalPages = 1;
                request.setAttribute("keyword", keyword);
            } else {
                // Lấy danh sách phân trang, lọc status = true
                posts = dao.getPosts(
                        page,
                        PAGE_SIZE,
                        null, // categoryId
                        null, // authorId
                        null, // status => bỏ lọc status
                        null, // searchTitle
                        "created_at",
                        "DESC"
                );

                totalPosts = dao.countPosts(
                        null, // categoryId
                        null, // authorId
                        null, // status => bỏ lọc status
                        null // searchTitle
                );

                totalPages = (int) Math.ceil((double) totalPosts / PAGE_SIZE);
            }

            // Lấy bài viết nổi bật
            List<PostDto> latestPosts = dao.getLatestBlogs(LATEST_BLOG_LIMIT);

            request.setAttribute("posts", posts);
            request.setAttribute("latestPosts", latestPosts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách bài viết.");
        }

        request.getRequestDispatcher("/CommonPage/BlogList.jsp").forward(request, response);
    }
}
