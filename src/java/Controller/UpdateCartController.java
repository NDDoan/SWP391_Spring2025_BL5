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
        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp");
            return;
        }

        CartDao dao = new CartDao();
        int cartId = dao.getCartIdByUserId(userId);

        List<CartItem> items = dao.getCartItemsByCartId(cartId);
        for (CartItem it : items) {
            String param = request.getParameter("quantity_" + it.getCartItemId());
            if (param != null) {
                try {
                    int q = Integer.parseInt(param);
                    dao.updateCartItemQuantity(it.getCartItemId(), q);
                } catch (NumberFormatException ignored) {}
            }
        }

        // Cập nhật lại cartCount nếu bạn hiển thị ở header
        int cartCount = dao.getCartItemCount(cartId);
        session.setAttribute("cartCount", cartCount);

        response.sendRedirect(request.getContextPath() + "/CartDetailController");
    }
}

