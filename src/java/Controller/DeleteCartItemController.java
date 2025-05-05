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
        if (id != null && !id.isEmpty()) {
            try {
                int cartItemId = Integer.parseInt(id);
                if (cartItemId > 0) {
                    CartDao dao = new CartDao();
                    dao.deleteCartItem(cartItemId);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace(); // Ghi log lỗi nếu muốn
            }
        }
        response.sendRedirect(request.getContextPath() + "/CartDetailController");
    }
}
