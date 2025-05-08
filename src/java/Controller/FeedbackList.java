package Controller;

import Dao.FeedbackDao;
import EntityDto.FeedbackDto;
import Entity.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet quản lý danh sách phản hồi cho trang Admin
 */
@WebServlet(name = "FeedbackList", urlPatterns = {"/FeedbackList"})
public class FeedbackList extends HttpServlet {

    /**
     * Xử lý chung cho cả GET và POST
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập mã hóa và kiểu trả về
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Kiểm tra xem user đã đăng nhập và có quyền Admin (role_id == 1) chưa
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole_id() != 1) {
            // Nếu chưa hoặc không phải admin, chuyển về trang login
            response.sendRedirect(request.getContextPath() + "/logincontroller");
            return;
        }

        try {

            String action = request.getParameter("action");
            if ("changeStatus".equals(action)) {
                try {
                    int reviewId = Integer.parseInt(request.getParameter("id"));
                    boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));

                    FeedbackDao feedbackDao = new FeedbackDao();
                    boolean result = feedbackDao.updateFeedbackStatus(reviewId, newStatus);

                    // Gửi lại về trang FeedbackList sau khi cập nhật
                    response.sendRedirect("FeedbackList?page=" + request.getParameter("page"));
                    return;

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Không thể cập nhật trạng thái: " + e.getMessage());
                    request.getRequestDispatcher("/AdminPage/error.jsp").forward(request, response);
                    return;
                }
            }

            // 1. Đọc tham số lọc và phân trang từ request
            String searchKeyword = request.getParameter("search");

            Integer productId = null;
            if (request.getParameter("productId") != null && !request.getParameter("productId").isEmpty()) {
                productId = Integer.parseInt(request.getParameter("productId"));
            }

            Integer rating = null;
            if (request.getParameter("rating") != null && !request.getParameter("rating").isEmpty()) {
                rating = Integer.parseInt(request.getParameter("rating"));
            }

            Boolean status = null;
            if (request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
                status = "true".equals(request.getParameter("status"));
            }

            String sortBy = request.getParameter("sortBy");    // cột sắp xếp
            String sortOrder = request.getParameter("sortOrder"); // thứ tự tăng/giảm

            int page = 1;   // trang hiện tại
            int pageSize = 10;  // số phần tử mỗi trang

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            if (request.getParameter("pageSize") != null) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }

            // 2. Khởi tạo DAO và lấy tổng số feedback để tính phân trang
            FeedbackDao feedbackDao = new FeedbackDao();
            int totalFeedbacks = feedbackDao.getTotalFeedbacks(
                    searchKeyword, productId, rating, status);
            int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);

            // 3. Lấy danh sách feedback đã lọc, sắp xếp, phân trang
            List<FeedbackDto> feedbackList = feedbackDao.getFeedbackList(
                    page, pageSize,
                    searchKeyword, productId, rating, status,
                    sortBy, sortOrder);

            // 4. Lấy danh sách sản phẩm để hiển thị trong dropdown lọc
            List<FeedbackDao.Product> productList = feedbackDao.getAllProducts();

            // 5. Đặt các giá trị vào request scope để JSP hiển thị
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("productList", productList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("selectedProductId", productId);
            request.setAttribute("selectedRating", rating);
            request.setAttribute("selectedStatus", status);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);

            // 6. Chuyển tiếp tới trang JSP quản lý feedback
            request.getRequestDispatcher("/AdminPage/FeedbackList.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            // Bắt lỗi, in stack trace và chuyển tới trang lỗi
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/AdminPage/error.jsp")
                    .forward(request, response);
        }
    }

    /**
     * Xử lý HTTP GET gọi chung vào processRequest
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Xử lý HTTP POST gọi chung vào processRequest
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Thông tin ngắn về servlet
     */
    @Override
    public String getServletInfo() {
        return "Servlet quản lý danh sách feedback";
    }
}
