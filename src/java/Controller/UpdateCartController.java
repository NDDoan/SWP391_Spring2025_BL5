//package Controller;
//
//import Dao.CartDao;
//import Entity.CartItem;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet(name = "UpdateCartController", urlPatterns = {"/update-cart"})
//public class UpdateCartController extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession(false);
//        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
//
//        if (userId == null) {
//            response.sendRedirect(request.getContextPath() + "/UserPage/Login.jsp");
//            return;
//        }
//
//        CartDao dao = new CartDao();
//        int cartId = dao.getCartIdByUserId(userId);
//
//        List<CartItem> items = dao.getCartItemsByCartId(cartId);
//
//        for (CartItem item : items) {
//            String param = request.getParameter("quantity_" + item.getCartItemId());
//            if (param != null) {
//                try {
//                    int quantity = Integer.parseInt(param);
//
//                    if (quantity > 0) {
//                        dao.updateCartItemQuantity(item.getCartItemId(), quantity);
//                    } else {
//                        request.setAttribute("errorMessage", "Số lượng phải lớn hơn 0.");
//                    }
//                } catch (NumberFormatException e) {
//                    request.setAttribute("errorMessage", "Số lượng nhập vào không hợp lệ.");
//                }
//            }
//        }
//
//        // Cập nhật lại cartCount nếu bạn hiển thị ở header
//        int cartCount = dao.getCartItemCount(cartId);
//        session.setAttribute("cartCount", cartCount);
//
//        // Sau khi cập nhật giỏ hàng, chuyển hướng lại trang chi tiết giỏ hàng
//        response.sendRedirect(request.getContextPath() + "/CartDetailController");
//    }
//}
