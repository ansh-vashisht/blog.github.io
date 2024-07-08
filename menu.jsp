<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <title>Admin Dashboard Panel</title> 
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
        }
        nav {
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            background-color: #2c3e50;
            padding-top: 20px;
            color: #fff;
        }
        .logo_name {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .menu-items ul {
            list-style-type: none;
            padding: 0;
        }
        .menu-items ul li {
            padding: 15px 20px;
            border-bottom: 1px solid #34495e;
        }
        .menu-items ul li a {
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        .menu-items ul li a i {
            margin-right: 10px;
        }
        .menu-items ul li:hover {
            background-color: #16a085;
        }
        .dashboard {
            margin-left: 250px;
            padding: 20px;
        }
        .top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ecf0f1;
            padding: 15px;
            border-bottom: 1px solid #bdc3c7;
        }
        .top .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .content {
            margin-top: 20px;
        }
        .box {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .box-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .number {
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <nav>
        <div class="logo_name">Menu</div>
        <div class="menu-items">
            <ul class="nav-links">
                <li><a href="das.jsp">
                    <i class="uil uil-estate"></i>
                    <span class="link-name">Dashboard</span>
                </a></li>
                <li><a href="users.jsp">
                    <i class="uil uil-users-alt"></i>
                    <span class="link-name">Users</span>
                </a></li>
                <li><a href="blogs.jsp">
                    <i class="uil uil-file-alt"></i>
                    <span class="link-name">Blogs</span>
                </a></li>
                <li><a href="contactus.jsp">
                    <i class="uil uil-file-alt"></i>
                    <span class="link-name">Contact Us</span>
                </a></li>
            </ul>
            <ul class="logout-mode">
                <li><a href="Logout.jsp">
                    <i class="uil uil-signout"></i>
                    <span class="link-name">Logout</span>
                </a></li>
            </ul>
        </div>
    </nav>

   
