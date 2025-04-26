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

        int cartId = 1; // Giả lập cartId = 1, sau này lấy từ session user

        CartDao cartDao = new CartDao();
        List<CartItem> cartItems = cartDao.getCartItemsByCartId(cartId);
        double totalOrderPrice = cartDao.getTotalOrderPrice(cartId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalOrderPrice", totalOrderPrice);

        request.getRequestDispatcher("/CustomerPage/CartDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu bạn chưa cần post xử lý gì thì có thể để trống
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "CartDetailController";
    }
}