<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <title>Fine Jewels & Watches | Global F'Rankelly 's Premier Jewelry Auction House</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
        <link
            rel="stylesheet"
            type="text/css"
            href="../component//userProfile.css"
            />
        <link rel="stylesheet" type="text/css" href="../component/header.css" />
        <link rel="stylesheet" type="text/css" href="../component/footer.css" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
            />
        <link
            rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            />
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
        .alert {
            display: none;
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #888;
            color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }
        .navbar {
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: #343a40 !important;
            border-bottom: 3px solid #e4af11;
        }

        .navbar-brand,
        .nav-link,
        .navbar-toggler-icon {
            color: #ffc107 !important;
        }

        .navbar-brand:hover,
        .nav-link:hover {
            color: #0a0800 !important;
        }

        .content {
            flex: 1;
            padding: 20px;
        }
    </style>

    <c:set var="auctionID" value="${param.auctionID}" />
    <c:set var="dao" value="<%= new UserDAOImpl()%>" />
    <c:set var="auction" value="${dao.getAuctionByID(auctionID)}" />
    <c:set var="listJewelry" value="${dao.displayCatalog(auctionID)}" />
    <c:if test="${listJewelry != null && !listJewelry.isEmpty()}">
        <c:set var="userID" value="${sessionScope.USERID}" />
        <c:set var="member" value="${dao.getInformation(userID)}" />
        <c:set var="status" value="1" />
        <c:if test="${member != null}">
            <c:set var="status" value="${member.status}" />
        </c:if>
    </c:if>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var statusAlert = document.getElementById('statusAlert');
            if (statusAlert.innerHTML.trim() !== '') {
                statusAlert.style.display = 'block';
                setTimeout(function () {
                    statusAlert.style.display = 'none';
                }, 1000);
            }
        });
        function getTimeDifference(startDate) {
            var now = new Date().getTime();
            var startTime = new Date(startDate).getTime();
            var difference = startTime - now;

            if (difference <= 0) {
                document.getElementById("countdown").innerHTML = "Auction started!";
                clearInterval(countdownInterval);
        <c:choose>
            <c:when test="${status == 1 && member != null}">
                document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/private/room/live/index.html?auctionID=${auctionID}"><img style="width: 50px; height: 50px" src="${pageContext.request.contextPath}/images/entrance.png"></a>';
                document.getElementById("auctionLink1").innerHTML = '<a href="${pageContext.request.contextPath}/private/room/live/index.html?auctionID=${auctionID}">JOIN AUCTION</a>';
                document.getElementById("bidForm").innerHTML = '<a href="${pageContext.request.contextPath}/private/room/live/index.html?auctionID=${auctionID}">JOIN AUCTION</a>';
            </c:when>
            <c:when test="${status == 0 && member != null}">
                document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/auctions/registerBid.jsp?auctionID=${auctionID}"><img style="width: 50px; height: 50px" src="${pageContext.request.contextPath}/images/entrance.png"></a>';
            </c:when>
            <c:otherwise>
                document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/login.jsp"><img style="width: 50px; height: 50px" src="../images/entrance.png"></a>';
            </c:otherwise>
        </c:choose>
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
            getTimeDifference('${auction.startDate}T${auction.startTime}');
                });

                var countdownInterval = setInterval(function () {
                    getTimeDifference('${auction.startDate}T${auction.startTime}');
                        }, 1000);


    </script>

    <body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#"
               ><i class="fas fa-gem"></i> Jewelry Auctions</a
            >
            <button
                class="navbar-toggler"
                type="button"
                data-toggle="collapse"
                data-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="Toggle navigation"
                >
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a
                            class="nav-link"
                            href="${pageContext.request.contextPath}/home.jsp"
                            ><i class="fas fa-home"></i> Home
                            <span class="sr-only">(current)</span></a
                        >
                    </li>
                    <li class="nav-item">
                        <a
                            class="nav-link"
                            href="${pageContext.request.contextPath}/auctions/upcoming.jsp"
                            ><i class="fas fa-gavel"></i> Auction</a
                        >
                    </li>
                    <li class="nav-item">
                        <a
                            class="nav-link"
                            href="${pageContext.request.contextPath}/seller/selling.html"
                            ><i class="fas fa-dollar-sign"></i> Sell</a
                        >
                    </li>
                    <!-- JSTL Conditional Rendering -->
                    <c:choose>
                        <c:when test="${empty sessionScope.USERNAME}">
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp"
                                   ><i class="fas fa-sign-in-alt"></i> Login</a
                                >
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="register.jsp"
                                   ><i class="fas fa-user-plus"></i> Register</a
                                >
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle"
                                   href="#"
                                   id="userDropdown"
                                   role="button"
                                   data-toggle="dropdown"
                                   aria-haspopup="true"
                                   aria-expanded="false"
                                   >
                                    <i class="fas fa-user"></i> ${sessionScope.USERNAME}
                                </a>
                                <div class="dropdown-menu" aria-labelledby="userDropdown">
                                    <a
                                        class="dropdown-item"
                                        href="${pageContext.request.contextPath}/bidder/profile.jsp"
                                        >Profile</a
                                    >
                                    <a
                                        class="dropdown-item"
                                        href="${pageContext.request.contextPath}/MainController?action=Log out"
                                        >Logout</a
                                    >
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
            </div>
        </nav>
    </header>
    <div class="container">
        <% String status = (String) request.getAttribute("PlACEBIDSTATUS");%>
        <div id="statusAlert" class="alert" style="display: none;">
            <%= (status != null) ? status : ""%>
        </div>
        <h1 class="mt-4">Fine Jewels & Watches</h1>
        <h2>Live Auction</h2>
        <h3>Live bidding begins: <c:out value="${auction.startDate}"/> at <c:out value="${auction.startTime}"/></h3>
        <div class="countdown-container">
            <h3 style="color: orange"><div id="countdown"></div></h3>
            <div id="auctionLink"></div>
        </div>
        <!-- Notification -->
        <c:choose>
            <c:when test="${status == 1 && member != null}">
                <div style="color: red" id="auctionLink1"><h2>Coming Soon!</h2></div>
            </c:when>
            <c:when test="${status == 0 && member != null}">
                <a href="registerBid.jsp?auctionID=${auctionID}" class="btn btn-primary">REGISTER TO BID</a>
            </c:when>
            <c:otherwise>
                <a href="../login.jsp" class="btn btn-primary">REGISTER TO BID</a>
            </c:otherwise>
        </c:choose>
        <!-- Sort -->
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
                        <c:forEach var="category" items="${dao.listCategory()}">
                            <option value="${category.categoryName}">${category.categoryName}</option>
                        </c:forEach>
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
            <c:forEach var="j" items="${listJewelry}">
                <c:set var="photos" value="${j.photos}" />
                <c:set var="photoArray" value="${fn:split(photos, ';')}" />
                <div class="col-md-4 mb-4 catalog-item" data-category="${j.categoryName}">
                    <div class="card">
                        <a href="${pageContext.request.contextPath}/auctions/itemDetail.jsp?jewelryID=${j.jewelryID}&auctionID=${auctionID}">
                            <img class="card-img-top" src="${pageContext.request.contextPath}/${photoArray[0]}" alt="${j.jewelryName}">
                        </a>
                        <div class="card-body">
                            <h5 class="card-title">${j.jewelryID}</h5>
                            <h5 class="card-title">${j.jewelryName}</h5>
                            Starting Bid: $1500 <br>
                            Est. $<span class="min-price">${j.minPrice}</span> - $<span class="max-price">${j.maxPrice}</span>
                            <br>
                            <c:choose>
                                <c:when test="${status == 0 && member != null}">
                                    <form action="${pageContext.request.contextPath}/auctions/registerBid.jsp?auctionID=${auctionID}" method="GET">
                                        <input type="submit" class="btn btn-primary" value="PLACE BID">
                                    </form>
                                </c:when>
                                <c:when test="${status == 1 && member != null}">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal">PLACE BID</button>
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal_">EDIT BID</button>

                                </c:when>
                                <c:otherwise>
                                    <form action="../login.jsp" method="POST">
                                        <input type="submit" class="btn btn-primary" value="PLACE BID">
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <c:if test="${listJewelry == null || listJewelry.isEmpty()}">
            <p>No items available in the catalog.</p>
        </c:if>
    </div>
    <% String preBid_Amount = (String) request.getParameter("preBid_Amount");%>
    <!-- Modal for bidding -->
    <div class="modal fade" id="bidModal" tabindex="-1" role="dialog" aria-labelledby="bidModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bidModalLabel">Place Your Bid</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="bidForm" action="${pageContext.request.contextPath}/MainController" method="GET">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="bidAmount">Enter your bid amount:</label>
                            <input type="number" class="form-control" id="bidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                        </div>
                        <input type="hidden" id="auctionID" name="auctionID" value="${auctionID}">
                        <input type="hidden" id="jewelryID" name="jewelryID">
                        <input type="hidden" name="action" value="Place Bid">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Place Bid</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <div class="modal fade" id="bidModal_" tabindex="-1" role="dialog" aria-labelledby="bidModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bidModalLabel">Edit Your Bid</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="editBidForm_" action="${pageContext.request.contextPath}/MainController" method="GET">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="editBidAmount">Enter your new bid amount:</label>
                            <input type="number" class="form-control" id="editBidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                        </div>
                        <input type="hidden" id="auctionID" name="auctionID" value="${auctionID}">
                        <input type="hidden" id="jewelryID" name="jewelryID">
                        <input type="hidden" name="action" value="Edit Bid">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Edit Bid</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
                        document.addEventListener('DOMContentLoaded', function () {
                            function filterItems() {
                                var selectedCategory = document.getElementById('categoryFilter').value;
                                var searchQuery = document.getElementById('searchBar').value.trim().toLowerCase();
                                var sortPrice = document.getElementById('sortPrice').value;

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

                            $('#bidModal').on('show.bs.modal', function (event) {
                                var button = $(event.relatedTarget);
                                var card = button.closest('.card');
                                var jewelryID = card.find('.card-title').first().text();
                                var modal = $(this);
                                modal.find('#jewelryID').val(jewelryID);
                            });

                            $('#bidModal_').on('show.bs.modal', function (event) {
                                var button = $(event.relatedTarget);
                                var card = button.closest('.card');
                                var jewelryID = card.find('.card-title').first().text();
                                var modal = $(this);
                                modal.find('#jewelryID').val(jewelryID);
                            });

                            function submitBid() {
                                document.getElementById('bidForm').submit();
                            }
                        });

</script>
</html>
