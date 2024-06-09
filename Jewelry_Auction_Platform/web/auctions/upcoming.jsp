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
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 800px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #f9f9f9;
            }
            h1 {
                text-align: center;
                color: #333;
            }
            ul {
                list-style: none;
                padding: 0;
            }
            li {
                margin-bottom: 20px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #fff;
            }
            .auction-details {
                margin-bottom: 10px;
            }
            .countdown {
                font-size: 18px;
                color: #333;
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
            }
            button:hover {
                background-color: #0056b3;
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
            <ul>
                <% for (Auction auction : listAuction) {
                    String auctionID = auction.getAuctionID();
                    Date startDate = auction.getStartDate();
                    LocalTime startTime = auction.getStartTime();
                %>
                <li>
                    <div class="auction-details">
                        <h2>Auction ID: <%= auctionID %></h2>
                        <p>Start Date: <%= startDate %></p>
                        <p>Start Time: <%= startTime %></p>
                    </div>
                    <div id="countdown_<%= auctionID %>" class="countdown"></div>
                    <!-- Form for each auction -->
                    <form action="detail.jsp" method="get">
                        <input type="hidden" name="auctionID" value="<%= auctionID %>">
                        <button type="submit">View Details</button>
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
    </body>
</html>
