package Dao;

import Entity.Slider;
import java.sql.*;
import java.util.*;
import DBContext.DBContext;

public class SliderDAO extends DBContext {

    public SliderDAO(Connection conn) {
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
}
