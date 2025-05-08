package Controller;

import Dao.OrderDao;
import Entity.FeedbackImage;
import Entity.Review;
import Dao.ReviewDao;
import Dao.ProductDao;
import Entity.OrderItems;
import Entity.Orders;
import EntityDto.ProductFeedbackDto;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "CustomerSendFeedbackController", urlPatterns = {"/CustomerSendFeedback"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // ngưỡng kích thước file 1MB
        maxFileSize = 1024 * 1024 * 15, // giới hạn file tải lên 15MB
        maxRequestSize = 1024 * 1024 * 50 // tổng kích thước request 50MB
)
public class CustomerSendFeedbackController extends HttpServlet {

    /**
     * Xử lý chung cho cả GET và POST (nếu cần mở rộng)
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // TODO: thêm xử lý chung (nếu có)
    }

    /**
     * Xử lý HTTP GET: hiển thị form gửi feedback
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy orderId từ tham số URL
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr == null || orderIdStr.isEmpty()) {
                // Nếu không có orderId, chuyển về trang danh sách đơn
                response.sendRedirect("myordercontroller");
                return;
            }

            int orderId = Integer.parseInt(orderIdStr);

            // Kiểm tra session và user đã đăng nhập
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                // Chưa đăng nhập, chuyển đến trang login
                response.sendRedirect("logincontroller");
                return;
            }

            // Lấy đơn hàng từ DB
            OrderDao orderDao = new OrderDao();
            Orders order = orderDao.getOrderByIdd(orderId);

            // Kiểm tra đơn hàng hợp lệ: tồn tại, thuộc người dùng, đã hoàn thành
            if (order == null || order.getUserId() != userId
                    || !"Completed".equals(order.getOrderStatus())) {
                // Không hợp lệ -> quay về trang danh sách
                response.sendRedirect("myordercontroller");
                return;
            }

            // Lấy chi tiết các sản phẩm trong đơn
            List<OrderItems> orderItems = orderDao.getOrderItems(orderId);

            // Chuẩn bị DTO để hiển thị feedback
            ProductDao productDao = new ProductDao();
            ReviewDao reviewDao = new ReviewDao();
            List<ProductFeedbackDto> products = new ArrayList<>();

            for (OrderItems item : orderItems) {
                ProductFeedbackDto dto = new ProductFeedbackDto();
                dto.setId(item.getProductId());
                // TODO: set thêm tên, ảnh, giá, số lượng nếu cần

                // Kiểm tra user đã review sản phẩm này trong đơn chưa
                int existingReviewId = reviewDao.getUserReviewForProductInOrder(
                        userId, item.getProductId(), orderId);
                if (existingReviewId > 0) {
                    // Nếu đã có review, lấy review để pre-fill form
                    //Nếu đã có, thì giao diện hiển thị ở chế độ xem-only, không cho gửi thêm nữa.
                    Review existingReview = reviewDao.getReviewById(existingReviewId);
                    if (existingReview != null) {
                        request.setAttribute("existingReview_" + item.getProductId(), existingReview);

                        // Lấy ảnh review nếu có
                        List<FeedbackImage> images = reviewDao.getImagesByReviewId(existingReviewId);
                        request.setAttribute("reviewImages_" + item.getProductId(), images);
                    }
                }

                products.add(dto);
            }

            // Đẩy dữ liệu sang JSP để hiển thị form feedback
            request.setAttribute("orderId", orderId);
            request.setAttribute("products", products);
            request.getRequestDispatcher("CustomerPage/CustomerSendFeedback.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            // In lỗi và chuyển về trang danh sách đơn
            e.printStackTrace();
            response.sendRedirect("myordercontroller");
        }
    }

    /**
     * Xử lý HTTP POST: thêm/cập nhật/xóa feedback
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy các tham số từ form
            String orderIdStr = request.getParameter("orderId");
            String productIdStr = request.getParameter("productId");
            String ratingStr = request.getParameter("rating");
            String comment = request.getParameter("comment");
            String action = request.getParameter("action"); // 'add', 'update', hoặc 'delete'
            String reviewIdStr = request.getParameter("reviewId"); // Dùng cho cập nhật/xóa

            // Kiểm tra các trường bắt buộc
            if (orderIdStr == null || productIdStr == null) {
                request.setAttribute("errorMessage", "Tham số yêu cầu không hợp lệ");
                doGet(request, response);
                return;
            }

            // Chuyển chuỗi sang số
            int orderId = Integer.parseInt(orderIdStr);
            int productId = Integer.parseInt(productIdStr);

            // Lấy userId từ session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                response.sendRedirect("login");
                return;
            }

            ReviewDao reviewDao = new ReviewDao();
            ProductDao productDao = new ProductDao();

            // Xử lý hành động xóa
            if ("delete".equals(action) && reviewIdStr != null) {
                int reviewId = Integer.parseInt(reviewIdStr);

                // Kiểm tra quyền sở hữu trước khi xóa
                Review review = reviewDao.getReviewById(reviewId);
                if (review != null && review.getUserId() == userId) {
                    // Xóa hình ảnh trước
                    reviewDao.deleteReviewImages(reviewId);

                    // Rồi xóa phản hồi
                    if (reviewDao.deleteReview(reviewId)) {
                        request.setAttribute("successMessage", "Phản hồi của bạn đã được xóa thành công.");

                        // Cập nhật đánh giá trung bình của sản phẩm
//                  productDao.updateProductAverageRating(productId);
                    } else {
                        request.setAttribute("errorMessage", "Không xóa được phản hồi. Vui lòng thử lại.");
                    }
                } else {
                    request.setAttribute("errorMessage", "Bạn không có quyền xóa phản hồi này.");
                }

                doGet(request, response);
                return;
            }

            // Với hành động thêm hoặc cập nhật, kiểm tra rating và comment
            if (ratingStr == null || comment == null) {
                request.setAttribute("errorMessage", "Đánh giá và bình luận là bắt buộc");
                doGet(request, response);
                return;
            }

            int rating = Integer.parseInt(ratingStr);

            // Xử lý hành động cập nhật
            if ("update".equals(action) && reviewIdStr != null) {
                int reviewId = Integer.parseInt(reviewIdStr);

                // Kiểm tra quyền sở hữu trước khi cập nhật
                Review existingReview = reviewDao.getReviewById(reviewId);
                if (existingReview != null && existingReview.getUserId() == userId) {
                    // Cập nhật nội dung phản hồi
                    existingReview.setRating(rating);
                    existingReview.setComment(comment);
                    existingReview.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                    existingReview.setStatus(false); // Reset trạng thái chờ duyệt lại

                    if (reviewDao.updateReview(existingReview)) {
                        // Xử lý cập nhật hình ảnh nếu cần
                        boolean deleteImages = "true".equals(request.getParameter("deleteImages"));
                        if (deleteImages) {
                            reviewDao.deleteReviewImages(reviewId);
                        }

                        // Tải lên hình ảnh mới
                        handleImageUploads(request, reviewId, reviewDao);

                        request.setAttribute("successMessage", "Phản hồi của bạn đã được cập nhật và đang chờ phê duyệt.");

                        // Cập nhật đánh giá trung bình của sản phẩm
//                  productDao.updateProductAverageRating(productId);
                    } else {
                        request.setAttribute("errorMessage", "Không cập nhật được phản hồi. Vui lòng thử lại.");
                    }
                } else {
                    request.setAttribute("errorMessage", "Bạn không có quyền cập nhật phản hồi này.");
                }

                doGet(request, response);
                return;
            }

            // Xử lý thêm mới phản hồi
            Review review = new Review();
            review.setProductId(productId);
            review.setUserId(userId);
            review.setRating(rating);
            review.setComment(comment);
            review.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            review.setStatus(false); // Ban đầu để false, admin sẽ duyệt sau

            // Lưu phản hồi vào cơ sở dữ liệu
            int reviewId = reviewDao.addReview(review);

            if (reviewId > 0) {
                // Xử lý tải hình ảnh
                handleImageUploads(request, reviewId, reviewDao);

                request.setAttribute("successMessage", "Phản hồi của bạn đã được gửi và đang chờ phê duyệt. Cảm ơn bạn!");

                // Cập nhật đánh giá trung bình của sản phẩm
//          productDao.updateProductAverageRating(productId);
            } else {
                request.setAttribute("errorMessage", "Không thể gửi phản hồi. Vui lòng thử lại.");
            }

            // Quay lại trang hiển thị phản hồi
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            doGet(request, response);
        }
    }

    /**
     * Phương thức trợ giúp để xử lý việc tải lên hình ảnh và video
     */
    private void handleImageUploads(HttpServletRequest request, int reviewId, ReviewDao reviewDao) throws Exception {
        // Danh sách các phần multipart chứa file
        List<Part> fileParts = new ArrayList<>();

        // In thông tin debug tổng số phần
        System.out.println("Total parts: " + request.getParts().size());
        for (Part part : request.getParts()) {
            System.out.println("Part name: " + part.getName() + ", size: " + part.getSize());
            // Lọc các phần có tên "media" hoặc "media[]" và có kích thước > 0
            if ((part.getName().equals("media") || part.getName().equals("media[]")) && part.getSize() > 0) {
                fileParts.add(part);
                System.out.println("Added file part: " + getFileName(part) + ", size: " + part.getSize());
            }
        }

        System.out.println("Total file parts: " + fileParts.size());

        // Giới hạn số lượng file tối đa là 5
        if (fileParts.size() > 5) {
            throw new Exception("Bạn chỉ được phép tải tối đa 5 tệp media.");
        }

        if (!fileParts.isEmpty()) {
            // Xác định thư mục upload (đường dẫn tuyệt đối)
            String uploadPath = request.getServletContext().getRealPath("/") + "uploads/feedback";
            File uploadDir = new File(uploadPath);

            // Nếu thư mục chưa tồn tại, tạo mới
            if (!uploadDir.exists()) {
                if (!uploadDir.mkdirs()) {
                    System.out.println("Failed to create directory: " + uploadPath);
                    throw new Exception("Tạo thư mục upload thất bại.");
                }
            }

            System.out.println("Upload directory: " + uploadPath);

            int successfulUploads = 0;
            StringBuilder errorMessages = new StringBuilder();

            // Xử lý từng file trong danh sách
            for (Part filePart : fileParts) {
                try {
                    String fileName = getFileName(filePart);
                    String contentType = filePart.getContentType();
                    boolean isVideo = false;

                    // Xác định đây có phải file video không
                    if (contentType != null) {
                        isVideo = contentType.startsWith("video/");
                    } else {
                        // Nếu contentType rỗng, kiểm tra dựa vào phần mở rộng
                        String extension = fileName.substring(fileName.lastIndexOf('.')).toLowerCase();
                        isVideo = extension.equals(".mp4") || extension.equals(".webm") || extension.equals(".mov");
                    }

                    // Giới hạn dung lượng: 5MB cho ảnh, 15MB cho video
                    long maxSize = isVideo ? 15 * 1024 * 1024 : 5 * 1024 * 1024;
                    if (filePart.getSize() > maxSize) {
                        errorMessages.append("Tệp ").append(fileName)
                                .append(" vượt quá giới hạn ").append(isVideo ? "15MB" : "5MB")
                                .append(". Bỏ qua.\n");
                        continue; // Tạm bỏ qua file này
                    }

                    // Kiểm tra định dạng video hợp lệ
                    if (isVideo && !isValidVideoType(contentType)) {
                        errorMessages.append("Tệp ").append(fileName)
                                .append(" là định dạng video không được hỗ trợ. Chỉ cho phép MP4, WebM, QuickTime.\n");
                        continue;
                    }

                    // Tạo tên file duy nhất tránh trùng lặp
                    String fileExtension = fileName.substring(fileName.lastIndexOf('.'));
                    String uniqueFileName = System.currentTimeMillis() + "_" + successfulUploads + fileExtension;
                    String filePath = uploadPath + File.separator + uniqueFileName;

                    // Ghi file xuống ổ đĩa
                    filePart.write(filePath);
                    System.out.println("File saved to: " + filePath);

                    // Lưu thông tin file vào database (dùng bảng FeedbackImage chung)
                    // Sau khi file đã được ghi vào ổ đĩa
                    FeedbackImage media = new FeedbackImage();
                    media.setReviewId(reviewId);
                    // **Đây là chỗ bạn gán URL sẽ lưu vào DB**
                    media.setImageUrl("uploads/feedback/" + uniqueFileName);
                    media.setCreatedAt(new Timestamp(System.currentTimeMillis()));

                    if (reviewDao.addFeedbackImage(media)) {
                        successfulUploads++;
                        System.out.println("Đã lưu bản ghi media vào CSDL");
                    } else {
                        errorMessages.append("Không lưu được bản ghi media cho ").append(fileName).append("\n");
                    }
                } catch (Exception e) {
                    errorMessages.append("Lỗi xử lý tệp ").append(getFileName(filePart))
                            .append(": ").append(e.getMessage()).append("\n");
                    e.printStackTrace();
                }
            }

            // Xử lý thông báo lỗi nếu có
            if (errorMessages.length() > 0) {
                if (successfulUploads == 0) {
                    // Nếu không file nào thành công thì ném Exception
                    throw new Exception("Tải media thất bại: " + errorMessages.toString());
                } else {
                    // Nếu chỉ một số file thất bại thì hiển thị cảnh báo
                    request.setAttribute("warningMessage", errorMessages.toString());
                }
            }
        }
    }

    /**
     * Kiểm tra xem định dạng video có được hỗ trợ không
     */
    private boolean isValidVideoType(String contentType) {
        if (contentType == null) {
            return false;
        }
        return contentType.equals("video/mp4")
                || contentType.equals("video/webm")
                || contentType.equals("video/quicktime");
    }

    /**
     * Phương thức lấy tên file từ Part
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        System.out.println("Content-Disposition: " + contentDisp);

        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                // Nếu tên file rỗng thì trả về "unknown_file"
                return fileName.isEmpty() ? "unknown_file" : fileName;
            }
        }
        return "unknown_file";
    }

    @Override
    public String getServletInfo() {
        return "Customer Feedback Controller";
    }
}
