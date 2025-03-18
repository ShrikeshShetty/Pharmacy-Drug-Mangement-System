<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <link rel="stylesheet" href="css/contact.css">
    <style>
        .logout-button {
            float: right;
            margin: 10px;
            margin-top: -45px;
            padding: 10px 15px;
            background-color: #ff4d4d;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }
        .logout-button:hover {
            background-color: #cc0000;
        }
    </style>
    <script>
        // Close the message box
        function closeMessageBox() {
            document.getElementById("message-box").style.display = "none";
        }
    </script>
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
    <main>
        <section class="contact-section">
            <h2>Contact Us</h2>
            <form action="Contact.jsp" method="post">
                <br>
                <label for="name">Name:</label>
                <input type="text" class="name" name="name" required><br><br>
                <label for="email">Email:</label>
                <input type="email" class="email" name="email" required><br><br>
                <label for="message">Message:</label>
                <textarea class="message" name="message" rows="4" required></textarea><br><br>
                <center><button type="submit">Send</button></center>
            </form>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 Pharmacy Drug Store. All rights reserved.</p>
    </footer>
    
<div class="container">
        <%
            String messageText = null;
            String messageType = null; // "success" or "error"

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String message = request.getParameter("message");

            if (name != null && email != null && message != null) {
                try {
                    // Database connection details
                    String url = "jdbc:mysql://localhost:3306/drugdatabase";
                    String user = "root";
                    String pass = "";

                    Connection con = DriverManager.getConnection(url, user, pass);
                    String query = "INSERT INTO messages (name, email, message) VALUES (?, ?, ?)";
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, name);
                    pst.setString(2, email);
                    pst.setString(3, message);

                    int result = pst.executeUpdate();
                    if (result > 0) {
                        messageText = "Message sent successfully!";
                        messageType = "success";
                    } else {
                        messageText = "Failed to send message.";
                        messageType = "error";
                    }

                    pst.close();
                    con.close();
                } catch (Exception e) {
                    messageText = "Error: " + e.getMessage();
                    messageType = "error";
                }
            }
        %>

        <!-- Message Box -->
        <% if (messageText != null) { %>
            <div id="message-box" class="message-box <%= messageType %>">
                <%= messageText %>
                <a class="close-btn" onclick="closeMessageBox()">×</a>
            </div>
        <% } %>
    </div>
</body>
</html>
