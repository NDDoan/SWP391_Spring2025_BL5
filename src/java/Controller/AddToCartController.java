package Controller;

import Dao.CartDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý hành động Thêm sản phẩm vào giỏ hàng.
 */
@WebServlet(name = "AddToCartController", urlPatterns = {"/AddToCartController"})
public class AddToCartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy thông tin sản phẩm và số lượng từ form
        int productId;
        int quantity;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
            if (quantity <= 0) {
                quantity = 1;
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/CartDetailController");
            return;
        }

        // Kiểm tra user đã đăng nhập
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp");
            return;
        }

        CartDao cartDao = new CartDao();
        // Lấy cartId, nếu chưa có thì tạo giỏ hàng mới
        int cartId = cartDao.getCartIdByUserId(userId);
        if (cartId < 0) {
            cartId = cartDao.createCartForUser(userId);
        }

        // Thêm sản phẩm vào giỏ hàng
        cartDao.addCartItem(cartId, productId, quantity);

        // Chuyển hướng về trang chi tiết giỏ hàng
        response.sendRedirect(request.getContextPath() + "/CartDetailController");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests về controller của giỏ hàng
        response.sendRedirect(request.getContextPath() + "/CartDetailController");
    }

    @Override
    public String getServletInfo() {
        return "Xử lý thêm sản phẩm vào giỏ hàng";
    }
}
