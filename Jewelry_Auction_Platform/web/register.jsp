<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register on Jewelry Auctions Online</title>
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
            .register-container {
                display: flex;
                width: 900px;
                height: 650px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
                background-color: #fff;
                border-radius: 15px;
                overflow: hidden;
            }
            .register-image {
                width: 50%;
                background: url('WEB-INF/asset/login.jpg') no-repeat center center;
                background-size: cover;
            }
            .register-form {
                width: 50%;
                padding: 50px 40px;
                box-sizing: border-box;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
            .register-form h1 {
                margin: 0;
                font-size: 28px;
                text-align: center;
                color: #333;
            }
            .register-form p {
                text-align: center;
                color: #666;
                font-size: 16px;
                margin-bottom: 30px;
            }
            .register-form input[type="text"],
            .register-form input[type="email"],
            .register-form input[type="password"] {
                width: 100%;
                padding: 15px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-sizing: border-box;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            .register-form input[type="text"]:focus,
            .register-form input[type="email"]:focus,
            .register-form input[type="password"]:focus {
                border-color: #000000;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.2);
            }
            .register-form input[type="submit"] {
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
            .register-form input[type="submit"]:hover {
                background-color: #444444;
            }
            .register-form .additional-links {
                text-align: center;
                margin-top: 20px;
            }
            .register-form .additional-links a {
                color: #007bff;
                text-decoration: none;
            }
            .register-form .additional-links a:hover {
                text-decoration: underline;
            }
            a {
                color: #000000;
            }
        </style>
    </head>
    <body>
        <div class="register-container">
            <div class="register-image"></div>
            <div class="register-form">
                <a href="home.jsp">
                    <h1>Jewelry Auctions Online</h1>
                </a>
                <p>Explore the World of Auctions with Us</p>
                <form action="MainController" method="POST">
                    <input type="text" name="name" placeholder="Your full name" autocomplete="name" required="required" autofocus="autofocus"/>
                    <input type="email" name="email" placeholder="Email address" autocomplete="email" required="required"/>
                    <input type="text" name="username" placeholder="Username" autocomplete="username" required="required">
                    <input type="password" name="password" placeholder="Password" autocomplete="current-password" required="required">
                    <br><br>
                    <input type="checkbox" name="agreed" checked=""> By registering, you confirm you are 18 years old or older, and you have read and agreed to the privacy
                    <br><br>
                    <input type="submit" name="action" value="Register">
                </form>
                <br>
                <div class="additional-links">
                    Already registered? <a href="login.jsp">Log in instead</a>
                </div>
            </div>
        </div>
    </body>
</html>
