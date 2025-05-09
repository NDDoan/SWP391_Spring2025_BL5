package Dao;

import DBContext.DBContext;
import Entity.CartItem;
import EntityDto.CartDetailDto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO cho chi tiết giỏ hàng
 */
public class CartDetailDao {

    private static final Logger LOGGER = Logger.getLogger(CartDetailDao.class.getName());

    // Lấy danh sách sản phẩm trong giỏ hàng của một user_id
    public List<CartDetailDto> getCartDetails(int userId) {
        List<CartDetailDto> cartItems = new ArrayList<>();
        
        try (Connection conn = new DBContext().getConnection()) {
            // Add logging to debug the issue
            System.out.println("Fetching cart details for userId: " + userId);
            
            // First check if the cart exists for the user
            String cartSql = "SELECT cart_id FROM Cart WHERE user_id = ?";
            try (PreparedStatement cartStmt = conn.prepareStatement(cartSql)) {
                cartStmt.setInt(1, userId);
                ResultSet cartRs = cartStmt.executeQuery();
                
                if (!cartRs.next()) {
                    System.out.println("No cart found for user: " + userId);
                    return cartItems; // Empty list - no cart found
                }
                
                int cartId = cartRs.getInt("cart_id");
                System.out.println("Found cart ID: " + cartId + " for user: " + userId);
                
                // Now get the cart items
                String sql = "SELECT ci.cart_item_id, ci.cart_id, ci.product_id, ci.quantity, " +
                             "p.product_name, p.price, p.discount_price, " +
                             "pi.media_url FROM Cart_Items ci " +
                             "JOIN Products p ON ci.product_id = p.product_id " +
                             "LEFT JOIN ProductMedia pi ON p.product_id = pi.product_id AND pi.is_primary = 1 " +
                             "WHERE ci.cart_id = ?";
                
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, cartId);
                    ResultSet rs = stmt.executeQuery();
                    
                    int itemCount = 0;
                    while (rs.next()) {
                        itemCount++;
                        CartDetailDto item = new CartDetailDto();
                        item.setCartItemId(rs.getInt("cart_item_id"));
                        item.setCartId(rs.getInt("cart_id"));
                        item.setProductId(rs.getInt("product_id"));
                        item.setProductName(rs.getString("product_name"));
                        item.setQuantity(rs.getInt("quantity"));
                        item.setPrice(rs.getDouble("price"));
                        item.setDiscountPrice(rs.getDouble("discount_price"));
                        item.setImageUrl(rs.getString("image_url"));
                        
                        item.getTotalPrice(); // Calculate total price
                        cartItems.add(item);
                    }
                    System.out.println("Found " + itemCount + " items in cart " + cartId);
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getCartDetails: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("General Error in getCartDetails: " + e.getMessage());
            e.printStackTrace();
        }
        
        return cartItems;
    }

    public void updateQuantity(int cartId, int productId, int quantity) {
        String sql = "UPDATE Cart_Items SET quantity = ? WHERE cart_id = ? AND product_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartId);
            stmt.setInt(3, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy chi tiết giỏ hàng", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
    }

    public boolean addToCart(int userId, int productId) {
        String checkSql = "SELECT cart_item_id, quantity FROM Cart_Items WHERE cart_id = (SELECT cart_id FROM Cart WHERE user_id = ?) AND product_id = ?";
        String insertSql = "INSERT INTO Cart_Items (cart_id, product_id, quantity) VALUES ((SELECT cart_id FROM Cart WHERE user_id = ?), ?, 1)";
        String updateSql = "UPDATE Cart_Items SET quantity = quantity + 1 WHERE cart_item_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    int cartItemId = rs.getInt("cart_item_id");
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, cartItemId);
                        updateStmt.executeUpdate();
                    }
                } else {
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, userId);
                        insertStmt.setInt(2, productId);
                        insertStmt.executeUpdate();
                    }
                }
            }
            return true;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy chi tiết giỏ hàng", e);
            return false;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
            return false;
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

    public boolean removeFromCart(int cartItemId) {
        String sql = "DELETE FROM Cart_Items WHERE cart_item_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cartItemId);
            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy chi tiết giỏ hàng", e);
            return false;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
            return false;
        }
    }

    public CartDetailDto getCartItem(int cartId, int productId) {
        String query = "SELECT ci.cart_item_id, ci.cart_id, ci.product_id, ci.quantity, "
                + "p.product_name, p.price, p.discount_price, "
                + "pi.image_url FROM Cart_Items ci "
                + "JOIN Products p ON ci.product_id = p.product_id "
                + "LEFT JOIN ProductImages pi ON p.product_id = pi.product_id AND pi.is_primary = 1 "
                + "WHERE ci.cart_id = ? AND ci.product_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, cartId);
            ps.setInt(2, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CartDetailDto item = new CartDetailDto();
                    item.setCartItemId(rs.getInt("cart_item_id"));
                    item.setCartId(rs.getInt("cart_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setDiscountPrice(rs.getDouble("discount_price"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setImageUrl(rs.getString("image_url"));

                    // Gọi setTotalPrice() để tính toán
                    item.getTotalPrice();
                    return item;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy chi tiết giỏ hàng", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }

        return null;
    }

    public double getProductTotalPrice(int productId, int cartId) {
        CartDetailDto cartItem = getCartItem(cartId, productId);
        return (cartItem != null) ? cartItem.getTotalPrice() : 0.0;
    }

    public static void main(String[] args) {
        // Khởi tạo DAO
        CartDetailDao cartDetailDao = new CartDetailDao();

        // Chọn userId cần test
        int testUserId = 2;

        // Gọi phương thức getCartDetails
        List<CartDetailDto> cartDetails = cartDetailDao.getCartDetails(testUserId);

        // Kiểm tra kết quả
        if (cartDetails.isEmpty()) {
            System.out.println("Giỏ hàng của userId " + testUserId + " đang trống hoặc không tồn tại.");
        } else {
            System.out.println("Chi tiết giỏ hàng của userId " + testUserId + ":");
            for (CartDetailDto item : cartDetails) {
                System.out.println("Cart Item ID: " + item.getCartItemId());
                System.out.println("Cart ID: " + item.getCartId());
                System.out.println("Product ID: " + item.getProductId());
                System.out.println("Product Name: " + item.getProductName());
                System.out.println("Image URL: " + item.getImageUrl());
                System.out.println("Quantity: " + item.getQuantity());
                System.out.println("Price: " + item.getPrice() + " VND");
                System.out.println("Discount Price: " + item.getDiscountPrice() + " VND");
                System.out.println("Total Price: " + item.getTotalPrice() + " VND");
                System.out.println("-----------------------------");
            }
        }

        int userId = 2; // Giả sử user có ID = 1
        int productId = 2; // Giả sử sản phẩm có ID = 2

        boolean result = cartDetailDao.addToCart(userId, productId);

        // In kết quả kiểm tra
        if (result) {
            System.out.println("✅ Đã thêm sản phẩm vào giỏ hàng thành công!");
        } else {
            System.out.println("❌ Lỗi khi thêm sản phẩm vào giỏ hàng!");
        }
    }
}
