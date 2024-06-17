<% 
    String username = request.getParameter("username");
    String password = request.getParameter("password");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log in to Jewelry Auctions Online</title>
        <link rel="stylesheet" href="component/main.css">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background: linear-gradient(to right, #ffffff, #000000);
            }
            .login-container {
                display: flex;
                width: 900px;
                height: 650px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
                background-color: #fff;
                border-radius: 15px;
                overflow: hidden;
            }
            .login-image {
                width: 50%;
                background: url('images/logo/login.jpg') no-repeat center center;
                background-size: cover;
            }
            .login-form {
                width: 50%;
                padding: 50px 40px;
                box-sizing: border-box;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
            .login-form h1 {
                margin: 0;
                font-size: 28px;
                text-align: center;
                color: #333;
            }
            .login-form p {
                text-align: center;
                color: #666;
                font-size: 16px;
                margin-bottom: 30px;
            }
            .login-form input[type="text"],
            .login-form input[type="password"] {
                width: 100%;
                padding: 15px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-sizing: border-box;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            .login-form input[type="text"]:focus,
            .login-form input[type="password"]:focus {
                border-color: #000000;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.2);
            }
            .login-form input[type="submit"] {
                width: 100%;
                padding: 15px;
                margin: 20px 0;
                border: none;
                border-radius: 10px;
                background-color: #000000;
                color: #fff;
                font-size: 18px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .login-form input[type="submit"]:hover {
                background-color: #444444;
            }
            .login-form .additional-links {
                text-align: center;
                margin-top: 20px;
            }
            .login-form .additional-links a {
                color: #007bff;
                text-decoration: none;
            }
            .login-form .additional-links a:hover {
                text-decoration: underline;
            }
            .error-message {
                color: red;
                background-color: #f8d7da;
                border: 1px solid #f5c2c7;
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 5px;
                position: relative;
            }
            .error-message .close-btn {
                position: absolute;
                top: 50%;
                right: 10px;
                transform: translateY(-50%);
                background: none;
                border: none;
                font-size: 16px;
                cursor: pointer;
            }
            a {
                color: #000000;
            }
        </style>
        <script>
            function closeErrorMessage() {
                var errorDiv = document.getElementById("error-message");
                errorDiv.style.display = "none";
            }
        </script>
    </head>
    <body>
        <div class="login-container">
            <div class="login-image"></div>
            <div class="login-form">
                <a href="home.jsp">
                    <h1>Jewelry Auctions Online</h1>
                </a>
                <p>Explore the World of Auctions with Us</p>
                <%
                    String error = (String) request.getAttribute("LOGIN_ERROR");
                %>
                <% if (error != null) { %>
                <div id="error-message" class="error-message">
                    <%= error %>
                    <button class="close-btn" onclick="closeErrorMessage()">X</button>
                </div>
                <% } %>
                <form action="MainController" method="POST">
                    <input type="text" name="email" placeholder="Phone number/ Username/ Email" required="required" value="<%= (username != null) ? username : "" %>" />
                    <input type="password" name="password" placeholder="Password" required="required" value="<%= (password != null) ? password : "" %>" />
                    <br><br>
                    <input type="checkbox" name="remember" checked=""> Remember me
                    <a href="#forgot">Forgot your password?</a>
                    <br><br>
                    <input type="submit" name="action" value="Log in">
                </form>
                <br>
                <div class="additional-links">
                    Don't have an account? <a href="register.jsp">Register instead</a>
                </div>
            </div>
        </div>
    </body>
</html>
