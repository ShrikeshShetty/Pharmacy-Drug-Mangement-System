<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.MultipartConfig" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String uploadPath = application.getRealPath("/") + "uploads";
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) {
    uploadDir.mkdir(); // Create 'uploads' folder if it doesn’t exist
    out.println("<h3>✅ Uploads Folder Created</h3>");
}

// Database connection
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");

// Get form data
String pid = request.getParameter("pid");
String pname = request.getParameter("pname");
String manufacturer = request.getParameter("manufacturer");
String mfg = request.getParameter("mfg");
String exp = request.getParameter("exp");
int price = Integer.parseInt(request.getParameter("price"));
int quantity = Integer.parseInt(request.getParameter("quantity"));
String fileName = request.getParameter("hidimg");

// Enable transaction management
conn.setAutoCommit(false);

try {    
    // Insert into product table
    String sqlProduct = "INSERT INTO product (pid, pname, manufacturer, mfg, exp, price, quantity, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt1 = conn.prepareStatement(sqlProduct);
    pstmt1.setString(1, pid);
    pstmt1.setString(2, pname);
    pstmt1.setString(3, manufacturer);
    pstmt1.setString(4, mfg);
    pstmt1.setString(5, exp);
    pstmt1.setInt(6, price);
    pstmt1.setInt(7, quantity);
    pstmt1.setString(8, fileName);
    int result1 = pstmt1.executeUpdate();

    // Insert into inventory table
    String sqlInventory = "INSERT INTO inventory (pid, pname, quantity, sid) VALUES (?, ?, ?, ?)";
    PreparedStatement pstmt2 = conn.prepareStatement(sqlInventory);
    pstmt2.setString(1, pid);
    pstmt2.setString(2, pname);
    pstmt2.setInt(3, quantity);
    pstmt2.setInt(4, 101); // Assuming `sid` is always 101 for now
    int result2 = pstmt2.executeUpdate();

    // Commit transaction if both inserts succeed
    if (result1 > 0 && result2 > 0) {
        conn.commit();
        out.println("<h3>✅ Product and Inventory added successfully!</h3>");
    } else {
        conn.rollback(); // Rollback if any insert fails
        out.println("<h3>❌ Failed to add product and inventory.</h3>");
    }

} catch (Exception e) {
    conn.rollback(); // Rollback in case of an exception
    e.printStackTrace();
} finally {
    conn.setAutoCommit(true);
    conn.close();
}
%>
