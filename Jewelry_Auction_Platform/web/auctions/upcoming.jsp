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
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Montserrat', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5f5f5;
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

            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #333;
                font-size: 32px;
                font-weight: 600;
                margin-bottom: 20px;
            }

            .auction {
                display: flex;
                flex-wrap: wrap;
                margin-bottom: 30px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                overflow: hidden;
            }

            .auction:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .image-container {
                width: 100%;
                max-width: 400px;
                margin-right: 20px;
                position: relative;
                overflow: hidden;
                flex: 1;
            }

            .image-container img {
                width: 100%;
                height: auto;
                border-radius: 5px;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, opacity 0.3s ease;
            }

            .image-container:hover img {
                transform: scale(1.05);
            }

            .auction-details {
                flex: 2;
                padding: 20px;
            }

            .countdown {
                text-align: center;
                font-size: 32px;
                color: #333;
                padding: 20px;
                border-radius: 10px;
                background-color: #f8f9fa;
                display: inline-block;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .countdown-text {
                font-weight: bold;
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
                margin-top: 20px;
            }

            button {
                padding: 12px 24px;
                font-size: 16px;
                color: white;
                background-color: #333;
                border: none;
                border-radius: 100px;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease;
                font-weight: 600;
            }

            button:hover {
                background-color: #555;
            }

            .auction h2 {
                font-size: 24px;
                margin-bottom: 10px;
                color: #333;
            }

            .auction p {
                font-size: 16px;
                color: #666;
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
            <h1>Upcoming Auctions</h1>
            <c:choose>
                <c:when test="${not empty AUCTIONS}">
                    <c:forEach var="auction" items="${AUCTIONS}">
                        <div class="auction">
                            <div class="image-container">
                                <img src="https://www.fortunaauction.com/wp-content/uploads/2024/06/1122-collection-image-1500.jpg" alt="Auction Image"><br>
                                <div class="countdown" id="countdown_${auction.auctionID}"></div>
                            </div>
                            <div class="auction-details">
                                <h2>Auction ID: ${auction.auctionID}</h2>
                                <p>COMING SOON ? Bidding Open from 
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
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>No upcoming auctions.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
