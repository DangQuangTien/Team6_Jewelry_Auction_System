<%-- 
    Document   : detail
    Created on : Jun 6, 2024, 2:12:04 AM
    Author     : User
--%>

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
        // Function to calculate the time difference between two dates
        function getTimeDifference(startDate) {
            var now = new Date().getTime();
            var startTime = new Date(startDate).getTime();
            var difference = startTime - now;

            // Calculate days, hours, minutes, and seconds
            var days = Math.floor(difference / (1000 * 60 * 60 * 24));
            var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((difference % (1000 * 60)) / 1000);

            // Display the countdown timer
            document.getElementById("countdown").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s " + "left";
        }

        // Update the timer every second
        setInterval(function () {
            getTimeDifference('<%= auction.getStartDate()%>T<%= auction.getStartTime()%>'); // Combine date and time
                }, 1000);

                // Call getTimeDifference when the page loads
                document.addEventListener('DOMContentLoaded', function () {
                    getTimeDifference('<%= auction.getStartDate()%>T<%= auction.getStartTime()%>');
                        });
    </script>

    <body>
    <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
    <a href="${pageContext.request.contextPath}/login.jsp">Log In</a>
    <div class="container">
        <h1 class="mt-4">Fine Jewels & Watches</h1>
        <h2>Live Auction</h2>
        <h3>Live bidding begins: <%= (auction.getStartDate() != null) ? auction.getStartDate() : ""%> at <%= (auction.getStartTime() != null) ? auction.getStartTime() : ""%></h3>
        <h3 style="color: orange"><div id="countdown"></div></h3>

        <!-- Filter by Category -->
        <div class="form-group">
            <label for="categoryFilter">Filter by Category:</label>
            <select class="form-control" id="categoryFilter">
                <option value="">All</option>
                <%-- Populate options dynamically based on available categories --%>
                <% for (Category category : dao.listCategory()) {%>
                <option value="<%= category.getCategoryName()%>"><%= category.getCategoryName()%></option>
                <% } %>
            </select>
            
        </div>
        <a href="registerBid.jsp" class="btn btn-primary">Register bid</a>

        <h2>Catalog</h2>
        <% if (listJewelry != null && !listJewelry.isEmpty()) { %>
        <div class="row" id="catalogItems">
            <% for (Jewelry j : listJewelry) {%>
            <div class="col-md-4 mb-4 catalog-item" data-category="<%= j.getCategoryName()%>">
                <div class="card">
                    <%
                        String photos = j.getPhotos();
                        String[] photoArray = photos.split(";");
                    %>
                    <img class="card-img-top" src="${pageContext.request.contextPath}/<%= photoArray[0]%>" alt="<%= j.getJewelryName()%>">
                    <div class="card-body">
                        <h5 class="card-title"><%= j.getJewelryName()%></h5>
                        <p class="card-text">Min Price: <%= j.getMinPrice()%></p>
                        <p class="card-text">Max Price: <%= j.getMaxPrice()%></p>
                        <!-- Hidden field for category -->
                        <input type="hidden" name="category" value="<%= j.getCategoryName()%>">
                        <!-- Place Bid Button -->
                        <a href="registerBid.jsp" class="btn btn-primary">Place Bid</a>
                    </div>
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
