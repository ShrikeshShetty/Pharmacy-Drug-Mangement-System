<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - Pharmacy Drug Store</title>
    <link rel="stylesheet" href="css/pharmacy_styles.css">
    <style>
        /* Additional styling for search results */
        .search-results {
            margin: 40px auto;
            text-align: center;
        }
        .search-results h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
        }
        .search-results .card {
            max-width: 250px;
            margin: 10px auto;
        }
        .search-results .card img {
            width: 100%;
            height: auto;
        }
        .search-results .card h3 {
            font-size: 1.2rem;
        }
    </style>
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

    <div class="search-results">
        <h2>Search Results for "<%= request.getParameter("query") %>"</h2>

        <div class="content-section">
            <%
                String query = request.getParameter("query");
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
                    stmt = conn.createStatement();
                    String searchQuery = "SELECT * FROM product WHERE pname LIKE ? LIMIT 10";
                    PreparedStatement pstmt = conn.prepareStatement(searchQuery);
                    pstmt.setString(1, "%" + query + "%");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        String productName = rs.getString("pname");
                        String productImage = rs.getString("image");
                        int price = rs.getInt("price");
            %>
            <div class="card">
                <img src="<%= productImage %>" alt="<%= productName %>">
                <h3><%= productName %></h3>
                <p>Price: ₹<%= price %></p>
                <%if (rs.getInt("quantity")>0) 
					{
					%>
  					<form action="PlaceOrder.jsp" method="post">
  					<input type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="Enter quantity" max="<%=rs.getInt("quantity") %>" required >
  					<input type="hidden" name="pid" value="<%=rs.getString("pid") %>">
  					<p></p>
  					<button>Buy</button></form></div>
  					<%
  					}
  					else	
  						{
  						%>
  					
  					<button>Out Of Stock</button></div>
  					<% 
  						} 
  					%>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                    try { if (conn != null) conn.close(); } catch (Exception e) {}
                }
            %>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Pharmacy Drug Store. All rights reserved.</p>
    </footer>

    <script src="script.js"></script>
</body>
</html>
