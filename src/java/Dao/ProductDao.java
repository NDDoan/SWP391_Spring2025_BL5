/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import Entity.Product;
import Entity.ProductMedia;
import Entity.ProductVariant;
import EntityDto.ProductDto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LENOVO
 */
public class ProductDao {

    private static final Logger LOGGER = Logger.getLogger(ProductDao.class.getName());

    /**
     * Thêm một product mới (bao gồm cả variants và media nếu có)
     *
     * @param productDto Dữ liệu product được lấy từ form
     * @return product id được sinh ra, hoặc -1 nếu có lỗi
     */
    public int addProduct(ProductDto productDto) {
        int generatedProductId = -1;
        String insertProductSQL = "INSERT INTO Products (product_name, brand_id, category_id, description, created_at, updated_at)"
                + "VALUES (?, (SELECT brand_id FROM Brands WHERE brand_name = ?), (SELECT category_id FROM Categories WHERE category_name = ?), ?, GETDATE(), GETDATE())";

        // Sẽ chèn variants và media sau khi insert thành công Product
        try (Connection conn = new DBContext().getConnection()) {
            // Bắt đầu giao dịch
            conn.setAutoCommit(false);

            // Insert Product
            try (PreparedStatement ps = conn.prepareStatement(insertProductSQL, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, productDto.getProductName());
                ps.setString(2, productDto.getBrandName());
                ps.setString(3, productDto.getCategoryName());
                ps.setString(4, productDto.getDescription());
                ps.executeUpdate();

                // Lấy product_id vừa được sinh ra
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedProductId = rs.getInt(1);
                    productDto.setProductId(generatedProductId);
                }
            }
            // Commit giao dịch khi mọi thứ thành công
            conn.commit();
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error adding product", ex);
            generatedProductId = -1;
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Connection error", ex);
            generatedProductId = -1;
        }
        return generatedProductId;
    }

    /**
     * Cập nhật thông tin của một Product (chỉ cập nhật bảng Products, variants
     * và media có thể được xử lý riêng)
     *
     * @param productDto Dữ liệu product cần cập nhật
     * @return true nếu cập nhật thành công, false nếu có lỗi
     */
    public boolean updateProduct(ProductDto productDto) {
        boolean updated = false;
        String updateProductSQL = "UPDATE Products SET product_name = ?, brand_id = (SELECT brand_id FROM Brands WHERE brand_name = ?),"
                + "category_id = (SELECT category_id FROM Categories WHERE category_name = ?), description = ?, updated_at = GETDATE()"
                + "WHERE product_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(updateProductSQL)) {

            ps.setString(1, productDto.getProductName());
            ps.setString(2, productDto.getBrandName());
            ps.setString(3, productDto.getCategoryName());
            ps.setString(4, productDto.getDescription());
            ps.setInt(5, productDto.getProductId());

            int rowAffected = ps.executeUpdate();
            updated = rowAffected > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating product", ex);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Connection error", ex);
        }
        return updated;
    }

    /**
     * Lấy thông tin chi tiết của một Product theo productId, bao gồm thông tin
     * từ bảng Products, danh sách variants và media.
     *
     * @param productId ID của product cần xem
     * @return ProductDto chứa đầy đủ thông tin, hoặc null nếu không tìm thấy
     */
    public ProductDto getProductById(int productId) {
        ProductDto productDto = null;
        String selectProductSQL = "SELECT p.product_id, p.product_name, b.brand_name, c.category_name, p.description, p.created_at, p.updated_at, "
                + "       b.brand_name, c.category_name "
                + "FROM Products p "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "LEFT JOIN Categories c ON p.category_id = c.category_id "
                + "WHERE p.product_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(selectProductSQL)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                productDto = new ProductDto();
                productDto.setProductId(rs.getInt("product_id"));
                productDto.setProductName(rs.getString("product_name"));
                productDto.setBrandName(rs.getString("brand_name"));
                productDto.setCategoryName(rs.getString("category_name"));
                productDto.setDescription(rs.getString("description"));
                productDto.setCreatedAt(rs.getTimestamp("created_at"));
                productDto.setUpdatedAt(rs.getTimestamp("updated_at"));

                // Lấy danh sách variants
                List<ProductVariant> variants = getVariantsByProductId(conn, productId);
                productDto.setVariants(variants);

                // Lấy danh sách media
                List<ProductMedia> mediaList = getMediaByProductId(conn, productId);
                productDto.setMediaList(mediaList);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching product by id", ex);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Connection error", ex);
        }
        return productDto;
    }

    /**
     * Phương thức nội bộ để lấy danh sách variants theo productId
     */
    private List<ProductVariant> getVariantsByProductId(Connection conn, int productId) throws SQLException {
        List<ProductVariant> variants = new ArrayList<>();
        String selectVariantSQL = "SELECT variant_id, product_id, cpu, ram, screen, storage, color, price, stock_quantity, created_at, updated_at FROM ProductVariants WHERE product_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(selectVariantSQL)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant variant = new ProductVariant();
                variant.setVariantId(rs.getInt("variant_id"));
                variant.setProductId(rs.getInt("product_id"));
                variant.setCpu(rs.getString("cpu"));
                variant.setRam(rs.getString("ram"));
                variant.setScreen(rs.getString("screen"));
                variant.setStorage(rs.getString("storage"));
                variant.setColor(rs.getString("color"));
                variant.setPrice(rs.getDouble("price"));
                variant.setStockQuantity(rs.getInt("stock_quantity"));
                variant.setCreatedAt(rs.getTimestamp("created_at"));
                variant.setUpdatedAt(rs.getTimestamp("updated_at"));
                variants.add(variant);
            }
        }
        return variants;
    }

    /**
     * Phương thức nội bộ để lấy danh sách media theo productId
     */
    private List<ProductMedia> getMediaByProductId(Connection conn, int productId) throws SQLException {
        List<ProductMedia> mediaList = new ArrayList<>();
        String selectMediaSQL = "SELECT media_id, product_id, media_url, media_type, is_primary, created_at, updated_at FROM ProductMedia WHERE product_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(selectMediaSQL)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductMedia media = new ProductMedia();
                media.setMediaId(rs.getInt("media_id"));
                media.setProductId(rs.getInt("product_id"));
                media.setMediaUrl(rs.getString("media_url"));
                media.setMediaType(rs.getString("media_type"));
                media.setPrimary(rs.getBoolean("is_primary"));
                media.setCreatedAt(rs.getTimestamp("created_at"));
                media.setUpdatedAt(rs.getTimestamp("updated_at"));
                mediaList.add(media);
            }
        }
        return mediaList;
    }

    public List<String> getAllBrandNames() {
        List<String> brandNames = new ArrayList<>();
        String query = "SELECT brand_name FROM Brands";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                brandNames.add(rs.getString("brand_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brandNames;
    }

    public List<String> getAllCategoryNames() {
        List<String> categoryNames = new ArrayList<>();
        String query = "SELECT category_name FROM Categories";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categoryNames.add(rs.getString("category_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoryNames;
    }

    public boolean isNameExistsExceptId(String name, int excludeId) {
        String sql;
        if (excludeId > 0) {
            sql = "SELECT COUNT(*) FROM Products WHERE product_name = ? AND product_id <> ?";
        } else {
            sql = "SELECT COUNT(*) FROM Products WHERE product_name = ?";
        }
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            if (excludeId > 0) {
                ps.setInt(2, excludeId);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
