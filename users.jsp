<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .menu {
            text-align: right;
            margin-bottom: 10px;
        }
        .menu a {
            text-decoration: none;
            color: #06C167;
            font-weight: bold;
        }
        .menu a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<jsp:include page="menu.jsp" />
<div class="container">
    <h2>User Information</h2>

    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <% 
                String url = "jdbc:mysql://localhost:3306/op";
                String user = "root";
                String password = "";
                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, user, password);
                    String query = "SELECT name, age, gender, email FROM login";
                    stmt = connection.prepareStatement(query);
                    rs = stmt.executeQuery();
                    
                    while (rs.next()) {
                        String name = rs.getString("name");
                        int age = rs.getInt("age");
                        String gender = rs.getString("gender");
                        String email = rs.getString("email");
            %>
                        <tr>
                            <td><%= name %></td>
                            <td><%= age %></td>
                            <td><%= gender %></td>
                            <td><%= email %></td>
                        </tr>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>
