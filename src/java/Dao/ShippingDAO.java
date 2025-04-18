package Dao;

import Entity.Shipping;
import java.sql.*;
import java.util.*;

public class ShippingDAO {
    private Connection conn;

    public ShippingDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Shipping> getAllShipping() throws SQLException {
        List<Shipping> list = new ArrayList<>();
        String sql = "SELECT * FROM Shipping";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractShipping(rs));
            }
        }
        return list;
    }

    public void insertShipping(Shipping s) throws SQLException {
        String sql = "INSERT INTO Shipping (order_id, shipping_address, shipping_status, tracking_number, shipping_date, estimated_delivery, delivery_notes, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, s.getOrderId());
            ps.setString(2, s.getShippingAddress());
            ps.setString(3, s.getShippingStatus());
            ps.setString(4, s.getTrackingNumber());
            ps.setDate(5, new java.sql.Date(s.getShippingDate().getTime()));
            ps.setDate(6, new java.sql.Date(s.getEstimatedDelivery().getTime()));
            ps.setString(7, s.getDeliveryNotes());
            ps.setDate(8, new java.sql.Date(s.getUpdatedAt().getTime()));
            ps.executeUpdate();
        }
    }

    public Shipping getShippingById(int id) throws SQLException {
        String sql = "SELECT * FROM Shipping WHERE shipping_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractShipping(rs);
            }
        }
        return null;
    }

    public void updateShipping(Shipping s) throws SQLException {
        String sql = "UPDATE Shipping SET shipping_address=?, shipping_status=?, tracking_number=?, shipping_date=?, estimated_delivery=?, delivery_notes=?, updated_at=? WHERE shipping_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getShippingAddress());
            ps.setString(2, s.getShippingStatus());
            ps.setString(3, s.getTrackingNumber());
            ps.setDate(4, new java.sql.Date(s.getShippingDate().getTime()));
            ps.setDate(5, new java.sql.Date(s.getEstimatedDelivery().getTime()));
            ps.setString(6, s.getDeliveryNotes());
            ps.setDate(7, new java.sql.Date(s.getUpdatedAt().getTime()));
            ps.setInt(8, s.getId());
            ps.executeUpdate();
        }
    }

    public void deleteShipping(int id) throws SQLException {
        String sql = "DELETE FROM Shipping WHERE shipping_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public List<Shipping> getShippingByStatus(String status) throws SQLException {
        List<Shipping> list = new ArrayList<>();
        String sql = "SELECT * FROM Shipping WHERE shipping_status LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + status + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractShipping(rs));
            }
        }
        return list;
    }

    public List<Shipping> getShippingByUserId(int userId) throws SQLException {
        List<Shipping> list = new ArrayList<>();
        String sql = "SELECT s.* FROM Shipping s JOIN Orders o ON s.order_id = o.id WHERE o.customer_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractShipping(rs));
            }
        }
        return list;
    }

    public List<Shipping> getShippingByShipper(int shipperId) throws SQLException {
        List<Shipping> list = new ArrayList<>();
        String sql = "SELECT * FROM Shipping WHERE shipperId = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shipperId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractShipping(rs));
            }
        }
        return list;
    }

    public void updateShippingStatus(int id, String status) throws SQLException {
        String sql = "UPDATE Shipping SET shipping_status = ?, updated_at = GETDATE() WHERE shipping_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    private Shipping extractShipping(ResultSet rs) throws SQLException {
        return new Shipping(
            rs.getInt("shipping_id"),
            rs.getInt("order_id"),
            rs.getString("shipping_address"),
            rs.getString("shipping_status"),
            rs.getString("tracking_number"),
            rs.getDate("shipping_date"),
            rs.getDate("estimated_delivery"),
            rs.getString("delivery_notes"),
            rs.getDate("updated_at")
        );
    }
     public List<Shipping> getShippingByCustomerId(int customerId) throws SQLException {
        List<Shipping> list = new ArrayList<>();
        String sql = "SELECT s.* FROM Shipping s JOIN Orders o ON s.order_id = o.order_id WHERE o.customer_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractShipping(rs));
                }
            }
        }
        return list;
    }
} 
