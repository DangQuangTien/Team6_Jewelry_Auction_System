<%@page import="entity.member.Member"%>
<%@page import="entity.product.Category"%>
<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="entity.Auction.Auction"%>
<%@page import="dao.UserDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fine Jewels & Watches | Global F'Rankelly 's Premier Jewelry Auction House</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
    </head>
    <style>
        .countdown-container {
            display: flex;
            align-items: center;
        }
        .countdown-container div {
            margin-right: 10px;
        }
        .blink {
            animation: blink-animation 1s linear infinite;
        }

        @keyframes blink-animation {
            0% {
                opacity: 1;
            }
            50% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }

    </style>
    <%
        String auctionID = request.getParameter("auctionID");
        UserDAOImpl dao = new UserDAOImpl();
        Auction auction = dao.getAuctionByID(auctionID);
        List<Jewelry> listJewelry = dao.displayCatalog(auctionID);
    %>
    <% if (listJewelry != null && !listJewelry.isEmpty()) {

            String userID = (String) session.getAttribute("USERID");
            Member member = dao.getInformation(userID);
            int status = 1;
            if (member != null) {
                status = member.getStatus();
            }

    %>
    <script>
        function getTimeDifference(startDate) {
            var now = new Date().getTime();
            var startTime = new Date(startDate).getTime();
            var difference = startTime - now;

            if (difference <= 0) {
                document.getElementById("countdown").innerHTML = "Auction started!";
                clearInterval(countdownInterval);
        <% if (status == 1 && member != null) { %>
                document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/private/room/live/index.html"><img style="width: 50px; height: 50px" src="../images/entrance.png"></a>';

        <% } else if (status == 0 && member != null) { %>
                document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/auctions/registerBid.jsp"><img style="width: 50px; height: 50px" src="../images/entrance.png"></a>';
        <% } else {%>
            document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/login.jsp"><img style="width: 50px; height: 50px" src="../images/entrance.png"></a>';
            <% } %>
                document.getElementById("auctionLink").classList.add("blink");
                return;
            }
            var days = Math.floor(difference / (1000 * 60 * 60 * 24));
            var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((difference % (1000 * 60)) / 1000);
            document.getElementById("countdown").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s left";
        }

        document.addEventListener('DOMContentLoaded', function () {
            getTimeDifference('<%= auction.getStartDate()%>T<%= auction.getStartTime()%>');
                });

                var countdownInterval = setInterval(function () {
                    getTimeDifference('<%= auction.getStartDate()%>T<%= auction.getStartTime()%>');
                        }, 1000);
    </script>

    <body>

    <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
    <a href="${pageContext.request.contextPath}/login.jsp">Log In</a>
    <div class="container">
        <h1 class="mt-4">Fine Jewels & Watches</h1>
        <h2>Live Auction</h2>
        <h3>Live bidding begins: <%= (auction.getStartDate() != null) ? auction.getStartDate() : ""%> at <%= (auction.getStartTime() != null) ? auction.getStartTime() : ""%></h3>
        <div class="countdown-container">
            <h3 style="color: orange"><div id="countdown"></div></h3>
            <div id="auctionLink"></div>
        </div>
        <% if (status == 1 && member != null){ %>
        <a href="../private/room/live/index.html" class="btn btn-primary">PLACE BID</a>
        <% } else if (status == 0 && member != null){ %>
        <a href="registerBid.jsp" class="btn btn-primary">REGISTER TO BID</a>
        <% } else { %>
        <a href="../login.jsp" class="btn btn-primary">REGISTER TO BID</a>
        <% } %>
        <hr>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="sortPrice">Sort By:</label>
                    <select class="form-control" id="sortPrice">
                        <option value="">Select</option>
                        <option value="lowToHigh">Estimate Low to High</option>
                        <option value="highToLow">Estimate High to Low</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="categoryFilter">Category:</label>
                    <select class="form-control" id="categoryFilter">
                        <option value="">All Categories</option>
                        <% for (Category category : dao.listCategory()) {%>
                        <option value="<%= category.getCategoryName()%>"><%= category.getCategoryName()%></option>
                        <% }%>
                    </select>
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="searchBar">Search By Lots:</label>
                    <input type="text" class="form-control" id="searchBar" placeholder="Search Lots">
                </div>
            </div>

        </div>
        <hr>
        <div class="row" id="catalogItems">
            <% for (Jewelry j : listJewelry) {
                    String photos = j.getPhotos();
                    String[] photoArray = photos.split(";");
            %>
            <div class="col-md-4 mb-4 catalog-item" data-category="<%= j.getCategoryName()%>">
                <div class="card">
                    <a href="itemDetail.jsp?jewelryID=<%= j.getJewelryID()%>&auctionID=<%= request.getParameter("auctionID")%>">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/<%= photoArray[0]%>" alt="<%= j.getJewelryName()%>">
                        <div class="card-body">
                            <h5 class="card-title"><%= j.getJewelryID()%></h5>
                            <h5 class="card-title"><%= j.getJewelryName()%></h5>
                            Starting Bid: $1500 <br>
                            Est. $<span class="min-price"><%= j.getMinPrice()%></span> - $<span class="max-price"><%= j.getMaxPrice()%></span>
                            <% if (status == 0) {%>
                            <form action="${pageContext.request.contextPath}/auctions/registerBid.jsp" method="GET">
                                <input type="submit" class="btn btn-primary" value="PLACE BID">
                            </form>
                            <% } else { %>
                            <br>
                            <form action="../login.jsp" method="POST">
                                <input type="submit" class="btn btn-primary" value="PLACE BID">
                            </form>
                            <% } %>
                        </div>
                    </a>
                </div>
            </div>
            <% } %>
            <% } else { %>
            <p>No items available in the catalog.</p>
            <% }%>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            function filterItems() {
                                var selectedCategory = document.getElementById('categoryFilter').value;
                                var searchQuery = document.getElementById('searchBar').value.trim().toLowerCase();
                                var sortPrice = document.getElementById('sortPrice').value;

                                console.log('Selected Category:', selectedCategory);
                                console.log('Search Query:', searchQuery);
                                console.log('Sort Price:', sortPrice);

                                var catalogItems = Array.from(document.querySelectorAll('.catalog-item'));

                                // Filter by category and search query
                                catalogItems.forEach(function (item) {
                                    var itemCategory = item.getAttribute('data-category');
                                    var itemJewelryID = item.querySelector('.card-title').textContent.toLowerCase();

                                    var categoryMatch = (selectedCategory === '' || itemCategory === selectedCategory);
                                    var searchMatch = (searchQuery === '' || itemJewelryID.includes(searchQuery));

                                    if (categoryMatch && searchMatch) {
                                        item.style.display = 'block';
                                    } else {
                                        item.style.display = 'none';
                                    }
                                });

                                // Sort by price
                                if (sortPrice !== '') {
                                    catalogItems.sort(function (a, b) {
                                        var aMinPrice = parseFloat(a.querySelector('.min-price').textContent);
                                        var bMinPrice = parseFloat(b.querySelector('.min-price').textContent);

                                        if (sortPrice === 'lowToHigh') {
                                            return aMinPrice - bMinPrice;
                                        } else if (sortPrice === 'highToLow') {
                                            return bMinPrice - aMinPrice;
                                        }
                                    });

                                    var catalogContainer = document.getElementById('catalogItems');
                                    catalogItems.forEach(function (item) {
                                        catalogContainer.appendChild(item);
                                    });
                                }
                            }

                            document.getElementById('categoryFilter').addEventListener('change', filterItems);
                            document.getElementById('searchBar').addEventListener('input', filterItems);
                            document.getElementById('sortPrice').addEventListener('change', filterItems);
                        });
    </script>
</body>
</html>
