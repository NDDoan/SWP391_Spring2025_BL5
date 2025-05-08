package Controller;

import Dao.BlogDao;
import EntityDto.PostDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogDetailController", urlPatterns = {"/BlogDetailController"})
public class BlogDetailController extends HttpServlet {

    private final BlogDao blogDao = new BlogDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postIdParam = request.getParameter("postId");
        try {
            if (postIdParam == null) {
                throw new IllegalArgumentException("Thiếu tham số postId.");
            }

            int postId = Integer.parseInt(postIdParam);
            // Lấy chi tiết bài viết (có thể là draft hoặc published tuỳ nhu cầu)
            PostDto post = blogDao.getBlogById(postId);
            if (post == null) {
                request.setAttribute("errorMessage", "Không tìm thấy bài viết với ID=" + postId);
            } else {
                request.setAttribute("post", post);
            }

        } catch (NumberFormatException ex) {
            request.setAttribute("errorMessage", "postId phải là số nguyên hợp lệ.");
        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Không thể tải chi tiết bài viết: " + ex.getMessage());
        }

        // Luôn lấy danh sách 5 bài mới nhất cho sidebar
        try {
            List<PostDto> newestList = blogDao.getNewestBlogPosts(5);
            request.setAttribute("newestList", newestList);
        } catch (Exception ex) {
            // Nếu lỗi thì ta vẫn forward, chỉ không có newestList
            log("Lỗi khi lấy bài mới nhất", ex);
        }

        // Chuyển tiếp tới JSP chi tiết
        RequestDispatcher rd = request.getRequestDispatcher("/CommonPage/BlogDetail.jsp");
        rd.forward(request, response);
    }
}
