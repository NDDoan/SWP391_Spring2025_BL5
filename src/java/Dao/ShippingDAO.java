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
        String sql = "INSERT INTO Shipping (order_id, shipping_address, shipping_status, tracking_number, shipping_date, estimated_delivery, delivery_notes, updated_at, shipperId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, s.getOrderId());
            ps.setString(2, s.getShippingAddress());
            ps.setString(3, s.getShippingStatus());
            ps.setString(4, s.getTrackingNumber());
            ps.setDate(5, new java.sql.Date(s.getShippingDate().getTime()));
            ps.setDate(6, new java.sql.Date(s.getEstimatedDelivery().getTime()));
            ps.setString(7, s.getDeliveryNotes());
            ps.setDate(8, new java.sql.Date(s.getUpdatedAt().getTime()));
            ps.setInt(9, s.getShipperId());
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

    public List<Shipping> getShippingByStatus(String status, String sortBy, String sortDir, int offset, int pageSize) throws SQLException {
        List<Shipping> list = new ArrayList<>();
        String sql = "SELECT * FROM Shipping ";
        boolean hasStatus = status != null && !status.isEmpty();

        if (hasStatus) {
            sql += "WHERE shipping_status = ? ";
        }

        sql += "ORDER BY " + sortBy + " " + sortDir + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            int paramIndex = 1;

            if (hasStatus) {
                statement.setString(paramIndex++, status);
            }

            statement.setInt(paramIndex++, offset);
            statement.setInt(paramIndex, pageSize);

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

    public List<Shipping> getShippingByStatusUserId(int userId, String status, String sortBy, String sortDir, int offset, int pageSize) throws SQLException {
        List<Shipping> list = new ArrayList<>();

        // Xác thực tên cột và hướng sắp xếp
        List<String> validSortColumns = List.of("shipping_id", "shipping_status", "shipping_date"); // tùy cột bạn có
        List<String> validSortDirs = List.of("asc", "desc");

        if (!validSortColumns.contains(sortBy)) {
            sortBy = "shipping_id";
        }
        if (!validSortDirs.contains(sortDir.toLowerCase())) {
            sortDir = "asc";
        }

        StringBuilder sql = new StringBuilder("SELECT * FROM Shipping WHERE shipperId = ?");
        boolean hasStatus = status != null && !status.isEmpty();
        if (hasStatus) {
            sql.append(" AND shipping_status = ?");
        }
        sql.append(" ORDER BY ").append(sortBy).append(" ").append(sortDir)
                .append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement statement = conn.prepareStatement(sql.toString())) {
            int index = 1;
            statement.setInt(index++, userId);
            if (hasStatus) {
                statement.setString(index++, status);
            }
            statement.setInt(index++, offset);
            statement.setInt(index, pageSize);

            ResultSet rs = statement.executeQuery();
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
                rs.getDate("updated_at"),
                rs.getInt("shipperId")
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

    public int getTotalShippingCount(String status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM shipping";
        if (status != null && !status.isEmpty()) {
            sql += " WHERE shipping_status = ?";
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            if (status != null && !status.isEmpty()) {
                ps.setString(1, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getTotalShippingCountId(int shiperid, String status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM shipping WHERE shipperId = ?";
        boolean hasStatus = status != null && !status.isEmpty();
        if (hasStatus) {
            sql += " AND shipping_status = ?";
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            ps.setInt(index++, shiperid);
            if (hasStatus) {
                ps.setString(index++, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
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

    public Shipping getShippingDetailById(int id) {
        Shipping shipping = null;
        String sql = "SELECT * FROM Shipping WHERE shipping_id  = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                shipping = extractShipping(rs); // Tái sử dụng hàm
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return shipping;
    }

    
}
