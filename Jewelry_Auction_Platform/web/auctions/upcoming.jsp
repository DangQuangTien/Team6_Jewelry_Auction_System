<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upcoming Auctions</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background-color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .content {
            flex: 1;
        }

        .navbar {
            background: radial-gradient(circle, rgba(255, 239, 166, 1) 0%, rgba(218, 165, 32, 0.8) 50%, rgba(184, 134, 11, 0.8) 100%);
            background-size: 200% 200%;
            background-position: 50% 50%;
            transition: background 0.3s ease, box-shadow 0.3s ease, padding-top 0.3s ease, padding-bottom 0.3s ease;
            padding-bottom: 15px;
            backdrop-filter: blur(15px);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3), 0 0 20px rgba(0, 0, 0, 0.19);
        }

        .navbar:hover {
            background-position: 100% 100%;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.25);
        }

        .navbar-scrolled {
            background-color: black;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            padding-top: 1px;
            padding-bottom: 1px;
        }

        .navbar-brand .brand-name {
            font-size: 2em;
            font-family: 'Zapf-Chancery';
            font-weight: 700;
            color: black;
        }

        .nav-link {
            color: black !important;
            transition: color 0.3s;
            font-size: 1.25em;
        }

        .navbar-nav .nav-link {
            position: relative;
            transition: color 0.3s;
        }

        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            width: 0;
            height: 2px;
            background-color: #ffc107;
            transition: width 0.3s, left 0.3s;
            visibility: hidden;
        }

        .dropdown-menu {
            background-color: #000;
            border: 1px solid rgba(255, 255, 255, 0.1);
            animation: fadeIn 0.5s;
        }

        .dropdown-item {
            color: #fff !important;
            transition: background-color 0.3s, color 0.3s;
            position: relative;
        }

        .dropdown-item::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -2px;
            width: 0;
            height: 2px;
            background-color: transparent;
            transition: width 0.3s ease;
        }

        .dropdown-item:hover {
            background-color: rgba(255, 255, 255, 0.1) !important;
            color: #ffc107 !important;
        }

        .dropdown-item:hover::after {
            width: 100%;
            background-color: #ffc107;
        }

        .nav-item.dropdown:hover::after {
            width: 100%;
            background-color: #ffc107;
        }

        .navbar-nav {
            flex-direction: row;
            justify-content: flex-end;
        }

        @media (max-width: 768px) {
            .navbar-collapse {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            .navbar-nav {
                width: 100%;
                flex-direction: column;
            }

            .nav-item {
                width: 100%;
            }

            .nav-link {
                width: 100%;
                text-align: left;
            }

            .dropdown-menu {
                position: static;
                float: none;
                width: 100%;
                text-align: left;
            }

            .navbar-collapse .navbar-nav .nav-item .nav-link {
                text-align: left;
            }

            .navbar-nav.ml-auto {
                justify-content: flex-end;
            }

            .navbar-nav .dropdown-menu {
                text-align: right;
            }
        }

        h1 {
            text-align: center;
            color: #000;
            font-size: 36px;
            font-weight: normal;
            text-transform: uppercase;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }

        .auction-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

        .auction {
            display: flex;
            flex-direction: row;
            width: calc(50% - 10px);
            margin-bottom: 20px;
            padding: 20px;
            background-color: #fafafa;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .auction:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .image-container {
            width: 150px;
            height: 150px;
            margin-right: 20px;
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px;
            transition: transform 0.3s ease-in-out;
        }

        .image-container img:hover {
            transform: scale(1.05);
        }

        .auction-details {
            flex: 1;
            padding: 10px;
        }

        .countdown {
            text-align: center;
            font-size: 18px;
            color: #333;
            padding: 10px;
            border-radius: 10px;
            background-color: #f8f9fa;
            display: inline-block;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            font-family: 'Andale Mono', monospace;
            margin-top: 10px;
        }

        .countdown-text {
            margin-bottom: 6px;
        }

        .countdown-number {
            font-size: 24px;
        }

        .countdown-unit {
            font-size: 14px;
            color: #666;
            margin-left: 4px;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        button {
            padding: 8px 16px;
            font-size: 14px;
            color: #1b1b1b;
            background-color: #ffc107;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
            display: block;
            margin: 0 auto;
            font-family: 'Helvetica Neue', Arial, sans-serif;
        }

        button:hover {
            background-color: #ffc107;
        }

        p {
            font-size: 1em;
            margin-bottom: 10px;
        }

        .container-bid {
            width: 90%;
            margin: 0 auto;
            padding: 20px;
            box-sizing: border-box;
        }

        .pagination {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }

        .pagination a {
            color: #1b1b1b;
            text-decoration: none;
            padding: 10px 15px;
            margin: 0 5px;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .pagination a:hover {
            background-color: #ffc107;
            color: #1b1b1b;
        }

        .pagination a.active {
            background-color: #ffc107;
            color: #1b1b1b;
        }

        footer {
            background-color: #1b1b1b;
            color: #fff;
            position: relative;
            overflow: hidden;
        }

        footer .container {
            padding-top: 20px;
            padding-bottom: 20px;
        }

        footer h5 {
            font-family: 'Zapf-Chancery', cursive;
            color: #ffc107;
        }

        footer p {
            font-family: Helvetica, sans-serif;
        }

        footer a {
            color: #ffc107;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .social-icons ul {
            list-style: none;
            padding: 0;
        }

        .social-icons li {
            display: inline;
            margin: 0 10px;
        }

        .social-icons a {
            color: #ffc107;
            font-size: 24px;
            transition: color 0.3s ease;
        }

        .social-icons a:hover {
            color: #fff;
        }

        .footer-decoration {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
        }

        .footer-diamond {
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
        }

        .footer-lines {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, #ffc107, transparent);
            animation: slide 10s infinite;
        }

        @keyframes slide {
            0% {
                transform: translateX(0);
            }
            100% {
                transform: translateX(100%);
            }
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        .social-icons {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .social-icons ul {
            list-style: none;
            padding: 0;
            display: flex;
        }

        .social-icons li {
            display: inline;
            margin: 0 10px;
        }

        .social-icons a {
            color: #ffc107;
            font-size: 24px;
            transition: color 0.3s ease;
        }

        .social-icons a:hover {
            color: #fff;
        }

    </style>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <span class="brand-name">F'RANKELLY</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="home">HOME</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="auctionDropdown" role="button"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        AUCTIONS <i class="fas fa-caret-down"></i>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="auctionDropdown">
                        <a class="dropdown-item" href="auctions">UPCOMING AUCTIONS</a>
                        <a class="dropdown-item" href="#">PAST AUCTIONS</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="sellingDropdown" role="button"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        SELLING <i class="fas fa-caret-down"></i>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="sellingDropdown">
                        <a class="dropdown-item" href="selling">ABOUT SELLING</a>
                        <a class="dropdown-item" href="response">APPRAISED ASSET</a>
                        <a class="dropdown-item" href="valuation">VALUATION REQUEST</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">ABOUT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">CONTACT</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-bid" style="margin-top: 100px;">
    <div style="text-align: left; font-family: 'Zapf-Chancery', cursive; font-size: 3.25em;">Upcoming Auctions</div>
    <br><br>
    <hr>
    <br><br>
    <c:choose>
        <c:when test="${not empty AUCTIONS}">
            <div class="auction-container">
                <c:forEach var="auction" items="${AUCTIONS}" varStatus="status" begin="${param.begin != null ? param.begin : 0}" end="${param.end != null ? param.end : 3}">
                    <div class="auction">
                        <div class="image-container">
                            <img src="https://www.fortunaauction.com/wp-content/uploads/2024/06/1122-collection-image-1500.jpg" alt="Auction Image" loading="lazy"><br>
                            <div class="countdown" id="countdown_${auction.auctionID}"></div>
                        </div>
                        <div class="auction-details">
                            <p>COMING SOON &#x2022; Bidding Open from
                                <fmt:formatDate value="${auction.startDate}" pattern="dd MMM" />
                                to
                                <fmt:formatDate value="${auction.endDate}" pattern="dd MMM" />
                            </p>
                            <p>(Live Sale Conclusion on
                                <fmt:formatDate value="${auction.endDate}" pattern="dd MMM" />
                                Starting at ${auction.startTime} ET)
                            </p>
                            <div class="button-container">
                                <form action="auction" method="POST">
                                    <input type="hidden" name="auctionID" value="${auction.auctionID}">
                                    <button type="submit">View Lots</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <script>
                        (function(auctionID, endDate, startTime) {
                            function getTimeDifference(endDateTime, startTime, elementID) {
                                var now = new Date().getTime();
                                var endTime = new Date(endDateTime + ' ' + startTime).getTime();
                                var difference = endTime - now;

                                if (difference <= 0) {
                                    document.getElementById(elementID).innerHTML = "ALREADY STARTED";
                                    clearInterval(window[elementID]);
                                    return;
                                }

                                var days = Math.floor(difference / (1000 * 60 * 60 * 24));
                                var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                                var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
                                var seconds = Math.floor((difference % (1000 * 60)) / 1000);

                                document.getElementById(elementID).innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s";
                            }

                            var elementID = "countdown_" + auctionID;
                            var endDateTime = "${auction.endDate}";

                            document.addEventListener('DOMContentLoaded', function() {
                                getTimeDifference(endDateTime, "${auction.startTime}", elementID);
                            });

                            window[elementID] = setInterval(function() {
                                getTimeDifference(endDateTime, "${auction.startTime}", elementID);
                            }, 1000);
                        })('${auction.auctionID}', '${auction.endDate}', '${auction.startTime}');
                    </script>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <p>No upcoming auctions.</p>
        </c:otherwise>
    </c:choose>
    <div class="pagination">
        <c:forEach var="i" begin="0" end="${fn:length(AUCTIONS) / 4}" step="1">
            <a href="?begin=${i * 4}&end=${i * 4 + 3}" class="${param.begin == (i * 4) ? 'active' : ''}">${i + 1}</a>
        </c:forEach>
    </div>
</div>

<footer class="text-center py-4 mt-auto" style="background-color: #1b1b1b; color: #fff; position: relative; overflow: hidden;">
    <div class="container">
        <div class="row">
            <div style="color: lightgray" class="col-md-4">
                <br><br>
                <h5 style="font-family: 'Zapf-Chancery'">F'RANKELLY AUCTION HOUSE</h5>
                <p style="font-family: Helvetica">Your premier destination for exquisite jewelry and gemstones. Discover the timeless beauty and elegance in our curated collections.</p>
            </div>
            <div style="color: lightgray" class="col-md-4">
                <br><br>
                <h5 style="font-family: 'Zapf-Chancery'">Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a style="text-decoration: none" href="${pageContext.request.contextPath}/register" style="color: #fdfdc7;">Join us</a></li>
                    <li><a style="text-decoration: none" href="${pageContext.request.contextPath}/auctions" style="color: #ffc107;">Start auction</a></li>
                    <li><a style="text-decoration: none" href="${pageContext.request.contextPath}/selling" style="color: #ffc107;">Appraise jewelry</a></li>
                </ul>
            </div>
            <div style="color: lightgray" class="col-md-4">
                <br><br>
                <h5 style="font-family: 'Zapf-Chancery'">Contact Us</h5>
                <p><i class="fas fa-phone-alt"></i> +849872539999</p>
                <p><i class="fas fa-envelope"></i> support@jewelryauction.com</p>
                <p><i class="fas fa-map-marker-alt"></i> 123 Jewelry Street, New York, NY</p>
                <!-- Social Icons -->
                <div class="social-icons mt-3">
                    <ul class="example-2">
                        <li class="icon-content">
                            <a href="https://linkedin.com/" aria-label="LinkedIn" data-social="linkedin">
                                <i class="fab fa-linkedin"></i>
                            </a>
                        </li>
                        <li class="icon-content">
                            <a href="https://www.github.com/" aria-label="GitHub" data-social="github">
                                <i class="fab fa-github"></i>
                            </a>
                        </li>
                        <li class="icon-content">
                            <a href="https://www.instagram.com/" aria-label="Instagram" data-social="instagram">
                                <i class="fab fa-instagram"></i>
                            </a>
                        </li>
                        <li class="icon-content">
                            <a href="https://youtube.com/" aria-label="Youtube" data-social="youtube">
                                <i class="fab fa-youtube"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="mt-4">
            <p>&copy; 2024 Jewelry Auction. All rights reserved.</p>
        </div>
    </div>
    <!-- Decorative Elements -->
    <div class="footer-decoration">
        <div class="footer-diamond" style="position: absolute; top: -20px; left: 50%; transform: translateX(-50%);">
            <i class="fas fa-gem" style="color: #ffc107; font-size: 50px; animation: pulse 2s infinite;"></i>
        </div>
        <div class="footer-lines" style="position: absolute; bottom: 0; left: 0; width: 100%; height: 2px; background: linear-gradient(90deg, #ffc107, transparent); animation: slide 10s infinite;"></div>
    </div>
</footer>

<!-- Include Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var dropdowns = document.querySelectorAll('.nav-item.dropdown');

        dropdowns.forEach(function(dropdown) {
            dropdown.addEventListener('mouseenter', function() {
                var dropdownMenu = dropdown.querySelector('.dropdown-menu');
                if (dropdownMenu) {
                    dropdownMenu.classList.add('show');
                }
            });
            dropdown.addEventListener('mouseleave', function() {
                var dropdownMenu = dropdown.querySelector('.dropdown-menu');
                if (dropdownMenu) {
                    dropdownMenu.classList.remove('show');
                }
            });
        });
    });

    $(document).ready(function() {
        $("a.nav-link").on('click', function(event) {
            if (this.hash !== "") {
                event.preventDefault();
                var hash = this.hash;
                $('html, body').animate({
                    scrollTop: $(hash).offset().top
                }, 800, function() {
                    window.location.hash = hash;
                });
            }
        });
    });

    document.addEventListener("DOMContentLoaded", function() {
        window.addEventListener("scroll", function() {
            if (window.scrollY > 50) {
                document.querySelector(".navbar").classList.add("navbar-scrolled");
            } else {
                document.querySelector(".navbar").classList.remove("navbar-scrolled");
            }
        });
    });
</script>
</body>
</html>
