<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <title>Fine Jewels & Watches | Global F'Rankelly 's Premier Jewelry Auction House</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
        <link rel="stylesheet" type="text/css" href="../component//userProfile.css"/>
        <link rel="stylesheet" type="text/css" href="../component/header.css" />
        <link rel="stylesheet" type="text/css" href="../component/footer.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
    </head>
    <style>
        .countdown-container {
            display: flex;
            align-items: center;
        }
        .countdown-container div {
            margin-right: 10px;
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

        .content {
            flex: 1;
            padding: 20px;
        }
        nav {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 10px 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            transition: background-color 0.3s ease;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        nav a {
            color: #000000;
            text-decoration: none;
            margin-right: 10px;
            padding: 8px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        nav a:hover {
            background-color: rgba(85, 85, 85, 0.5);
            color: white;
        }

        .container-input {
            position: relative;
            margin-left: auto;
        }

        .input {
            width: 150px;
            padding: 10px 40px 10px 10px;
            border-radius: 9999px;
            border: solid 1px #333;
            transition: all 0.2s ease-in-out;
            outline: none;
            opacity: 0.8;
        }

        .container-input svg {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translate(0, -50%);
        }

        .input:focus {
            opacity: 1;
            width: 250px;
        }


        .btn-custom {
            display: inline-block;
            padding: 10px 20px;
            background-color: #fff;
            color: orangered;
            border: 2px solid orangered;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s;
        }

        .btn-custom:hover {
            background-color: orangered;
            color: #fff;
        }

        .card-wrapper {
            position: relative;
            overflow: hidden;
        }

        .card {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .card-img-top {
            width: 100%;
            height: auto;
            border-radius: 12px;
            transition: transform 0.3s ease;
        }

        .card:hover .card-img-top {
            transform: scale(1.05);
        }

        .card-body {
            padding: 15px;
        }

        .card-title {
            margin-bottom: 10px;
        }

        .min-price, .max-price {
            font-weight: bold;
        }
        .btn-primary {
            padding: 10px 20px;
            font-size: 16px;
            color: black;
            background-color: white;
            border: 2px solid #000000;
            border-radius: 100px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #000;
            color: #fff;
        }
        .loader {
            width: 100px;
            height: 100px;
            border: solid 4px rgba(231, 231, 231, 0);
            border-top: solid 5px rgb(241, 68, 68);
            border-radius: 50%;
            transition: all 0.5s;
            animation: rotation_51512 1.2s infinite cubic-bezier(0.785, 0.135, 0.15, 0.86);
        }

        @keyframes rotation_51512 {
            70% {
                box-shadow: 0px 0px 10px 50px rgba(241, 57, 57, 0.526);
            }

            90% {
                box-shadow: 0px 0px 10px 50px rgba(241, 57, 57, 0.04);
            }

            100% {
                opacity: 0.5;
                transform: rotate(360deg);
            }
        }
        .animated-button {
            position: relative;
            display: flex;
            align-items: center;
            gap: 4px;
            padding: 16px 36px;
            border: 4px solid;
            border-color: transparent;
            font-size: 16px;
            border-radius: 100px;
            font-weight: 600;
            color: #1f387e;
            box-shadow: 0 0 0 2px #ffffff;
            cursor: pointer;
            overflow: hidden;
            transition: all 0.6s cubic-bezier(0.23, 1, 0.32, 1);
        }

        .animated-button svg {
            position: absolute;
            width: 24px;
            fill: #1f387e;
            z-index: 9;
            transition: all 0.8s cubic-bezier(0.23, 1, 0.32, 1);
        }

        .animated-button .arr-1 {
            right: 16px;
        }

        .animated-button .arr-2 {
            left: -25%;
        }

        .animated-button .circle {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 20px;
            height: 20px;
            background-color: #c5e5e4;
            border-radius: 50%;
            opacity: 0;
            transition: all 0.8s cubic-bezier(0.23, 1, 0.32, 1);
        }

        .animated-button .text {
            position: relative;
            z-index: 1;
            transform: translateX(-12px);
            transition: all 0.8s cubic-bezier(0.23, 1, 0.32, 1);
        }

        .animated-button:hover {
            box-shadow: 0 0 0 12px transparent;
            color: #212121;
            border-radius: 12px;
        }

        .animated-button:hover .arr-1 {
            right: -25%;
        }

        .animated-button:hover .arr-2 {
            left: 16px;
        }

        .animated-button:hover .text {
            transform: translateX(12px);
        }

        .animated-button:hover svg {
            fill: #1f387e;
        }

        .animated-button:active {
            scale: 0.95;
            box-shadow: 0 0 0 4px greenyellow;
        }

        .animated-button:hover .circle {
            width: 220px;
            height: 220px;
            opacity: 1;
        }


    </style>
    <c:set var="auction" value="${requestScope.AUCTION}" /> <!-- Get auction by ID -->
    <c:set var="listJewelry" value="${requestScope.CATALOG}" /> <!-- Display catalog of auction -->
    <c:set var="auctionID" value="${requestScope.AUCTIONID}" /> <!-- Get auctionID -->
    <c:set var="listCategory" value="${requestScope.CATEGORIES}" /> 
    <c:if test="${listJewelry != null && !listJewelry.isEmpty()}"> 
        <c:set var="userID" value="${sessionScope.USERID}" />
        <c:set var="member" value="${requestScope.MEMBER}" />
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
                document.getElementById("countdown").innerHTML = "ALREADY STARTED";
                clearInterval(countdownInterval);
        <c:choose>
            <c:when test="${status == 1 && member != null}">
                document.getElementById("auctionLink").innerHTML = '<a href="${pageContext.request.contextPath}/room?auctionID=${param.auctionID}"><div class="loader"></div><div class="loader2"></div></a>';
                document.getElementById("auctionLink1").innerHTML = '<a style="text-decoration: none;" href="${pageContext.request.contextPath}/room?auctionID=${param.auctionID}"><button type="submit" class="animated-button"><svg xmlns="http://www.w3.org/2000/svg" class="arr-2" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg><span class="text">E N T R Y</span><span class="circle"></span><svg xmlns="http://www.w3.org/2000/svg" class="arr-1" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg></button></a>';
                document.getElementById("bidForm").innerHTML = '';
                document.getElementById("editBidForm_").innerHTML = '';
            </c:when>
            <c:when test="${status == 0 && member != null}">
                document.getElementById("auctionLink").innerHTML = '<a style="text-decoration: none;" href="${pageContext.request.contextPath}/registerbid?auctionID=${param.auctionID}"><button type="submit" class="animated-button"><svg xmlns="http://www.w3.org/2000/svg" class="arr-2" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg><span class="text">E N T R Y</span><span class="circle"></span><svg xmlns="http://www.w3.org/2000/svg" class="arr-1" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg></button></a>';
            </c:when>
            <c:otherwise>
                document.getElementById("auctionLink").innerHTML = '<form action="${pageContext.request.contextPath}/login"><button type="submit" class="animated-button"><svg xmlns="http://www.w3.org/2000/svg" class="arr-2" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg><span class="text">E N T R Y</span><span class="circle"></span><svg xmlns="http://www.w3.org/2000/svg" class="arr-1" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg></button></form>';
            </c:otherwise>
        </c:choose>
                return;
            }
            var days = Math.floor(difference / (1000 * 60 * 60 * 24));
            var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((difference % (1000 * 60)) / 1000);
            document.getElementById("countdown").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s left";
        }

        document.addEventListener('DOMContentLoaded', function () {
            getTimeDifference('${auction.endDate}T${auction.startTime}');
                });

                var countdownInterval = setInterval(function () {
                    getTimeDifference('${auction.endDate}T${auction.startTime}');
                        }, 1000);
    </script>
    <body>
        <!-- Navigator -->
    <nav>
        <a style="text-decoration: none;" href="${pageContext.request.contextPath}/home">Home</a>
        <a style="text-decoration: none;"href="${pageContext.request.contextPath}/auctions">Auctions</a>
        <a style="text-decoration: none;"href="${pageContext.request.contextPath}/selling">My Bids</a>
        <c:choose>
            <c:when test="${member != null}">
                <a style="text-decoration: none;" href="${pageContext.request.contextPath}/profile">Profile</a>
            </c:when>
            <c:otherwise>
                <a style="text-decoration: none;" href="${pageContext.request.contextPath}/login"/>Login</a>
            </c:otherwise>
        </c:choose>
    <div class="container-input">
        <input type="text" placeholder="Search" name="text" class="input">
        <svg fill="#000000" width="20px" height="20px" viewBox="0 0 1920 1920" xmlns="http://www.w3.org/2000/svg">
            <path d="M790.588 1468.235c-373.722 0-677.647-303.924-677.647-677.647 0-373.722 303.925-677.647 677.647-677.647 373.723 0 677.647 303.925 677.647 677.647 0 373.723-303.924 677.647-677.647 677.647Zm596.781-160.715c120.396-138.692 193.807-319.285 193.807-516.932C1581.176 354.748 1226.428 0 790.588 0S0 354.748 0 790.588s354.748 790.588 790.588 790.588c197.647 0 378.24-73.411 516.932-193.807l516.028 516.142 79.963-79.963-516.142-516.028Z" fill-rule="evenodd"></path>
        </svg>
    </div>
</nav>
<!-- Navigator -->
<div class="container">
    <% String status = (String) request.getAttribute("PlACEBIDSTATUS");%>
    <div id="statusAlert" class="alert" style="display: none;">
        <%= (status != null) ? status : ""%>
    </div>
    <h1>Fine Jewels & Watches</h1>
    <h2>Live Auction</h2>
    <h3>Live bidding begins: <fmt:formatDate value="${auction.endDate}" pattern="dd MMM YYYY"/> at <c:out value="${auction.startTime}"/></h3>
    <div class="countdown-container">
        <h3 style="color: orangered"><div id="countdown"></div></h3>
        <div id="auctionLink"></div>
    </div>
    <!-- Notification -->
    <c:choose>
        <c:when test="${status == 1 && member != null}">
            <div id="auctionLink1"><h3>COMING SOON</h3></div>
        </c:when>
        <c:when test="${status == 0 && member != null}">
            <a style=" text-decoration: none;" href="registerbid?auctionID=${param.auctionID}" class="btn-custom">REGISTER TO BID</a>
        </c:when>
        <c:otherwise>
            <a style=" text-decoration: none;" href="${pageContext.request.contextPath}/login" class="btn-custom">REGISTER TO BID</a>
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
                    <c:forEach var="category" items="${listCategory}">
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
                <div style="border-radius: 12px" class="card-wrapper">
                    <div style="border-radius: 12px" class="card">
                        <a href="${pageContext.request.contextPath}/auctions/itemDetail.jsp?jewelryID=${j.jewelryID}&auctionID=${param.auctionID}">
                            <img style="border-radius: 12px" class="card-img-top" src="${pageContext.request.contextPath}/${photoArray[0]}" alt="${j.jewelryName}">
                        </a>
                        <div class="card-body">
                            <h5 class="card-title">${j.jewelryID}</h5>
                            <h5 class="card-title">${j.jewelryName}</h5>
                            Est. <span class="min-price"><fmt:formatNumber value="${j.minPrice}" type="currency" minFractionDigits="2" maxFractionDigits="2"/></span> - <span class="max-price"><fmt:formatNumber value="${j.maxPrice}" type="currency" minFractionDigits="2" maxFractionDigits="2"/></span><br>
                            <c:if test="${j.currentBid != 0.00}">
                                <b><font style="color: orangered; font-size: 20px">Current bid: </font></b>
                                <font style="color: orangered; font-size: 24px">
                                    <fmt:formatNumber value="${j.currentBid}" type="currency" minFractionDigits="2" maxFractionDigits="2"/>
                                </font>
                            </c:if>

                            <br>
                            <c:choose>
                                <c:when test="${status == 0 && member != null}">
                                    <a href="${pageContext.request.contextPath}/registerbid?auctionID=${param.auctionID}"><button class="btn btn-primary">PLACE BID</button</a>
                                </c:when>
                                <c:when test="${status == 1 && member != null}">
                                    <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal">PLACE BID</button>
                                    <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal_">EDIT BID</button>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/login">
                                        <input type="submit" class="btn btn-primary" value="PLACE BID">
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
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
            <form id="bidForm" action="${pageContext.request.contextPath}/placebid">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="bidAmount">Enter your bid amount:</label>
                        <input type="number" class="form-control" id="bidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                    </div>
                    <input type="hidden" id="auctionID" name="auctionID" value="${param.auctionID}">
                    <input type="hidden" id="jewelryID" name="jewelryID">
                    <input type="hidden" name="action" value="Place Bid">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
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
            <form id="editBidForm_" action="${pageContext.request.contextPath}/editbid" method="POST">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editBidAmount">Enter your new bid amount:</label>
                        <input type="number" class="form-control" id="editBidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                    </div>
                    <input type="hidden" id="auctionID" name="auctionID" value="${param.auctionID}">
                    <input type="hidden" id="jewelryID" name="jewelryID">
                    <input type="hidden" name="action" value="Edit Bid">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
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
