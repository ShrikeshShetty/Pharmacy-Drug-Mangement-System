<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Inventory</title>
    <link rel="stylesheet" href="css/admin-style.css">
</head>
<body>
    <div class="main">
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>Pharmacy Admin</h2>
            </div>
            <ul class="nav-menu">
                <li class="nav-item"><a href="SellerHomepage.jsp" class="nav-link">HOME</a></li>
                <li class="nav-item"><a href="AddProduct.html" class="nav-link">ADD</a></li>
                <li class="nav-item"><a href="AddInventory.jsp" class="nav-link active">RESTOCK</a></li>
                <li class="nav-item"><a href="SellerOrders.jsp" class="nav-link">ORDERS</a></li>
            </ul>
        </aside>
        <div class="content-area">
            <div class="top-bar">
                <h1 class="page-title">Add Inventory</h1>
                <div class="user-info">
                    <span class="user-name">Welcome, <%= session.getAttribute("currentuser") %></span>
                    <a href="Logout.jsp" class="logout-btn">Logout</a>
                </div>
            </div>
            <div class="card">
                <h2 class="card-title">Current Inventory</h2>
                <div class="product-grid">
                    <%@ page import="java.sql.*" %>
                    <%
                    String guid = (String)session.getAttribute("currentuser");
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
                        PreparedStatement ps = conn.prepareStatement("SELECT p.pid, i.quantity, p.pname, p.manufacturer, p.mfg, p.exp, p.price, p.image FROM product p, inventory i WHERE p.pid = i.pid AND i.sid = ?");
                        ps.setString(1, guid);
                        ResultSet rs = ps.executeQuery();
                        while(rs.next()) {
                    %>
                        <div class="product-card">
                            <img src="<%= rs.getString("image") %>" alt="<%= rs.getString("pname") %>" class="product-image">
                            <div class="product-info">
                                <h3 class="product-title"><%= rs.getString("pname") %></h3>
                                <p><strong>ID:</strong> <%= rs.getString("pid") %></p>
                                <p><strong>Manufacturer:</strong> <%= rs.getString("manufacturer") %></p>
                                <p><strong>Mfg Date:</strong> <%= rs.getDate("mfg") %></p>
                                <p><strong>Exp Date:</strong> <%= rs.getDate("exp") %></p>
                                <p><strong>Stock:</strong> <%= rs.getInt("quantity") %></p>
                                <p><strong>Price:</strong> <%= rs.getInt("price") %></p>
                                <form action="UpdateInventory.jsp" method="post" class="inventory-form">
                                    <input type="number" name="restock" placeholder="Quantity" required>
                                    <input type="hidden" name="pid" value="<%= rs.getString("pid") %>">
                                    <button type="submit" class="form-submit">Restock</button>
                                </form>
                            </div>
                        </div>
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
            </div>
        </div>
    </div>
</body>
</html>