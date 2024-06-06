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
            <% for (Auction auction : listAuction) { %>
                <li>
                    <div class="auction-details">
                        <h2>Auction ID: <%= auction.getAuctionID() %></h2>
                        <p>Start Date: <%= auction.getStartDate() %></p>
                        <p>Start Time: <%= auction.getStartTime() %></p>
                    </div>
                    <div id="countdown_<%= auction.getAuctionID() %>" class="countdown"></div>
                    <!-- Form for each auction -->
                    <form action="detail.jsp" method="get">
                        <input type="hidden" name="auctionID" value="<%= auction.getAuctionID() %>">
                        <button type="submit">View Details</button>
                    </form>
                    <!-- JavaScript countdown timer -->
                    <script>
                        function getTimeDifference_<%= auction.getAuctionID() %>(startTime) {
                            var now = new Date().getTime();
                            var auctionStartTime = new Date(startTime).getTime();
                            var difference = auctionStartTime - now;
                            
                            var days = Math.floor(difference / (1000 * 60 * 60 * 24));
                            var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                            var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
                            var seconds = Math.floor((difference % (1000 * 60)) / 1000);

                            document.getElementById("countdown_<%= auction.getAuctionID() %>").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s " + "left";
                        }

                        setInterval(function () {
                            getTimeDifference_<%= auction.getAuctionID() %>('<%= auction.getStartDate() %>T<%= auction.getStartTime() %>');
                        }, 1000);

                        getTimeDifference_<%= auction.getAuctionID() %>('<%= auction.getStartDate() %>T<%= auction.getStartTime() %>');
                    </script>
                </li>
            <% } %>
        </ul>
    <% } else { %>
        <p>No upcoming auctions.</p>
    <% } %>
</div>
</body>
</html>
