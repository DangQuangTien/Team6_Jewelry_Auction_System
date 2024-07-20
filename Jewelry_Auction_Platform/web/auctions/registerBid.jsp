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
        header {
    background-color: #ffffff;
    padding: 10px 0;
    border-bottom: 1px solid #ccc;
}

.navbar-brand {
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.navbar-nav .nav-item .nav-link {
    font-size: 18px;
    color: #333;
    font-weight: 500;
    transition: color 0.3s ease;
}

.navbar-nav .nav-item .nav-link:hover {
    color: #ff6f61;
}

.form-inline .form-control {
    width: 300px;
}

#bell-icon {
    font-size: 20px;
    color: #333;
}

#bell-icon:hover {
    color: #ff6f61;
}

.navbar-toggler {
    border: none;
}

.navbar-toggler-icon {
    color: #333;
}

        
        html, body {
    height: 100%;
    margin: 0;
    display: flex;
    flex-direction: column;
}

.container-fluid {
    flex: 1;
}

footer {
    background-color: #302c2c;
    color: #ffffff;
    text-align: center;
    padding: 10px 0;
    margin-top: 30px;
    border-top: 1px solid #ddd;
}

footer a {
    color: #ffffff;
    text-decoration: none;
    margin: 0 10px;
}

footer a:hover {
    color: #a98585;
}

        
        
        
        
        
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        #cardImage {
        display: none; /* Hide initially */
    }

        .container-fluid {
            background-color: white;
            padding: 30px;
            max-width: 1300px;
            border-radius: 8px;
            margin-bottom: 50px;
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
        .button {
            position: relative;
            transition: all 0.3s ease-in-out;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
            padding-block: 0.5rem;
            padding-inline: 1.25rem;
            background-color: rgb(0 107 179);
            border-radius: 9999px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #ffff;
            gap: 10px;
            font-weight: bold;
            border: 3px solid #ffffff4d;
            outline: none;
            overflow: hidden;
            font-size: 15px;
        }

        .icon {
            width: 24px;
            height: 24px;
            transition: all 0.3s ease-in-out;
        }

        .button:hover {
            transform: scale(1.05);
            border-color: #fff9;
        }

        .button:hover .icon {
            transform: translate(4px);
        }

        .button:hover::before {
            animation: shine 1.5s ease-out infinite;
        }

        .button::before {
            content: "";
            position: absolute;
            width: 100px;
            height: 100%;
            background-image: linear-gradient(
                120deg,
                rgba(255, 255, 255, 0) 30%,
                rgba(255, 255, 255, 0.8),
                rgba(255, 255, 255, 0) 70%
                );
            top: 0;
            left: -100px;
            opacity: 0.6;
        }

        @keyframes shine {
            0% {
                left: -100px;
            }

            60% {
                left: 100%;
            }

            to {
                left: 100%;
            }
        }

    </style>

    <body>
        <c:set var="member" value="${sessionScope.MEMBER}" />
        <nav>
            <a style="text-decoration: none;" href="${pageContext.request.contextPath}/home">HOME</a>
            <a style="text-decoration: none;"href="${pageContext.request.contextPath}/auctions">AUCTIONS</a>
            <a style="text-decoration: none;"href="${pageContext.request.contextPath}/selling">SELLING</a>
            <a style="text-decoration: none;"href="#">EXPLORE</a>
            <a style="text-decoration: none;"href="#">ABOUT</a>
            <a style="text-decoration: none;"href="#">CONTACT</a>
        </nav>       
        <!-- END OF HEADER -->
        <div class="container-fluid mt-5">
            <h1 class="text-center" style="font-weight: 600;">Bidder Registration</h1>
            <h3 class="text-center">F'RANKELLY - FINE JEWELS & WATCHES</h3>
            <p id="datetime" class="text-center"> - HO CHI MINH, HCM</p>
            <form action="${pageContext.request.contextPath}/registerbid" id="registrationForm" method="POST" class="row needs-validation" novalidate>
                <div class="col-md-6">
                    <div class="form-section mb-4">
                        <h4 style="font-weight: bold;">USER INFORMATION</h4>
                        <div class="form-group">
                            <label for="firstName">First Name *</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" value="${member.firstName}" required>
                            <div class="invalid-feedback">First name is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name *</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" value="${member.lastName}"  required>
                            <div class="invalid-feedback">Last name is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="companyName">Company Name</label>
                            <input type="text" class="form-control" id="companyName" name="companyName" required>
                            <div class="invalid-feedback">Please enter your company name.</div>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone *</label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="${member.phoneNumber}" required>
                            <div class="invalid-feedback">Phone number is required.</div>
                        </div>
                    </div>
                    <div class="form-section mb-4">
                        <h4 style="font-weight: bold;">SHIPPING ADDRESS</h4>
                        <div class="form-group">
                            <label for="country">Country *</label>
                            <input type="text" class="form-control" id="country" name="country" required>
                            <div class="invalid-feedback">Country is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="address">Address *</label>
                            <input type="text" class="form-control" id="address1" name="address1" required>
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
                        <h4 style="font-weight: bold;">CREDIT CARD</h4>
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
                            <input type="text" class="form-control" id="cardHolderName" name="cardHolderName" value="${member.firstName} ${member.lastName}" required/>
                            <div class="invalid-feedback">Card holder name is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="cardNumber">Credit Card Number *</label>
                            <input type="text" style="margin-bottom: 5px;" class="form-control" id="cardNumber" name="cardNumber" maxlength="19" required>
                            <div class="invalid-feedback" id="cardNumberFeedback">Credit card number is required.</div>
                            <small id="cardType" style="margin-top: 5px;"></small> <!-- Display card type -->
                            <img id="cardImage" src="" alt="Card Image" width="88" height="58" style="margin-top: 5px;"> <!-- Placeholder for card type image -->
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV Code *</label>
                            <input type="text" class="form-control" id="cvv" name="cvv" maxlength="3" required>
                            <div class="invalid-feedback">CVV code is required.</div>
                        </div>
                        <div class="form-group">
                            <label for="expiryDate">Expiry Date *</label>
                            <div class="form-row">
                                <div class="col">
                                    <select class="form-control" id="expiryDay" name="expiryDay" required>
                                        <option value="">Day</option>
                                        <% for (int i = 1; i <= 31; i++) {%>
                                        <option value="<%= i%>"><%= i%></option>
                                        <% }%>
                                    </select>
                                    <div class="invalid-feedback">Expiry day is required.</div>
                                </div>
                                <div class="col">
                                    <select class="form-control" id="expiryMonth" name="expiryMonth" required>
                                        <option value="">Month</option>
                                        <% String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}; %>
                                        <% for (int i = 0; i < months.length; i++) {%>
                                        <option value="<%= i + 1%>"><%= months[i]%></option>
                                        <% }%>
                                    </select>
                                    <div class="invalid-feedback">Expiry month is required.</div>
                                </div>
                                <div class="col">
                                    <select class="form-control" id="expiryYear" name="expiryYear" required>
                                        <option value="">Year</option>
                                        <% for (int i = 2024; i <= 2100; i++) {%>
                                        <option value="<%= i%>"><%= i%></option>
                                        <% }%>
                                    </select>
                                    <div class="invalid-feedback">Expiry year is required.</div>
                                </div>
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
                    <input type="hidden" name="auctionID" value="<%= request.getParameter("auctionID")%>">
                    <button type="submit" class="button">
                        Apply Now
                        <svg fill="currentColor" viewBox="0 0 24 24" class="icon">
                        <path
                            clip-rule="evenodd"
                            d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25zm4.28 10.28a.75.75 0 000-1.06l-3-3a.75.75 0 10-1.06 1.06l1.72 1.72H8.25a.75.75 0 000 1.5h5.69l-1.72 1.72a.75.75 0 101.06 1.06l3-3z"
                            fill-rule="evenodd"
                            ></path>
                        </svg>
                    </button>
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
             // Function to update date and time dynamically
  function updateDateTime() {
    // Get current date and time
    let now = new Date();
    let dateOptions = { month: 'short', day: 'numeric', year: 'numeric', hour: 'numeric', minute: 'numeric', hour12: true };
    let formattedDate = now.toLocaleDateString('en-US', dateOptions);
    
    // Update the HTML element with id="datetime"
    document.getElementById('datetime').textContent = formattedDate + ' - HO CHI MINH, HCM';
  }

  // Call the function initially to set the initial date and time
  updateDateTime();

  // Update every minute (60000 milliseconds)
  setInterval(updateDateTime, 60000);

  // Function to format credit card number with spaces
  function formatCreditCardNumber(value) {
    // Remove non-numeric characters
    let formattedValue = value.replace(/\D/g, '');

    // Apply formatting (add spaces every 4 digits)
    formattedValue = formattedValue.replace(/(\d{4})(?=\d)/g, '$1 ');

    return formattedValue.trim(); // Trim any leading/trailing spaces
}


    // Function to validate credit card number
    function validateCreditCardNumber(value) {
        // Remove spaces and non-numeric characters
        let cardNumber = value.replace(/\s+/g, '');
        
        // Validate length and format
        if (cardNumber.length !== 16 || !/^\d+$/.test(cardNumber)) {
            return false;
        }
        
        return true;
    }

    

   function getCardType(cardNumber) {
    // Define card types and their patterns
    const cardTypes = {
        'Visa': { pattern: /^4/, image: `${pageContext.request.contextPath}/auctions/images/visa.png` },
        'MasterCard': { pattern: /^5[1-5]/, image: `${pageContext.request.contextPath}/auctions/images/mastercard.png` },
        'American Express': { pattern: /^3[47]/, image: `${pageContext.request.contextPath}/auctions/images/amex.png` }
    };

    // Check each card type pattern
    for (const [cardName, { pattern, image }] of Object.entries(cardTypes)) {
        if (pattern.test(cardNumber)) {
            return { type: cardName, image: image };
        }
    }

    // If no match found, return null (not supported)
    return null;
}


