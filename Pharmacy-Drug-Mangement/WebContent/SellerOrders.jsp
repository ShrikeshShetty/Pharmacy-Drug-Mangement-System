
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Orders</title>
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
                <li class="nav-item"><a href="AddInventory.jsp" class="nav-link">RESTOCK</a></li>
                <li class="nav-item"><a href="SellerOrders.jsp" class="nav-link active">ORDERS</a></li>
            </ul>
        </aside>
        <div class="content-area">
            <div class="top-bar">
                <h1 class="page-title">Seller Orders</h1>
                <div class="user-info">
                    <span class="user-name">Welcome, <%= session.getAttribute("currentuser") %></span>
                    <a href="Logout.jsp" class="logout-btn">Logout</a>
                </div>
            </div>
            <div class="card">
                <h2 class="card-title">Order List</h2>
                <table class="table">
                    <tr>
                        <th>Order ID</th>
                        <th>Product ID</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Customer ID</th>
                        <th>Order Date and Time</th>
                    </tr>
                    <%@ page import="java.sql.*" %>
                    <%
                    String guid = (String)session.getAttribute("currentuser");
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
                        CallableStatement cs = conn.prepareCall("call getsellerorders(?)");
                        cs.setString(1, guid);
                        ResultSet rs = cs.executeQuery();
                        while(rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getInt("oid") %></td>
                            <td><%= rs.getString("pid") %></td>
                            <td><%= rs.getInt("price") %></td>
                            <td><%= rs.getInt("quantity") %></td>
                            <td><%= rs.getString("uid") %></td>
                            <td><%= rs.getTimestamp("orderdatetime") %></td>
                        </tr>
                    <%
                        }
                        rs.close();
                        cs.close();
                        conn.close();
                    } catch(Exception e) {
                        out.println("Error: " + e);
                    }
                    %>
                </table>
            </div>
        </div>
    </div>
</body>
</html>