<%@page import="entity.member.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bidder Registration</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="../component/header.css">
        <link rel="stylesheet" type="text/css" href="../component/footer.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
    </head>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2, h3, h4 {
            color: #333;
        }

        .hidden {
            display: none;
        }

        .form-section {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        button[type="submit"] {
            width: 100%;
        }
    </style>

    <body>
        <c:set var="username" value="${sessionScope.USERNAME}" />
        <c:set var="role" value="${sessionScope.ROLE}" />
        <!-- START OF HEADER -->
        <%
            Member member = (Member) session.getAttribute("INF");
            String firstName = "";
            String lastName = "";
            String phone = "";
            if (member != null) {
                firstName = member.getFirstName() != null ? member.getFirstName() : "";
                lastName = member.getLastName() != null ? member.getLastName() : "";
                phone = member.getPhoneNumber() != null ? member.getPhoneNumber() : "";
            }
        %>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light">
                <a class="navbar-brand" href="#">Jewelry Auctions</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home.jsp">Home<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auctions/upcoming.jsp">Auction</a>
                        </li>
                        <c:if test="${role == 'Member' || role == null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/seller/selling.html">Sell</a>
                            </li>
                        </c:if>
                        <c:choose>
                            <c:when test="${username == null}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:set var="url">
                                    <c:choose>
                                        <c:when test="${role == 'Member'}">bidder/profile.jsp</c:when>
                                        <c:when test="${role == 'Staff'}">staff/staff.jsp</c:when>
                                        <c:when test="${role == 'Manager'}">manager/manager.jsp</c:when>
                                        <c:otherwise>admin/admin.jsp</c:otherwise>
                                    </c:choose>
                                </c:set>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/${url}">${username}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        <li class="nav-item">
                            <a class="nav-link" href="notification.jsp" id="bell-icon"><i class="fas fa-bell"></i></a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <!-- END OF HEADER -->
        <div class="container mt-5">
            <h2 class="text-center">Bidder Registration</h2>
            <h3 class="text-center">FINE JEWELS & WATCHES</h3>
            <p class="text-center">JUN 3, 2024 AT 12 PM EDT - HO CHI MINH, HCM</p>
            <form action="${pageContext.request.contextPath}/registerbid" id="registrationForm" method="POST" class="row needs-validation" novalidate>
                <div class="col-md-6">
                    <div class="form-section mb-4">
                        <h4>USER INFORMATION</h4>
                        <div class="form-group">
                            <label for="firstName">First Name *</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" value="<%= firstName%>" required>
                            <div class="invalid-feedback">First name is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name *</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" value="<%= lastName%>"  required>
                            <div class="invalid-feedback">Last name is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="companyName">Company Name</label>
                            <input type="text" class="form-control" id="companyName" name="companyName" required>
                            <div class="invalid-feedback">Please enter your company name.</div>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone *</label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="<%= phone%>" required>
                            <div class="invalid-feedback">Phone number is required.</div>
                        </div>
                    </div>
                    <div class="form-section mb-4">
                        <h4>SHIPPING ADDRESS</h4>
                        <div class="form-group">
                            <label for="country">Country *</label>
                            <input type="text" class="form-control" id="country" name="country" required>
                            <div class="invalid-feedback">Country is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="address">Address *</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                            <div class="invalid-feedback">Address is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="address2">Address 2</label>
                            <input type="text" class="form-control" id="address2" name="address2" required>
                            <div class="invalid-feedback">Address is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="city">City *</label>
                            <input type="text" class="form-control" id="city" name="city" required>
                            <div class="invalid-feedback">City is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="state">State/Province *</label>
                            <input type="text" class="form-control" id="state" name="state" required>
                            <div class="invalid-feedback">State/Province is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="zip">Zip Code *</label>
                            <input type="text" class="form-control" id="zip" name="zip" required>
                            <div class="invalid-feedback">Zip Code is required.</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-section mb-4">
                        <h4>CREDIT CARD</h4>
                        <p>Note: Your credit card will be authorized for $1 for verification purposes. This authorization may appear as a charge and immediate refund in your account by your bank.</p>
                        <font color=#000000>IMPORTANT: Winning bidders will be charged a Buyer's Premium IN ADDITION to their winning bid (the Buyer's Premium is not included in the online bid value).</font>
                        <p>Buyer's Premiums are as follows:</p>
                        <ul>
                            <li>25% on the first $300,000</li>
                            <li>20% from $300,001 to $3,000,000</li>
                            <li>12.5% on the excess over $3,000,000</li>
                        </ul>
                        <p>For example, if you bid $1,000 on a lot and win, the amount due with the Buyer's Premium would be $1,250.</p>
                        <p>IMPORTANT: Please note that bids, once placed, cannot be retracted or reduced. Kindly refer to our Terms and Conditions for full details.</p>
                        <div class="form-group">
                            <label for="cardHolderName">Card Holder Name *</label>
                            <input type="text" class="form-control" id="cardHolderName" name="cardHolderName"  value="<%= firstName + " " + lastName%>" required>
                            <div class="invalid-feedback">Card holder name is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="cardNumber">Credit Card Number *</label>
                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" required>
                            <div class="invalid-feedback" id="cardNumberFeedback">Credit card number is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV Code *</label>
                            <input type="text" class="form-control" id="cvv" name="cvv" maxlength="3" required>
                            <div class="invalid-feedback">CVV code is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="expiryDate">Expiry Date *</label>
                            <input type="text" class="form-control" id="expiryDate" name="expiryDate" maxlength="5" placeholder="MM / YY" required>
                            <div class="invalid-feedback">Expiry date is required.</div>
                        </div>
                    </div>
                    <div class="form-section mb-4">
                        <h4>BILLING ADDRESS</h4>
                        <div class="form-check mb-2">
                            <input type="checkbox" class="form-check-input" id="sameAsShipping" name="sameAsShipping" checked>
                            <label class="form-check-label" for="sameAsShipping">Same as Shipping Address</label>
                        </div>
                        <div id="billingAddress" class="hidden">
                            <div class="form-group">
                                <label for="billingCountry">Country *</label>
                                <input type="text" class="form-control" id="billingCountry" name="billingCountry" required>
                                <div class="invalid-feedback">Country is required.</div>
                            </div>
                            <div class="form-group">
                                <label for="billingAddressInput">Address *</label>
                                <input type="text" class="form-control" id="billingAddressInput" name="billingAddressInput" required>
                                <div class="invalid-feedback">Address is required.</div>
                            </div>
                            <div class="form-group">
                                <label for="billingAddress2">Address 2</label>
                                <input type="text" class="form-control" id="billingAddress2" name="billingAddress2" required>
                                <div class="invalid-feedback">Address is required.</div>
                            </div>
                            <div class="form-group">
                                <label for="billingCity">City *</label>
                                <input type="text" class="form-control" id="billingCity" name="billingCity" required>
                                <div class="invalid-feedback">City is required.</div>
                            </div>
                            <div class="form-group">
                                <label for="billingState">State/Province *</label>
                                <input type="text" class="form-control" id="billingState" name="billingState" required>
                                <div class="invalid-feedback">State/Province is required.</div>
                            </div>
                            <div class="form-group">
                                <label for="billingZip">Zip Code *</label>
                                <input type="text" class="form-control" id="billingZip" name="billingZip" required>
                                <div class="invalid-feedback">Zip Code is required.</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-group mt-3">
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="terms" name="terms" required>
                            <label class="form-check-label" for="terms">I have read and agree to the General Conditions of Sale, Terms of Use and Privacy Policy.</label>
                            <div class="invalid-feedback">You must agree to the terms.</div>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="age" name="age" required>
                            <label class="form-check-label" for="age">I am 18 years of age or older</label>
                            <div class="invalid-feedback">You must be at least 18 years old.</div>
                        </div>
                    </div>
                    <input type="hidden" name="auctionID" value="<%= request.getParameter("auctionID") %>">
                    <input type="submit" name="action" value="Register" class="btn btn-primary mt-3">
                </div>
            </form>
        </div>
        <!-- START OF FOOTER -->
        <footer class="text-center py-3 mt-auto">
            <div>
                <h6>Jewelry Auction</h6>
                <a href="register.jsp">Register</a> |
                <a href="login.jsp">Login</a> |
                <a href="#">Help & FAQ</a> |
                <a href="#">Support</a> |
                <a href="#">Sitemap</a>

            </div>
            
        </footer>
        <!-- END OF FOOTER -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            document.getElementById('sameAsShipping').addEventListener('change', function () {
                const billingAddress = document.getElementById('billingAddress');
                if (this.checked) {
                    billingAddress.classList.add('hidden');
                    document.getElementById('billingAddressInput').required = false;
                    document.getElementById('billingCountry').required = false;
                    document.getElementById('billingCity').required = false;
                    document.getElementById('billingState').required = false;
                    document.getElementById('billingZip').required = false;
                } else {
                    billingAddress.classList.remove('hidden');
                    document.getElementById('billingAddressInput').required = true;
                    document.getElementById('billingCountry').required = true;
                    document.getElementById('billingCity').required = true;
                    document.getElementById('billingState').required = true;
                    document.getElementById('billingZip').required = true;
                }
            });
        </script>
        <%--  
                document.getElementById('registrationForm').addEventListener('submit', function(event) {
                    event.preventDefault();
                    event.stopPropagation();

            const form = this;
            if (form.checkValidity() === false) {
                form.classList.add('was-validated');
            } else {

                const cardNumber = document.getElementById('cardNumber').value;
                const cvv = document.getElementById('cvv').value;
                const expiryDate = document.getElementById('expiryDate').value;

                let cardValid = validateCreditCard(cardNumber);
                let cvvValid = validateCVV(cvv);
                let expiryValid = validateExpiryDate(expiryDate);

                if (cardValid && cvvValid && expiryValid) {
                    alert('Form submitted!');
                } else {
                    if (!cardValid) {
                        document.getElementById('cardNumber').classList.add('is-invalid');
                        document.getElementById('cardNumberFeedback').innerText = 'Invalid credit card number.';
                    }
                    if (!cvvValid) {
                        document.getElementById('cvv').classList.add('is-invalid');
                    }
                    if (!expiryValid) {
                        document.getElementById('expiryDate').classList.add('is-invalid');
                    }
                }
            }
        });

        function validateCreditCard(cardNumber) {
            const regex = /^[0-9]{13,19}$/;
            return regex.test(cardNumber);
        }

        function validateCVV(cvv) {
            const regex = /^[0-9]{3}$/;
            return regex.test(cvv);
        }


        function validateExpiryDate(expiryDate) {
            const regex = /^(0[1-9]|1[0-2])\/([2-9][0-9])$/;
            if (!regex.test(expiryDate)) return false;

            const [month, year] = expiryDate.split('/');
            const currentYear = new Date().getFullYear() % 100;
            const enteredYear = parseInt(year, 10);
            const enteredMonth = parseInt(month, 10);

            if (enteredYear < currentYear) return false;

            if (enteredYear === currentYear && enteredMonth <= new Date().getMonth() + 1) return false;

            return true;
}

        document.getElementById('expiryDate').addEventListener('input', function() {
            const input = this.value;
            if (input.length === 2 && !input.includes('/')) {
                this.value = input + '/';
            }
        });

    </script> --%>
    </body>
</html>