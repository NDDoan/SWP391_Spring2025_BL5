package Controller;

import Dao.ProductDao;
import Dao.ProductMediaDao;
import Dao.ProductVariantDao;
import Entity.ProductVariant;
import EntityDto.ProductDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ProductForManagerDetailController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final ProductVariantDao variantDao = new ProductVariantDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. Mode: view, edit, add
        String mode = request.getParameter("mode");
        if (mode == null) {
            mode = "view";
        }

        // 2. Load ProductDto
        ProductDto product;
        if ("add".equalsIgnoreCase(mode)) {
            product = new ProductDto();
        } else {
            String pid = request.getParameter("productId");
            int productId;
            try {
                productId = Integer.parseInt(pid);
            } catch (Exception e) {
                request.setAttribute("errorMessage", "ProductId không hợp lệ.");
                RequestDispatcher rd = request.getRequestDispatcher("AdminPage/error.jsp");
                rd.forward(request, response);
                return;
            }
            product = productDao.getProductById(productId);
            if (product == null) {
                request.setAttribute("errorMessage", "Không tìm thấy sản phẩm.");
                RequestDispatcher rd = request.getRequestDispatcher("AdminPage/error.jsp");
                rd.forward(request, response);
                return;
            }
        }

        // 3. Common attributes
        product.setMediaList(new ProductMediaDao().getMediaByProductId(product.getProductId()));
        request.setAttribute("product", product);
        request.setAttribute("mode", mode);
        request.setAttribute("brandList", productDao.getAllBrandNames());
        request.setAttribute("categoryList", productDao.getAllCategoryNames());

        // 4. Variant lookup options
        request.setAttribute("cpuOptions", variantDao.getAllCpuOptions());
        request.setAttribute("ramOptions", variantDao.getAllRamOptions());
        request.setAttribute("screenOptions", variantDao.getAllScreenOptions());
        request.setAttribute("storageOptions", variantDao.getAllStorageOptions());
        request.setAttribute("colorOptions", variantDao.getAllColorOptions());

        // 5. Edit single Variant if requested
        String editVariantId = request.getParameter("editVariantId");
        if (editVariantId != null) {
            ProductVariant editV = variantDao.getVariantById(Integer.parseInt(editVariantId));
            request.setAttribute("variantToEdit", editV);
        }

        // 6. Load list of Variants
        if ("add".equalsIgnoreCase(mode)) {
            product.setVariants(List.of());
        } else {
            product.setVariants(variantDao.getVariantsByProductId(product.getProductId()));
        }

        // 7. Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("AdminPage/ProductDetail.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle delete variant if any
        String deleteId = request.getParameter("deleteVariantId");
        String pid = request.getParameter("productId");
        if (deleteId != null && pid != null) {
            int variantId = Integer.parseInt(deleteId);
            int productId = Integer.parseInt(pid);
            variantDao.deleteVariant(variantId);
            response.sendRedirect(request.getContextPath()
                    + "/ProductForManagerDetailController?productId=" + productId + "&mode=view");
            return;
        }
        // Otherwise just process
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Handle add/edit Product
        String mode = request.getParameter("mode");
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

        // 2. Handle add/update Variant
        String variantAction = request.getParameter("variantAction");
        if (variantAction != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String qtyStr = request.getParameter("stockQuantity").trim();
            int qty;
            try {
                qty = Integer.parseInt(qtyStr);
            } catch (NumberFormatException e) {
                qty = -1;
            }
            if (qty < 0) {
                // gán error và hiển thị lại trang mà không redirect
                request.setAttribute("errorVariant", "Bạn không thể để tồn kho nhỏ hơn 0.");
                processRequest(request, response);
                return;
            }
            // Parse lookup IDs
            ProductVariant v = new ProductVariant();
            v.setProductId(productId);
            v.setCpuId(Integer.parseInt(request.getParameter("cpu_id")));
            v.setRamId(Integer.parseInt(request.getParameter("ram_id")));
            v.setScreenId(Integer.parseInt(request.getParameter("screen_id")));
            v.setStorageId(Integer.parseInt(request.getParameter("storage_id")));
            v.setColorId(Integer.parseInt(request.getParameter("color_id")));
            v.setPrice(Double.parseDouble(request.getParameter("price")));
            v.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));

            if ("update".equalsIgnoreCase(variantAction)) {
                v.setVariantId(Integer.parseInt(request.getParameter("variantId")));
                variantDao.updateVariant(v);
            } else {
                variantDao.addVariant(v);
            }

            // After variant change, redirect back to view
            response.sendRedirect(request.getContextPath()
                    + "/ProductForManagerDetailController?productId=" + productId + "&mode=view");
            return;
        }

        // Default: just show page
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controller for Product Detail + Variant (lookup-based)";
    }
}
