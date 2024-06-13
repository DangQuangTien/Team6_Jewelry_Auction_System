<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html lang="en">
<head>
    <title>Maximize Your Jewelry and Watch Sales with Jewelry Auction Online</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="asset/selling.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f5f5f5;
        }

        .navbar {
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: #343a40;
            border-bottom: 3px solid #e4af11;
        }

        .navbar-brand, .nav-link, .navbar-toggler-icon {
            color: #ffc107 !important;
        }

        .navbar-brand:hover, .nav-link:hover {
            color: #fff !important;
        }

        main {
            padding: 40px 20px;
            max-width: 900px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #selling-content h1, #selling-content h2, #selling-content h3 {
            color: #333;
            text-align: center;
        }

        #selling-content h1 {
            font-size: 2.5rem;
            margin-bottom: 30px;
        }

        #selling-content h2 {
            font-size: 2rem;
            border-bottom: 2px solid #dc3545;
            padding-bottom: 5px;
            margin-bottom: 30px;
        }

        #selling-content p {
            margin-bottom: 20px;
            text-align: justify;
            font-size: 1.1rem;
            line-height: 1.6;
        }

        #selling-content .highlight {
            background-color: #f8d7da;
            padding: 15px;
            border-left: 5px solid #dc3545;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        #selling-content .example {
            background-color: #e9ecef;
            padding: 15px;
            border-left: 5px solid #6c757d;
            margin-bottom: 20px;
            font-style: italic;
            border-radius: 4px;
        }

        #selling-content button {
            background-color: #dc3545;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 1.2em;
            transition: background-color 0.3s ease;
            border-radius: 4px;
        }

        #selling-content button:hover {
            background-color: #c82333;
        }

        footer {
            background-color: #343a40;
            color: #fff;
            padding: 1rem;
            text-align: center;
        }

        footer a {
            color: #ffc107;
            margin: 0 10px;
        }

        footer a:hover {
            color: #fff;
        }

        .fade-in {
            animation: fadeIn 1.5s ease-in;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .wheel-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 300px; /* Adjusted container height */
            width: 150px; /* Container width */
            overflow: hidden;
            position: relative;
            margin: 0 auto; /* Center the wheel horizontally */
        }

        .wheel {
            display: flex;
            flex-direction: column;
            height: 100%;
            width: 100%; /* Match the width of the container */
            overflow-y: auto;
            scroll-snap-type: y mandatory;
            scrollbar-width: none; /* For Firefox */
            -ms-overflow-style: none;  /* For Internet Explorer and Edge */
        }

        .wheel::-webkit-scrollbar {
            display: none; /* For Chrome, Safari, and Opera */
        }

        .wheel div {
            flex: 0 0 100px; /* Height of each item for larger spacing */
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 2rem; /* Font size */
            scroll-snap-align: center;
            color: #343a40;
        }

        .wheel div:nth-child(even) {
            background-color: #f8f9fa;
        }

        .wheel div:nth-child(odd) {
            background-color: #e9ecef;
        }

        .wheel-overlay {
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 100px; /* Match the item height */
            margin-top: -50px; /* Center the overlay */
            background-color: rgba(255, 255, 255, 0.8);
            pointer-events: none;
            border-top: 1px solid #343a40;
            border-bottom: 1px solid #343a40;
        }

        .modal-dialog {
            max-width: 200px; /* Adjust to fit the wheel width with padding */
            margin: 1.75rem auto;
        }

        .modal-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%; /* Match the width of the modal dialog */
        }

        .modal-body {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 1rem;
        }

        .modal-footer {
            display: flex;
            justify-content: space-between;
            width: 100%;
            padding: 1rem;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#"><i class="fas fa-gem"></i> Jewelry Auctions</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">          
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/home.jsp"><i class="fas fa-home"></i> Home <span class="sr-only">(current)</span></a>
            </li>                
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/auctions/upcoming.jsp"><i class="fas fa-gavel"></i> Auction</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/seller/request.jsp"><i class="fas fa-clipboard"></i> Request A Valuation</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/seller/response.jsp">
                    <i class="fas fa-reply"></i> Response
                </a>
            </li>                
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/seller/shipmentRequest.jsp"><i class="fas fa-bell"></i> Notification</a>
            </li>
        </ul>
    </div>
</nav>

<main id="selling-content" class="container mt-4 fade-in">          
    <h1>Selling with Jewelry Auction Online</h1>        
    <p>With our unique model, we are at the forefront of revolutionizing the industry, merging the tried-and-true methods of traditional auction houses with the dynamism of modern innovative marketplace models, utilizing cutting-edge technology and focusing on an unyielding commitment to customer service.</p>
    <h2>Why sell with Jewelry Auction Online</h2>
    <p>We’re committed to setting and upholding the highest standards for our sellers. Selling jewelry and watches can be a challenging and confusing process, but it doesn’t have to be. With us by your side, you can rest assured that your valuable assets are in the best hands possible.</p>
    <p>We think of ourselves as a torch-bearer on the dimly-lit, pitfall-filled path to selling jewelry and watches.</p>
    <p>At our core values of integrity, authenticity, accountability, and excellence are at the forefront of everything we do. We believe our values, performance, and reputation set us far apart from our competitors.</p>
    <div class="highlight">1 of 5: Our Goals Are Aligned With Yours</div>
    <p>Unlike buyers who seek to purchase your jewelry and watches for as cheap as possible, we are not interested in buying your jewelry at all—we are interested in selling your jewelry for you, to the highest bidder.</p>
    <p>Additionally, we believe that we should only be paid for our services if we are able to sell your jewelry and watches for the prices that you agree with. We provide fully-insured shipping, cataloging, photography, and marketing of your jewelry and watches, all at our expense.</p>
    <p>Furthermore, because we are only paid upon success via our premiums (and our premiums are lower than the other major auction houses), the more money that we make you, the more we get paid. Maximizing the value of your jewelry and watches is absolutely in our best interest.</p>
    <div class="example">The group lot depicted here illustrates the importance of correct pricing. The consignor initially desired to consign the lot with a reserve of $10,000. We agreed that the lot was potentially worth considerably more than $10,000 but requested a lower reserve and starting bid and the consignor agreed. On auction day the lot opened at $5,000 and, as a result of prudent pricing, a bidding war erupted during the live auction and the group of vintage Chanel costume jewelry sold for $25,000.</div>
    <div class="highlight">2 of 5: We Have Solutions That Others Simply Do Not</div>
    <p>While many auction houses hold jewelry and watch auctions every few months, we host live and online global auctions every two (2) weeks, allowing us to provide results for you in a much shorter period of time.</p>
    <p>Need money even sooner? We’ve got a solution for that too.</p>
    <p>Our Lightning Auctions deliver auction results in just days. This auction format is a first-price sealed-bid auction where a list of pre-qualified bidders, who pay a premium to participate in the auctions, are presented the lots for sale and are allowed to submit their top bid, one time, in a sealed envelope. Once all envelopes have been collected, they are opened and the top bid is taken.</p>
    <div class="example">The owner of the Rolex Daytona “Rainbow” shown here was not happy with the cash offers that he was given by other buyers. He tried the watch once at auction and it did not sell and was then looking for more immediate solutions. He consigned the watch with us and we hosted a Lightning Auction for him. The Watch sold to a private client for $375,000 and the consignor was very pleased.</div>
    <h3>Ready to jump ahead and submit your valuation request or want to learn more first?</h3>
    <button class="btn-primary-custom mt-3" onclick="showModal()">Request A Valuation</button>
</main>

<!-- Modal -->
<div class="modal fade" id="scrollingWheelModal" tabindex="-1" aria-labelledby="scrollingWheelModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scrollingWheelModalLabel">Select a Number</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="wheel-container">
                    <div class="wheel" id="numberWheel">
                        <!-- Options will be populated by JavaScript -->
                    </div>
                    <div class="wheel-overlay"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="confirmSelection()">Confirm</button>
            </div>
        </div>
    </div>
</div>

<footer class="footer text-center py-3 mt-auto">
    <div>
        <h6>Jewelry Auction</h6>
        <a href="register.jsp">Register</a> |
        <a href="login.jsp">Login</a> |
        <a href="#">Help & FAQ</a> |
        <a href="#">Support</a> |
        <a href="#">Sitemap</a>
    </div>
    <div>
        <span>&copy; <script>document.write(new Date().getFullYear())</script> Jewelry Auction. All rights reserved.</span>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="asset/selling.js"></script>
<script>
    function showModal() {
        // Populate the number wheel
        const numberWheel = document.getElementById('numberWheel');
        numberWheel.innerHTML = '';
        for (let i = 1; i <= 1000; i++) {
            const div = document.createElement('div');
            div.textContent = i;
            numberWheel.appendChild(div);
        }
        // Show the modal
        $('#scrollingWheelModal').modal('show');
    }

    function confirmSelection() {
        // Get the selected number (closest to center)
        const numberWheel = document.getElementById('numberWheel');
        const selectedNumber = Math.round((numberWheel.scrollTop + numberWheel.clientHeight / 2) / 100);
        console.log('Selected number:', selectedNumber);
        // Navigate to request.jsp
        window.location.href = 'request.jsp';
    }
</script>
</body>
</html>
