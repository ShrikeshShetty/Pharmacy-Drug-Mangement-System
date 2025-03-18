<%@ page import="java.sql.*" %>
<%
    String oid = request.getParameter("oid");
    int newQuantity = Integer.parseInt(request.getParameter("quantity"));
    Connection conn = null;
    PreparedStatement ps = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
        
        // Update quantity, and assume price is calculated dynamically (e.g., price per unit is stored somewhere)
        String updateSql = "UPDATE orders SET quantity=?, price=(SELECT price * ? FROM product WHERE product.pid = orders.pid) WHERE oid=?";
        ps = conn.prepareStatement(updateSql);
        ps.setInt(1, newQuantity);
        ps.setInt(2, newQuantity);
        ps.setString(3, oid);
        ps.executeUpdate();
        
        response.sendRedirect("Orders.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
