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
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp"); // hoặc về trang đăng nhập
            return;
        }

        CartDao cartDao = new CartDao();
        int cartId = cartDao.getCartIdByUserId(userId);

        List<CartItem> cartItems = cartDao.getCartItemsByCartId(cartId);
        double totalOrderPrice = cartDao.getTotalOrderPrice(cartId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalOrderPrice", totalOrderPrice);

        request.getRequestDispatcher("/CustomerPage/CartDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        CartDao cartDao = new CartDao();
        int cartId = cartDao.getCartIdByUserId(userId);

        cartDao.addCartItem(cartId, productId, quantity);  // Gọi DAO để thêm vào CSDL

        response.sendRedirect(request.getContextPath() + "/CartDetailController"); // Load lại giỏ hàng sau khi thêm
    }


    @Override
    public String getServletInfo() {
        return "CartDetailController";
    }
}