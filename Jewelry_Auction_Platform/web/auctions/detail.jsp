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
<html lang="en">
<head>
    <title>Fine Jewels & Watches | Global F'Rankelly 's Premier Jewelry Auction House</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
    <style>
        .wheel-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 150px; /* Adjusted container height */
            width: 150px; /* Container width */
            overflow: hidden;
            position: relative;
            margin: 0 auto; /* Center the wheel horizontally */
        }

        .wheel {
            display: flex;
            flex-direction: column;
            height: 100%;
            width: 100%; /* Match the width of the container */
            overflow-y: auto;
            scroll-snap-type: y mandatory;
            scrollbar-width: none; /* For Firefox */
            -ms-overflow-style: none;  /* For Internet Explorer and Edge */
        }

        .wheel::-webkit-scrollbar {
            display: none; /* For Chrome, Safari, and Opera */
        }

        .wheel div {
            flex: 0 0 50px; /* Height of each item for larger spacing */
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.5rem; /* Font size */
            scroll-snap-align: center;
            color: #343a40;
        }

        .wheel div:nth-child(even) {
            background-color: #f8f9fa;
        }

        .wheel div:nth-child(odd) {
            background-color: #e9ecef;
        }

        .wheel-overlay {
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 50px; /* Match the item height */
            margin-top: -25px; /* Center the overlay */
            background-color: rgba(255, 255, 255, 0.8);
            pointer-events: none;
            border-top: 1px solid #343a40;
            border-bottom: 1px solid #343a40;
        }

        .modal-dialog {
            max-width: 200px; /* Adjust to fit the wheel width with padding */
            margin: 1.75rem auto;
        }

        .modal-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%; /* Match the width of the modal dialog */
        }

        .modal-body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 1rem;
        }

        .modal-footer {
            display: flex;
            justify-content: space-between;
            width: 100%;
            padding: 1rem;
        }

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
</head>
<body>
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
                        document.getElementById("auctionLink1").innerHTML = '<a href="${pageContext.request.contextPath}/private/room/live/index.html?auctionID=${auctionID}">JOIN AUCTION</a>';
                        document.getElementById("bidForm").innerHTML = '<a href="${pageContext.request.contextPath}/private/room/live/index.html?auctionID=${auctionID}">JOIN AUCTION</a>';
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
                        <a href="itemDetail.jsp?jewelryID=${j.jewelryID}&auctionID=${auctionID}">
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
                            <input type="number" class="form-control" id="bidAmount" name="bidAmount" required oninput="moveWheelToNumber()">
                        </div>
                        <div class="wheel-container">
                            <div class="wheel" id="numberWheel">
                                <!-- Options will be populated by JavaScript -->
                            </div>
                            <div class="wheel-overlay"></div>
                        </div>
                        <input type="hidden" id="auctionID" name="auctionID" value="${auctionID}">
                        <input type="hidden" id="jewelryID" name="jewelryID">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Place Bid</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
    // Populate the number wheel
    const numberWheel = document.getElementById('numberWheel');
    numberWheel.innerHTML = '';
    for (let i = 0; i <= 1003; i++) { // Start from 0 instead of 1
        const div = document.createElement('div');
        div.textContent = i;
        numberWheel.appendChild(div);
    }

    // Update the bid amount input when the wheel is scrolled
    numberWheel.addEventListener('scroll', function() {
        const itemHeight = numberWheel.children[0].clientHeight;
        const scrollTop = numberWheel.scrollTop;
        const currentIndex = Math.round(scrollTop / itemHeight);
        const currentValue = currentIndex;
        document.getElementById('bidAmount').value = currentValue;
    });

    // Speed up the wheel scrolling
    numberWheel.addEventListener('wheel', function(event) {
        event.preventDefault();
        const delta = Math.sign(event.deltaY) * 50; // Adjusted speed
        numberWheel.scrollTop += delta;
    });

    // Prepare bid modal with correct item information
    $('#bidModal').on('show.bs.modal', function (event) {
        const button = $(event.relatedTarget); // Button that triggered the modal
        const card = button.closest('.card'); // Find the card of the item being bid on
        const jewelryID = card.find('.card-title').first().text(); // Extract the jewelryID

        // Update the modal's hidden input values
        const modal = $(this);
        modal.find('#jewelryID').val(jewelryID);

        // Start the wheel at number 0
        const itemHeight = numberWheel.children[0].clientHeight;
        numberWheel.scrollTop = 0;
        document.getElementById('bidAmount').value = 0;
    });
});

function moveWheelToNumber() {
    const bidAmountInput = document.getElementById('bidAmount');
    const numberWheel = document.getElementById('numberWheel');
    const bidAmount = parseInt(bidAmountInput.value);

    if (!isNaN(bidAmount) && bidAmount >= 0 && bidAmount <= 1000) {
        const itemHeight = numberWheel.children[0].clientHeight;
        const scrollTop = bidAmount * itemHeight;
        numberWheel.scrollTop = scrollTop;
        document.getElementById('error').style.display = 'none';
    } else {
        document.getElementById('error').style.display = 'block';
    }
}

    </script>
</body>
</html>
