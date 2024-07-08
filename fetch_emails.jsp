<%@ page import="java.sql.*" %>
<%
    String inputValue = request.getParameter("input").trim();
    if (inputValue != null && !inputValue.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish the database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/op", "root", "");
            
            // Prepare SQL statement to fetch emails based on input
            String sql = "SELECT email FROM login WHERE email LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + inputValue + "%");
            
            // Execute query
            rs = stmt.executeQuery();
            
            // Prepare JSON response
            StringBuilder json = new StringBuilder();
            json.append("[");
            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    json.append(",");
                }
                json.append("\"").append(rs.getString("email")).append("\"");
                first = false;
            }
            json.append("]");
            
            // Set response content type
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            // Send JSON response
            out.print(json.toString());
            
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error fetching emails: " + e.getMessage());
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* ignored */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignored */ }
        }
    }
%>
