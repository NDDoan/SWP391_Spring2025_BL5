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

public class CartDao {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

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

    public List<CartItem> getCartItemsByOrderId(int orderId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT * FROM Cart_Items WHERE order_id = ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);  // Thực hiện set giá trị của orderId
            rs = ps.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setCartItemId(rs.getInt("order_id"));  // Assuming you have orderId field
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(null);
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();  // Đảm bảo đóng kết nối
        }

        return list;
    }
    
    
    
    public void clearCart(int cartId) throws Exception {
    String sqlDeleteItems = "DELETE FROM Cart_Items WHERE cart_id = ?";
    String sqlCheckCartEmpty = "SELECT COUNT(*) FROM Cart_Items WHERE cart_id = ?";

    try (Connection conn = new DBContext().getConnection()) {
        // Xóa tất cả các mục trong giỏ hàng
        try (PreparedStatement psDelete = conn.prepareStatement(sqlDeleteItems)) {
            psDelete.setInt(1, cartId);
            psDelete.executeUpdate();
        }

        // Kiểm tra xem giỏ hàng còn mục nào không
        try (PreparedStatement psCheck = conn.prepareStatement(sqlCheckCartEmpty)) {
            psCheck.setInt(1, cartId);
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next()) {
                    int itemCount = rs.getInt(1);
                    if (itemCount == 0) {
                        System.out.println("Cart is empty.");
                    } else {
                        System.out.println("There are still items in the cart.");
                    }
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();  // In ra lỗi nếu có
        // Bạn có thể thay đổi đoạn này để log lỗi nếu cần thay vì ném lại SQLException
    }
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
        String sql = "SELECT SUM(ci.quantity * pv.price) AS total_price "
                + "FROM Cart_Items ci "
                + "JOIN ProductVariants pv ON ci.variant_id = pv.variant_id "
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
    public void addCartItem(int cartId, int productId, int quantity, int variantId) {
        String checkQuery = "SELECT cart_item_id FROM Cart_Items WHERE cart_id = ? AND product_id = ? AND variant_id = ?";
        String insertQuery = "INSERT INTO Cart_Items (cart_id, product_id, quantity, variant_id) VALUES (?, ?, ?, ?)";
        String updateQuery = "UPDATE Cart_Items SET quantity = quantity + ? WHERE cart_id = ? AND product_id = ? AND variant_id = ?";

        try {
            conn = new DBContext().getConnection();

            // Kiểm tra sản phẩm có trong giỏ hàng không, dựa trên cả variant_id
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.setInt(3, variantId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Nếu sản phẩm đã tồn tại, cập nhật số lượng
                ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, quantity);
                ps.setInt(2, cartId);
                ps.setInt(3, productId);
                ps.setInt(4, variantId);
                ps.executeUpdate();
            } else {
                // Nếu sản phẩm chưa có trong giỏ, thêm mới sản phẩm vào giỏ hàng
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, cartId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);
                ps.setInt(4, variantId);
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

    // Lấy tổng số lượng sản phẩm trong giỏ hàng
    public int getCartItemCount(int cartId) {
        int totalCount = 0;
        String sql = "SELECT SUM(quantity) AS total_quantity "
                + "FROM Cart_Items "
                + "WHERE cart_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartId);
            rs = ps.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt("total_quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return totalCount;
    }

    // Đóng kết nối cơ sở dữ liệu
    private void close() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
