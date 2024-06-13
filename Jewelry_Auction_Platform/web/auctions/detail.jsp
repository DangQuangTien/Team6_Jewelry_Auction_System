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
                document.getElementById("countdown").innerHTML = "Auction started!";
                clearInterval(countdownInterval);
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
        <h3 style="color: orange"><div id="countdown"></div></h3>
        <a href="registerBid.jsp" class="btn btn-primary">REGISTER TO BID</a>
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
                        <% } %>
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
            <% if (listJewelry != null && !listJewelry.isEmpty()) { %>
            <%
                String userID = (String) session.getAttribute("USERID");
                Member member = dao.getInformation(userID);
                int status = 1;
                if (member != null) {
                    status = member.getStatus();
                }
                for (Jewelry j : listJewelry) {
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
                            <button type="button" class="btn btn-primary place-bid-button" data-toggle="modal" data-target="#placeBidModal" data-jewelry-id="<%= j.getJewelryID()%>">
                                PLACE BID
                            </button>
                            <% } else { %>
                            <br>
                            <button type="button" class="btn btn-primary place-bid-button" data-toggle="modal" data-target="#placeBidModal" data-jewelry-id="<%= j.getJewelryID()%>">
                                PLACE BID
                            </button>
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

    <!-- Modal -->
    <div class="modal fade" id="placeBidModal" tabindex="-1" aria-labelledby="placeBidModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="placeBidModalLabel">Place Your Bid</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                    <div class="modal-body">
                        <input type="hidden" id="modalJewelryID" name="jewelryID">
                        <div class="form-group">
                            <label for="bidAmount">Bid Amount</label>
                            <input type="number" class="form-control" id="bidAmount" name="bidAmount" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Place Bid</button>
                    </div>
            </div>
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

            $('#placeBidModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); 
                var jewelryID = button.data('jewelry-id'); 
                var modal = $(this);
                modal.find('#modalJewelryID').val(jewelryID);
            });
        });
    </script>
</body>
</html>
