<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy Homepage</title>
    <link rel="stylesheet" href="css/pharmacy_styles.css">
    <style>
        /* Slider container */
/* Slider container */
.slider {
  position: relative;
  width: 100%; /* Adjust to 100% width to make the slider more responsive */
  max-width: 1100px; /* Maximum width */
  height: 480px; /* Set to desired height */
  overflow: hidden;
  margin: auto;
  margin-top: 20px;
  filter:drop-shadow(10px 10px 20px black);
}

/* Slides container */
.slides {
  display: flex;
  transition: transform 0.5s ease-in-out;
}

/* Individual slide */
.slide {
  min-width: 100%; /* Each slide takes the full width */
  height: 100%; /* Each slide fills the height */
  display: flex;
  justify-content: center; /* Center the image */
  align-items: center; /* Center the image */
}

/* Image styles */
.slide img {
  object-fit: cover; /* Ensure the image covers the area without distortion */
  object-position: center; /* Center the image if it's cropped */
}

/* Navigation buttons */
.prev, .next {
  position: absolute;
  top: 50%;
  padding: 10px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  cursor: pointer;
  background-color: rgba(0, 0, 0, 0.5);
  border: none;
  transform: translateY(-50%);
  z-index: 1;
}

.prev { left: 10px; }
.next { right: 10px; }


        /* Testimonials Section */
        .testimonials {
            background-color: #eafafa;
            padding: 40px 20px;
            text-align: center;
        }
        .testimonials h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
        }
        .testimonials .testimonial {
            max-width: 300px;
            margin: 10px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.1);
        }
        .testimonials .testimonial p {
            font-size: 1rem;
            margin-bottom: 10px;
        }
        .testimonials .testimonial h4 {
            color: #008080;
            font-size: 1.2rem;
        }

        /* Featured Section */
        .featured-products {
            margin: 40px auto;
            text-align: center;
        }
        .featured-products h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
        }
        .featured-products .card {
            max-width: 250px;
            margin: 10px auto;
        }

        /* Tips Section */
        .health-tips {
            background-color: #f8f8f8;
            padding: 40px 20px;
            text-align: center;
        }
        .health-tips h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
        }
        .health-tips ul {
            list-style-type: none;
            padding: 0;
        }
        .health-tips ul li {
            margin: 10px 0;
            font-size: 1rem;
            line-height: 1.5;
        }
        .health-tips ul li:before {
            content: "✔";
            color: #008080;
            margin-right: 10px;
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

    <div class="slider">
    <div class="slides">
        <img src="images/banner1.jpg" class="slide" alt="Image 1">
        <img src="images/banner2.png" class="slide" id="image2"alt="Image 2">
        <img src="images/banner3.png" class="slide" alt="Image 3">
        
    </div>
    <button class="prev" onclick="changeSlide(-1)">&#10094;</button>
    <button class="next" onclick="changeSlide(1)">&#10095;</button>
</div>
    <br><br><br><br>
        <!-- Search Section -->
        <div class="search-section">
            <h2>Search Medicines, Lab Tests, or Health Care Packages</h2>
            <form action="SearchResults.jsp" method="get">
                <input type="text" name="query" placeholder="Search here..." required>
                <button type="submit">Search</button>
            </form>
        </div>

        <!-- Featured Products Section -->
        <div class="featured-products">
            <h2>Featured Products</h2>
            <div class="content-section">
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
                        stmt = conn.createStatement();
                        String query = "SELECT * FROM product LIMIT 4";
                        rs = stmt.executeQuery(query);
                        while (rs.next()) {
                            String productName = rs.getString("pname");
                            String productImage = rs.getString("image");
                            int price = rs.getInt("price");
                %>
                <div class="card">
                    <img src="<%= productImage %>" alt="<%= productName %>">
                    <h3><%= productName %></h3>
                    <p>Price: ₹<%= price %></p>
                    
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



        <!-- Health Tips Section -->
        <div class="health-tips">
            <h2>Health Tips</h2>
            <ul>
                <li>Stay hydrated by drinking at least 8 glasses of water daily.</li>
                <li>Exercise regularly for at least 30 minutes a day.</li>
                <li>Get 7-8 hours of sleep for optimal health.</li>
                <li>Take your vitamins and supplements as prescribed.</li>
            </ul>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Pharmacy Drug Store. All rights reserved.</p>
    </footer>
         <script src="script.js"></script>
</body>
</html>
