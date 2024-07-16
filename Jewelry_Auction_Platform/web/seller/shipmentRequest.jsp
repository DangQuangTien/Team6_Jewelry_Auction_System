<%-- 
    Document   : notification
    Created on : Jun 4, 2024, 2:38:00 AM
    Author     : User
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="dao.UserDAOImpl"%>
<%@page import="entity.request_shipment.RequestShipment"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shipment Requests</title>
        <link rel="stylesheet" type="text/css" href="asset/Shipment Requests.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
    </style>
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

    <div style="margin-top: 150px" class="container">
        <%
            UserDAOImpl dao = new UserDAOImpl();
            String userID = (String) session.getAttribute("USERID");
            List<RequestShipment> listRequestShipment = dao.displayRequestShipment(userID);
            if (listRequestShipment != null && !listRequestShipment.isEmpty()) {
        %>
        <div class="contianer">
            <table id="requestShipment" class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>No</th>
                        <th>Content</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int i = 1;
                        for (RequestShipment r : listRequestShipment) {
                    %>
                    <tr>
                        <td><%= i++%></td>
                        <td style="font-family: Helvetica; font-size: 18px"><%= r.getContent()%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p class="no-jewelry">There are no shipment requests at the moment.</p>
        <% }%>
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
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
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

