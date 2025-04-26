package Controller;

import Dao.CartDao;
import Entity.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UpdateCartController", urlPatterns = {"/update-cart"})
public class UpdateCartController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int cartId = 1; // Lấy từ session khi có user
        CartDao dao = new CartDao();
        List<CartItem> items = dao.getCartItemsByCartId(cartId);

        // Duyệt qua từng item và lấy param quantity_<id>
        for (CartItem it : items) {
            String param = request.getParameter("quantity_" + it.getCartItemId());
            if (param != null) {
                try {
                    int q = Integer.parseInt(param);
                    dao.updateCartItemQuantity(it.getCartItemId(), q);
                } catch (NumberFormatException ignored) {}
            }
        }
        // Quay lại trang chi tiết giỏ hàng
        response.sendRedirect(request.getContextPath() + "/CartDetailController");
    }
}
