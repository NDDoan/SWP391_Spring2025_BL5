package Dao;

import Entity.CartItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import DBContext.DBContext;

public class CartDao {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public List<CartItem> getCartItemsByCartId(int cartId) {
        List<CartItem> list = new ArrayList<>();
        String query = "SELECT cart_item_id, cart_id, product_id, product_name, quantity, price "
                     + "FROM cart_item "
                     + "WHERE cart_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
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

    public void updateCartItemQuantity(int cartItemId, int newQuantity) {
        String query = "UPDATE cart_item SET quantity = ? WHERE cart_item_id = ?";
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

    public void deleteCartItem(int cartItemId) {
        String query = "DELETE FROM cart_item WHERE cart_item_id = ?";
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

    public double getTotalOrderPrice(int cartId) {
        String query = "SELECT SUM(price * quantity) AS total_price FROM cart_item WHERE cart_id = ?";
        double total = 0;
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
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
    
    public int getCartIdByUserId(int userId) {
    int cartId = -1;
    String query = "SELECT cart_id FROM cart WHERE user_id = ?";
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
