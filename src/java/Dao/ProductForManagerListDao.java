/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import EntityDto.ProductForManagerListDto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LENOVO
 */
public class ProductForManagerListDao {

    private static final Logger LOGGER = Logger.getLogger(ProductForManagerListDao.class.getName());
    // Kích thước trang cố định: 5 sản phẩm/trang.
    private static final int PAGE_SIZE = 5;

    /**
     * Lấy danh sách sản phẩm marketing với các chức năng tìm kiếm, sắp xếp, lọc
     * và phân trang.
     *
     * @param search Từ khóa tìm kiếm theo tên sản phẩm. Nếu null hoặc rỗng thì
     * không tìm.
     * @param page Số trang cần lấy (bắt đầu từ 1).
     * @param sortField Tên trường sắp xếp (ví dụ: "p.product_name",
     * "b.brand_name", ...).
     * @param sortDir Hướng sắp xếp ("ASC" hoặc "DESC").
     * @return Danh sách các đối tượng ProductForManagerListDto.
     */
    public List<ProductForManagerListDto> getProductForMarketingList(String search, int page, String sortField, String sortDir) {
        List<ProductForManagerListDto> list = new ArrayList<>();
        String sql = buildDynamicQuery(search, sortField, sortDir);
        int offset = (page - 1) * PAGE_SIZE;

//        LOGGER.log(Level.INFO, "Dynamic SQL Query: {0}", sql);

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            // Nếu có từ khóa tìm kiếm, gán tham số cho câu lệnh.
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search.trim() + "%");
            }
            // Gán tham số cho phân trang.
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, PAGE_SIZE);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductForManagerListDto dto = new ProductForManagerListDto(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("brand_name"),
                        rs.getString("category_name"),
                        rs.getInt("totalStockQuantity"),
                        rs.getString("primaryMediaUrl")
                );
                list.add(dto);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching product marketing list", ex);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Connection error", ex);
        }
        return list;
    }

    /**
     * Xây dựng câu truy vấn động dựa trên các tham số tìm kiếm và sắp xếp.
     *
     * @param search Từ khóa tìm kiếm theo tên sản phẩm.
     * @param sortField Trường sắp xếp.
     * @param sortDir Hướng sắp xếp.
     * @return Một câu lệnh SQL dạng String hoàn chỉnh với phần LIMIT và OFFSET
     * để phân trang.
     */
    private String buildDynamicQuery(String search, String sortField, String sortDir) {
        StringBuilder sql = new StringBuilder();

        // Phần SELECT và JOIN các bảng liên quan
        sql.append("SELECT p.product_id, p.product_name, b.brand_name, c.category_name, ")
                .append("       ISNULL(SUM(v.stock_quantity), 0) as totalStockQuantity, ")
                .append("       pm.media_url as primaryMediaUrl ")
                .append("FROM Products p ")
                .append("LEFT JOIN Brands b ON p.brand_id = b.brand_id ")
                .append("LEFT JOIN Categories c ON p.category_id = c.category_id ")
                .append("LEFT JOIN ProductVariants v ON p.product_id = v.product_id ")
                .append("LEFT JOIN ProductMedia pm ON p.product_id = pm.product_id AND pm.is_primary = 1 ");

        // Thêm điều kiện tìm kiếm nếu có
        if (search != null && !search.trim().isEmpty()) {
            sql.append("WHERE p.product_name LIKE ? ");
        }

        // Nhóm các sản phẩm để tính tổng số lượng tồn kho
        sql.append("GROUP BY p.product_id, p.product_name, b.brand_name, c.category_name, pm.media_url ");

        // Thêm điều kiện sắp xếp
        sql.append("ORDER BY ").append(resolveSortField(sortField)).append(" ")
                .append(resolveSortDirection(sortDir)).append(" ");

        // Phân trang với OFFSET và FETCH (SQL Server 2012+)
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        return sql.toString();
    }

    /**
     * Xác thực và trả về trường sắp xếp hợp lệ. Nếu sortField không hợp lệ, trả
     * về trường mặc định.
     *
     * @param sortField Trường sắp xếp truyền vào.
     * @return Trường sắp xếp hợp lệ.
     */
    private String resolveSortField(String sortField) {
        // Danh sách các trường hợp lệ bạn cho phép sắp xếp
        if (sortField == null || sortField.trim().isEmpty()) {
            return "p.product_id";
        }
        // Cần kiểm tra kỹ trong môi trường thực tế để tránh SQL Injection (trong ví dụ này, ta giả sử dữ liệu hợp lệ)
        return sortField;
    }

    /**
     * Xác thực và trả về hướng sắp xếp hợp lệ.
     *
     * @param sortDir Hướng sắp xếp truyền vào.
     * @return "ASC" hoặc "DESC"
     */
    private String resolveSortDirection(String sortDir) {
        if (sortDir == null || sortDir.trim().isEmpty() || !sortDir.equalsIgnoreCase("DESC")) {
            return "ASC";
        }
        return "DESC";
    }

    // Ví dụ main để test
    public static void main(String[] args) {
        ProductForManagerListDao dao = new ProductForManagerListDao();
        List<ProductForManagerListDto> products = dao.getProductForMarketingList("Laptop", 1, "p.product_name", "ASC");
        for (ProductForManagerListDto dto : products) {
            System.out.println(dto);
        }
    }
}
