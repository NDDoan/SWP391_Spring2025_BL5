package Controller;

import Dao.PostDao;
import EntityDto.PostDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogDetailController", urlPatterns = {"/BlogDetailController"})
public class BlogDetailController extends HttpServlet {

    private static final int LATEST_BLOG_LIMIT = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/BlogListController");
            return;
        }

        PostDto post;
        try {
            int postId = Integer.parseInt(idParam);
            PostDao dao = new PostDao();
            post = dao.getPostById(postId);
        } catch (NumberFormatException ex) {
            // ID không hợp lệ
            response.sendRedirect(request.getContextPath() + "/BlogListController");
            return;
        } catch (Exception ex) {
            // Lỗi khi truy vấn dữ liệu
            response.sendRedirect(request.getContextPath() + "/BlogListController");
            return;
        }

        if (post == null) {
            response.sendRedirect(request.getContextPath() + "/BlogListController");
            return;
        }

        List<PostDto> latestPosts;
        try {
            latestPosts = new PostDao().getLatestBlogs(LATEST_BLOG_LIMIT);
        } catch (Exception ex) {
            throw new ServletException("Lỗi khi lấy bài viết nổi bật", ex);
        }

        request.setAttribute("post", post);
        request.setAttribute("latestPosts", latestPosts);

        RequestDispatcher rd = request.getRequestDispatcher("/CommonPage/BlogDetail.jsp");
        rd.forward(request, response);
    }
}