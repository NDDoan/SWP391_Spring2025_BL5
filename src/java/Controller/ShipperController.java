package Controller;

import Dao.ShippingDAO;
import Entity.Shipping;
import Entity.User;
import DBContext.DBContext;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/shipper")
public class ShipperController extends HttpServlet {

    private ShippingDAO shippingDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = new DBContext().getConnection();
            shippingDAO = new ShippingDAO(conn);
        } catch (Exception e) {
            throw new ServletException("Không thể kết nối cơ sở dữ liệu", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && user.getRole_id()== 3) {
            // Lấy danh sách đơn hàng của shipper hiện tại
            try {
                List<Shipping> list = shippingDAO.getShippingByShipper(user.getUser_id());
                request.setAttribute("shipList", list);
                request.getRequestDispatcher("/Shipper/ShipperShipping.jsp").forward(request, response);
            } catch (Exception e) {
                throw new ServletException("Lỗi khi lấy danh sách đơn hàng cho shipper", e);
            }
        } else {
            response.sendRedirect("logincontroller");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateShippingStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            try {
                shippingDAO.updateShippingStatus(id, status);
                response.sendRedirect("shipper");
            } catch (Exception e) {
                throw new ServletException("Cập nhật trạng thái đơn hàng thất bại", e);
            }
        } else {
            doGet(request, response);
        }
    }
}
