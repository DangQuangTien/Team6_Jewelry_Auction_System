<%@page import="dao.UserDAOImpl"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
            }
            nav {
                background-color: white;
                color: #000000;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            nav a {
                color: #000000;
                text-decoration: none;
                margin-right: 10px;
                padding: 8px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }
            nav a:hover {
                background-color: rgba(85, 85, 85, 0.5);
                color: white;
            }
            .profile-container {
                margin-top: 20px;
            }
            .profile-header {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .profile-content {
                margin-top: 20px;
            }

            .Btn {
                --black: #000000;
                --ch-black: #141414;
                --eer-black: #1b1b1b;
                --night-rider: #2e2e2e;
                --white: #ffffff;
                --af-white: #f3f3f3;
                --ch-white: #e1e1e1;
                display: flex;
                align-items: center;
                justify-content: flex-start;
                width: 45px;
                height: 45px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                position: relative;
                overflow: hidden;
                transition-duration: .3s;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.199);
                background-color: var(--af-white);
            }

            /* plus sign */
            .sign {
                width: 100%;
                transition-duration: .3s;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .sign svg {
                width: 17px;
            }

            .sign svg path {
                fill: var(--night-rider);
            }
            /* text */
            .text {
                position: absolute;
                right: 0%;
                width: 0%;
                opacity: 0;
                color: var(--night-rider);
                font-size: 1.2em;
                transition-duration: .3s;
            }
            /* hover effect on button width */
            .Btn:hover {
                width: 125px;
                border-radius: 5px;
                transition-duration: .3s;
            }

            .Btn:hover .sign {
                width: 30%;
                transition-duration: .3s;
                padding-left: 20px;
            }
            /* hover effect button's text */
            .Btn:hover .text {
                opacity: 1;
                width: 70%;
                transition-duration: .3s;
                padding-right: 10px;
            }
            /* button click effect*/
            .Btn:active {
                transform: translate(2px ,2px);
            }

            .btn-update {
                width: fit-content;
                height: 45px;
                background: #ffffff0d;
                border-radius: 8px;
                border: 2px solid #334b79;
                font-size: 15px;
                font-weight: bold;
                color: #334b79;
                -webkit-transition: 0.5s all ease;
                transition: 0.5s all ease;
                position: relative;
                overflow: hidden;
                padding: 10px 25px;
                z-index: 1;
                margin-left: 390px;
            }

            .btn-update:before {
                width: 50%;
                height: 100%;
                content: "";
                margin: auto;
                position: absolute;
                top: 0%;
                left: -50%;
                background: #334b79;
                transition: all 0.5s ease;
                z-index: -1;
            }

            .btn-update:after {
                width: 50%;
                height: 100%;
                content: "";
                margin: auto;
                position: absolute;
                top: 0%;
                left: 100%;
                background: #334b79;
                transition: all 0.5s ease;
                z-index: -1;
            }

            .btn-update:hover {
                color: white;
                cursor: pointer;
            }

            .btn-update:hover:before {
                top: 0;
                left: 0;
            }

            .btn-update:hover:after {
                top: 0;
                left: 50%;
            }
        </style>
        <script>
            function validateForm() {
                var firstName = document.forms["profileForm"]["firstName"].value;
                var lastName = document.forms["profileForm"]["lastName"].value;
                var phoneNumber = document.forms["profileForm"]["phoneNumber"].value;
                var nameRegex = /^[A-Za-z]{1,15}$/;
                var phoneRegex = /^[0-9]{10,11}$/;

                if (!nameRegex.test(firstName)) {
                    alert("First name must be between 1 and 15 characters and contain no numbers.");
                    return false;
                }
                if (!nameRegex.test(lastName)) {
                    alert("Last name must be between 1 and 15 characters and contain no numbers.");
                    return false;
                }
                if (!phoneRegex.test(phoneNumber)) {
                    alert("Phone number must be 10 or 11 number characters.")
                    return false;
                }
                return true;
            }

            function submitForm(action) {
                var form = document.getElementById('profileForm');
                form.action = action;
                form.submit();
            }
        </script>
    </head>
    <body>
        <c:set var="userID" value="${sessionScope.USERID}" />
        <c:set var="member" value="${requestScope.MEMBER}" />
        <c:set var="address" value="${requestScope.ADDRESS}" />
        <c:set var="card" value="${requestScope.CREDITCARD}" />
        <nav>
            <div>
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/auctions">Auctions</a>
                <a href="${pageContext.request.contextPath}/valuation">Selling</a>
                <a href="${pageContext.request.contextPath}/my-upcoming-bids">My Bids</a>
                <a href="${pageContext.request.contextPath}/response">My Asset</a>
            </div>
            <form action="${pageContext.request.contextPath}/logout">
                <button type="submit" class="Btn">
                    <div class="sign">
                        <svg viewBox="0 0 512 512">
                        <path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"></path>
                        </svg>
                    </div>
                    <div class="text">Logout</div>
                </button>
            </form>
        </nav>
        <div class="container profile-container">
            <div class="profile-header text-center">
                <h2>My Profile</h2>
            </div>
            <div class="profile-content">
                <form id="profileForm" name="profileForm" style="margin-bottom: 50px;" action="${pageContext.request.contextPath}/updateProfile" method="POST" onsubmit="return validateForm();">
                    <div class="row">
                        <div class="col-md-6">
                            <h4>User Information</h4>
                            <div class="mb-6 row">
                                <input type="hidden" id="memberID" name="memberID" value="${member.memberID}">
                                <div class="mb-3 col">
                                    <label for="firstName" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" value="${member.firstName}" required>
                                </div>
                                <div class="mb-3 col">
                                    <label for="lastName" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" value="${member.lastName}" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${member.phoneNumber}" required>
                            </div>
                            <div class="mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-control" id="gender" name="gender" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male" ${member.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${member.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Others" ${member.gender == 'Others' ? 'selected' : ''}>Others</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="DOB" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="DOB" name="DOB" value="${member.DOB}" required>
                            </div>

                        </div>
                        <div class="col-md-6">
                            <h4>Shipping Address</h4>
                            <div class="mb-3">
                                <label for="city" class="form-label">City</label>
                                <input type="text" class="form-control" id="city" name="city" value="${address.city}" required>
                            </div>
                            <div class="mb-3">
                                <label for="state" class="form-label">State</label>
                                <input type="text" class="form-control" id="state" name="state" value="${address.state}" required>
                            </div>
                            <div class="mb-3">
                                <label for="zipCode" class="form-label">Zip Code</label>
                                <input type="text" class="form-control" id="zipCode" name="zipCode" value="${address.zipCode}" required>
                            </div>
                            <div class="mb-3">
                                <label for="country" class="form-label">Country</label>
                                <input type="text" class="form-control" id="country" name="country" value="${address.country}" required>
                            </div>
                            <div class="mb-3">
                                <label for="country" class="form-label">Address 1</label>
                                <input type="text" class="form-control" id="address1" name="address1" value="${address.address1}" required>
                            </div>
                            <div class="mb-3">
                                <label for="country" class="form-label">Address 2</label>
                                <input type="text" class="form-control" id="address2" name="address2" value="${address.address2}">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h4>Card Information</h4>
                            <div class="mb-3">
                                <label for="holderName" class="form-label">Holder Name</label>
                                <input type="text" class="form-control" id="holderName" name="holderName" value="${card.holderName}" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber" name="cardNumber" value="${card.cardNumber}" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="cvvCode" class="form-label">CVV Code</label>
                                <input type="text" class="form-control" id="cvvCode" name="cvvCode" value="${card.cvvCode}" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="expiryDate" class="form-label">Expiry Date</label>
                                <input type="text" class="form-control" id="expiryDate" name="expiryDate" value="${card.expiryDate}" readonly>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <button type="button" class="btn-update mb-3 w-100" onclick="submitForm('${pageContext.request.contextPath}/deactivateProfile')">Deactivate Account</button>
                                </div>
                                <div class="col-md-6">
                                    <button type="submit" class="btn-update mb-3 w-100">Update Profile</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <footer style="background-color: #000407; font-family: Helvetica; height: 30px; position: fixed; bottom: 0; width: 100%; text-align: center;">
            <span style="color: lightgrey; font-size: 14px;">&#169; F'RANKELLY AUCTION <script>document.write(new Date().getFullYear())</script></span>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    </body>
</html>
