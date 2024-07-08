<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: lightgreen;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .container h2 {
            text-align: center;
            color: #333;
        }
        .input-group {
            margin-bottom: 20px;
        }
        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .input-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .custom-dropdown {
            position: relative;
            margin-bottom: 20px;
        }
        .custom-dropdown input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #fff;
            border: 1px solid #ccc;
            border-top: none;
            width: 100%;
            max-height: 150px;
            overflow-y: auto;
            z-index: 1;
        }
        .dropdown-content a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #333;
            transition: background-color 0.3s;
        }
        .dropdown-content a:hover {
            background-color: #f9f9f9;
        }
        .btn-submit {
            background-color: #06C167;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #049a5c;
        }
        .login-signup {
            text-align: center;
            margin-top: 20px;
        }
        .login-signup a {
            color: #06C167;
            font-weight: bold;
            text-decoration: none;
        }
        .error-msg {
            color: red;
            text-align: center;
        }
    </style>
    <script>
        function fetchEmailsAndShowDropdown() {
            var emailInput = document.getElementById("email");
            var dropdownContent = document.getElementById("emailDropdownContent");
            var inputValue = emailInput.value.trim();
            
            dropdownContent.innerHTML = "";
            if (inputValue.length > 0) {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var emails = JSON.parse(xhr.responseText);
                            emails.forEach(function(email) {
                                var option = document.createElement("a");
                                option.textContent = email;
                                option.onclick = function() {
                                    emailInput.value = email;
                                    dropdownContent.style.display = "none";
                                };
                                dropdownContent.appendChild(option);
                            });
                            dropdownContent.style.display = "block";
                        } else {
                            console.log("Error fetching emails: " + xhr.status);
                        }
                    }
                };
                xhr.open("GET", "fetch_emails.jsp?input=" + inputValue, true);
                xhr.send();
            } else {
                dropdownContent.style.display = "none";
            }
        }
        document.addEventListener("click", function(event) {
            var emailInput = document.getElementById("email");
            var dropdownContent = document.getElementById("emailDropdownContent");
            if (!emailInput.contains(event.target) && !dropdownContent.contains(event.target)) {
                dropdownContent.style.display = "none";
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form action="das.jsp" method="post">
            <div class="input-group">
                <label for="email">Email:</label>
                <div class="custom-dropdown">
                    <input type="text" id="email" name="email" oninput="fetchEmailsAndShowDropdown()">
                    <div class="dropdown-content" id="emailDropdownContent">
                    </div>
                </div>
            </div>
            <div class="input-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="input-group">
                <input type="submit" class="btn-submit" value="Login">
            </div>
        </form>
        <div class="login-signup">
            <span>Don't have an account? <a href="signup.jsp">Sign Up</a></span>
        </div>
    </div>
</body>
</html>
