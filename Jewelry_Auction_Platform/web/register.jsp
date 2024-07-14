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
        }
        .register-card {
            width: 600px;
            background: #fff;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: fadeInUp 0.5s ease-out;
        }
        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(50px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .register-card h1 {
            font-size: 2em;
            margin-bottom: 10px;
            font-family: 'Zapf-Chancery', cursive;
        }
        .register-card p {
            color: #666;
            font-size: 16px;
            margin-bottom: 20px;
        }
        .register-card form {
            display: flex;
            flex-direction: column;
            animation: slideInLeft 0.5s ease-out;
        }
        @keyframes slideInLeft {
            0% {
                opacity: 0;
                transform: translateX(-50px);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }
        .register-card input[type="text"],
        .register-card input[type="email"],
        .register-card input[type="password"],
        .register-card select,
        .register-card input[type="tel"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
            animation: fadeIn 0.5s ease-out;
        }
        .register-card input[type="text"]:focus,
        .register-card input[type="email"]:focus,
        .register-card input[type="password"]:focus,
        .register-card select:focus,
        .register-card input[type="tel"]:focus {
            border-color: #000000;
        }
        .register-card input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            background-color: #000000;
            color: #fff;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            animation: scaleIn 0.5s ease-out;
        }
        @keyframes scaleIn {
            0% {
                transform: scale(0.8);
            }
            100% {
                transform: scale(1);
            }
        }
        .register-card input[type="submit"]:hover {
            background-color: #444444;
        }
        .register-card .login-link {
            margin-top: 15px;
            font-size: 14px;
            animation: fadeIn 0.5s ease-out;
        }
        .register-card .login-link a {
            color: #007bff;
            text-decoration: none;
        }
        .register-card .login-link a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: red;
            margin-top: 10px;
            animation: fadeIn 0.5s ease-out;
        }
        .dob-container {
            display: flex;
            justify-content: space-between;
        }
        .dob-container select {
            flex: 1;
            margin-right: 10px;
        }
        .gender-container {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .gender-container label {
            margin-right: 10px;
        }
        .gender-container label:first-child {
            margin-left: 10px; /* ?? t?o kho?ng cách t? ??u */
        }
        .gender-container label:last-child {
            margin-right: 0; /* ?? lo?i b? kho?ng cách ? label cu?i cùng */
        }
    </style>
    <script>
        function validateForm() {
            var firstName = document.forms["registerForm"]["firstName"].value;
            var lastName = document.forms["registerForm"]["lastName"].value;
            var email = document.forms["registerForm"]["email"].value;
            var username = document.forms["registerForm"]["username"].value;
            var password = document.forms["registerForm"]["password"].value;
            var phoneNumber = document.forms["registerForm"]["phoneNumber"].value;
            var nameRegex = /^[A-Za-z]{1,15}$/;
            var passwordRegex = /^(?=.*[A-Z]).{6,}$/;
            var phoneRegex = /^[0-9]{10,11}$/;

            if (!nameRegex.test(firstName)) {
                alert("First name must be between 1 and 15 characters and contain no numbers.");
                return false;
            }
            if (!nameRegex.test(lastName)) {
                alert("Last name must be between 1 and 15 characters and contain no numbers.");
                return false;
            }
            if(!phoneRegex.test(phoneNumber)){
                alert("Phone number must be 10 or 11 number characters.")
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
            // Validate gender selection
            var checkedBoxes = document.querySelectorAll('input[name="gender"]:checked');
            if (checkedBoxes.length !== 1) {
                alert("Please select exactly one gender.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="register-card">
        <a style="text-decoration: none" href="${pageContext.request.contextPath}/home">
            <h1 style="font-family: 'Zapf-Chancery'; font-size: 3em; font-weight: bold">F'RANKELLY</h1>
        </a>
        <p style="text-align: center; color: #666; font-size: 16px; font-family: 'Arial', sans-serif;">Explore the World of Auctions with Us</p>
        <% if (request.getAttribute("errorMsg") != null) {%>
        <div style="color: red;">
            <%= request.getAttribute("errorMsg")%>
        </div>
        <% }%>
        <form name="registerForm" action="${pageContext.request.contextPath}/register" method="POST" onsubmit="return validateForm()">
            <div style="display: flex; justify-content: space-between;">
                <input type="text" name="firstName" placeholder="First name" autocomplete="given-name" required="required" autofocus="autofocus" style="width: 48%;">
                <input type="text" name="lastName" placeholder="Last name" autocomplete="family-name" required="required" style="width: 48%;">
            </div>
            <input type="email" name="email" placeholder="Email address" autocomplete="email" required="required" style="width: 100%;">
            <input type="text" name="username" placeholder="Username" autocomplete="" style="width: 100%;">
            <input type="tel" name="phoneNumber" placeholder="Phone Number" autocomplete="" required="required" style="width: 100%;">
<!--            <input type="tel" class="form-control" id="phone" name="phone"  ng-model="user.phone" phone-validation required>-->
            <div class="dob-container">
                <select name="dobDay" required>
                    <option value="">Day</option>
                    <% for (int i = 1; i <= 31; i++) { %>
                    <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
                <select name="dobMonth" required>
                    <option value="">Month</option>
                    <% String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}; %>
                    <% for (int i = 0; i < months.length; i++) { %>
                    <option value="<%= i + 1 %>"><%= months[i] %></option>
                    <% } %>
                </select>
                <select name="dobYear" required>
                    <option value="">Year</option>
                    <% for (int i = 1900; i <= 2024; i++) { %>
                    <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
            </div>
            <div class="gender-container">
                <span>Gender:</span>
                <label><input type="radio" name="gender" value="male" required> Male</label>
                <label><input type="radio" name="gender" value="female" required> Female</label>
                <label><input type="radio" name="gender" value="other" required> Other</label>
            </div>
                <input type="password" name="password" placeholder="Password" autocomplete="" style="width: 100%;">
            <div class="checkbox-container">
                <input type="checkbox" name="agreed" id="agreed" required>
                <label for="agreed">By registering, you confirm you are 18 years old or older, and you have read and agreed to the privacy policy.</label>
            </div>
            <input type="submit" name="action" value="Register">
        </form>
        <br>
        <div>Already registered? <a href="${pageContext.request.contextPath}/login">Log in instead</a></div>
    </div>
</body>
</html>