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
                font-family: Andale Mono;
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
                font-family: Andale Mono;
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
                background-color: rgba(27, 27, 27, 0.75);
                border: 1px solid rgba(255, 255, 255, 0.1);
                animation: fadeIn 0.5s;
                margin-top: -10px
            }

            .dropdown-item {
                color: #fff !important;
                transition: background-color 0.3s, color 0.3s;
                position: relative; /* Ensure pseudo-element positioning */
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
                background-color: #ffc107
            }
            .nav-item dropdown:hover::after {
                width: 100%;
                background-color: #ffc107
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

            .auction {
                display: flex;
                margin-bottom: 20px;
                padding: 20px;
                background-color: #fafafa;
                overflow: hidden;
            }

            .image-container {
                width: 30%;
                margin-right: 20px;
                position: relative;
                overflow: hidden;
            }

            .image-container img {
                width: 100%;
                height: auto;
            }

            .auction-details {
                flex: 1;
                opacity: 1; /* Ensure details are visible */
                padding: 10px;
            }

            .countdown {
                text-align: center;
                font-size: 35px;
                color: #333;
                padding: 20px;
                border-radius: 10px;
                background-color: #f8f9fa;
                display: inline-block;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                font-family: Andale Mono;
            }

            .countdown-text {
                margin-bottom: 6px;
            }

            .countdown-number {
                font-size: 48px;
            }

            .countdown-unit {
                font-size: 18px;
                color: #666;
                margin-left: 4px;
            }

            .button-container {
                text-align: center;
                margin-top: 10px;
            }

            button {
                padding: 15px 200px;
                font-size: 20px;
                color: black;
                background-color: white;
                border: 2px solid #000000;
                border-radius: 100px;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease;
                display: block;
                margin-top: 100px;
                margin-left: 120px;
                font-family: Helvetica;
            }

            button:hover {
                background-color: #000;
                color: #fff;
            }


            p {
                font-size:200% ;
                margin-bottom: 10px;
            }
            .container-bid {
                width: 90%;
                margin: 0 auto;
                padding: 0 20px;
                box-sizing: border-box;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
            <div class="container">
                <a class="navbar-brand"
                   href="${pageContext.request.contextPath}/home">
                    <span class="brand-name">F'RANKELLY</span>
                </a>
                <button class="navbar-toggler" type="button"
                        data-toggle="collapse" data-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="home"> HOME</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#"
                               id="auctionDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">
                                AUCTIONS <i class="fas fa-caret-down"></i>
                            </a>
                            <div class="dropdown-menu"
                                 aria-labelledby="auctionDropdown">
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="auctions">UPCOMING
                                    AUCTIONS</a>
                                <a style="font-family:Andale Mono" class="dropdown-item" href="#">PAST
                                    AUCTION</a>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#"
                               id="sellingDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">
                                SELLING <i class="fas fa-caret-down"></i>
                            </a>
                            <div class="dropdown-menu"
                                 aria-labelledby="sellingDropdown">
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="selling">ABOUT SELLING
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="response">APPRAISED ASSET
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="valuation">VALUATION REQUEST
                                </a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about"> ABOUT</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about"> CONTACT</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div  style="margin-top: 200px;" class="container-bid">
            <div style="text-align: left; font-family: 'Zapf-Chancery'; font-size: 3.25em">Upcoming Auctions</div><br><br>
            <hr>
            <br><br>
            <c:choose>
                <c:when test="${not empty AUCTIONS}">
                    <c:forEach var="auction" items="${AUCTIONS}">
                        <c:set var="currentDate" value="<%= new java.util.Date()%>" />
                        <c:if test="${auction.endDate.time < currentDate.time}">  
                            <div class="auction"> 
                                <div class="image-container">
                                    <img src="https://www.fortunaauction.com/wp-content/uploads/2024/06/1122-collection-image-1500.jpg" alt="Auction Image" loading="lazy"><br>
                                    <div style="font-family: Sans serif; color: #666" class="countdown" id="countdown_${auction.auctionID}"></div>
                                </div>
                                <div class="auction-details">
                                    <p>Bidding Open from 
                                        <fmt:formatDate value="${auction.startDate}" pattern="dd MMM"/> 
                                        to 
                                        <fmt:formatDate value="${auction.endDate}" pattern="dd MMM"/>
                                    </p>

                                    <p>(Live Sale Conclusion on 
                                        <fmt:formatDate value="${auction.endDate}" pattern="dd MMM"/> 
                                        Starting at ${auction.startTime} ET)
                                    </p>
                                    <div class="button-container">
                                        <form action="auction" method="POST">
                                            <input type="hidden" name="auctionID" value="${auction.auctionID}">
                                            <button  type="submit">View Lots</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <script>
                                (function (auctionID, endDate, startTime) {
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

                                    document.addEventListener('DOMContentLoaded', function () {
                                        getTimeDifference(endDateTime, "${auction.startTime}", elementID);
                                    });

                                    window[elementID] = setInterval(function () {
                                        getTimeDifference(endDateTime, "${auction.startTime}", elementID);
                                    }, 1000);
                                })('${auction.auctionID}', '${auction.endDate}', '${auction.startTime}');
                            </script>
                            <hr>
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>No upcoming auctions.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    var dropdowns = document.querySelectorAll('.nav-item.dropdown');

                                    dropdowns.forEach(function (dropdown) {
                                        dropdown.addEventListener('mouseenter', function () {
                                            var dropdownMenu = dropdown.querySelector('.dropdown-menu');
                                            if (dropdownMenu) {
                                                dropdownMenu.classList.add('show');
                                            }
                                        });
                                        dropdown.addEventListener('mouseleave', function () {
                                            var dropdownMenu = dropdown.querySelector('.dropdown-menu');
                                            if (dropdownMenu) {
                                                dropdownMenu.classList.remove('show');
                                            }
                                        });
                                    });
                                });

                                $(document).ready(function () {
                                    $("a.nav-link").on('click', function (event) {
                                        if (this.hash !== "") {
                                            event.preventDefault();
                                            var hash = this.hash;
                                            $('html, body').animate({
                                                scrollTop: $(hash).offset().top
                                            }, 800, function () {
                                                window.location.hash = hash;
                                            });
                                        }
                                    });
                                });
                                document.addEventListener("DOMContentLoaded", function () {
                                    window.addEventListener("scroll", function () {
                                        if (window.scrollY > 50) {
                                            document.querySelector(".navbar").classList.add("navbar-scrolled");
                                        } else {
                                            document.querySelector(".navbar").classList.remove("navbar-scrolled");
                                        }
                                    });
                                });
    </script>
</html>
