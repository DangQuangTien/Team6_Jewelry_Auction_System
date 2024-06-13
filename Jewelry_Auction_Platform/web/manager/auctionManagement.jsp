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
        <title>Jewelry Auctions Online - Upcoming Auctions</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f7f7f7;
                color: #333;
                line-height: 1.6;
            }
            .container {
                max-width: 1200px;
                margin: 30px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                font-size: 2.5em;
                color: #444;
                margin-bottom: 40px;
            }
            .auction-list {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
            }
            .auction-item {
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .auction-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            }
            .auction-details h2 {
                font-size: 1.5em;
                color: #007bff;
                margin-bottom: 10px;
            }
            .auction-details p {
                font-size: 1em;
                margin: 5px 0;
            }
            .countdown {
                font-size: 1.2em;
                color: #ff5722;
                margin-bottom: 15px;
                font-weight: bold;
            }
            form {
                text-align: center;
            }
            button, .create-button {
                display: inline-block;
                padding: 10px 20px;
                font-size: 1em;
                color: #fff;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                transition: background-color 0.3s, transform 0.3s;
            }
            button:hover, .create-button:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
            }
            .create-button {
                margin-top: 40px;
                display: block;
                width: fit-content;
                margin-left: auto;
                margin-right: auto;
                background-color: #28a745;
            }
            .create-button:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Upcoming Auctions</h1>
            <%
                UserDAOImpl dao = new UserDAOImpl();
                List<Auction> listAuction = dao.displayAuction();
            %>
            <% if (!listAuction.isEmpty()) { %>
            <div class="auction-list">
                <% for (Auction auction : listAuction) {
                        String auctionID = auction.getAuctionID();
                        Date startDate = auction.getStartDate();
                        LocalTime startTime = auction.getStartTime();
                %>
                <div class="auction-item">
                    <div class="auction-details">
                        <h2>Auction ID: <%= auctionID %></h2>
                        <p>Start Date: <%= startDate %></p>
                        <p>Start Time: <%= startTime %></p>
                    </div>
                    <div id="countdown_<%= auctionID %>" class="countdown"></div>
                    <!-- Form for each auction -->
                    <form action="${pageContext.request.contextPath}/auctions/detail.jsp" method="get">
                        <input type="hidden" name="auctionID" value="<%= auctionID %>">
                        <button type="submit">View Details</button>
                    </form>
                    <!-- JavaScript countdown timer -->
                    <script>
                        (function (auctionID, startDate, startTime) {
                            function getTimeDifference(startDateTime, elementID) {
                                var now = new Date().getTime();
                                var startTime = new Date(startDateTime).getTime();
                                var difference = startTime - now;

                                if (difference <= 0) {
                                    // If the start date is in the past or the countdown reaches zero
                                    document.getElementById(elementID).innerHTML = "Auction started!";
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
                </div>
                <% } %>
            </div>
            <% } else { %>
            <p>No upcoming auctions.</p>
            <% } %>
            <!-- Link to createAuction.jsp -->
            <a href="${pageContext.request.contextPath}/manager/createAuction.jsp" class="create-button">Create New Auction</a>
        </div>
    </body>
</html>
