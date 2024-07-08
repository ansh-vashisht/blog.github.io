<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add New Blog</title>
  <!-- Include necessary CSS files -->
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
  <!-- Include your custom styles -->
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container mt-5">
  <div class="row">
    <div class="col-lg-8 offset-lg-2">
      <h2>Add New Blog</h2>
      <form action="add_blog_process.jsp" method="post">
        <div class="form-group">
          <label for="title">Title</label>
          <input type="text" class="form-control" id="title" name="title" required>
        </div>
        <div class="form-group">
          <label for="topic">Topic</label>
          <input type="text" class="form-control" id="topic" name="topic" required>
        </div>
        <div class="form-group">
          <label for="descr">Description</label>
          <textarea class="form-control" id="descr" name="descr" rows="5" required></textarea>
        </div>
        <div class="form-group">
          <label for="img">Image Path</label>
          <input type="text" class="form-control" id="img" name="img" required>
        </div>
        <div class="form-group">
          <label for="img">Address of Full Blog:</label>
          <input type="text" class="form-control" id="extra" name="extra" required>
        </div>
        <input type="hidden" name="author" value="<%= request.getRemoteUser() %>">
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
    </div>
  </div>
</div>

<!-- Include necessary JS files -->
<script src="plugins/jquery/jquery.js"></script>
<script src="plugins/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>
