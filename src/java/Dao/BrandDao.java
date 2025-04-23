/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import Entity.Brand;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LENOVO
 */
public class BrandDao {

    private static final Logger LOGGER = Logger.getLogger(BrandDao.class.getName());

    public List<Brand> getAllBrands() {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT brand_id, brand_name, logo_url FROM Brands WHERE logo_url IS NOT NULL";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Brand b = new Brand();
                b.setBrandId(rs.getInt("brand_id"));
                b.setBrandName(rs.getString("brand_name"));
                b.setLogoUrl(rs.getString("logo_url"));
                brands.add(b);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching brands", e);
        }
        return brands;
    }
}
