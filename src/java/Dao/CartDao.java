package Dao;

import Entity.CartItem;
import DBContext.DBContext;
import java.sql.Statement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartDao {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;
     private static final Logger LOGGER = Logger.getLogger(CartDao.class.getName());

    /**
     * Lấy danh sách các sản phẩm trong giỏ hàng theo cart_id. Giá lấy từ bảng
     * ProductVariants (lấy giá nhỏ nhất của mỗi product_id).
     *
     * @param cartId mã giỏ hàng của người dùng
     * @return danh sách CartItem của giỏ hàng
     */
    public List<CartItem> getCartItemsByCartId(int cartId) {
        List<CartItem> list = new ArrayList<>();
        String sql
                = "SELECT ci.cart_item_id, ci.cart_id, ci.product_id, ci.quantity, p.product_name, pv.min_price AS price "
                + "FROM Cart_Items ci "
                + "JOIN Products p ON ci.product_id = p.product_id "
                + "JOIN (SELECT product_id, MIN(price) AS min_price FROM ProductVariants GROUP BY product_id) pv "
                + "  ON ci.product_id = pv.product_id "
                + "WHERE ci.cart_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartId);
            rs = ps.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setCartId(rs.getInt("cart_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    public void updateCartItemQuantity(int cartItemId, int newQuantity) {
        String query = "UPDATE Cart_Items SET quantity = ? WHERE cart_item_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartItemId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }
    
        public int getCartItemCount(int userId) {
        String sql = "SELECT SUM(quantity) AS total FROM Cart_Items WHERE cart_id = (SELECT cart_id FROM Cart WHERE user_id = ?)";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy chi tiết giỏ hàng", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return 0;
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public void deleteCartItem(int cartItemId) {
        String query = "DELETE FROM Cart_Items WHERE cart_item_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cartItemId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    /**
     * Tính tổng giá trị đơn hàng của giỏ hàng. Giá lấy từ bảng ProductVariants.
     *
     * @param cartId mã giỏ hàng
     * @return tổng giá trị (price * quantity)
     */
    public double getTotalOrderPrice(int cartId) {
        String sql
                = "SELECT SUM(ci.quantity * pv.min_price) AS total_price "
                + "FROM Cart_Items ci "
                + "JOIN (SELECT product_id, MIN(price) AS min_price FROM ProductVariants GROUP BY product_id) pv "
                + "  ON ci.product_id = pv.product_id "
                + "WHERE ci.cart_id = ?";
        double total = 0;
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartId);
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble("total_price");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return total;
    }

    // Lấy cart_id của người dùng dựa trên user_id
    public int getCartIdByUserId(int userId) {
        int cartId = -1;
        String query = "SELECT cart_id FROM Cart WHERE user_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                cartId = rs.getInt("cart_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return cartId;
    }

    // Thêm sản phẩm vào giỏ hàng
    public void addCartItem(int cartId, int productId, int quantity) {
        String checkQuery = "SELECT cart_item_id FROM Cart_Items WHERE cart_id = ? AND product_id = ?";
        String insertQuery = "INSERT INTO Cart_Items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
        String updateQuery = "UPDATE Cart_Items SET quantity = quantity + ? WHERE cart_id = ? AND product_id = ?";

        try {
            conn = new DBContext().getConnection();

            // Kiểm tra sản phẩm có trong giỏ hàng không
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Nếu sản phẩm đã tồn tại, cập nhật số lượng
                ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, quantity);
                ps.setInt(2, cartId);
                ps.setInt(3, productId);
                ps.executeUpdate();
            } else {
                // Nếu sản phẩm chưa có trong giỏ, thêm mới sản phẩm vào giỏ hàng
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, cartId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    /**
     * Tạo giỏ hàng mới cho user và trả về cart_id.
     *
     * @param userId mã người dùng
     * @return cartId mới tạo, hoặc -1 nếu thất bại
     */
    public int createCartForUser(int userId) {
        int newCartId = -1;
        String sql = "INSERT INTO Cart (user_id) VALUES (?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                newCartId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return newCartId;
    }

    // Đóng kết nối cơ sở dữ liệu
    private void close() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
