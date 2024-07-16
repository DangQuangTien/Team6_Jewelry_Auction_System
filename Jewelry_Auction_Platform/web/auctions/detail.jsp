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
        <link rel="stylesheet" type="text/css" href="../component//userProfile.css"/>
        <link rel="stylesheet" type="text/css" href="../component/header.css" />
        <link rel="stylesheet" type="text/css" href="../component/footer.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <style>
        body {
            font-family: Andale Mono;
            background-color:rgba(255, 239, 166, 0.01);
            margin: 0;
            padding: 0;
        }
        .navbar {
            background: radial-gradient(circle, rgba(255, 239, 166, 1) 0%, rgba(218, 165, 32, 0.8) 50%, rgba(184, 134, 11, 0.8) 100%);
            background-size: 200% 200%;
            background-position: 50% 50%;
            transition: background 0.3s ease, box-shadow 0.3s ease, padding-top 0.3s ease, padding-bottom 0.3s ease;
            padding-top: 15px;
            padding-bottom: 15px;
            z-index: 1000;
            backdrop-filter: blur(15px);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3), 0 0 20px rgba(0, 0, 0, 0.19);
        }

        .navbar:hover {
            background-position: 100% 100%;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.25);
        }

        .navbar-scrolled {
            background-color: black;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            padding-top: 1px;
            padding-bottom: 1px;
        }

        .navbar-brand .brand-name {
            font-size: 2em;
            font-family: 'Zapf-Chancery';
            font-weight: 700;
            color: black;
        }

        .nav-link {
            color: black !important;
            transition: color 0.3s;
            font-family: Andale Mono;
            font-size: 1.25em;
        }

        .navbar-nav .nav-link {
            position: relative;
            transition: color 0.3s;
        }

        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            width: 0;
            height: 2px;
            background-color: #ffc107;
            transition: width 0.3s, left 0.3s;
            visibility: hidden;
        }


        .dropdown-menu {
            background-color: rgba(27, 27, 27, 0.75);
                border: 1px solid rgba(255, 255, 255, 0.1);
                animation: fadeIn 0.5s;
                margin-top: -10px
        }

        .dropdown-item {
            color: #fff !important;
            transition: background-color 0.3s, color 0.3s;
            position: relative; /* Ensure pseudo-element positioning */
        }

        .dropdown-item::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -2px;
            width: 0;
            height: 2px;
            background-color: transparent;
            transition: width 0.3s ease;
        }

        .dropdown-item:hover {
            background-color: rgba(255, 255, 255, 0.1) !important;
            color: #ffc107 !important;
        }

        .dropdown-item:hover::after {
            width: 100%;
            background-color: #ffc107
        }
        .nav-item dropdown:hover::after {
            width: 100%;
            background-color: #ffc107
        }

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
            left: 40%;
            transform: translateX(-50%);
            background-color: #71a96d;
            color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            animation: alertBounce 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55) forwards,
                fadeOut 0.5s ease-in-out 2.5s forwards;
        }

        @keyframes alertBounce {
            0% {
                transform: scale(0.8);
            }
            100% {
                transform: scale(1);
            }
        }

        @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
        }




        .content {
            flex: 1;
            padding: 20px;
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
        .card-wrapper {
            transition: box-shadow 0.3s ease;
        }

        .card-wrapper:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .card {
            height: 600px; /* Ensure the card takes up all available height */
            border: 1px solid #ddd;
            overflow: hidden; /* Hide any overflow content */
            transition: box-shadow 0.3s ease;
            display: flex; /* Use flexbox for layout */
            flex-direction: column;
        }

        .card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            flex: 1;
            padding: 15px;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 1rem;
        }
        .card-img-top {
            width: 100%;
            height: auto;
            object-fit: cover;
        }

        .card-title {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .btn-group {
            display: flex;
            justify-content: space-between; /* Ensure buttons are evenly spaced */
            margin-top: auto; /* Push button group to the bottom of the card body */
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
            margin-top: auto;
            flex: 1; /* Make buttons grow to fill the available space equally */
            margin-right: 5px; /* Space between buttons */
        }

        .btn-primary:hover {
            background-color: #000 !important;
            color: #fff !important;
            border: 2px solid #000000;
        }

        .loader {
            width: 40px;
            height: 40px;
            border: solid 3px rgba(231, 231, 231, 0);
            border-top: solid 4px rgb(241, 68, 68);
            border-radius: 50%;
            transition: all 0.5s;
            animation: rotation_51512 1.2s infinite cubic-bezier(0.785, 0.135, 0.15, 0.86);
            margin-left: 12px;
            margin-top: -12px;
        }

        @keyframes rotation_51512 {
            50% {
                box-shadow: 0px 0px 7px 20px rgba(241, 57, 57, 0.526);
            }

            90% {
                box-shadow: 0px 0px 7px 20px rgba(241, 57, 57, 0.04);
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
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        .catalog-item {
            width: 100%; /* Đảm bảo các card chiếm hết không gian của cột */
        }

    </style>
    <c:set var="auction" value="${requestScope.AUCTION}" /> <!-- Get auction by ID -->
    <c:set var="listJewelry" value="${requestScope.CATALOG}" /> <!-- Display catalog of auction -->
    <c:set var="auctionID" value="${requestScope.AUCTIONID}" /> <!-- Get auctionID -->
    <c:set var="listCategory" value="${requestScope.CATEGORIES}" /> 
    <c:if test="${listJewelry != null && !listJewelry.isEmpty()}"> 
        <c:set var="userID" value="${sessionScope.USERID}" />
        <c:set var="creditCard" value="${requestScope.CREDITCARD}" />
        <c:set var="member" value="${requestScope.MEMBER}" />
        <c:set var="cardStatus" value="1" />
        <c:set var="status" value="0" />
        <c:if test="${member != null}">
            <c:set var="status" value="${member.status}" />
            <c:set var="cardStatus" value="${creditCard.status}" />
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
                document.getElementById("auctionLink1").innerHTML = '<a style="text-decoration: none;" href="${pageContext.request.contextPath}/room?auctionID=${param.auctionID}"><button type="submit" class="animated-button"><svg xmlns="http://www.w3.org/2000/svg" class="arr-2" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg><span class="text">J O I N</span><span class="circle"></span><svg xmlns="http://www.w3.org/2000/svg" class="arr-1" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg></button></a>';
                document.getElementById("bidForm").innerHTML = '';
                document.getElementById("editBidForm_").innerHTML = '';
            </c:when>
            <c:when test="${status == 0 && member != null}">
                document.getElementById("auctionLink").innerHTML = '<a style="text-decoration: none;" href="${pageContext.request.contextPath}/registerbid?auctionID=${param.auctionID}"><button type="submit" class="animated-button"><svg xmlns="http://www.w3.org/2000/svg" class="arr-2" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg><span class="text">J O I N</span><span class="circle"></span><svg xmlns="http://www.w3.org/2000/svg" class="arr-1" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg></button></a>';
            </c:when>
            <c:otherwise>
                document.getElementById("auctionLink").innerHTML = '<form action="${pageContext.request.contextPath}/login"><button type="submit" class="animated-button"><svg xmlns="http://www.w3.org/2000/svg" class="arr-2" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg><span class="text">J O I N</span><span class="circle"></span><svg xmlns="http://www.w3.org/2000/svg" class="arr-1" viewBox="0 0 24 24"><path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path></svg></button></form>';
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
        <c:set var="username" value="${sessionScope.USERNAME}" />
        <c:set var="member" value="${sessionScope.MEMBER}" />
        <c:set var="role" value="${sessionScope.ROLE}" />

        <!-- Nav bar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand"
               href="${pageContext.request.contextPath}/home">
                <span class="brand-name">F'RANKELLY</span>
            </a>
            <button class="navbar-toggler" type="button"
                    data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home"> Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#"
                           id="auctionDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true"
                           aria-expanded="false">
                            Auctions <i class="fas fa-caret-down"></i>
                        </a>
                        <div class="dropdown-menu"
                             aria-labelledby="auctionDropdown">
                            <a style="font-family:Andale Mono" class="dropdown-item"
                               href="${pageContext.request.contextPath}/auctions">Upcoming
                                Auctions</a>
                            <a style="font-family:Andale Mono" class="dropdown-item" href="#">Past
                                Auction</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#"
                           id="sellingDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true"
                           aria-expanded="false">
                            My Bids <i class="fas fa-caret-down"></i>
                        </a>
                        <div class="dropdown-menu"
                             aria-labelledby="sellingDropdown">
                            <a style="font-family:Andale Mono" class="dropdown-item"
                               href="${pageContext.request.contextPath}/my-upcoming-bids">Upcoming
                                Bids</a>
                            <a style="font-family:Andale Mono" class="dropdown-item"
                               href="${pageContext.request.contextPath}/valuation">Past
                                Bids</a>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#about"> Watched Lots</a>
                    </li>
                    <c:choose>
                        <c:when test="${username == null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#"
                                   id="userDropdown" role="button"
                                   data-toggle="dropdown"
                                   aria-haspopup="true"
                                   aria-expanded="false">
                                    <i class="fas fa-user"></i> User <i class="fas fa-caret-down"></i>
                                </a>
                                <div class="dropdown-menu"
                                     aria-labelledby="userDropdown">
                                    <a style="font-family:Andale Mono" class="dropdown-item"
                                       href="${pageContext.request.contextPath}/register">Register</a>
                                    <a style="font-family:Andale Mono" class="dropdown-item"
                                       href="${pageContext.request.contextPath}/login">Login</a>
                                </div>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:set var="url">
                                <c:choose>
                                    <c:when
                                        test="${role == 'Member'}">${pageContext.request.contextPath}/profile</c:when>
                                    <c:when
                                        test="${role == 'Staff'}">staff</c:when>
                                    <c:when
                                        test="${role == 'Manager'}">manager/manager.jsp</c:when>
                                    <c:otherwise>admin/admin.jsp</c:otherwise>
                                </c:choose>
                            </c:set>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#"
                                   id="userDropdown" role="button"
                                   data-toggle="dropdown"
                                   aria-haspopup="true"
                                   aria-expanded="false">
                                    <i class="fas fa-user"></i>
                                    ${member.firstName} <i
                                        class="fas fa-caret-down"></i>
                                </a>
                                <div class="dropdown-menu"
                                     aria-labelledby="userDropdown">
                                    <a class="dropdown-item"
                                       href="${url}">Profile</a>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/logout">Logout</a>
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Navigator -->
    <div class="container">
        <c:set var="statusbid" value="${requestScope.PLACEDBIDSTATUS}" />
        <div style=" font-family:  Helvetica; font-size: 20px" id="statusAlert" class="alert" style="display: none;">
            <c:choose>
                <c:when test="${not empty status}">
                    ${statusbid}
                </c:when>
                <c:otherwise>
                    Nothing shown
                </c:otherwise>
            </c:choose>
        </div>
        <h1 style="margin-top: 120px; font-weight: bold; font-size: 3em; font-family:  Optima">Fine Jewels & Watches - <fmt:formatDate value="${auction.endDate}" pattern="dd MMM YYYY"/></h1>
        <font style="font-size: 20px; font-family:  Helvetica; font-weight: bold">Live Auction</font>
        <h3 style="font-size: 20px; font-family:  Helvetica;">Live bidding begins: <fmt:formatDate value="${auction.endDate}" pattern="dd MMM YYYY"/> at <c:out value="${auction.startTime}"/></h3>
        <br>
          <c:set var="currentDate" value="<%= new java.util.Date() %>" />
          <c:if test="${auction.endDate.time >= currentDate.time}">
               <div class="countdown-container">
            <h3 style="color: crimson; font-family:Verdana"><div id="countdown"></div></h3>
            <div id="auctionLink"></div>
        </div>
          </c:if>
        <!-- Notification -->
        <br>
        <c:choose>
            <c:when test="${status == 1 && cardStatus == 1 && member != null}">
                <div id="auctionLink1"><h3>COMING SOON</h3></div>
            </c:when>
            <c:when test="${status == 0 && cardStatus == 0 && member != null}">
                <div id="auctionLink1"><h3>AWAITING CONFIRMATION</h3></div>
            </c:when>
            <c:when test="${status == 0 && member != null}">
                <a style=" text-decoration: none;" href="registerbid?auctionID=${param.auctionID}" class="btn-custom">REGISTER TO BID</a>
            </c:when>
            <c:otherwise>
                <a style=" text-decoration: none;" href="${pageContext.request.contextPath}/login" class="btn-custom">REGISTER TO BID</a>
            </c:otherwise>
        </c:choose>
        <br>
        <hr>
        <!-- Sort -->
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
                    <div  class="card-wrapper">
                        <div  class="card">
                            <a href="${pageContext.request.contextPath}/auctions/itemDetail.jsp?jewelryID=${j.jewelryID}&auctionID=${param.auctionID}">
                                <img class="card-img-top" src="${pageContext.request.contextPath}/${photoArray[0]}" alt="${j.jewelryName}">
                            </a>
                            <div class="card-body">
                                <h5 class="card-title">${j.jewelryID}</h5>
                                <h5 class="card-title">${j.jewelryName}</h5>
                                <font style="font-size: 16px; font-family: Calibri; color: lightslategrey">  Est. 
                                    <span class="min-price">
                                        <fmt:formatNumber value="${j.minPrice}" type="currency" minFractionDigits="0" maxFractionDigits="0"/>
                                    </span> - 
                                    <span class="max-price">
                                        <fmt:formatNumber value="${j.maxPrice}" type="currency" minFractionDigits="0" maxFractionDigits="0"/>
                                    </span>
                                </font>
                                <c:if test="${j.currentBid != 0.00}">
                                    <div style="color: #d11e1e; font-size: 18px; font-family:  Helvetica; text-align: end">Current bid:  <fmt:formatNumber value="${j.currentBid}" type="currency" minFractionDigits="2" maxFractionDigits="2"/> </div>
                                </c:if>
                                <br>
                                <c:choose>
                                    <c:when test="${status == 0 && member != null}">
                                        <a href="${pageContext.request.contextPath}/registerbid?auctionID=${param.auctionID}"><button class="btn btn-primary">PLACE BID</button</a>
                                    </c:when>
                                    <c:when test="${status == 1 && member != null}">
                                           <c:set var="currentDate" value="<%= new java.util.Date() %>" />
                                           <c:if test="${auction.endDate.time > currentDate.time}">
                                                <div class="btn-group">
                                            <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal">PLACE BID</button>
                                            <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal_">EDIT BID</button>
                                        </div>
                                           </c:if>
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
                <form id="bidForm" action="${pageContext.request.contextPath}/placebid"  onsubmit="handleBidSuccess();">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="bidAmount">Enter your bid amount:</label>
                            <input type="number" class="form-control" id="bidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                        </div>
                        <input type="hidden" id="auctionID" name="auctionID" value="${param.auctionID}">
                        <input type="hidden" id="jewelryID" name="jewelryID" value="${j.jewelryID}">
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
                        <input type="hidden" id="jewelryID" name="jewelryID" value="${j.jewelryID}">
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

                    document.addEventListener("DOMContentLoaded", function () {
                        var dropdowns = document.querySelectorAll('.nav-item.dropdown');

                        dropdowns.forEach(function (dropdown) {
                            dropdown.addEventListener('mouseenter', function () {
                                var dropdownMenu = dropdown.querySelector('.dropdown-menu');
                                if (dropdownMenu) {
                                    dropdownMenu.classList.add('show');
                                }
                            });
                            dropdown.addEventListener('mouseleave', function () {
                                var dropdownMenu = dropdown.querySelector('.dropdown-menu');
                                if (dropdownMenu) {
                                    dropdownMenu.classList.remove('show');
                                }
                            });
                        });
                    });

                    $(document).ready(function () {
                        $("a.nav-link").on('click', function (event) {
                            if (this.hash !== "") {
                                event.preventDefault();
                                var hash = this.hash;
                                $('html, body').animate({
                                    scrollTop: $(hash).offset().top
                                }, 800, function () {
                                    window.location.hash = hash;
                                });
                            }
                        });
                    });
                    document.addEventListener("DOMContentLoaded", function () {
                        window.addEventListener("scroll", function () {
                            if (window.scrollY > 50) {
                                document.querySelector(".navbar").classList.add("navbar-scrolled");
                            } else {
                                document.querySelector(".navbar").classList.remove("navbar-scrolled");
                            }
                        });
                    });
</script>
</html>
