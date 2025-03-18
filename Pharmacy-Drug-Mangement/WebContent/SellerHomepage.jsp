<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>
    <link rel="stylesheet" href="css/admin-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
</head>
<body>
    <div class="main">
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>Pharmacy Admin</h2>
            </div>
            <ul class="nav-menu">
                <li class="nav-item"><a href="SellerHomepage.jsp" class="nav-link active">Dashboard</a></li>
                <li class="nav-item"><a href="AddProduct.html" class="nav-link">Add Product</a></li>
                <li class="nav-item"><a href="AddInventory.jsp" class="nav-link">Restock</a></li>
                <li class="nav-item"><a href="SellerOrders.jsp" class="nav-link">Orders</a></li>
            </ul>
        </aside>
        <div class="content-area">
            <div class="top-bar">
                <h1 class="page-title">Seller Dashboard</h1>
                <div class="user-info">
                    <span class="user-name">Welcome, <%= session.getAttribute("currentuser") %></span>
                    <a href="Logout.jsp" class="logout-btn">Logout</a>
                </div>
            </div>
            <div class="card">
                <h2 class="card-title">Seller Information</h2>
                <%@ page import="java.sql.*" %>
                <%
                String guid = (String)session.getAttribute("currentuser");
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
                    PreparedStatement ps = conn.prepareStatement("select sname, sid, address, phno from seller where sid=?");
                    ps.setString(1, guid);
                    ResultSet rs = ps.executeQuery();
                    if(rs.next()) {
                %>
                    <p><strong>Name:</strong> <%= rs.getString("sname") %></p>
                    <p><strong>ID:</strong> <%= rs.getString("sid") %></p>
                    <p><strong>Address:</strong> <%= rs.getString("address") %></p>
                    <p><strong>Phone:</strong> <%= rs.getString("phno") %></p>
                <%
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch(Exception e) {
                    out.println("Error: " + e);
                }
                %>
            </div>
            <!-- Add more cards or content as needed -->
        </div>
    </div>
</body>
</html>