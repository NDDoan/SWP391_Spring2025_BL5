/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.ProductDao;
import EntityDto.ProductDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author LENOVO
 */
public class ProductForManagerDetailController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Lấy tham số mode: view, edit hoặc add
        String mode = request.getParameter("mode");
        if (mode == null || mode.trim().isEmpty()) {
            mode = "view";   // Mặc định chế độ xem nếu không có
        }

        // Nếu ở chế độ add thì không cần productId, tạo đối tượng rỗng
        ProductDto product = null;
        if ("add".equalsIgnoreCase(mode)) {
            product = new ProductDto();
        } else {
            // Chế độ view hoặc edit: yêu cầu productId
            String productIdParam = request.getParameter("productId");
            int productId = 0;
            try {
                productId = Integer.parseInt(productIdParam);
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Không tìm thấy ProductId hợp lệ");
                RequestDispatcher dispatcher = request.getRequestDispatcher("ManagerPage/error.jsp");
                dispatcher.forward(request, response);
                return;
            }

            ProductDao dao = new ProductDao();
            product = dao.getProductById(productId);
            if (product == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin sản phẩm.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("ManagerPage/error.jsp");
                dispatcher.forward(request, response);
                return;
            }
        }

        // Đưa thông tin product và mode vào request để JSP xử lý hiển thị phù hợp
        request.setAttribute("product", product);
        request.setAttribute("mode", mode);

        RequestDispatcher dispatcher = request.getRequestDispatcher("ManagerPage/ProductDetail.jsp");
        dispatcher.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý submit của form trong chế độ edit hoặc add: gọi method updateProduct hoặc addProduct từ ProductDao.
        // Ví dụ đơn giản dưới đây chỉ demo, bạn cần bổ sung kiểm tra và thông báo đầy đủ.

        // Lấy chế độ từ request (edit hoặc add)
        String mode = request.getParameter("mode");
        ProductDao dao = new ProductDao();
        if ("edit".equalsIgnoreCase(mode)) {
            // Thực hiện cập nhật sản phẩm
            // Lấy dữ liệu form và xây dựng ProductDto
            ProductDto product = new ProductDto();
            product.setProductId(Integer.parseInt(request.getParameter("productId")));
            product.setProductName(request.getParameter("productName"));
            product.setBrandName(request.getParameter("brandName"));
            product.setCategoryName(request.getParameter("categoryName"));
            product.setDescription(request.getParameter("description"));
            // Các xử lý variants và media có thể thêm ở đây (ví dụ, xử lý danh sách từ các input)

            boolean updated = dao.updateProduct(product);
            if (updated) {
                request.setAttribute("message", "Cập nhật sản phẩm thành công.");
            } else {
                request.setAttribute("message", "Cập nhật sản phẩm thất bại.");
            }
        } else if ("add".equalsIgnoreCase(mode)) {
            // Thực hiện thêm mới sản phẩm
            ProductDto product = new ProductDto();
            product.setProductName(request.getParameter("productName"));
            product.setBrandName(request.getParameter("brandName"));
            product.setCategoryName(request.getParameter("categoryName"));
            product.setDescription(request.getParameter("description"));
            // Các xử lý variants và media có thể thêm ở đây

            int newId = dao.addProduct(product);
            if (newId > 0) {
                request.setAttribute("message", "Thêm sản phẩm thành công.");
                product = dao.getProductById(newId);
            } else {
                request.setAttribute("message", "Thêm sản phẩm thất bại.");
            }
            request.setAttribute("product", product);
        }

        // Sau khi xử lý POST, chuyển sang chế độ view
        // (Có thể chuyển đổi sang edit nếu cần)
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
