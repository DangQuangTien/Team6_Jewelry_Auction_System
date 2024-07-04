<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>F'RANKELLY AUCTION HOUSE - LOGIN</title>
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
                overflow: hidden;
                animation: slideIn 0.5s ease forwards;
            }
            @keyframes slideIn {
                from {
                    transform: translateY(-100%);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            .login-image {
                width: 50%;
                background: url('images/logo/login.jpg') no-repeat center center;
                background-size: cover;
                animation: fadeIn 1s ease forwards;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
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
                position: relative;
                font-family: monospace;
                font-size: 18px
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-image"></div>
            <div class="login-form">
                <a style="text-decoration: none" href="${pageContext.request.contextPath}/home">
                    <h1 style="font-family: 'Zapf-Chancery'; font-size: 3em; font-weight: bold">F'RANKELLY</h1>
                </a>
                <p>Explore the World of Auctions with Us</p>.
                <c:set var="error" value="${requestScope.error}" />
                <c:set var="username" value="${requestScope.username}" />
                <c:set var="password" value="${requestScope.password}" />
                <form action="login" method="POST">
                    <input type="text" name="email" placeholder="Phone number/ Username/ Email" required="required" value="<c:if  test="${not empty  username}"></c:if>" />
                    <input type="password" name="password" placeholder="Password" required="required" value="<c:if  test="${not empty  password}"></c:if>" />
                        <br><br>
                    <c:if  test="${not empty  error}">
                        <div id="error-message" class="error-message"> ${error}</div><br>
                    </c:if>
                    <input type="checkbox" name="remember" checked=""> Remember me
                    <a href="#forgot">Forgot your password?</a>
                    <br><br>
                    <input type="submit" name="action" value="Log in">
                </form>
                <br>
                <div class="additional-links">
                    Don't have an account? <a href="${pageContext.request.contextPath}/register">Register instead</a>
                </div>
            </div>
        </div>
    </body>
    <script>
        setTimeout(function () {
            var errorMessage = document.getElementById('error-message');
            if (errorMessage) {
                errorMessage.style.display = 'none';
            }
        }, 3000);
    </script>
</html>
