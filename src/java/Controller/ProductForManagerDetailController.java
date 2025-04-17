/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.ProductDao;
import Dao.ProductVariantDao;
import Entity.ProductVariant;
import EntityDto.ProductDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
    private final ProductDao productDao = new ProductDao();
    private final ProductVariantDao variantDao = new ProductVariantDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String mode = request.getParameter("mode");
        if (mode == null) {
            mode = "view";
        }
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (Exception e) {
            request.setAttribute("errorMessage", "ProductId không hợp lệ.");
            RequestDispatcher rd = request.getRequestDispatcher("ManagerPage/error.jsp");
            rd.forward(request, response);
            return;
        }
        ProductDto product = mode.equals("add")
                ? new ProductDto()
                : productDao.getProductById(productId);
        List<String> brands = productDao.getAllBrandNames();
        List<String> categories = productDao.getAllCategoryNames();
        String editVariantId = request.getParameter("editVariantId");
        ProductVariant editVariant = editVariantId != null
                ? variantDao.getVariantById(Integer.parseInt(editVariantId))
                : null;

        // fetch updated variant list
        product.setVariants(variantDao.getVariantsByProductId(productId));

        request.setAttribute("product", product);
        request.setAttribute("mode", mode);
        request.setAttribute("brandList", brands);
        request.setAttribute("categoryList", categories);
        request.setAttribute("variantToEdit", editVariant);

        RequestDispatcher rd = request.getRequestDispatcher("ManagerPage/ProductDetail.jsp");
        rd.forward(request, response);
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
        // XỬ LÝ DELETE VARIANT TRƯỚC KHI HIỂN THỊ DETAIL
        String deleteId = request.getParameter("deleteVariantId");
        String productIdParam = request.getParameter("productId");
        if (deleteId != null && productIdParam != null) {
            int variantId = Integer.parseInt(deleteId);
            int productId = Integer.parseInt(productIdParam);
            // xóa
            new ProductVariantDao().deleteVariant(variantId);
            // redirect về chính trang detail với cùng productId & mode=view
            response.sendRedirect(request.getContextPath()
                    + "/ProductForManagerDetailController?productId=" + productId + "&mode=view");
            return;
        }
        // Nếu không phải delete, vẫn chạy bình thường
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

        String variantAction = request.getParameter("variantAction");
        int productId = Integer.parseInt(request.getParameter("productId"));
        if (variantAction != null) {
            ProductVariant v = new ProductVariant();
            v.setProductId(productId);
            v.setCpu(request.getParameter("cpu"));
            v.setRam(request.getParameter("ram"));
            v.setScreen(request.getParameter("screen"));
            v.setStorage(request.getParameter("storage"));
            v.setColor(request.getParameter("color"));
            v.setPrice(Double.parseDouble(request.getParameter("price")));
            v.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
            if (variantAction.equals("add")) {
                variantDao.addVariant(v);
            } else if (variantAction.equals("update")) {
                v.setVariantId(Integer.parseInt(request.getParameter("variantId")));
                variantDao.updateVariant(v);
            }
            response.sendRedirect(request.getContextPath()
                    + "/ProductForManagerDetailController?productId=" + productId + "&mode=view");
            return;
        }
        // handle delete via GET param
        String deleteId = request.getParameter("deleteVariantId");
        if (deleteId != null) {
            variantDao.deleteVariant(Integer.parseInt(deleteId));
            response.sendRedirect(request.getContextPath()
                    + "/ProductForManagerDetailController?productId=" + request.getParameter("productId") + "&mode=view");
            return;
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
