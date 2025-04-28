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
 HEAD
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


        // Lấy cartId từ session của người dùng
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp"); // chuyển hướng nếu chưa đăng nhập
            return;
        }

        // Tạo CartDao để truy xuất dữ liệu giỏ hàng
        CartDao dao = new CartDao();
        int cartId = dao.getCartIdByUserId(userId);  // Lấy cartId từ userId

        // Lấy danh sách sản phẩm trong giỏ hàng của người dùng
        List<CartItem> items = dao.getCartItemsByCartId(cartId);

        // Duyệt qua từng sản phẩm trong giỏ hàng và cập nhật số lượng
        for (CartItem item : items) {
            String param = request.getParameter("quantity_" + item.getCartItemId());
 b2a8dda (fix cart and add Vnpay)
            if (param != null) {
                try {
                    int quantity = Integer.parseInt(param);

                    // Kiểm tra xem số lượng có hợp lệ không (lớn hơn 0)
                    if (quantity > 0) {
                        // Cập nhật số lượng sản phẩm trong giỏ hàng
                        dao.updateCartItemQuantity(item.getCartItemId(), quantity);
                    } else {
                        // Nếu số lượng không hợp lệ, có thể để lại thông báo hoặc bỏ qua
                        request.setAttribute("errorMessage", "Số lượng phải lớn hơn 0.");
                    }
                } catch (NumberFormatException e) {
                    // Xử lý nếu giá trị nhập vào không phải là số hợp lệ
                    request.setAttribute("errorMessage", "Số lượng nhập vào không hợp lệ.");
                }
            }
        }

 HEAD
        // Cập nhật lại cartCount nếu bạn hiển thị ở header
        int cartCount = dao.getCartItemCount(cartId);
        session.setAttribute("cartCount", cartCount);


        // Sau khi cập nhật giỏ hàng, chuyển hướng lại trang chi tiết giỏ hàng
 b2a8dda (fix cart and add Vnpay)
        response.sendRedirect(request.getContextPath() + "/CartDetailController");
    }
}

