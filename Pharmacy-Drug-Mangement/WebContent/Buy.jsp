<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy</title>
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
<div class="search-section">
    <h2>Search Medicines, Lab Tests, or Health Care Packages</h2>
    <form action="SearchResults.jsp" method="get">
        <input type="text" name="query" placeholder="Search here..." required>
        <button type="submit">Search</button>
    </form>
</div>

<div class="active">
    <%@ page import="java.sql.*" %>
    <%@ page import="javax.sql.*" %>

    <%
    HttpSession httpSession = request.getSession();
    String uid = (String) httpSession.getAttribute("currentuser");
    %>

    <div class="filler"></div>

    <%
    ResultSet rs = null;
    PreparedStatement ps = null;
    java.sql.Connection conn = null;
    String query = "SELECT p.pname, p.pid, p.manufacturer, p.mfg, p.price, i.quantity, p.image FROM product p, inventory i WHERE p.pid = i.pid";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
        ps = conn.prepareStatement(query);
        rs = ps.executeQuery();
    %>

    <!-- ? START CONTENT SECTION OUTSIDE LOOP -->
<div class="content-section">
    <div class="row">
    <% while (rs.next()) { %>
        <div class="card">
            <img src="<%= rs.getString("image")%>" width="180" height="200">
            <h1><%= rs.getString("pname") %></h1>
            <p><b>ID: </b><%= rs.getString("pid") %></p>
            <p><b>Manufacturer: </b><%= rs.getString("manufacturer") %></p>
            <p><b>Mfg Date: </b><%= rs.getDate("mfg") %></p>
            <p><b>Stock: </b><%= rs.getInt("quantity") %></p>
            <p><b>Price: </b><%= rs.getInt("price") %></p>

            <% if (rs.getInt("quantity") > 0) { %>
                <form action="PlaceOrder.jsp" method="post">
                    <input type="number" name="orderquantity" 
                           onkeypress="return event.charCode >= 48 && event.charCode <= 57"
                           placeholder="Enter quantity" max="<%= rs.getInt("quantity") %>" required>
                    <input type="hidden" name="pid" value="<%= rs.getString("pid") %>">
                    <p></p>
                    <button>Buy</button>
                </form>
            <% } else { %>
                <button>Out Of Stock</button>
            <% } %>
        </div>
    <% } %>
    </div> <!-- Close .row -->
</div> <!-- Close .content-section -->

    
    <%
    } catch (Exception e) {
        out.println("Error: " + e);
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {};
        try { if (ps != null) ps.close(); } catch (Exception e) {};
        try { if (conn != null) conn.close(); } catch (Exception e) {};
    }
    %>
<footer>
        <p>&copy; 2024 Pharmacy Drug Store. All rights reserved.</p>
    </footer>
</body>
</html>
