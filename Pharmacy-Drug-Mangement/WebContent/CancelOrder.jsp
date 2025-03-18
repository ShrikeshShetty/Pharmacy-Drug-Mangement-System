<%@ page import="java.sql.*" %>
<%
    String oid = request.getParameter("oid");

    if (oid != null && !oid.trim().isEmpty()) { // Validate oid
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "");
            String sql = "DELETE FROM orders WHERE oid=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, oid);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("Orders.jsp");
            } else {
                out.println("<script>alert('Failed to delete order!'); window.location='Orders.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error occurred!'); window.location='Orders.jsp';</script>");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    } else {
        out.println("<script>alert('Invalid Order ID!'); window.location='Orders.jsp';</script>");
    }
%>
