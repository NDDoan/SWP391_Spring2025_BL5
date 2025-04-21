/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import Entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Acer
 */
public class UserDao {

    private static final Logger LOGGER = Logger.getLogger(UserDao.class.getName());

    //Kiểm tra đăng nhập
    public User login(String email, String password) {
        String sql = "SELECT * FROM Users WHERE email = ? AND password_hash = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = extractUser(rs);
                updateLastLogin(user.getUser_id()); // Cập nhật last_login
                return user;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi đăng nhập", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return null;
    }

    //kiểm tra email đã tồn tại chưa
    public boolean isEmailRegistered(String email) {
        String sql = "SELECT 1 FROM Users WHERE email = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi kiểm tra email", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return false;
    }

    //lưu token remember me
    /*
    Khi đăng nhập, nếu Remember Me được chọn, thì:
    Tạo một token ngẫu nhiên (UUID).
    Lưu token đó vào reset_token của User.
    Hạn sử dụng là 7 ngày (reset_token_expiry).
    Nếu người dùng quay lại sau 7 ngày → Token hết hạn → Phải đăng nhập lại.
     */
    public boolean updateRememberToken(int userId, String token) {
        String sql = "UPDATE Users SET reset_token = ?, reset_token_expiry = DATEADD(DAY, 7, GETDATE()) WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lưu Remember Me token", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return false;
    }

    //lấy user từ token remember me
    public User getUserByRememberToken(String token) {
        String sql = "SELECT * FROM Users WHERE reset_token = ? AND reset_token_expiry > GETDATE()";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUser(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy User từ Remember Me token", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return null;
    }

    /*
    Khi người dùng nhấn "Quên mật khẩu":
    Tạo một token đặt lại mật khẩu.
    Lưu vào reset_token và reset_token_expiry.
    Gửi email chứa link:
    https://xxx.com/reset-password?token=xxxxxx 
    Khi người dùng nhập mật khẩu mới → Kiểm tra token hợp lệ rồi đổi mật khẩu.
     */
    //tạo token để đặt lại mật khẩu
    public boolean generateResetToken(String email, String token, Timestamp expiry) {
        String sql = "UPDATE Users SET reset_token = ?, reset_token_expiry = ? WHERE email = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            stmt.setTimestamp(2, expiry);
            stmt.setString(3, email);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi tạo Reset Token", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return false;
    }

    //lấy user từ reset token
    public User getUserByResetToken(String token) {
        String sql = "SELECT * FROM Users WHERE reset_token = ? AND reset_token_expiry > GETDATE()";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUser(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy User từ Reset Token", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return null;
    }

    //Cập nhật mật khẩu mới - Sau khi người dùng đặt lại mật khẩu, cần cập nhật trong DB.
    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE Users SET password_hash = ?, reset_token = NULL, reset_token_expiry = NULL WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword);  // Nên mã hóa trước khi lưu!
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi cập nhật mật khẩu", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return false;
    }

    //Vô hiệu hóa Token sau khi đặt lại mật khẩu 
    public boolean invalidateResetToken(String email) {
        String sql = "UPDATE Users SET reset_token = NULL, reset_token_expiry = NULL WHERE email = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi vô hiệu hóa Reset Token", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return false;

    }

    //Lưu thời điểm đăng nhập cuối
    public void updateLastLogin(int userId) {
        String sql = "UPDATE Users SET last_login = GETDATE() WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi cập nhật Last Login", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
    }

