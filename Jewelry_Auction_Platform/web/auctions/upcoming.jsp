<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Upcoming Auctions</title>
        <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
        <style>
            body, html {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
                scroll-behavior: smooth;
            }

            nav {
                background-color: white;
                color: #000000;
                padding: 10px 20px;
                display: flex;
                justify-content: flex-end; /* Center align navigation links */
            }

            nav a {
                color: #000000;
                text-decoration: none;
                margin-right: 10px;
                padding: 8px;
                transition: background-color 0.3s ease;
            }

            nav a:hover {
                background-color: rgba(85, 85, 85, 0.5);
                color: white;
            }

            .container {
                max-width: 90%;
                margin: 100px auto;
                padding: 20px;
                box-sizing: border-box; /* Ensures padding and borders fit within container */
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
                font-size: 300%;
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
                padding: 15px 300px;
                font-size: 18px;
                color: black;
                background-color: white;
                border: 2px solid #000000;
                border-radius: 100px;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease;
                display: block;
                margin-top: 100px;
                margin-left: 120px
            }

            button:hover {
                background-color: #000;
                color: #fff;
            }


            p {
                font-size:200% ;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <nav>
            <a href="${pageContext.request.contextPath}/home">HOME</a>
            <a href="${pageContext.request.contextPath}/auctions">AUCTIONS</a>
            <a href="${pageContext.request.contextPath}/selling">SELLING</a>
            <a href="#">EXPLORE</a>
            <a href="#">ABOUT</a>
            <a href="#">CONTACT</a>
        </nav>
        <div class="container">
            <div style="text-align: left; font-family: 'Zapf-Chancery'; font-size: 3.25em">Upcoming Auctions</div><br><br>
            <hr>
            <br><br>
            <c:choose>
                <c:when test="${not empty AUCTIONS}">
                    <c:forEach var="auction" items="${AUCTIONS}">
                        <div class="auction">
                            <div class="image-container">
                                <img src="https://www.fortunaauction.com/wp-content/uploads/2024/06/1122-collection-image-1500.jpg" alt="Auction Image" loading="lazy"><br>
                                <div class="countdown" id="countdown_${auction.auctionID}"></div>
                            </div>
                            <div class="auction-details">
                                <p>COMING SOON &#x2022; Bidding Open from 
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
                                        <button type="submit">View Lots</button>
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
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>No upcoming auctions.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