function updateCardImage(cardType) {
    let cardImageContainer = document.getElementById('cardImage');
    let cardTypeText = document.getElementById('cardType');

    if (cardType.type !== 'Not supported. Supported types are: Visa, MasterCard, and American Express') {
        cardImageContainer.src = cardType.image; // Set image source directly
        cardImageContainer.style.display = 'block'; // Display the image container
        cardTypeText.textContent = `CARD TYPE: ${cardType.type.toUpperCase()}`;
    } else {
        cardImageContainer.src = cardType.image; // Set image source directly
        cardImageContainer.style.display = 'block'; // Display the image container
        cardTypeText.textContent = cardType.type; // Display not supported message
    }
}

// Event listener for input change on credit card number field
document.getElementById('cardNumber').addEventListener('input', function() {
    let input = this.value;
    let formattedInput = formatCreditCardNumber(input);
    this.value = formattedInput;

    // Remove spaces for database storage
    let cardNumberWithoutSpaces = input.replace(/\s/g, '');

    // Determine card type
    let cardType = getCardType(cardNumberWithoutSpaces.substring(0, 6)); // Check first six digits for card type

    if (cardType === null) {
        // Display error for unsupported card type
        document.getElementById('cardNumber').classList.add('is-invalid');
        document.getElementById('cardNumberFeedback').textContent = 'Card type not supported. Supported types are: Visa, MasterCard, and American Express.';
        document.getElementById('cardNumberFeedback').style.display = 'block';
    } else {
        // Update card image and type display
        updateCardImage(cardType);

        // Validate credit card number
        let isValid = validateCreditCardNumber(cardNumberWithoutSpaces);
        if (!isValid) {
            document.getElementById('cardNumber').classList.add('is-invalid');
            document.getElementById('cardNumberFeedback').style.display = 'block';
        } else {
            document.getElementById('cardNumber').classList.remove('is-invalid');
            document.getElementById('cardNumberFeedback').style.display = 'none';
        }
    }
});

    // Function to check if all required fields are filled and checkboxes are checked
    function validateForm() {
    let isValid = true;

    // Check if all required fields are filled
    document.querySelectorAll('.needs-validation .form-control').forEach(function(input) {
        if (!input.checkValidity()) {
            isValid = false;
            input.classList.add('is-invalid');
            // Assuming error message is next sibling with class 'invalid-feedback'
            if (input.nextElementSibling) {
                input.nextElementSibling.classList.add('invalid-feedback');
                input.nextElementSibling.style.display = 'block';
            }
        } else {
            input.classList.remove('is-invalid');
            if (input.nextElementSibling) {
                input.nextElementSibling.style.display = 'none';
            }
        }
    });
    
    // Check if checkboxes are checked
    if (!document.getElementById('terms').checked) {
        isValid = false;
        document.getElementById('terms').classList.add('is-invalid');
        // Assuming error message is next sibling with class 'invalid-feedback'
        if (document.getElementById('terms').nextElementSibling) {
            document.getElementById('terms').nextElementSibling.classList.add('invalid-feedback');
            document.getElementById('terms').nextElementSibling.style.display = 'block';
        }
    } else {
        document.getElementById('terms').classList.remove('is-invalid');
        if (document.getElementById('terms').nextElementSibling) {
            document.getElementById('terms').nextElementSibling.style.display = 'none';
        }
    }
    if (!document.getElementById('age').checked) {
        isValid = false;
        document.getElementById('age').classList.add('is-invalid');
        // Assuming error message is next sibling with class 'invalid-feedback'
        if (document.getElementById('age').nextElementSibling) {
            document.getElementById('age').nextElementSibling.classList.add('invalid-feedback');
            document.getElementById('age').nextElementSibling.style.display = 'block';
        }
    } else {
        document.getElementById('age').classList.remove('is-invalid');
        if (document.getElementById('age').nextElementSibling) {
            document.getElementById('age').nextElementSibling.style.display = 'none';
        }
    }

    return isValid;
}

// Event listener for form submission
document.getElementById('registrationForm').addEventListener('submit', function(event) {
    if (!validateForm()) {
        event.preventDefault();
    }
});

        </script>
    </body>
</html>