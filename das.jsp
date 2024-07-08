<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <!-- Include Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        .header {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }
        .content {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        .box {
            width: calc(50% - 40px); /* 50% width with margin adjustments */
            min-width: 300px; /* Ensure boxes don't get too narrow */
            height: 320px; /* Fixed height for all boxes */
            margin: 20px;
            padding: 20px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center;
        }
        .box-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #06C167;
        }
        .number {
            font-size: 24px;
            font-weight: bold;
        }
        canvas {
            max-width: 100%;
            max-height: 70%; /* Adjust height of charts within boxes */
            margin-top: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="menu.jsp" />

<%
        String name = ""; // Initialize the username variable
        String email = request.getParameter("email"); // Retrieve email from login form
        String url = "jdbc:mysql://localhost:3306/op";
        String user = "root";
        String password = "";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            String query = "SELECT name FROM login WHERE email = ?";
            stmt = connection.prepareStatement(query);
            stmt.setString(1, email);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <div class="header">
        <h1>Welcome, <%= name %>!</h1>
    </div>

<div class="content">
    <div class="box">
        <div class="box-title">Total Users</div>
        <% 
            int totalUsers = 0;
            try {
                connection = DriverManager.getConnection(url, user, password);
                String query = "SELECT COUNT(*) AS count FROM login";
                stmt = connection.prepareStatement(query);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    totalUsers = rs.getInt("count");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <div class='number'><br><br><br><p styles="font-size:xlarge"><%= totalUsers %></p></div>
    </div>
    
    <div class="box">
        <div class="box-title">Gender Distribution</div>
        <canvas id="genderChart" width="300" height="300"></canvas>
        <%
            int maleCount = 0;
            int femaleCount = 0;
            
            try {
                connection = DriverManager.getConnection(url, user, password);
                String query = "SELECT gender, COUNT(*) AS count FROM login GROUP BY gender";
                stmt = connection.prepareStatement(query);
                rs = stmt.executeQuery();
                
                while (rs.next()) {
                    String gender = rs.getString("gender");
                    int count = rs.getInt("count");
                    
                    if (gender.equalsIgnoreCase("male")) {
                        maleCount = count;
                    } else if (gender.equalsIgnoreCase("female")) {
                        femaleCount = count;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <script>
            var ctx1 = document.getElementById('genderChart').getContext('2d');
            var genderChart = new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: ['Male', 'Female'],
                    datasets: [{
                        label: 'Gender Distribution',
                        data: [<%= maleCount %>, <%= femaleCount %>],
                        backgroundColor: [
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 99, 132, 0.2)'
                        ],
                        borderColor: [
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 99, 132, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                stepSize: 10 // Ensure step size is 1 for integer values
                            }
                        }]
                    }
                }
            });
        </script>
    </div>
    
    <div class="box">
        <div class="box-title">Age Distribution</div>
        <canvas id="ageChart" width="150" height="150"></canvas>
        <%
            HashMap<Integer, Integer> ageMap = new HashMap<>();
            
            try {
                connection = DriverManager.getConnection(url, user, password);
                String query = "SELECT age, COUNT(*) AS count FROM login GROUP BY age";
                stmt = connection.prepareStatement(query);
                rs = stmt.executeQuery();
                
                while (rs.next()) {
                    int age = rs.getInt("age");
                    int count = rs.getInt("count");
                    ageMap.put(age, count);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <script>
            var ctx2 = document.getElementById('ageChart').getContext('2d');
            var ageChart = new Chart(ctx2, {
                type: 'pie',
                data: {
                    labels: [<%
                        int count = 1;
                        for (Integer age : ageMap.keySet()) {
                            out.print("'" + age + " years'");
                            if (count < ageMap.size()) out.print(",");
                            count++;
                        }
                    %>],
                    datasets: [{
                        label: 'Age Distribution',
                        data: [<%
                            count = 1;
                            for (Integer countVal : ageMap.values()) {
                                out.print(countVal);
                                if (count < ageMap.size()) out.print(",");
                                count++;
                            }
                        %>],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)',
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)',
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)'
                        ],
                        borderWidth: 1
                    }]
                }
            });
        </script>
    </div>
    
    <div class="box">
        <div class="box-title">Total Blogs</div>
        <% 
            int totalBlogs = 0;
            try {
                connection = DriverManager.getConnection(url, user, password);
                String query = "SELECT COUNT(*) AS count FROM blog";
                stmt = connection.prepareStatement(query);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    totalBlogs = rs.getInt("count");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <div class='number' styles="font-size:xlarge"><br><br><br><%= totalBlogs %></div>
    </div>
</div>

</body>
</html>
