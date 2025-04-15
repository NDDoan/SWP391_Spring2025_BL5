<%-- 
    Document   : HomePage
    Created on : Apr 15, 2025, 3:10:04 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
.container {
    width: 95%;
    margin: auto;
    font-family: 'Inter', sans-serif;
    display: flex;
    gap: 20px;
    padding: 20px;
}

.main-content {
    flex: 3;
}

.sidebar {
    flex: 1;
    background-color: #f5f5f5;
    padding: 15px;
    border-radius: 12px;
}

.slider-item, .post-item, .product-item {
    margin-bottom: 20px;
    background-color: #fff;
    padding: 10px;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
}

.slider-item:hover, .post-item:hover, .product-item:hover {
    transform: scale(1.02);
}

.slider-item img,
.post-item img,
.product-item img {
    border-radius: 8px;
    max-width: 100%;
}

h2, h3 {
    color: #333333;
}

h4 {
    color: #4A90E2;
    margin: 8px 0 4px 0;
}

a {
    text-decoration: none;
    color: inherit;
}

a:hover h4 {
    color: #FF6B6B;
}

.latest-posts p, .static-links ul li, .static-contacts p {
    margin: 5px 0;
}

.static-links ul {
    list-style: none;
    padding-left: 0;
}

.static-links a {
    color: #4A90E2;
}

.static-links a:hover {
    text-decoration: underline;
}
</style>

<div class="container">
    <div class="main-content">
        <%
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(dbURL, user, pass);
                stmt = conn.createStatement();
        %>

        <!-- === SLIDERS === -->
        <div class="sliders">
            <h2>Sliders</h2>
            <%
                rs = stmt.executeQuery("SELECT title, image_url, backlink FROM Sliders WHERE is_active = 1");
                while(rs.next()) {
                    String title = rs.getString("title");
                    String image = rs.getString("image_url");
                    String backlink = rs.getString("backlink");
            %>
                <div class="slider-item">
                    <a href="<%=backlink%>">
                        <img src="<%=image%>" alt="<%=title%>">
                        <h3><%=title%></h3>
                    </a>
                </div>
            <%
                }
            %>
        </div>

        <!-- === FEATURED POSTS === -->
        <div class="featured-posts">
            <h2>Hot Posts</h2>
            <%
                rs = stmt.executeQuery("SELECT id, title, thumbnail_url, brief_info FROM Posts WHERE is_featured = 1 AND is_published = 1");
                while(rs.next()) {
                    int postId = rs.getInt("id");
                    String title = rs.getString("title");
                    String thumb = rs.getString("thumbnail_url");
                    String brief = rs.getString("brief_info");
            %>
                <div class="post-item">
                    <a href="post-detail.jsp?id=<%=postId%>">
                        <img src="<%=thumb%>" alt="<%=title%>" style="width:100px; height:80px;">
                        <h4><%=title%></h4>
                        <p><%=brief%></p>
                    </a>
                </div>
            <%
                }
            %>
        </div>

        <!-- === FEATURED PRODUCTS === -->
        <div class="featured-products">
            <h2>Featured Products</h2>
            <%
                rs = stmt.executeQuery("SELECT id, name, thumbnail_url, brief_info FROM Products WHERE is_featured = 1 AND is_active = 1");
                while(rs.next()) {
                    int productId = rs.getInt("id");
                    String name = rs.getString("name");
                    String thumb = rs.getString("thumbnail_url");
                    String brief = rs.getString("brief_info");
            %>
                <div class="product-item">
                    <a href="product-detail.jsp?id=<%=productId%>">
                        <img src="<%=thumb%>" alt="<%=name%>" style="width:100px; height:100px;">
                        <h4><%=name%></h4>
                        <p><%=brief%></p>
                    </a>
                </div>
            <%
                }
            %>
        </div>

        <%
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
    </div>

    <!-- === SIDEBAR === -->
    <div class="sidebar">
        <!-- Latest Posts -->
        <div class="latest-posts">
            <h3>Latest Posts</h3>
            <%
                try {
                    conn = DriverManager.getConnection(dbURL, user, pass);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT id, title FROM Posts WHERE is_published = 1 ORDER BY created_at DESC OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY");
                    while(rs.next()) {
                        int postId = rs.getInt("id");
                        String title = rs.getString("title");
            %>
                <p><a href="post-detail.jsp?id=<%=postId%>"><%=title%></a></p>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Sidebar Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            %>
        </div>

        <!-- Contact Info -->
        <div class="static-contacts">
            <h3>Contact</h3>
            <p>Email: support@yourshop.com</p>
            <p>Phone: 0123 456 789</p>
            <p>Address: 123 Trần Hưng Đạo, Q.1, HCM</p>
        </div>

        <!-- Quick Links -->
        <div class="static-links">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="about.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </div>
    </div>
</div>
