<%@ page import="java.sql.*" %>
<%
    String oid = request.getParameter("oid");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int quantity = 0;
    int price = 0;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
        
        // Fetch current order details
        String fetchSql = "SELECT quantity, price FROM orders WHERE oid=?";
        ps = conn.prepareStatement(fetchSql);
        ps.setString(1, oid);
        rs = ps.executeQuery();
        if (rs.next()) {
            quantity = rs.getInt("quantity");
            price = rs.getInt("price");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update Order</title>
    <link rel="stylesheet" href="css/pharmacy_styles.css">
</head>
<body>
    <header>
        <h1>Pharmacy Drug Store</h1>
        <form action="Logout.jsp" method="post" style="display:inline;">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </header>
    <nav class="navbar">
        <a href="Homepage.jsp">HOME</a>
        <a href="Buy.jsp">BUY</a>
        <a href="Orders.jsp">ORDERS</a>
        <a href="Contact.jsp">CONTACT</a>
    </nav>
    <br><br><br><br>
    <div class="uOrder">
     
    <h2>Update Order</h2>
    <br><br>
    <form action="processUpdate.jsp" method="post">
        <input type="hidden" name="oid" value="<%= oid %>">
        <label>Quantity:</label>
        <input type="number" name="quantity" value="<%= quantity %>" min="1" required>
        <br><br>
        <input type="submit" value="Update Order" style="background-color: #004d4d;color:white; padding:10px;cursor:pointer">
    </form>
     
    </div>
        <br><br><br><br>
        <footer>
        <p>&copy; 2024 Pharmacy Drug Store. All rights reserved.</p>
    </footer>
</body>
</html>
