<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Us</title>
  <meta http-equiv="refresh" content="3;url=das.jsp">
  <!-- Include necessary CSS files -->
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
  <!-- Include your custom styles -->
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 600px;
      margin: 50px auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .btn-primary {
      width: 100%;
    }

    .message {
      text-align: center;
      margin-top: 20px;
    }
  </style>
</head>
<body>
<%@ include file="menu.jsp" %>
<div class="container">
  <h2>Contact Us</h2>
  
  <%!
    Connection conn = null;
    PreparedStatement stmt = null;
    
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/op";
    String dbUser = "root";
    String dbPassword = "";
  %>

  <% 
    // Check if the form has been submitted
    if (request.getMethod().equals("POST")) {
      String name = request.getParameter("name");
      String email = request.getParameter("email");
      String query = request.getParameter("query");

      try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Establish a connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Insert the contact details into the database
        String sql = "INSERT INTO contact (name, email, query) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, query);

        int rowsAffected = stmt.executeUpdate();

        if (rowsAffected > 0) {
          out.println("<p class='message'>Thank you for contacting us!</p>");
        } else {
          out.println("<p class='message'>Failed to submit your query. Please try again.</p>");
        }
      } catch (Exception e) {
        e.printStackTrace();
        out.println("<p class='message'>Error: " + e.getMessage() + "</p>");
      } finally {
        // Close the resources
        try {
          if (stmt != null) stmt.close();
          if (conn != null) conn.close();
        } catch (SQLException se) {
          se.printStackTrace();
        }
      }
    }
  %>

  <form method="post" action="">
    <div class="form-group">
      <label for="name">Name</label>
      <input type="text" class="form-control" id="name" name="name" required>
    </div>
    <div class="form-group">
      <label for="email">Email</label>
      <input type="email" class="form-control" id="email" name="email" required>
    </div>
    <div class="form-group">
      <label for="query">Query</label>
      <textarea class="form-control" id="query" name="query" rows="5" required></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>
</div>

<!-- Include necessary JS files -->
<script src="plugins/jquery/jquery.js"></script>
<script src="plugins/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>