    //đăng kí tài khoản
    public boolean register(User user) {
        if (isEmailRegistered(user.getEmail())) {
            LOGGER.log(Level.WARNING, "Email đã tồn tại: {0}", user.getEmail());
            return false; // Email đã tồn tại, không cho phép đăng ký
        }

        String sql = "INSERT INTO Users (full_name, gender, email, password_hash, phone_number, address, avatar_url, role_id, is_active, is_verified, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, NULL, ?, ?, ?, ?)";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFull_name());
            stmt.setString(2, user.getGender());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPassword_hash()); // Đã mã hóa trước khi truyền vào
            stmt.setString(5, user.getPhone_number());
            stmt.setString(6, user.getAddress());
            stmt.setInt(7, user.getRole_id()); // Mặc định là 2 nếu user bình thường
            stmt.setBoolean(8, true); // is_active (mặc định true)
            stmt.setBoolean(9, false); // is_verified (mặc định false)
            stmt.setTimestamp(10, new Timestamp(System.currentTimeMillis())); // created_at hiện tại

            return stmt.executeUpdate() > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi đăng ký", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return false;
    }

    public User getUserById(int userId) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = extractUser(rs); // Tái sử dụng extractUser
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy User theo ID", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return user;
    }

    public boolean isPhoneNumberRegistered(String phone) {
        String sql = "SELECT COUNT(*) FROM Users WHERE phone_number = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, phone);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu số điện thoại đã tồn tại
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi kiểm tra số điện thoại", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi chung khi kiểm tra số điện thoại", e);
        }
        return false;
    }

    public boolean isPhoneNumberRegistered(String phone, Integer userId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE phone_number = ? AND user_id <> ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, phone);
            stmt.setInt(2, (userId == null || userId <= 0) ? -1 : userId); // Nếu userId không hợp lệ, gán giá trị -1 để không khớp với user nào

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu số điện thoại đã tồn tại (trừ chính userId đó)
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi kiểm tra số điện thoại", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi chung khi kiểm tra số điện thoại", e);
        }
        return false;
    }

    public boolean updateUserProfile(User user) {
        String sql = "UPDATE Users SET full_name = ?, gender = ?, phone_number = ?, address = ? WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFull_name());
            stmt.setString(2, user.getGender());
            stmt.setString(3, user.getPhone_number());
            stmt.setString(4, user.getAddress());
            stmt.setInt(5, user.getUser_id());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có ít nhất 1 dòng bị ảnh hưởng
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL", e);
            return false;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi chung", e);
            return false;
        }
    }

    public boolean updateUserAvatar(int userId, String avatarPath) {
        String sql = "UPDATE Users SET avatar_url = ? WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, avatarPath);
            stmt.setInt(2, userId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi cập nhật avatar", e);
            return false;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi chung khi cập nhật avatar", e);
            return false;
        }
    }

    public User getUserByEmail(String email) {
        User user = null;
        try {
            Connection conn = new DBContext().getConnection();
            String sql = "SELECT * FROM Users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword_hash(rs.getString("password_hash")); // 🔥 Lấy mật khẩu đã hash từ DB
                user.setRole_id(rs.getInt("role_id"));
            }
            conn.close();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy user từ mail", e);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy user từ mail", e);

        }
        return user;
    }

    // Hàm hỗ trợ: Chuyển ResultSet thành User
    private User extractUser(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("user_id"),
                rs.getString("full_name"),
                rs.getString("gender"),
                rs.getString("email"),
                rs.getString("password_hash"),
                rs.getString("phone_number"),
                rs.getString("address"),
                rs.getString("avatar_url"),
                rs.getInt("role_id"),
                rs.getBoolean("is_active"),
                rs.getBoolean("is_verified"),
                rs.getString("reset_token"),
                rs.getTimestamp("reset_token_expiry"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at"),
                rs.getTimestamp("last_login")
        );
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = extractUser(rs);
                list.add(u);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi lấy danh sách người dùng", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }

        return list;
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi xóa người dùng", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return false;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE [dbo].[Users] SET "
                + "[full_name] = ?, "
                + "[gender] = ?, "
                + "[email] = ?, "
                + "[phone_number] = ?, "
                + "[address] = ?, "
                + "[role_id] = ?, "
                + "[is_active] = ?, "
                + "[is_verified] = ?, "
                + "[updated_at] = ? "
                + "WHERE [user_id] = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFull_name());
            stmt.setString(2, user.getGender());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone_number());
            stmt.setString(5, user.getAddress());
            stmt.setInt(6, user.getRole_id());
            stmt.setBoolean(7, user.isIs_active());
            stmt.setBoolean(8, user.isIs_verified());
            stmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));  // Cập nhật thời gian
            stmt.setInt(10, user.getUser_id());  // Điều kiện WHERE

            return stmt.executeUpdate() > 0;  // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi cập nhật người dùng", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối CSDL", e);
        }
        return false;  // Trả về false nếu có lỗi
    }

    public boolean insertUser(User user) {
        String sql = "INSERT INTO Users "
                + "(email, full_name, gender, avatar_url, phone_number, address, role_id, created_at, updated_at, is_active, password_hash, is_verified, reset_token, reset_token_expiry, last_login) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getFull_name());
            ps.setString(3, user.getGender());
            ps.setString(4, null);
            ps.setString(5, user.getPhone_number());
            ps.setString(6, user.getAddress());
            ps.setInt(7, user.getRole_id());
            ps.setTimestamp(8, null); // reset_token_expiry
            ps.setTimestamp(9, null); // last_login
            ps.setBoolean(10, user.isIs_active());
            ps.setString(11, user.getPassword_hash()); // Đừng để null nếu cột yêu cầu NOT NULL
            ps.setBoolean(12, user.isIs_verified());
            ps.setString(13, null); // reset_token
            ps.setTimestamp(14, null); // reset_token_expiry
            ps.setTimestamp(15, null); // last_login

            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi SQL khi chèn người dùng mới: " + e.getMessage(), e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi chèn người dùng mới: " + e.getMessage(), e);
        }

        return false;
    }

