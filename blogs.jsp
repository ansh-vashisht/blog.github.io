<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="megakit,business,company,agency,multipurpose,modern,bootstrap4">
  <meta name="author" content="themefisher.com">
  <title>Blog Hut | A Blogging website</title>

  <!-- Bootstrap.min CSS -->
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
  <!-- Icon Font CSS -->
  <link rel="stylesheet" href="plugins/themify/css/themify-icons.css">
  <link rel="stylesheet" href="plugins/fontawesome/css/all.css">
  <link rel="stylesheet" href="plugins/magnific-popup/dist/magnific-popup.css">
  <!-- Owl Carousel CSS -->
  <link rel="stylesheet" href="plugins/slick-carousel/slick/slick.css">
  <link rel="stylesheet" href="plugins/slick-carousel/slick/slick-theme.css">
  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="css/style.css">
  <!-- Custom CSS for fixed width -->
  <style>
    .blog-item {
      width: 300px; /* Fixed width for blog item */
      margin: auto; /* Center the blog item */
    }
    .blog-item img {
      width: 100%; /* Image takes the full width of the blog item */
      height: 200px; /* Fixed height for images */
      object-fit: cover; /* Ensure images cover the fixed height without distortion */
    }
  </style>
</head>

<body>
<!-- Header Start --> 
<%@ include file="menu.jsp" %>
<!-- Header Close --> 

<section class="section blog-wrap bg-gray">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 text-center mb-5">
        <h2>Welcome to the Blogs</h2>
      </div>
      <div class="col-lg-8 offset-lg-2"> <!-- Added offset to center the blogs block -->
        <div class="row justify-content-center"> <!-- Center the blog items in the row -->
          <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/op";
            String user = "root";
            String password = "";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
              // Load the JDBC driver
              Class.forName("com.mysql.cj.jdbc.Driver");
              // Establish a connection
              conn = DriverManager.getConnection(url, user, password);
              // Create a statement
              stmt = conn.createStatement();
              // Execute a query
              String sql = "SELECT * FROM blog";
              rs = stmt.executeQuery(sql);

              // Iterate through the result set and display each blog in a grid item
              while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String topic = rs.getString("topic");
                String descr = rs.getString("descr");
                String img = rs.getString("img");
                String author = rs.getString("author");
                String address = rs.getString("extra"); 

                out.println("<div class='col-lg-6 col-md-6 mb-5 d-flex justify-content-center'>");
                out.println("  <div class='blog-item'>");
                if (img != null && !img.isEmpty()) {
                  out.println("    <a href='" + address + "'><img src='" + img + "' alt='' class='img-fluid rounded'></a>");
                }
                out.println("    <div class='blog-item-content bg-white p-4'>");
                out.println("      <div class='blog-item-meta py-1 px-2'>");
                out.println("        <span class='text-muted text-capitalize mr-3'><i class='ti-pencil-alt mr-2'></i>" + topic + "</span>");
                out.println("      </div>"); 
                out.println("      <h3 class='mt-3 mb-3'><a href='" + address + "'>" + title + "</a></h3>");
                out.println("      <p class='mb-4'>" + (descr.length() > 100 ? descr.substring(0, 100) + "..." : descr) + "</p>");
                out.println("      <a href='" + address + "' class='btn btn-small btn-main btn-round-full'>Read More</a>");
                out.println("    </div>");
                out.println("  </div>");
                out.println("</div>");
              }
            } catch (Exception e) {
              e.printStackTrace();
              out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
              // Close the resources
              try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
              } catch (SQLException se) {
                se.printStackTrace();
              }
            }
          %>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Link to add a new blog -->
<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-lg-4 text-center">
      <a href="add_blog.jsp" class="btn btn-primary">Add New Blog</a>
    </div>
  </div>
</div>

<!-- Essential Scripts -->
<script src="plugins/jquery/jquery.js"></script>
<script src="plugins/bootstrap/js/popper.js"></script>
<script src="plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="plugins/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
<script src="plugins/slick-carousel/slick/slick.min.js"></script>
<script src="plugins/counterup/jquery.waypoints.min.js"></script>
<script src="plugins/counterup/jquery.counterup.min.js"></script>
<script src="js/custom.js"></script>

</body>
</html>
