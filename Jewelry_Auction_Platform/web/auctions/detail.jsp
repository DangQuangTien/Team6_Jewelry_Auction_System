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
        <title>Jewelry Auctions Online</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <%
        String auctionID = request.getParameter("auctionID");
        UserDAOImpl dao = new UserDAOImpl();
        Auction auction = dao.getAuctionByID(auctionID);
        List<Jewelry> listJewelry = dao.displayCatalog(auctionID);
    %>

    <script>
        function getTimeDifference(startDate) {
            var now = new Date().getTime();
            var startTime = new Date(startDate).getTime();
            var difference = startTime - now;

            if (difference <= 0) {
                // If the start date is in the past or the countdown reaches zero
                document.getElementById("countdown").innerHTML = "Auction started!";
                clearInterval(countdownInterval); // Stop the interval
                return;
            }
            // Calculate days, hours, minutes, and seconds
            var days = Math.floor(difference / (1000 * 60 * 60 * 24));
            var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((difference % (1000 * 60)) / 1000);
            // Display the countdown timer
            document.getElementById("countdown").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s " + "left";
        }
        // Call getTimeDifference when the page loads
        document.addEventListener('DOMContentLoaded', function () {
            getTimeDifference('<%= auction.getStartDate()%>T<%= auction.getStartTime()%>');
                });

                // Update the timer every second
                var countdownInterval = setInterval(function () {
                    getTimeDifference('<%= auction.getStartDate()%>T<%= auction.getStartTime()%>');
                        }, 1000);
    </script>
    <body>
    <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
    <a href="${pageContext.request.contextPath}/login.jsp">Log In</a>

    <%-- Auction --%>
    <div class="container">
        <h1 class="mt-4">Fine Jewels & Watches</h1>
        <h2>Live Auction</h2>
        <h3>Live bidding begins: <%= (auction.getStartDate() != null) ? auction.getStartDate() : ""%> at <%= (auction.getStartTime() != null) ? auction.getStartTime() : ""%></h3>
        <h3 style="color: orange"><div id="countdown"></div></h3>
        <a href="registerBid.jsp" class="btn btn-primary">Register bid</a>
        <!-- Filter by Category -->
        <br><br>
        <div class="form-group">
            Category:
            <select class="form-control" id="categoryFilter">
                <option value="">All Categories</option>
                <%-- Populate options dynamically based on available categories --%>
                <% for (Category category : dao.listCategory()) {%>
                <option value="<%= category.getCategoryName()%>"><%= category.getCategoryName()%></option>
                <% } %>
            </select>
        </div>
        <%-- Auction --%>

        <h2>Catalog</h2>
        <% if (listJewelry != null && !listJewelry.isEmpty()) { %>
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
                            Est. $<%= j.getMinPrice()%> - $<%= j.getMaxPrice()%>
                            <!-- Place Bid Button -->
                            <form action="${pageContext.request.contextPath}/auctions/registerBid.jsp" method="GET">
                                <input type="hidden" name="jewelryID" value="<%= j.getJewelryID()%>">
                                <input type="submit"  class="btn btn-primary" value="Place Bid">
                            </form>
                        </div>
                    </a>
                </div>
            </div>

            <% } %>
        </div>
        <% } else { %>
        <p>No items available in the catalog.</p>
        <% }%>
    </div>
    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            // Function to filter catalog items by category
                            function filterByCategory(category) {
                                var catalogItems = document.querySelectorAll('.catalog-item');

                                catalogItems.forEach(function (item) {
                                    if (category === '' || item.getAttribute('data-category') === category) {
                                        item.style.display = 'block';
                                    } else {
                                        item.style.display = 'none';
                                    }
                                });
                            }

                            // Event listener for category filter change
                            document.getElementById('categoryFilter').addEventListener('change', function () {
                                var selectedCategory = this.value;
                                filterByCategory(selectedCategory);
                            });
                        });
    </script>
</body>
</html>
