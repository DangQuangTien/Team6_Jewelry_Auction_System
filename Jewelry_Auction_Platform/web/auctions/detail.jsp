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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Jewelry Auctions Online</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 960px;
            }
            .header {
                padding: 3rem 1.5rem;
                text-align: center;
                color: #6c757d;
            }
            .catalog-item {
                transition: transform .2s;
            }
            .catalog-item:hover {
                transform: scale(1.1);
            }
            .catalog {
                margin-top: 2rem;
            }
        </style>
    </head>
    <%
        String auctionID = request.getParameter("auctionID");
        UserDAOImpl dao = new UserDAOImpl();
        Auction auction = dao.getAuctionByID(auctionID);
        List<Jewelry> listJewelry = dao.displayCatalog(auctionID);
    %>
    <body>
        <div class="header">
            <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-secondary">Home</a>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-secondary">Log In</a>
            <h1 class="display-4">Fine Jewels & Watches</h1>
            <p class="lead">Live Auction</p>
            <p>Live bidding begins: <%= (auction.getStartDate() != null) ? auction.getStartDate() : ""%> at <%= (auction.getStartTime() != null) ? auction.getStartTime() : ""%></p>
            <h3 style="color: orange"><div id="countdown"></div></h3>
        </div>
        <div class="container">
            <!-- Search Bar -->
            <div class="form-group">
                <label for="searchBar">Search:</label>
                <input type="text" class="form-control" id="searchBar" placeholder="Search for items...">
            </div>

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

            <div class="catalog">
                <h2>Catalog</h2>
                <% if (listJewelry != null && !listJewelry.isEmpty()) { %>
                <div class="row" id="catalogItems">
                    <% for (Jewelry j : listJewelry) {%>
                    <div class="col-md-4 mb-4 catalog-item" data-category="<%= j.getCategoryName()%>">
                        <div class="card h-100">
                            <%
                                String photos = j.getPhotos();
                                String[] photoArray = photos.split(";");
                            %>
                            <img class="card-img-top" src="${pageContext.request.contextPath}/<%= photoArray[0]%>" alt="<%= j.getJewelryName()%>">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title"><%= j.getJewelryName()%></h5>
                                <p class="card-text">Min Price: <%= j.getMinPrice()%></p>
                                <p class="card-text">Max Price: <%= j.getMaxPrice()%></p>
                                <!-- Hidden field for category -->
                                <input type="hidden" name="category" value="<%= j.getCategoryName()%>">
                                <!-- Place Bid Button -->
                                <a href="#" class="btn btn-primary mt-auto">Place Bid</a>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } else { %>
                <p>No items available in the catalog.</p>
                <% }%>
            </div>
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