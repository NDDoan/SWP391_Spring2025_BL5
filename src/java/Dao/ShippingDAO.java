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
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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
        String sql = "UPDATE Shipping SET shipping_address=?, shipping_status=?, tracking_number=?, shipping_date=?, estimated_delivery=?, delivery_notes=?, updated_at=?, shipperId=? WHERE shipping_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getShippingAddress());
            ps.setString(2, s.getShippingStatus());
            ps.setString(3, s.getTrackingNumber());
            ps.setDate(4, new java.sql.Date(s.getShippingDate().getTime()));
            ps.setDate(5, new java.sql.Date(s.getEstimatedDelivery().getTime()));
            ps.setString(6, s.getDeliveryNotes());
            ps.setDate(7, new java.sql.Date(s.getUpdatedAt().getTime()));
            ps.setInt(8, s.getShipperId());
            ps.setInt(9, s.getId());
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

    public List<Shipping> getShippingByStatus(String status,String sortBy, String sortDir) throws SQLException {
        List<Shipping> list = new ArrayList<>();
         String sql = "SELECT * FROM Shipping ";
        // Nếu status không rỗng, thêm điều kiện lọc theo status
        if (status != null && !status.isEmpty()) {
            sql += "WHERE shipping_status = ?";
        }

        // Thêm phần sắp xếp
        sql += " ORDER BY " + sortBy + " " + sortDir;

        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            // Thiết lập giá trị cho userId (luôn có)
            

            // Nếu status không rỗng, thiết lập thêm giá trị cho shipping_status
            if (status != null && !status.isEmpty()) {
                statement.setString(1, status);
            }

            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
            
                list.add(extractShipping(resultSet));
            }
            return list;
        }
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

    public List<Shipping> getShippingByStatusUserId(int userId, String status, String sortBy, String sortDir) throws SQLException {
        // Nếu status là rỗng, không cần thêm điều kiện cho status trong câu truy vấn
        List<Shipping> list = new ArrayList<>();
         String sql = "SELECT * FROM Shipping WHERE shipperId = ?";
        // Nếu status không rỗng, thêm điều kiện lọc theo status
        if (status != null && !status.isEmpty()) {
            sql += " AND shipping_status = ?";
        }

        // Thêm phần sắp xếp
        sql += " ORDER BY " + sortBy + " " + sortDir;

        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            // Thiết lập giá trị cho userId (luôn có)
            statement.setInt(1, userId);

            // Nếu status không rỗng, thiết lập thêm giá trị cho shipping_status
            if (status != null && !status.isEmpty()) {
                statement.setString(2, status);
            }

            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
            
                list.add(extractShipping(resultSet));
            }
            return list;
        }
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
        String sql = "SELECT s.* FROM Shipping s JOIN Orders o ON s.order_id = o.order_id WHERE o.user_id = ?";
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

    public List<Shipping> getShippingByCustomerIdStatus(int customerId, String status) throws SQLException {
        List<Shipping> list = new ArrayList<>();
        String sql = "SELECT s.* FROM Shipping s "
                + "JOIN Orders o ON s.order_id = o.order_id "
                + "WHERE o.user_id = ? AND s.shipping_status LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setString(2, "%" + status + "%"); // Thêm lọc theo trạng thái
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractShipping(rs));
                }
            }
        }
        return list;
    }

}
