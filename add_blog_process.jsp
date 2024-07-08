<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Adding Blog Process</title>
  <meta http-equiv="refresh" content="3;url=blogs.jsp"> <!-- Redirect after 3 seconds -->
  <!-- Include necessary CSS files -->
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
  <!-- Include your custom styles -->
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: antiquewhite;
      margin: 0;
      padding: 0;
    }

    .card {
      background-color: #c2ffc5;
      width: 500px;
      height: 300px;
      margin: 100px auto;
      border-radius: 20px;
      padding: 30px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .card h1 {
      color: #2A2C30;
      text-align: center;
      margin-bottom: 20px;
    }

    .card p {
      color: #000000;
      text-align: center;
      font-size: 20px;
      line-height: 1.6;
    }

    .home {
      display: block;
      text-align: center;
      color: #2A2C30;
      margin-top: 20px;
      text-decoration: none;
    }

    .home:hover {
      color: #2A2C30;
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="card">
  <h1>Thank You</h1>
  <p>Blog added successfully!</p>
  <a href="blog.jsp" class="home">Return to Blog</a>
</div>

<%
  String title = request.getParameter("title");
  String topic = request.getParameter("topic");
  String descr = request.getParameter("descr");
  String img = request.getParameter("img");
  String extra = request.getParameter("extra");
  String author = request.getRemoteUser(); // Assuming the author is the logged-in user

  // Database connection parameters
  String url = "jdbc:mysql://localhost:3306/op";
  String dbUser = "root";
  String dbPassword = "";
  Connection conn = null;
  PreparedStatement stmt = null;

  try {
    // Load the JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");
    // Establish a connection
    conn = DriverManager.getConnection(url, dbUser, dbPassword);

    // Insert the blog data into the database
    String sql = "INSERT INTO blog (title, topic, descr, img, author,extra) VALUES (?, ?, ?, ?, ?,?)";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, title);
    stmt.setString(2, topic);
    stmt.setString(3, descr);
    stmt.setString(4, img); // Set image path directly
    stmt.setString(5, author);
    stmt.setString(6, extra);

    int rowsAffected = stmt.executeUpdate();

    if (rowsAffected <= 0) {
      throw new SQLException("Failed to add blog.");
    }
  } catch (Exception e) {
    e.printStackTrace();
    out.println("<p>Error: " + e.getMessage() + "</p>");
  } finally {
    // Close the resources
    try {
      if (stmt != null) stmt.close();
      if (conn != null) conn.close();
    } catch (SQLException se) {
      se.printStackTrace();
    }
  }
%>

<!-- Include necessary JS files -->
<script src="plugins/jquery/jquery.js"></script>
<script src="plugins/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>
