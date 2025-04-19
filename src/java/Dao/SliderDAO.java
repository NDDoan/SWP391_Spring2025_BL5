package Dao;

import Entity.Slider;
import java.sql.*;
import java.util.*;
import DBContext.DBContext;

public class SliderDAO extends DBContext {

    // ✅ Constructor mặc định để có thể dùng new SliderDAO()
    public SliderDAO() {
    }

    // ✅ Nếu cần constructor có tham số thì giữ lại
    public SliderDAO(Connection conn) {
        // Có thể lưu conn lại nếu bạn muốn dùng nó thay vì gọi getConnection()
    }

    public List<Slider> getActiveSliders() throws Exception {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM Sliders WHERE is_active = 1";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Slider(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("image_url"),
                    rs.getString("backlink"),
                    rs.getBoolean("is_active")
                ));
            }
        }
        return list;
    }
    
    public List<Slider> getAllSliders() throws Exception {
    List<Slider> list = new ArrayList<>();
    String sql = "SELECT * FROM Sliders";
    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Slider(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("image_url"),
                rs.getString("backlink"),
                rs.getBoolean("is_active")
            ));
        }
    } catch (Exception e) {
        throw new Exception("Error retrieving all sliders: " + e.getMessage());
    }
    return list;
}

}
