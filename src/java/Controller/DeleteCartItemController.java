// DeleteCartItemController.java
package Controller;

import Dao.CartDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DeleteCartItemController", urlPatterns = {"/delete-cart-item"})
public class DeleteCartItemController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("cartItemId");
        if (id != null) {
            try {
                int cartItemId = Integer.parseInt(id);
                new CartDao().deleteCartItem(cartItemId);
            } catch (NumberFormatException ignored) {}
        }
        response.sendRedirect(request.getContextPath() + "/CartDetailController");
    }
}
