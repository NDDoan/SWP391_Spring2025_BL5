package Controller;

import Dao.PostDao;
import EntityDto.PostDto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogListController", urlPatterns = {"/BlogListContrroller"})
public class BlogListController extends HttpServlet {

    private static final int PAGE_SIZE = 5;            // Số bài viết mỗi trang
    private static final int LATEST_BLOG_LIMIT = 5;    // Số bài viết mới ở sidebar

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PostDao dao = new PostDao();
        int page = 1;
        String pageParam = request.getParameter("page");
        String keyword = request.getParameter("keyword"); // Lấy từ khóa tìm kiếm

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {
            }
        }

        try {
            List<PostDto> posts;
            int totalPosts = 0;

            if (keyword != null && !keyword.trim().isEmpty()) {
                // Nếu có từ khóa tìm kiếm, sử dụng searchPostsByKeyword
                posts = dao.searchPostsByKeyword(keyword.trim());
                totalPosts = posts.size(); // Không phân trang khi tìm kiếm
                page = 1; // Reset về trang 1 khi tìm kiếm
            } else {
                // Không có từ khóa -> phân trang bình thường
                posts = dao.getPosts(
                        page,
                        PAGE_SIZE,
                        null, null,
                        "1", // status = true
                        null,
                        "created_at",
                        "DESC"
                );
                totalPosts = dao.countPosts("1", null, null, null);
            }

            // Lấy bài viết mới nhất cho sidebar
            List<PostDto> latestPosts = dao.getLatestBlogs(LATEST_BLOG_LIMIT);

            int totalPages = (int) Math.ceil((double) totalPosts / PAGE_SIZE);

            request.setAttribute("posts", posts);
            request.setAttribute("latestPosts", latestPosts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keyword", keyword); // Truyền keyword lại để giữ trên form

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tải danh sách bài viết.");
        }

        request.getRequestDispatcher("/CommonPage/BlogList.jsp").forward(request, response);
    }
}
