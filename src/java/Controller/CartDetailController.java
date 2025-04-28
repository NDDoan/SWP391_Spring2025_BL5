package Controller;

import Dao.CartDao;
import Entity.CartItem;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Đặt URL mapping cho tiện
@WebServlet(name = "CartDetailController", urlPatterns = {"/CartDetailController"})
public class CartDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp"); // chuyển hướng tới trang đăng nhập
            return;
        }

        CartDao cartDao = new CartDao();
        int cartId = cartDao.getCartIdByUserId(userId);

        List<CartItem> cartItems = cartDao.getCartItemsByCartId(cartId);
        double totalOrderPrice = cartDao.getTotalOrderPrice(cartId);

        // Lưu danh sách sản phẩm và tổng tiền vào request để hiển thị trên trang
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalOrderPrice", totalOrderPrice);

        // Forward đến trang CartDetail.jsp để hiển thị giỏ hàng
        request.getRequestDispatcher("/CustomerPage/CartDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp"); // chuyển hướng tới trang đăng nhập
            return;
        }

        // Xử lý việc thêm sản phẩm vào giỏ hàng
        if (request.getParameter("action") != null && request.getParameter("action").equals("add")) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            CartDao cartDao = new CartDao();
            int cartId = cartDao.getCartIdByUserId(userId);

            int variantId = 0;
            try {
                if (request.getParameter("variantId") != null) {
                    variantId = Integer.parseInt(request.getParameter("variantId"));
                }
            } catch (Exception e) {
                variantId = 0;
            }

            // Thêm sản phẩm vào giỏ hàng
            cartDao.addCartItem(cartId, productId, quantity, variantId);

            // Sau khi thêm sản phẩm, chuyển hướng lại giỏ hàng
            response.sendRedirect(request.getContextPath() + "/CartDetailController");
        }

        // Xử lý việc xóa sản phẩm khỏi giỏ hàng
        if (request.getParameter("action") != null && request.getParameter("action").equals("delete")) {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));

            CartDao cartDao = new CartDao();
            cartDao.deleteCartItem(cartItemId); // Gọi phương thức deleteCartItem từ CartDao

            // Lấy lại cartId của người dùng
            int cartId = cartDao.getCartIdByUserId(userId);

            // Cập nhật số lượng sản phẩm trong giỏ hàng sau khi xóa
            int cartCount = cartDao.getCartItemCount(cartId);

            // Lưu lại số lượng giỏ hàng vào session để hiển thị ở header
            request.getSession().setAttribute("cartCount", cartCount);

            // Sau khi xóa sản phẩm, chuyển hướng lại trang giỏ hàng để hiển thị lại giỏ hàng đã thay đổi
            response.sendRedirect(request.getContextPath() + "/CartDetailController");
        }
    }

    @Override
    public String getServletInfo() {
        return "CartDetailController";
    }
}