<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders</title>
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

<div class="active">
    <%@ page import="java.sql.*" %>
    <%@ page import="javax.sql.*" %>
    <%
    HttpSession httpSession = request.getSession();
    String gid = (String) httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    ResultSet rs = null;
    CallableStatement cs = null;
    Connection conn = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
        cs = conn.prepareCall("call getorders(?)");
        cs.setString(1, gid);
        rs = cs.executeQuery();
    %>
    <div class="filler2"></div>
    <table class="tables">
        <tr>
            <th>Order ID</th>
            <th>Product ID</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Seller ID</th>
            <th>Order Date and Time</th>
            <th>Actions</th>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("oid") %></td>
            <td><%= rs.getString("pid") %></td>
            <td><%= rs.getInt("price") %></td>
            <td><%= rs.getInt("quantity") %></td>
            <td><%= rs.getString("sid") %></td>
            <td><%= rs.getTimestamp("orderdatetime") %></td>
            <td>
                <a href="CancelOrder.jsp?oid=<%= rs.getInt("oid") %>">
                    <button style="background-color: red">Remove</button>
                </a>
                <a href="updateOrders.jsp?oid=<%= rs.getInt("oid") %>">
                    <button style="background-color: green">Update</button>
                </a>
            </td>
        </tr>
        <% } %>
    </table>
</div>
<%
    } catch (Exception e) {
        out.println("Error: " + e);
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (cs != null) cs.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<footer>
        <p>&copy; 2024 Pharmacy Drug Store. All rights reserved.</p>
    </footer>
</body>
</html>
