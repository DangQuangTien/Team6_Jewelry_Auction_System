<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register on Jewelry Auctions Online</title>
        <link rel="stylesheet" href="component/main.css">
        <script>
            function validateForm() {
                var firstName = document.forms["registerForm"]["firstName"].value;
                var lastName = document.forms["registerForm"]["lastName"].value;
                var email = document.forms["registerForm"]["email"].value;
                var username = document.forms["registerForm"]["username"].value;
                var password = document.forms["registerForm"]["password"].value;
                var nameRegex = /^[A-Za-z]{1,15}$/;
                var passwordRegex = /^(?=.*[A-Z]).{6,}$/;

                if (!nameRegex.test(firstName)) {
                    alert("First name must be between 1 and 15 characters and contain no numbers.");
                    return false;
                }
                if (!nameRegex.test(lastName)) {
                    alert("Last name must be between 1 and 15 characters and contain no numbers.");
                    return false;
                }
                if (username.length === 0) {
                    alert("Username is required.");
                    return false;
                }
                if (!passwordRegex.test(password)) {
                    alert("Password must be at least 6 characters long and contain at least one uppercase character.");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <div class="register-card">
            <a href="home.jsp">
                <h1>Jewelry Auctions Online</h1> 
            </a>
            <p style="text-align: center; color: #666; font-size: 16px; font-family: 'Arial', sans-serif;">Explore the World of Auctions with Us</p>
            <% if (request.getAttribute("errorMsg") != null) {%>
            <div style="color: red;">
                <%= request.getAttribute("errorMsg")%>
            </div>
            <% }%>
            <form name="registerForm" action="MainController" onsubmit="return validateForm()">
                <input type="text" name="firstName" placeholder="Your first name" autocomplete="name" required="required" autofocus="autofocus"/>
                <input type="text" name="lastName" placeholder="Your last name" autocomplete="name" required="required"/>
                <input type="email" name="email" placeholder="Email address" autocomplete="email" required="required"/>
                <input type="text" name="username" placeholder="Username" autocomplete="username" required="required">
                <input type="password" name="password" placeholder="Password" autocomplete="current-password" required="required">
                <input type="checkbox" name="agreed" checked=""> By registering, you confirm you are 18 years old or older, and you have read and agreed to the privacy
                <br><br>
                <input type="submit" name="action" value="Register User">
            </form>
            <br>
            <div>Already registered? <a href="login.jsp">Log in instead</a></div>
        </div>
    </body>
</html>

