<%@page import="java.time.LocalTime"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="entity.Auction.Auction"%>
<%@page import="dao.UserDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Upcoming Jewelry and Watch Auctions at Global F'Rankelly 's Premier Jewelry Auction House</title>
        <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-color: #f5eded;
                font-family: 'Arial', sans-serif;
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
                color: #0a0800 !important;
            }

            .container {
                max-width: 1000px;
                margin: 20px auto;
                padding: 20px;
                border-radius: 5px;
                background-color: #f5eded;
                color: #333;
            }

            h1 {
                text-align: center;
                color: #ffc107;
                margin-bottom: 30px;
                animation: glow 1.5s infinite;
            }

            @keyframes glow {
                0% { text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #ffc107, 0 0 20px #ffc107, 0 0 25px #ffc107, 0 0 30px #ffc107, 0 0 35px #ffc107; }
                100% { text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #ffc107, 0 0 20px #ffc107, 0 0 25px #ffc107, 0 0 30px #ffc107, 0 0 35px #ffc107; }
            }

            .auction-list {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                list-style: none;
                padding: 0;
                justify-content: space-between;
            }

            .auction-item {
                flex: 1 1 calc(50% - 20px);
                margin-bottom: 20px;
                padding: 20px;
                border-radius: 5px;
                background-color: #fff;
                color: #333;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .auction-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .auction-details {
                margin-bottom: 10px;
            }

            .auction-details h2 {
                font-size: 1.5em;
                color: #007bff;
                margin-bottom: 10px;
            }

            .auction-details p {
                font-size: 1.1em;
                color: #666;
                margin-bottom: 5px;
            }

            .countdown {
                font-size: 18px;
                color: #d9534f;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .countdown.started {
                color: #28a745;
            }

            form {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            button {
                padding: 10px 20px;
                font-size: 16px;
                color: #fff;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #0056b3;
            }

            .icon {
                font-size: 1.2em;
                margin-right: 8px;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#"><i class="fas fa-gem icon"></i> Jewelry Auctions</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home.jsp"><i class="fas fa-home icon"></i> Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/auctions/upcoming.jsp"><i class="fas fa-gavel icon"></i> Auction</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/seller/request.jsp"><i class="fas fa-clipboard icon"></i> Request A Valuation</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/seller/response.jsp"><i class="fas fa-reply icon"></i> Response</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/seller/shipmentRequest.jsp"><i class="fas fa-bell icon"></i> Notification</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="container">
            <h1>Upcoming Auctions</h1>
            <%
                UserDAOImpl dao = new UserDAOImpl();
                List<Auction> listAuction = dao.displayAuction();
            %>
            <% if (!listAuction.isEmpty()) { %>
            <ul class="auction-list">
                <% for (Auction auction : listAuction) {
                    String auctionID = auction.getAuctionID();
                    Date startDate = auction.getStartDate();
                    LocalTime startTime = auction.getStartTime();
                %>
                <li class="auction-item">
                    <div class="auction-details">
                        <h2><i class="fas fa-tag icon"></i>Auction ID: <%= auctionID %></h2>
                        <p><i class="fas fa-calendar-alt icon"></i>Start Date: <%= startDate %></p>
                        <p><i class="fas fa-clock icon"></i>Start Time: <%= startTime %></p>
                    </div>
                    <div id="countdown_<%= auctionID %>" class="countdown"></div>
                    <!-- Form for each auction -->
                    <form action="detail.jsp" method="get">
                        <input type="hidden" name="auctionID" value="<%= auctionID %>">
                        <button type="submit"><i class="fas fa-eye icon"></i> View Auction Now</button>
                    </form>
                    <!-- JavaScript countdown timer -->
                    <script>
                        (function(auctionID, startDate, startTime) {
                            function getTimeDifference(startDateTime, elementID) {
                                var now = new Date().getTime();
                                var startTime = new Date(startDateTime).getTime();
                                var difference = startTime - now;

                                if (difference <= 0) {
                                    // If the start date is in the past or the countdown reaches zero
                                    document.getElementById(elementID).innerHTML = "Auction started!";
                                    document.getElementById(elementID).classList.add("started");
                                    clearInterval(window[elementID]); // Stop the interval
                                    return;
                                }

                                // Calculate days, hours, minutes, and seconds
                                var days = Math.floor(difference / (1000 * 60 * 60 * 24));
                                var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                                var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
                                var seconds = Math.floor((difference % (1000 * 60)) / 1000);

                                // Display the countdown timer
                                document.getElementById(elementID).innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s " + "left";
                            }

                            var elementID = "countdown_" + auctionID;
                            var startDateTime = startDate + "T" + startTime;

                            // Call getTimeDifference when the page loads
                            document.addEventListener('DOMContentLoaded', function () {
                                getTimeDifference(startDateTime, elementID);
                            });

                            // Update the timer every second
                            window[elementID] = setInterval(function () {
                                getTimeDifference(startDateTime, elementID);
                            }, 1000);
                        })('<%= auctionID %>', '<%= startDate %>', '<%= startTime %>');
                    </script>
                </li>
                <% } %>
            </ul>
            <% } else { %>
            <p>No upcoming auctions.</p>
            <% }%>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
