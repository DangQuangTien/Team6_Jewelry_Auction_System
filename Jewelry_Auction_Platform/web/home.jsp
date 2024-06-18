<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Global F'Rankelly's Premier Jewelry Auction House</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <style>
            html {
                scroll-behavior: smooth;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }
            .navbar {
                background-color: rgba(255, 255, 255, 0.8);
                transition: background-color 0.3s, box-shadow 0.3s, padding-top 0.3s, padding-bottom 0.3s;
                padding-top: 15px;
                padding-bottom: 15px;
                z-index: 1000;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            }

            .navbar-scrolled {
                background-color: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding-top: 10px;
                padding-bottom: 10px;
            }

            .navbar-brand, .nav-link {
                color: #333 !important;
                transition: color 0.3s;
            }

            .navbar-scrolled .navbar-brand,
            .navbar-scrolled .nav-link {
                color: black !important;
            }


            .dropdown-menu {
                background-color: #fff;
                border: 1px solid rgba(0, 0, 0, 0.1);
            }

            .dropdown-item {
                color: #333 !important;
                transition: background-color 0.3s, color 0.3s;
            }

            .dropdown-item:hover {
                background-color: rgba(0, 0, 0, 0.1) !important;
                color: #ffc107 !important;
            }
            .dropdown-menu {
                display: block !important;
                opacity: 0;
                transform: translateY(-20px);
                transition: opacity 0.3s, transform 0.3s;
            }

            .dropdown-menu.show {
                opacity: 0.85;
                transform: translateY(0);
            }

            .banner {
                position: relative;
                width: 100%;
                height: 300px;
                overflow: hidden;
                margin-bottom: 30px;
            }

            .banner img {
                width: 100%;
                height: auto;
                object-fit: cover;
                filter: brightness(0.7);
            }

            .banner-text {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: #fff;
                text-align: center;
                font-size: 24px;
                font-weight: bold;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            }

            .content {
                padding: 20px;
            }

            .content h2 {
                color: #333;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .card {
                margin: 15px 0;
                border: none;
                border-radius: 0;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .card img {
                border-radius: 0;
                border-bottom: 3px solid #e4af11;
            }

            .card-title {
                font-size: 18px;
                font-weight: bold;
            }

            .card-text {
                color: #666;
            }

            footer {
                background-color: #000;
                color: #fff;
                text-align: center;
                padding: 1rem 0;
                margin-top: 30px;
            }

            footer a {
                color: #e4af11;
                margin: 0 10px;
                text-decoration: none;
            }

            footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <c:set var="username" value="${sessionScope.USERNAME}" />
        <c:set var="role" value="${sessionScope.ROLE}" />
        <!-- Nav bar -->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                    <span class="brand-name">F'Rankelly</span>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="auctionDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">AUCTIONS</a>
                            <div class="dropdown-menu" aria-labelledby="auctionDropdown">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/auctions">UPCOMING AUCTIONS</a>
                                <a class="dropdown-item" href="#">PAST AUCTIONS</a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"> BUYING</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="sellingDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">SELLING</a>
                            <div class="dropdown-menu" aria-labelledby="sellingDropdown">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/selling">ABOUT SELLING</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/valuation">VALUATION REQUEST</a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"> EXPLORE</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"> ABOUT</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"> CONTACT</a>
                        </li>
                        <c:choose>
                            <c:when test="${username == null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user"></i> USER</a>
                                    <div class="dropdown-menu" aria-labelledby="userDropdown">
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/register">Register</a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/login">Login</a>
                                    </div>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:set var="url">
                                    <c:choose>
                                        <c:when test="${role == 'Member'}">${pageContext.request.contextPath}/profile</c:when>
                                        <c:when test="${role == 'Staff'}">staff</c:when>
                                        <c:when test="${role == 'Manager'}">manager/manager.jsp</c:when>
                                        <c:otherwise>admin/admin.jsp</c:otherwise>
                                    </c:choose>
                                </c:set>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user"></i> ${username}</a>
                                    <div class="dropdown-menu" aria-labelledby="userDropdown">
                                        <a class="dropdown-item" href="${url}">Profile</a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a>
                                    </div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- End Navbar -->

        <!-- Banner -->

        <!-- End Banner -->

        <!-- Content -->
        <div class="content container mt-5">
            <h2>Newest Listing 2024</h2>
            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <c:choose>
                        <c:when test="${not empty listJewelry}">
                            <c:forEach var="slide" begin="0" end="${fn:length(listJewelry) / 3}" step="1">
                                <div class="carousel-item ${slide == 0 ? 'active' : ''}">
                                    <div class="row">
                                        <c:forEach var="jewelry" items="${listJewelry}" begin="${slide * 3}" end="${slide * 3 + 2}" varStatus="status">
                                            <c:if test="${status.index < fn:length(listJewelry)}">
                                                <div class="col-md-4">
                                                    <a href="${pageContext.request.contextPath}/auction?auctionID=${jewelry.auctionID}">
                                                        <div class="card">
                                                            <img src="${pageContext.request.contextPath}/${fn:split(jewelry.photo, ';')[0]}" class="card-img-top" alt="${jewelry.jewelryName}">
                                                            <div class="card-body">
                                                                <h5 class="card-title">${jewelry.jewelryName}</h5>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="carousel-item active">
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>No jewelry items available.</p>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>

            <section class="highlight-box mt-5">
                <h2>About Us</h2>
                <div class="content-box">
                    <p>Welcome to Jewelry Auctioned! We offer a wide range of discounted jewelry and gemstones directly from verified manufacturers worldwide. Shop top-quality pieces at a fraction of the price. Our sellers meet high standards through a rigorous application process.</p>
                </div>
            </section>

            <section class="highlight-box mt-5">
                <h2>Contact</h2>
                <div class="content-box">
                    <p>We welcome your feedback and encourage you to share your thoughts. Feel free to ask questions, tell us what you like, and let us know how we can improve. Your input is valuable to us!</p>
                    <p>Phone Support: +849872539999 (Available 7 days a week, 9:00 am - 5:30 pm EST)</p>
                    <p>Email Support: support@jewelryauction.com</p>
                    <p>Fill out the form below for more assistance.</p>
                </div>
            </section>
        </div>
        <!-- End Content -->

        <!-- Footer -->
        <footer class="text-center py-3 mt-auto">
            <div>
                <h6>Jewelry Auction</h6>
                <a href="${pageContext.request.contextPath}/register">Register</a> |
                <a href="${pageContext.request.contextPath}/login">Login</a> |
                <a href="#">Auctions</a> |
                <a href="#">Selling</a>
            </div>
        </footer>
        <!-- End Footer -->
        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script>
            $(document).ready(function () {
                $("a").on('click', function (event) {
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

                $(window).scroll(function () {
                    if ($(this).scrollTop() > 50) {
                        $('.navbar').addClass('scrolled');
                    } else {
                        $('.navbar').removeClass('scrolled');
                    }
                });
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                window.addEventListener("scroll", function () {
                    if (window.scrollY > 50) {
                        document.querySelector(".navbar").classList.add("navbar-scrolled");
                    } else {
                        document.querySelector(".navbar").classList.remove("navbar-scrolled");
                    }
                });
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
        </script>
    </body>
</html>
