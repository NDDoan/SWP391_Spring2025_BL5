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

        ProductDto product;
        if ("add".equalsIgnoreCase(mode)) {
            product = new ProductDto();
        } else {
            String productIdParam = request.getParameter("productId");
            int productId = 0;
            try {
                productId = Integer.parseInt(productIdParam);
            } catch (Exception e) {
                request.setAttribute("errorMessage", "ProductId không hợp lệ.");
                RequestDispatcher rd = request.getRequestDispatcher("AdminPage/error.jsp");
                rd.forward(request, response);
                return;
            }
            product = productDao.getProductById(productId);
            if (product == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin sản phẩm.");
                RequestDispatcher rd = request.getRequestDispatcher("AdminPage/error.jsp");
                rd.forward(request, response);
                return;
            }
        }

        // Common attributes
        request.setAttribute("product", product);
        request.setAttribute("mode", mode);
        request.setAttribute("brandList", productDao.getAllBrandNames());
        request.setAttribute("categoryList", productDao.getAllCategoryNames());

        // Variant editing if requested
        String editVariantId = request.getParameter("editVariantId");
        if (editVariantId != null) {
            ProductVariant editVariant = variantDao.getVariantById(Integer.parseInt(editVariantId));
            request.setAttribute("variantToEdit", editVariant);
        }

        // Load variants for view/edit
        if ("add".equalsIgnoreCase(mode)) {
            product.setVariants(List.of());
        } else {
            product.setVariants(variantDao.getVariantsByProductId(product.getProductId()));
        }

        RequestDispatcher rd = request.getRequestDispatcher("AdminPage/ProductDetail.jsp");
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
        request.setCharacterEncoding("UTF-8");
        String mode = request.getParameter("mode");

        // ===== Validate and handle product add/edit =====
        if ("add".equalsIgnoreCase(mode) || "edit".equalsIgnoreCase(mode)) {
            // Extract form values
            String name = request.getParameter("productName").trim();
            String brand = request.getParameter("brandName").trim();
            String category = request.getParameter("categoryName").trim();
            String desc = request.getParameter("description").trim();
            int currentId = 0;
            if ("edit".equalsIgnoreCase(mode)) {
                currentId = Integer.parseInt(request.getParameter("productId"));
            }
            // Validate unique product name
            if (productDao.isNameExistsExceptId(name, currentId)) {
                request.setAttribute("errorName", "Tên sản phẩm đã tồn tại rồi.");
                // Preserve form inputs
                request.setAttribute("productName", name);
                request.setAttribute("brandName", brand);
                request.setAttribute("categoryName", category);
                request.setAttribute("description", desc);
                processRequest(request, response);
                return;
            }
            // Build DTO
            ProductDto product = new ProductDto();
            if ("edit".equalsIgnoreCase(mode)) {
                product.setProductId(currentId);
            }
            product.setProductName(name);
            product.setBrandName(brand);
            product.setCategoryName(category);
            product.setDescription(desc);

            int prodId;
            if ("add".equalsIgnoreCase(mode)) {
                prodId = productDao.addProduct(product);
            } else {
                productDao.updateProduct(product);
                prodId = product.getProductId();
            }
            response.sendRedirect(request.getContextPath()
                    + "/ProductForManagerDetailController?productId=" + prodId + "&mode=view");
            return;
        }

        // ===== Validate and handle variant add/update =====
        String variantAction = request.getParameter("variantAction");
        if (variantAction != null) {
            int prodId = Integer.parseInt(request.getParameter("productId"));
            // Validate quantity
            String qtyStr = request.getParameter("stockQuantity").trim();
            int qty;
            try {
                qty = Integer.parseInt(qtyStr);
            } catch (NumberFormatException e) {
                qty = -1;
            }
            if (qty < 0) {
                request.setAttribute("errorVariant", "Bạn không thể để tồn kho nhỏ hơn không 🐧.");
                processRequest(request, response);
                return;
            }
            ProductVariant v = new ProductVariant();
            v.setProductId(prodId);
            v.setCpu(request.getParameter("cpu"));
            v.setRam(request.getParameter("ram"));
            v.setScreen(request.getParameter("screen"));
            v.setStorage(request.getParameter("storage"));
            v.setColor(request.getParameter("color"));
            v.setPrice(Double.parseDouble(request.getParameter("price")));
            v.setStockQuantity(qty);
            if ("update".equalsIgnoreCase(variantAction)) {
                v.setVariantId(Integer.parseInt(request.getParameter("variantId")));
                variantDao.updateVariant(v);
            } else {
                variantDao.addVariant(v);
            }
            response.sendRedirect(request.getContextPath()
                    + "/ProductForManagerDetailController?productId=" + prodId + "&mode=view");
            return;
        }

        // Default: forward to view
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
