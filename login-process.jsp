<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Processing</title>
</head>
<body>
    <h2>Login Processing</h2>
    <%
        // Retrieve form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate credentials against database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/op", "root", "");
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM login WHERE email = ? AND password = ?");
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        // Check if login is successful
        if (rs.next()) {
            // Successful login
            String name = rs.getString("name");
            out.println("<p>Login successful! Welcome, " + name + ".</p>");
        } else {
            // Failed login
            out.println("<p>Login failed. Please check your email and password.</p>");
        }

        // Close resources
        rs.close();
        stmt.close();
        conn.close();
    %>
</body>
</html>
