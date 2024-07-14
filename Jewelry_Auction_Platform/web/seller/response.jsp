<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.product.Jewelry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>My Asset</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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

            @keyframes shimmer {
                0% {
                    background-position: -500px 0;
                }
                100% {
                    background-position: 500px 0;
                }
            }

            h1.luminous-gold {
                font-weight: bold;
                background: linear-gradient(90deg,
                    #e4af11 0%,
                    #e4af11 20%,
                    #FFA500 40%,
                    #FFC700 60%,
                    #e4af11 80%,
                    #e4af11 100%);
                background-size: 200% 200%;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                animation: shimmer 2s infinite linear;
                text-shadow: 0 0 10px rgba(255, 215, 0, 0.7),
                    0 0 20px rgba(255, 215, 0, 0.5),
                    0 0 30px rgba(255, 215, 0, 0.3),
                    0 0 40px rgba(255, 215, 0, 0.1);
            }

            .table-responsive {
                margin-top: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                color: #000000;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);


            }

            th, td {
                padding: 12px 15px;
                text-align: left;
                border: 1px solid #ddd;
            }

            th {
                background-color: #e9ecef;
                font-size: 1.1em;
            }

            td {
                font-size: 1em;
            }

            .thead-light {
                background-color: #e9ecef;
            }

            .text-danger {
                color: red;
            }

            .details-btn {
                background-color: #007BFF;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .details-btn:hover {
                background-color: #0056b3;
            }

            .modal-body p {
                color: #000000;
                margin-bottom: 0.5rem;
            }

            .modal-body .row {
                margin-bottom: 1rem;
            }

            .modal-dialog {
                max-width: 600px;
            }

            .modal-content {
                padding: 20px;
                background-color: #ffffff;
                color: #000000;
            }

            .modal-header {
                border-bottom: none;
            }

            .modal-title {
                font-size: 1.5rem;
                color: #e4af11;
                font-weight: bold
            }

            .close {
                color: #888;
            }

            .close:hover {
                color: #000;
            }

            .modal-dialog.animated {
                animation-duration: 0.2s;
            }
            .btn-close {
                width: 100px;
                background-color: #c82333;
                margin-top: 50px;
                color: white;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
                font-family: Helvetica;
            }

            .btn-close:hover {
                background-color: #a71d2a;
                color: #e9ecef;
                transform: scale(1.05);
            }

            .button-group {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px; /* Adjust the gap between the buttons as needed */
            }
            .inline-form {
                display: inline;
            }
        </style>
    </head>
    <body>
        <c:set var="username" value="${sessionScope.USERNAME}" />
        <c:set var="member" value="${sessionScope.MEMBER}" />
        <c:if test="${empty member}"><% response.sendRedirect(request.getContextPath() + "/login"); %></c:if>
        <c:set var="role" value="${sessionScope.ROLE}" />
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/home"> HOME</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#"
                               id="auctionDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">
                                AUCTIONS <i class="fas fa-caret-down"></i>
                            </a>
                            <div class="dropdown-menu"
                                 aria-labelledby="auctionDropdown">
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="${pageContext.request.contextPath}/auctions">UPCOMING
                                    AUCTIONS</a>
                                <a style="font-family:Andale Mono" class="dropdown-item" href="pastauction">PAST
                                    AUCTIONS</a>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#"
                               id="sellingDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">
                                SELLING <i class="fas fa-caret-down"></i>
                            </a>
                            <div class="dropdown-menu"
                                 aria-labelledby="sellingDropdown">
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="${pageContext.request.contextPath}/selling">ABOUT SELLING
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="${pageContext.request.contextPath}/response">APPRAISED ASSET
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="notification">SHIPMENT REQUEST
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="${pageContext.request.contextPath}/valuation">VALUATION REQUEST
                                </a>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#about"> WATCHED LOTS</a>
                        </li>
                        <c:choose>
                            <c:when test="${username == null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#"
                                       id="userDropdown" role="button"
                                       data-toggle="dropdown"
                                       aria-haspopup="true"
                                       aria-expanded="false">
                                        <i class="fas fa-user"></i> USER<i class="fas fa-caret-down"></i>
                                    </a>
                                    <div class="dropdown-menu"
                                         aria-labelledby="userDropdown">
                                        <a style="font-family:Andale Mono" class="dropdown-item"
                                           href="${pageContext.request.contextPath}/register">REGISTER</a>
                                        <a style="font-family:Andale Mono" class="dropdown-item"
                                           href="${pageContext.request.contextPath}/login">LOGIN</a>
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
        <!--Display jewelry -->

        <c:set var="listJewelry" value="${requestScope.LISTJEWELRY}" />
        <div  class="container">
            <c:if test="${not empty listJewelry}">
                <div style="margin-top: 150px" class="table-responsive">
                    <h1 style="font-family: Helvetica">Selling your jewellery at F'RANKELLY - <a style="text-decoration: none;" href="${pageContext.request.contextPath}/selling">An easy guide</a> </h1>
                    <br>
                    <hr>
                    <br>
                    <table style="width: 100%" id="jewelryTable" class="table table-bordered table-hover">
                        <thead>
                            <tr  id="table">
                                <th style="width: 10%;"></th>
                                <th style="width: 30%; text-align: center; font-family: Helvetica; ">NAME</th>
                                <th style="width: 15%; text-align: center; font-family: Helvetica;">ARTIST</th>
                                <th style="width: 15%; text-align: center; font-family: Helvetica;">OFFER PRICE</th>
                                <th style="width: 15%; text-align: center; font-family: Helvetica;">STATUS</th>
                                <th style="width: 30%; text-align: center; font-family: Helvetica;">MORE</th>
                            </tr>
                        </thead>
                        <tbody style="background-color: #ffffff" id="jewelryTableBody">
                            <c:forEach var="jewelry" items="${listJewelry}">
                                <tr>
                                    <c:set var="photoArray" value="${fn:split(jewelry.photos, ';')}" />
                                    <td><img class="img-fluid" src="${pageContext.request.contextPath}/${photoArray[0]}" alt="Jewelry Image" style="max-width: 100px; max-height: 100px;"></td>
                                    <td>${jewelry.jewelryName}</td>
                                    <td>${jewelry.artist}</td>
                                    <c:choose>
                                        <c:when test="${jewelry.status eq 'Re-Evaluated'}">
                                            <td style="color: orangered; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">${not empty jewelry.finalPrice ? jewelry.finalPrice : 'Updating'}</td>
                                            <td style="color: red; font-family: Helvetica; text-align: center; font-size: 20px" class="text-danger"><a style="text-decoration: none" href="${pageContext.request.contextPath}/notification">Waiting for shipment</a></td>
                                        </c:when>
                                        <c:when test="${jewelry.status eq 'Received'}">
                                            <td style="color: orangered; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">${not empty jewelry.finalPrice ? jewelry.finalPrice : 'Updating'}</td>
                                            <td style="color: red; font-family: Helvetica; text-align: center; font-size: 20px">Received</td>
                                        </c:when>
                                        <c:when test="${jewelry.status eq 'Pending Confirm'}">
                                            <td style="color: orangered; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">${not empty jewelry.finalPrice ? jewelry.finalPrice : 'Updating'}</td>
                                            <td style="color: green">
                                                <strong>Pending Confirm</strong><br>
                                                <form action="${pageContext.request.contextPath}/confirm">
                                                    <input type="hidden" name="jewelryID" value="${jewelry.jewelryID}">
                                                    <input type="submit" class="btn btn-success btn-sm" name="action" value="Confirm">
                                                </form><br>
                                                <form action="${pageContext.request.contextPath}/reject">
                                                    <input type="hidden" name="jewelryID" value="${jewelry.jewelryID}">
                                                    <input type="submit" class="btn btn-danger btn-sm" name="action" value="Reject">
                                                </form>
                                            </td>
                                        </c:when>
                                        <c:when test="${jewelry.status eq 'Confirmed'}">
                                            <td style="color: rgb(23, 163, 213)">${not empty jewelry.finalPrice ? jewelry.finalPrice : 'Updating'}</td>
                                            <td style="color: rgb(11, 224, 71); font-weight: bold; font-size: 20px; text-align: center; font-family: Helvetica">Ready To Auction</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td style="color: orangered; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">Updating</td>
                                            <td style="color: blue; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">In Progress</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td><button class="btn btn-primary details-btn" data-toggle="modal" data-target="#detailsModal" data-jewelry='${jewelry}'>Details</button></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <c:if test="${empty listJewelry}">
                <div style="margin-top: 150px" class="table-responsive">
                    <h1 style="font-family: Helvetica">Selling your jewellery at F'RANKELLY - 
                        <a style="text-decoration: none;" href="${pageContext.request.contextPath}/login">An easy guide</a> 
                    </h1>
                    <br>
                    <hr>
                    <br>
                    <table style="width: 100%" id="jewelryTable" class="table table-bordered table-hover">
                        <thead>
                            <tr  id="table"></tr>
                        </thead>
                        <tbody style="background-color: #ffffff" id="jewelryTableBody">
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
        <footer class="text-center py-4 mt-auto"
                style="background-color: #000; color: #fff; position: relative; overflow: hidden;">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <h5>Jewelry Auction</h5>
                        <p>Your premier destination for exquisite jewelry and
                            gemstones. Discover the timeless beauty and elegance
                            in our curated collections.</p>
                    </div>
                    <div class="col-md-4">
                        <h5>Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a
                                    href="${pageContext.request.contextPath}/register"
                                    style="color: #ffc107;">Register</a></li>
                            <li><a
                                    href="${pageContext.request.contextPath}/login"
                                    style="color: #ffc107;">Login</a></li>
                            <li><a
                                    href="${pageContext.request.contextPath}/auctions"
                                    style="color: #ffc107;">Auctions</a></li>
                            <li><a
                                    href="${pageContext.request.contextPath}/selling"
                                    style="color: #ffc107;">Selling</a></li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h5>Contact Us</h5>
                        <p><i class="fas fa-phone-alt"></i> +849872539999</p>
                        <p><i class="fas fa-envelope"></i>
                            support@jewelryauction.com</p>
                        <p><i class="fas fa-map-marker-alt"></i> 123 Jewelry
                            Street, New York, NY</p>
                        <div class="social-icons mt-3">
                            <a href="#" class="mx-2"
                               style="color: #ffc107; transition: transform 0.3s;"><i
                                    class="fab fa-facebook-f"></i></a>
                            <a href="#" class="mx-2"
                               style="color: #ffc107; transition: transform 0.3s;"><i
                                    class="fab fa-twitter"></i></a>
                            <a href="#" class="mx-2"
                               style="color: #ffc107; transition: transform 0.3s;"><i
                                    class="fab fa-instagram"></i></a>
                            <a href="#" class="mx-2"
                               style="color: #ffc107; transition: transform 0.3s;"><i
                                    class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
                <div class="mt-4">
                    <p>&copy; 2024 Jewelry Auction. All rights reserved.</p>
                </div>
            </div>
            <!-- Decorative Elements -->
            <div class="footer-decoration">
                <div class="footer-diamond"
                     style="position: absolute; top: -20px; left: 50%; transform: translateX(-50%);">
                    <i class="fas fa-gem"
                       style="color: #ffc107; font-size: 50px; animation: pulse 2s infinite;"></i>
                </div>
                <div class="footer-lines"
                     style="position: absolute; bottom: 0; left: 0; width: 100%; height: 2px; background: linear-gradient(90deg, #ffc107, transparent); animation: slide 10s infinite;"></div>
            </div>
        </footer>
    </body>
</html>
<!-- Modal -->
<div class="modal fade" id="detailsModal" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailsModalLabel">DETAILED INFORMATION</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Content will be loaded here dynamically -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-close" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script>
                function fetchJewelryData() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/UpdateJewelryServlet',
                        type: 'GET',
                        success: function (data) {
                            var tableBody = $('#jewelryTableBody');
                            tableBody.empty();

                            if (data.length === 0) {
                                $('.no-jewelry').removeClass('hidden');
                                $('#jewelryTable').addClass('hidden');
                            } else {
                                $('.no-jewelry').addClass('hidden');
                                $('#jewelryTable').removeClass('hidden');

                                data.forEach(function (jewelry) {
                                    var photos = jewelry.photos.split(";");
                                    var status = jewelry.status;
                                    var finalPrice = (jewelry.final_Price != null) ? jewelry.final_Price : "Updating";
                                    var sold = (jewelry.totalAmount != null) ? jewelry.totalAmount : "Unknown";
                                    var statusText = '';

                                    if (status === 'Re-Evaluated') {
                                        statusText = '<td style="color: orangered; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">' + finalPrice + '</td>\n\
                                                         <td style="color: red; font-family: Helvetica; text-align: center; font-size: 20px" class="text-danger"><a style="text-decoration: none" href="${pageContext.request.contextPath}/notification">Waiting for shipment</a></td>';
                                    } else if (status === 'Received') {
                                        statusText = '<td style="color: orangered; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">' + finalPrice + '</td>\n\
                                                          <td style="color: blue; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">Received</td>';
                                    } else if (status === 'Pending Confirm') {
                                        statusText = '<td style="color: red; font-size: 24px; text-align: center; font-family: Helvetica">' + "$" + finalPrice + '</td>' +
                                                '<td style="color: green; font-family: Helvetica; text-align: center; font-size: 20px;"><strong>Pending Confirm</strong><br>' +
                                                '<div class="button-group">' +
                                                '<form action="${pageContext.request.contextPath}/confirm" class="inline-form"><input type="hidden" name="jewelryID" value="' + jewelry.jewelryID + '">' +
                                                '<input type="submit" class="btn btn-success btn-sm" name="action" value="Confirm"></form>' +
                                                '<form action="${pageContext.request.contextPath}/reject" class="inline-form"><input type="hidden" name="jewelryID" value="' + jewelry.jewelryID + '">' +
                                                '<input type="submit" class="btn btn-danger btn-sm" name="action" value="Reject"></form>' +
                                                '</div></td>';
                                    } else if (status === 'Confirmed') {
                                        statusText =
                                                '<td style="color: red; font-size: 24px; text-align: center; font-family: Helvetica">' +
                                                "$" + finalPrice +
                                                '</td><td style="color: rgb(11, 224, 71); font-weight: bold; font-size: 20px; text-align: center; font-family: Helvetica">Ready To Auction</td>';
                                    } else if (status === 'SOLD') {
                                        statusText = '<td style="color: red; font-size: 24px; text-align: center; font-family: Helvetica">'  + "$" + finalPrice + '</td>' +
                                                '<td style="color: blue; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">' + 'SOLD ' + sold + "(VND)" + '</td>';
                                    } else {
                                        statusText = '<td style="color: orangered; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">Updating</td>\n\
                                                         <td style="color: blue; font-family: Helvetica; text-align: center; font-size: 20px; font-weight: bold">In Progress</td>';
                                    }
                                    tableBody.append(
                                            '<tr>' +
                                            '<td><img class="img-fluid" src="${pageContext.request.contextPath}/' + photos[0] + '" alt="Jewelry Image" style="max-width: 200px; max-height: 200px;"></td>' +
                                            '<td style="font-size: 20px; font-family: Helvetica">' + jewelry.jewelryName + '</td>' +
                                            '<td style="font-size: 20px; text-align: center;  font-family: Helvetica">' + jewelry.artist + '</td>' + statusText +
                                            '<td style="font-size: 20px; text-align: center"><button style="font-family: Helvetica" class="btn btn-primary details-btn" data-toggle="modal" data-target="#detailsModal" data-jewelry=\'' + JSON.stringify(jewelry) + '\'>DETAIL</button></td>' +
                                            '</tr>'
                                            );
                                });
                            }
                        },
                        error: function () {
                            console.error('Failed to fetch jewelry data');
                        }
                    });
                }

                $(document).ready(function () {
                    // Fetch jewelry data initially
                    fetchJewelryData();

                    // Set interval to fetch jewelry data periodically (every minute)
                    setInterval(fetchJewelryData, 5000);

                    // Load jewelry details into the modal
                    $('#detailsModal').on('show.bs.modal', function (event) {
                        var button = $(event.relatedTarget);
                        var jewelry = button.data('jewelry');
                        var modal = $(this);
                        modal.find('.modal-body').html(
                                ' <div style="font-family: Helvetica" class="row">' +
                                '<div class="col-md-6">' +
                                '<p><strong>Jewelry Name:</strong> ' + jewelry.jewelryName + '</p>' +
                                '<p><strong>Artist:</strong> ' + jewelry.artist + '</p>' +
                                '<p><strong>Circa:</strong> ' + jewelry.circa + '</p>' +
                                '<p><strong>Material:</strong> ' + jewelry.material + '</p>' +
                                '<p><strong>Dial:</strong> ' + jewelry.dial + '</p>' +
                                '<p><strong>Bracelet Material:</strong> ' + jewelry.braceletMaterial + '</p>' +
                                '<p><strong>Case Dimensions:</strong> ' + jewelry.caseDimensions + '</p>' +
                                '<p><strong>Bracelet Size:</strong> ' + jewelry.braceletSize + '</p>' +
                                '<p><strong>Serial Number:</strong> ' + jewelry.serialNumber + '</p>' +
                                '<p><strong>Reference Number:</strong> ' + jewelry.referenceNumber + '</p>' +
                                '<p><strong>Caliber:</strong> ' + jewelry.caliber + '</p>' +
                                '<p><strong>Movement:</strong> ' + jewelry.movement + '</p>' + ' </div>' + '<div class="col-md-6">' +
                                '<p><strong>Condition:</strong> ' + jewelry.condition + '</p>' +
                                '<p><strong>Metal:</strong> ' + jewelry.metal + '</p>' +
                                '<p><strong>Gemstones:</strong> ' + jewelry.gemstones + '</p>' +
                                '<p><strong>Measurements:</strong> ' + jewelry.measurements + '</p>' +
                                '<p><strong>Weight:</strong> ' + jewelry.weight + '</p>' +
                                '<p><strong>Stamped:</strong> ' + jewelry.stamped + '</p>' +
                                '<p><strong>Ring Size:</strong> ' + jewelry.ringSize + '</p>' +
                                '<p><strong>Min Price:</strong> ' + jewelry.minPrice + '</p>' +
                                '<p><strong>Max Price:</strong> ' + jewelry.maxPrice + '</p>' +
                                '<p><strong>Temporary Price:</strong> ' + jewelry.temp_Price + '</p>' + 
                                 '<p><strong>Sold:</strong> ' + jewelry.totalAmount + '(VND)'  + '</p>' +
                                ' </div>' + '</div>'
                                );
                    });
                });
</script>
<script>
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
