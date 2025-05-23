package Dao;

import DBContext.DBContext;
import Entity.CartItem;
import Entity.OrderItems;
import Entity.Orders;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import EntityDto.OrderDto;
import EntityDto.OrderItemDto;

public class OrderDao {

    private static final Logger LOGGER = Logger.getLogger(OrderDao.class.getName());

    // Lấy danh sách đơn hàng của một user theo userId
    public List<OrderDto> getOrdersByUserId(int userId) {
        Map<Integer, OrderDto> orderMap = new HashMap<>();
        String sql = "SELECT o.order_id, o.created_at, p.product_name, o.total_amount, o.order_status "
                + "FROM Orders o "
                + "JOIN Order_Items oi ON o.order_id = oi.order_id "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "WHERE o.user_id = ? "
                + "ORDER BY o.order_id";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    OrderDto order = orderMap.get(orderId);

                    if (order == null) {
                        Timestamp orderDate = rs.getTimestamp("created_at");
                        double totalCost = rs.getDouble("total_amount");
                        String status = rs.getString("order_status");
                        order = new OrderDto(orderId, orderDate, new ArrayList<>(), totalCost, status);
                        orderMap.put(orderId, order);
                    }

                    // Thêm sản phẩm vào danh sách productNames
                    order.getProductNames().add(rs.getString("product_name"));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy danh sách đơn hàng", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }

        return new ArrayList<>(orderMap.values());
    }
    
