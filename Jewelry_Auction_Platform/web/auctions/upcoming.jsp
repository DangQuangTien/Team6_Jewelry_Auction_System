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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 40px;
            }
            .auction-item {
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                overflow: hidden;
                transition: transform 0.3s;
                display: flex;
                flex-direction: column;
                height: 100%;
            }
            .auction-item:hover {
                transform: translateY(-5px);
            }
            .auction-image {
                height: 200px;
                background-color: #e9ecef;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .auction-image img {
                max-height: 100%;
                max-width: 100%;
                object-fit: cover;
            }
            .auction-details {
                padding: 20px;
                flex-grow: 1;
            }
            .auction-details h2 {
                font-size: 20px;
                color: #007bff;
                margin-bottom: 10px;
            }
            .auction-details p {
                margin: 0;
                color: #555;
            }
            .countdown {
                font-size: 18px;
                color: #333;
                margin-top: 10px;
            }
            .view-details-btn {
                padding: 10px 20px;
                font-size: 16px;
                text-align: center;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 20px;
            }
            .view-details-btn:hover {
                background-color: #0056b3;
            }

            .active {
                border: 2px solid #007bff;
            }

            .expired {
                opacity: 0.5;
                background-color: #ccc;
                border: 2px solid #999;
            }

            .countdown.active {
                color: #28a745;
                font-weight: bold;
            }

            .countdown.expired {
                color: #dc3545;
                font-weight: bold;
            }

            .auction-item.active:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .auction-item.expired:hover {
                transform: none;
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
            <div class="row">
                <% for (Auction auction : listAuction) {%>
                <div class="col-sm-6 col-md-4 col-lg-3 d-flex">
                    <div class="auction-item w-100" id="auction_<%= auction.getAuctionID()%>">
                        <div class="auction-image">
                            <img src="path/to/image.jpg" alt="Auction Image">
                        </div>
                        <div class="auction-details">
                            <h2>Auction ID: <%= auction.getAuctionID()%></h2>
                            <p>Start Date: <%= auction.getStartDate()%></p>
                            <p>Start Time: <%= auction.getStartTime()%></p>
                            <div id="countdown_<%= auction.getAuctionID()%>" class="countdown"></div>
                        </div>
                        <form action="detail.jsp" method="get" class="d-flex justify-content-center">
                            <input type="hidden" name="auctionID" value="<%= auction.getAuctionID()%>">
                            <button type="submit" class="view-details-btn">View Details</button>
                        </form>
                    </div>
                </div>
                <% } %>
            </div>
            <script>
                function getTimeDifference(auctionID, startTime) {
                    var now = new Date().getTime();
                    var auctionStartTime = new Date(startTime).getTime();
                    var difference = auctionStartTime - now;

                    if (difference < 0) {
                        var auctionElement = document.getElementById('auction_' + auctionID);
                        auctionElement.classList.add('expired');
                        document.getElementById('countdown_' + auctionID).innerHTML = 'Auction Ended';
                    } else {
                        var days = Math.floor(difference / (1000 * 60 * 60 * 24));
                        var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                        var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
                        var seconds = Math.floor((difference % (1000 * 60)) / 1000);

                        document.getElementById('countdown_' + auctionID).innerHTML = days + 'd ' + hours + 'h ' +
                                minutes + 'm ' + seconds + 's ' + 'left';
                    }
                }

                <% for (Auction auction : listAuction) {%>
                var auctionID = '<%= auction.getAuctionID()%>';
                var startTime = '<%= auction.getStartDate()%>T<%= auction.getStartTime()%>';
                    setInterval(function () {
                        getTimeDifference(auctionID, startTime);
                    }, 1000);
                <% } %>
            </script>
            <% } else { %>
            <p class="text-center">No upcoming auctions.</p>
            <% }%>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