//    public List<User> getFilteredUsers(String keyword, String roleFilter) {
//        List<User> userList = new ArrayList<>();
//        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");
//
//        List<Object> parameters = new ArrayList<>();
//
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            sql.append(" AND full_name LIKE ?");
//            parameters.add("%" + keyword.trim() + "%");
//        }
//        if (roleFilter != null && !roleFilter.trim().isEmpty()) {
//            try {
//                int roleId = Integer.parseInt(roleFilter);
//                sql.append(" AND role_id = ?");
//                parameters.add(roleId);
//            } catch (NumberFormatException e) {
//                System.out.println("roleFilter không hợp lệ: " + roleFilter);
//                // Có thể return danh sách rỗng hoặc bỏ qua bộ lọc role
//                return userList;
//            }
//        }
//
//        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
//
//            for (int i = 0; i < parameters.size(); i++) {
//                ps.setObject(i + 1, parameters.get(i));
//            }
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                User u = extractUser(rs);
//                userList.add(u);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return userList;
//    }
    public List<User> getFilteredUsers(String keyword, String roleFilter, int offset, int limit, String sortBy, String sortOrder) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");

        List<Object> parameters = new ArrayList<>();

        // Tìm kiếm
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            parameters.add("%" + keyword + "%");
        }

        // Lọc theo role
        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND role_id = ?");
            parameters.add(Integer.parseInt(roleFilter));
        }

        // Giới hạn role_id nằm trong 3, 4, 5
        sql.append(" AND role_id IN (?, ?, ?)");
        parameters.add(3);
        parameters.add(4);
        parameters.add(5);

        // Sắp xếp
        // Chỉ cho phép một số cột nhất định để tránh SQL Injection
        String sortColumn = "user_id"; // mặc định
        if ("full_name".equals(sortBy) || "email".equals(sortBy) || "user_id".equals(sortBy)) {
            sortColumn = sortBy;
        }

        String sortDirection = "ASC"; // mặc định
        if ("DESC".equalsIgnoreCase(sortOrder)) {
            sortDirection = "DESC";
        }

        sql.append(" ORDER BY ").append(sortColumn).append(" ").append(sortDirection);

        // Phân trang
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        parameters.add(offset);
        parameters.add(limit);

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<User> getFilteredCustomer(String keyword, String roleFilter, int offset, int limit) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            parameters.add("%" + keyword + "%");
        }

        // Luôn lọc role_id = 2 cho customer
        sql.append(" AND role_id = ?");
        parameters.add(2);

        // Phân trang
        sql.append(" ORDER BY user_id ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        parameters.add(offset);
        parameters.add(limit);

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractUser(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countFilteredUsers(String keyword, String roleFilter) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM users WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            parameters.add("%" + keyword + "%");
        }
        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND role_id = ?");
            parameters.add(Integer.parseInt(roleFilter));
        }
        sql.append(" AND role_id IN (?, ?, ?)");
        parameters.add(3);
        parameters.add(4);
        parameters.add(5);

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int countFilteredCustomer(String keyword, String roleFilter) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM users WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            parameters.add("%" + keyword + "%");
        }
        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND role_id = ?");
            parameters.add(Integer.parseInt(roleFilter));
        }
        sql.append(" AND role_id = ?");
        parameters.add(2);

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public List<User> getUsersByRole(int roleId) throws Exception {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                users.add(extractUser(rs)); // tái sử dụng method extractUser nếu đã có
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public static void main(String[] args) {
        UserDao userDao = new UserDao();

        // Tham số truyền vào cho phương thức getFilteredUsers
        String keyword = "";  // Thử tìm kiếm theo tên "John"
        String roleFilter = "";  // Lọc theo vai trò User (role_id = 2)
        int offset = 0;           // Offset cho phân trang
        int limit = 5;            // Số lượng kết quả tối đa

        // Lấy danh sách người dùng đã lọc
    }

    public Map<String, Object> getUserByIdWithRole(int id) {
        String sql = "SELECT u.*, r.role_name FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.user_id = ?";
        Map<String, Object> result = new HashMap<>();

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = extractUser(rs);
                result.put("user", user);
                result.put("role_name", rs.getString("role_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

}
