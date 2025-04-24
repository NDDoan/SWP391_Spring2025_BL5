package Controller;

import Dao.PostDao;
import EntityDto.PostDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogDetailController", urlPatterns = {"/BlogDetail"})
public class BlogDetailController extends HttpServlet {

    private static final int LATEST_BLOG_LIMIT = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            // Nếu không có id, chuyển về danh sách
            response.sendRedirect(request.getContextPath() + "/BlogList");
            return;
        }

        try {
            int postId = Integer.parseInt(idParam);
            PostDao dao = new PostDao();

            // Lấy chi tiết bài viết
            PostDto post = dao.getPostById(postId);
            // Nếu không tìm thấy hoặc status = false => quay lại list
            if (post == null || !post.isStatus()) {
                response.sendRedirect(request.getContextPath() + "/BlogList");
                return;
            }

            // Lấy 5 bài viết mới nhất để hiển thị sidebar
            List<PostDto> latestPosts = dao.getPosts(
                1,                           // trang 1
                LATEST_BLOG_LIMIT,           // số record
                null, null,                  // không filter category/author
                "1",                         // status = active
                null,                        // không tìm text
                "created_at", "DESC"         // sắp xếp theo created_at giảm dần
            );

            request.setAttribute("post", post);
            request.setAttribute("latestPosts", latestPosts);

            // Forward về JSP chi tiết
            RequestDispatcher rd = request.getRequestDispatcher("/CommonPage/BlogDetail.jsp");
            rd.forward(request, response);

        } catch (NumberFormatException ex) {
            // id không hợp lệ
            response.sendRedirect(request.getContextPath() + "/BlogList");
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}
