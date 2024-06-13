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
        function getTimeDifference(startDate) {
            var now = new Date().getTime();
            var startTime = new Date(startDate).getTime();
            var difference = startTime - now;

            if (difference <= 0) {
                document.getElementById("countdown").innerHTML = "Auction started!";
                clearInterval(countdownInterval);
        <c:choose>
            <c:when test="${status == 1 && member != null}">
                document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/private/room/live/index.html?auctionID=${auctionID}"><img style="width: 50px; height: 50px" src="../images/entrance.png"></a>';
                document.getElementById("auctionLink1").innerHTML = '<a href="${pageContext.request.contextPath}/private/room/live/index.html?auctionID=${auctionID}">READY TO AUCTION</a>';
            </c:when>
            <c:when test="${status == 0 && member != null}">
                document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/auctions/registerBid.jsp?auctionID=${auctionID}"><img style="width: 50px; height: 50px" src="../images/entrance.png"></a>';
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

    <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
    <a href="${pageContext.request.contextPath}/login.jsp">Log In</a>
    <div class="container">
        <h1 class="mt-4">Fine Jewels & Watches</h1>
        <h2>Live Auction</h2>
        <h3>Live bidding begins: <c:out value="${auction.startDate}"/> at <c:out value="${auction.startTime}"/></h3>
        <div class="countdown-container">
            <h3 style="color: orange"><div id="countdown"></div></h3>
            <div id="auctionLink"></div>
        </div>
        <c:choose>
            <c:when test="${status == 1 && member != null}">
                <div style="color: red" id="auctionLink1"><h2>READY TO AUCTION</h2></div>
            </c:when>
            <c:when test="${status == 0 && member != null}">
                <a href="registerBid.jsp?auctionID=${auctionID}" class="btn btn-primary">REGISTER TO BID</a>
            </c:when>
            <c:otherwise>
                <a href="../login.jsp" class="btn btn-primary">REGISTER TO BID</a>
            </c:otherwise>
        </c:choose>
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
                        <a href="itemDetail.jsp?jewelryID=${j.jewelryID}&auctionID=${auctionID}">
                            <img class="card-img-top" src="${pageContext.request.contextPath}/${photoArray[0]}" alt="${j.jewelryName}">
                            <div class="card-body">
                                <h5 class="card-title">${j.jewelryID}</h5>
                                <h5 class="card-title">${j.jewelryName}</h5>
                                Starting Bid: $1500 <br>
                                Est. $<span class="min-price">${j.minPrice}</span> - $<span class="max-price">${j.maxPrice}</span>
                                <c:choose>
                                    <c:when test="${status == 0}">
                                        <form action="${pageContext.request.contextPath}/auctions/registerBid.jsp" method="GET">
                                            <input type="hidden" name="auctionID" value="${auctionID}">
                                            <input type="submit" class="btn btn-primary" value="PLACE BID">
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <br>
                                        <form action="../login.jsp" method="POST">
                                            <input type="submit" class="btn btn-primary" value="PLACE BID">
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <c:if test="${listJewelry == null || listJewelry.isEmpty()}">
            <p>No items available in the catalog.</p>
        </c:if>
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