    //lấy order theo order id
    public OrderDto getOrderById(int orderId) {
        OrderDto order = null;
        String sql = "SELECT o.order_id, o.created_at, p.product_name, o.total_amount, o.order_status "
                + "FROM Orders o "
                + "JOIN Order_Items oi ON o.order_id = oi.order_id "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "WHERE o.order_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    if (order == null) {
                        Timestamp orderDate = rs.getTimestamp("created_at");
                        double totalCost = rs.getDouble("total_amount");
                        String status = rs.getString("order_status");
                        order = new OrderDto(orderId, orderDate, new ArrayList<>(), totalCost, status);
                    }
                    order.getProductNames().add(rs.getString("product_name"));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi tìm đơn hàng theo ID", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return order;
    }

    public List<OrderItemDto> getOrderItemsByOrderId(int orderId) {
        List<OrderItemDto> orderItemsList = new ArrayList<>();
        String sql = "SELECT oi.*, p.product_name "
                + "FROM Order_Items oi "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "WHERE oi.order_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItemDto item = new OrderItemDto();
                    item.setOrderItemId(rs.getInt("order_item_id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    item.setSubtotal(rs.getDouble("subtotal"));
                    item.setProductName(rs.getString("product_name")); // <-- lấy thêm product name

                    orderItemsList.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItemsList;
    }

    //lấy order theo status
    public List<OrderDto> getOrdersByStatus(String status) {
        Map<Integer, OrderDto> orderMap = new HashMap<>();
        String sql = "SELECT o.order_id, o.created_at, p.product_name, o.total_amount, o.order_status "
                + "FROM Orders o "
                + "JOIN Order_Items oi ON o.order_id = oi.order_id "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "WHERE o.order_status = ? "
                + "ORDER BY o.order_id";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    OrderDto order = orderMap.get(orderId);
                    if (order == null) {
                        Timestamp orderDate = rs.getTimestamp("created_at");
                        double totalCost = rs.getDouble("total_amount");
                        order = new OrderDto(orderId, orderDate, new ArrayList<>(), totalCost, status);
                        orderMap.put(orderId, order);
                    }
                    order.getProductNames().add(rs.getString("product_name"));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lọc đơn hàng theo trạng thái", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return new ArrayList<>(orderMap.values());
    }

    //search order theo date
    public List<OrderDto> getOrdersByDateRange(Timestamp startDate, Timestamp endDate) {
        Map<Integer, OrderDto> orderMap = new HashMap<>();
        String sql = "SELECT o.order_id, o.created_at, p.product_name, o.total_amount, o.order_status "
                + "FROM Orders o "
                + "JOIN Order_Items oi ON o.order_id = oi.order_id "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "WHERE o.created_at BETWEEN ? AND ? "
                + "ORDER BY o.order_id";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTimestamp(1, startDate);
            stmt.setTimestamp(2, endDate);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    OrderDto order = orderMap.get(orderId);
                    if (order == null) {
                        Timestamp orderDate = rs.getTimestamp("created_at");
                        double totalCost = rs.getDouble("total_amount");
                        String status = rs.getString("order_status");
                        order = new OrderDto(orderId, orderDate, new ArrayList<>(), totalCost, status);
                        orderMap.put(orderId, order);
                    }
                    order.getProductNames().add(rs.getString("product_name"));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi tìm đơn hàng theo khoảng ngày", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return new ArrayList<>(orderMap.values());
    }

    public int createOrder(Orders order) throws Exception {
        String sql = "INSERT INTO orders (user_id, order_status, total_amount, created_at) VALUES (?, ?, ?, GETDATE())";  // Sử dụng GETDATE() thay vì NOW()
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, order.getUserId());
            stmt.setString(2, order.getOrderStatus());
            stmt.setDouble(3, order.getTotalAmount());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // return order_id
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void createOrderItem(int orderId, CartItem item) throws Exception {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price, subtotal) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            stmt.setInt(2, item.getProductId());
            stmt.setInt(3, item.getQuantity());
            stmt.setDouble(4, item.getPrice());
            stmt.setDouble(5, item.getQuantity()*item.getPrice());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OrderDto> getOrdersFiltered(Timestamp startDate, Timestamp endDate, int orderid, String sortBy, String sortDir, int offset, int limit, String staus) throws Exception {
        Map<Integer, OrderDto> orderMap = new LinkedHashMap<>(); // giữ thứ tự

        StringBuilder sql = new StringBuilder(
                "SELECT o.order_id, o.created_at, o.total_amount, o.order_status, p.product_name "
                + "FROM Orders o "
                + "JOIN Order_Items oi ON o.order_id = oi.order_id "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "WHERE 1 = 1 "
        );

        List<Object> params = new ArrayList<>();

        if (startDate != null && endDate != null) {
            sql.append(" AND o.created_at BETWEEN ? AND ? ");
            params.add(startDate);
            params.add(endDate);
        }

        if (orderid != 0) {
            sql.append("AND o.order_id = ? ");
            params.add(orderid);
        }
        if (staus != null && !staus.isEmpty()) {
            sql.append(" AND o.order_status = ? ");
            params.add(staus);
        }
        sql.append("ORDER BY o.").append(sortBy).append(" ").append(sortDir).append(" ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            // set param
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                OrderDto order = orderMap.get(orderId);
                if (order == null) {
                    order = new OrderDto();
                    order.setOrderId(orderId);
                    order.setOrderDate(rs.getTimestamp("created_at"));
                    order.setTotalCost(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("order_status"));
                    order.setProductNames(new ArrayList<>());
                    orderMap.put(orderId, order);
                }
                order.getProductNames().add(rs.getString("product_name"));
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Error", e);
        }

        return new ArrayList<>(orderMap.values());
    }

    public int countFilteredOrders(Timestamp startDate, Timestamp endDate, int orderid, String staus) throws Exception {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT o.order_id) FROM Orders o WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (startDate != null && endDate != null) {
            sql.append("AND o.created_at BETWEEN ? AND ? ");
            params.add(startDate);
            params.add(endDate);
        }

        if (orderid != 0) {
            sql.append("AND o.order_id = ? ");
            params.add(orderid);
        }
        if (staus != null && !staus.isEmpty()) {
            sql.append(" AND o.order_status = ? ");
            params.add(staus);
        }

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi đếm đơn hàng", e);
        }

        return count;
    }

    //phân trang cho order
    public List<OrderDto> getOrdersWithPagination(int offset, int limit) {
        Map<Integer, OrderDto> orderMap = new HashMap<>();
        String sql = "SELECT o.order_id, o.created_at, p.product_name, o.total_amount, o.order_status "
                + "FROM Orders o "
                + "JOIN Order_Items oi ON o.order_id = oi.order_id "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "ORDER BY o.order_id ";
              

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
           
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    OrderDto order = orderMap.get(orderId);
                    if (order == null) {
                        Timestamp orderDate = rs.getTimestamp("created_at");
                        double totalCost = rs.getDouble("total_amount");
                        String status = rs.getString("order_status");
                        order = new OrderDto(orderId, orderDate, new ArrayList<>(), totalCost, status);
                        orderMap.put(orderId, order);
                    }
                    order.getProductNames().add(rs.getString("product_name"));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi phân trang danh sách đơn hàng", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return new ArrayList<>(orderMap.values());
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //đếm các bản ghi orders 
    public int getTotalPages(int userId, int pageSize) {
        int totalOrders = 0;
        String sql = "SELECT COUNT(*) FROM Orders WHERE user_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalOrders = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }

        // Tính tổng số trang
        return (int) Math.ceil((double) totalOrders / pageSize);
    }

    /**
     * Gets an Order entity by order ID Used for the feedback feature
     *
     * @param orderId The order ID to retrieve
     * @return Order entity or null if not found
     */
    public Orders getOrderByIdd(int orderId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Orders order = null;

        try {
            conn = new DBContext().getConnection();
            String sql = "SELECT [order_id], [user_id], [order_status], [total_amount], "
                    + "[created_at], [updated_at] "
                    + "FROM [dbo].[Orders] "
                    + "WHERE [order_id] = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);

            rs = ps.executeQuery();
            if (rs.next()) {
                order = new Orders();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error getting order by ID: " + e.getMessage(), e);
        } finally {
            closeResources(conn, ps, rs);
        }

        return order;
    }

    /**
     * Gets order items for an order Used for the feedback feature
     *
     * @param orderId The order ID
     * @return List of order items
     */
    public List<OrderItems> getOrderItems(int orderId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<OrderItems> items = new ArrayList<>();

        try {
            conn = new DBContext().getConnection();
            String sql = "SELECT [order_item_id], [order_id], [product_id], "
                    + "[quantity], [price], [subtotal] "
                    + "FROM [dbo].[Order_Items] "
                    + "WHERE [order_id] = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);

            rs = ps.executeQuery();
            while (rs.next()) {
                OrderItems item = new OrderItems();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setSubtotal(rs.getDouble("subtotal"));

                items.add(item);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error getting order items: " + e.getMessage(), e);
        } finally {
            closeResources(conn, ps, rs);
        }

        return items;
    }

    /**
     * Helper method to close database resources
     */
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
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
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error closing resources: " + e.getMessage(), e);
        }
    }

    public static void main(String[] args) {
        OrderDao orderDao = new OrderDao();

//    int testUserId = 3; // Thay bằng ID thực tế trong database
//    List<OrderDto> orders = orderDao.getOrdersByUserId(testUserId);
//
//    if (orders.isEmpty()) {
//        System.out.println("Không có đơn hàng nào cho userId: " + testUserId);
//    } else {
//        for (OrderDto order : orders) {
//            System.out.println("Đơn hàng ID: " + order.getOrderId());
//            System.out.println("Ngày tạo: " + order.getOrderDate());
//            System.out.println("Sản phẩm: " + order.getProductNames());
//            System.out.println("Tổng tiền: " + order.getTotalCost());
//            System.out.println("Trạng thái: " + order.getStatus());
//            System.out.println("----------------------------");
//        }
//    }
//    // 1️⃣ Test tìm kiếm đơn hàng theo ID
//        int testOrderId = 2;
//        System.out.println("🔍 Tìm đơn hàng theo ID: " + testOrderId);
//        OrderDto orderById = orderDao.getOrderById(testOrderId);
//        printOrder(orderById);
//        // 2️⃣ Test lọc đơn hàng theo trạng thái
//        String testStatus = "Completed"; // Thay bằng trạng thái có sẵn trong DB
//        System.out.println("\n📌 Lọc đơn hàng theo trạng thái: " + testStatus);
//        List<OrderDto> ordersByStatus = orderDao.getOrdersByStatus(testStatus);
//        printOrderList(ordersByStatus);
//
        // 3️⃣ Test tìm đơn hàng theo khoảng ngày
        Timestamp startDate = Timestamp.valueOf("2024-01-01 00:00:00");
        Timestamp endDate = Timestamp.valueOf("2024-12-31 23:59:59");
        System.out.println("\n📅 Tìm đơn hàng từ " + startDate + " đến " + endDate);
        List<OrderDto> ordersByDate = orderDao.getOrdersByDateRange(startDate, endDate);
        printOrderList(ordersByDate);
//
//        // 4️⃣ Test phân trang danh sách đơn hàng
//        int offset = 0; // Lấy từ bản ghi thứ 0
//        int limit = 5;  // Lấy 5 bản ghi
//        System.out.println("\n📄 Phân trang danh sách đơn hàng (offset: " + offset + ", limit: " + limit + ")");
//        List<OrderDto> paginatedOrders = orderDao.getOrdersWithPagination(offset, limit);
//        printOrderList(paginatedOrders);
    }

    // 📌 Hàm hỗ trợ in thông tin một đơn hàng
    private static void printOrder(OrderDto order) {
        if (order == null) {
            System.out.println("⚠ Không tìm thấy đơn hàng!");
            return;
        }
        System.out.println("🆔 Order ID: " + order.getOrderId());
        System.out.println("📅 Created At: " + order.getOrderDate());
        System.out.println("📦 Product Names: " + order.getProductNames());
        System.out.println("💰 Total Amount: " + order.getTotalCost());
        System.out.println("🔖 Status: " + order.getStatus());
        System.out.println("---------------------------------");
    }

    // 📌 Hàm hỗ trợ in danh sách đơn hàng
    private static void printOrderList(List<OrderDto> orders) {
        if (orders.isEmpty()) {
            System.out.println("⚠ Không có đơn hàng nào!");
            return;
        }
        for (OrderDto order : orders) {
            printOrder(order);
        }
    }
}
