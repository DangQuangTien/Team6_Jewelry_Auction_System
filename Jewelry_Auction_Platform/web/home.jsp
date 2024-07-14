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
        <link rel="stylesheet"
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <style>
            html {
                scroll-behavior: smooth;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #fff;
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

            .content {
                padding: 20px;
            }

            .carousel-control-prev, .carousel-control-next {
                position: absolute;
                top: 50%;
                width: 5%;
                height: 50px;
                margin-top: -25px;
                font-size: 20px;
                color: #fff;
                text-align: center;
                background: rgba(0, 0, 0, 0.5);
                border: none;
                border-radius: 50%;
                transition: all 0.3s ease;
            }

            .carousel-control-prev {
                left: -5%;
            }

            .carousel-control-next {
                right: -5%;
            }

            .carousel-control-prev:hover, .carousel-control-next:hover {
                background: rgba(0, 0, 0, 0.8);
            }

            .content h2 {
                color: #000;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .card {
                height: 450px;
                margin: 15px 0;
                border: none;
                border-radius: 0;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .card:hover {
                transform: translateY(-8px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }

            .card img {
                border-radius: 0;
                border-bottom: 3px solid #e4af11;
            }

            .card-title {
                font-size: 15px;
                color: #000;
                font-family: Verdana;
                text-align: center
            }

            .card-text {
                color: #666;
            }

            .btn-primary {
                background-color: #000;
                color: #ffc107;
                border: none;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #343a40;
                color: #e4af11;
            }

            footer {
                background-color: #000;
                color: #fff;
                text-align: center;
                padding: 1rem 0;
                margin-top: 30px;
                position: relative;
                overflow: hidden;
            }

            footer a {
                color: #ffc107;
                margin: 0 10px;
                text-decoration: none;
            }

            footer a:hover {
                text-decoration: underline;
            }

            .img-fluid {
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .img-fluid:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            }

            .hover-content {
                transition: background-color 0.3s, transform 0.3s;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .hover-content:hover {
                background-color: #f8f9fa;
                transform: scale(1.02);
            }


            .social-icons a {
                color: #ffc107;
                margin: 0 10px;
                text-decoration: none;
                transition: color 0.3s, transform 0.3s;
            }

            .social-icons a:hover {
                color: #e4af11;
                transform: scale(1.2);
            }

            .service-box, .gallery-box, .team-box, .about-box, .contact-box {
                margin-top: 50px;
            }

            .service-box h2, .gallery-box h2, .team-box h2, .about-box h2, .contact-box h2 {
                color: #000;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .service-box p, .gallery-box p, .team-box p, .about-box p, .contact-box p {
                color: #666;
            }

            .about-box img, .contact-box img {
                max-width: 100%;
                border-radius: 10px;
                margin-bottom: 20px;
            }

            .icon-box {
                font-size: 50px;
                margin-bottom: 20px;
                color: #ffc107;
                transition: color 0.3s ease;
            }

            .icon-box:hover {
                color: #e4af11;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            @keyframes slideInFromLeft {
                from {
                    transform: translateX(-100%);
                }
                to {
                    transform: translateX(0);
                }
            }

            @keyframes slideInFromRight {
                from {
                    transform: translateX(100%);
                }
                to {
                    transform: translateX(0);
                }
            }

            .animated-button {
                animation: slideInFromLeft 2s ease-in-out;
            }

            .animated-button-right {
                animation: slideInFromRight 2s ease-in-out;
            }

            @keyframes pulse {
                0%, 100% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.2);
                }
            }

            @keyframes slide {
                0% {
                    left: -100%;
                }
                50% {
                    left: 100%;
                }
                100% {
                    left: -100%;
                }
            }

            .decorative-diamond {
                animation: pulse 2s infinite;
            }

            .banner {
                position: relative;
                width: 100%; /* Adjusted width for full coverage */
                height: 1000px;
                overflow: hidden;
                margin-bottom: 30px;
                margin-top: 60px;
            }

            .banner-image {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: url('images/banner.jpg') center/cover no-repeat;
                will-change: transform;
                transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                filter: brightness(85%);
            }

            .banner:hover .banner-image {
                transform: scale(1.05);
            }

            .particle-background {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 0;
                overflow: hidden;
            }
            .banner-heading, .banner-subheading {
                opacity: 0;
                transform: translateY(-20px);
                animation: slideIn 1s forwards;
                text-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            }
            .banner-text {
                position: absolute;
                top: 50%;
                left: 20px; /* Adjust left spacing as needed */
                transform: translateY(-50%);
                color: #fff;
                text-align: left; /* Align text to the left */
                z-index: 1;
            }

            .banner-heading,
            .banner-subheading {
                opacity: 0;
                transform: translateY(-20px);
                animation: slideIn 1s forwards;
                text-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            }

            .banner-heading {
                font-size: 80px;
                margin-bottom: 100px;
                margin-left: 60px;
                opacity: 0;
                transform: translateY(-200px);
                animation: slideIn 1s forwards 0.5s;
                text-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
                font-family: 'Zapf-Chancery';
            }

            .banner-subheading {
                font-size: 24px;
                margin-left: 70px;
                margin-bottom: 300px;
                opacity: 0;
                transform: translateY(-100px);
                animation: slideIn 1s forwards 0.7s;
                text-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
                font-family: 'Andale Mono';
            }
            @keyframes slideIn {
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            ul {
                list-style: none;
            }

            .example-2 {
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .example-2 .icon-content {
                margin: 0 10px;
                position: relative;
            }
            .example-2 .icon-content .tooltip {
                position: absolute;
                top: -30px;
                left: 50%;
                transform: translateX(-50%);
                color: #fff;
                padding: 6px 10px;
                border-radius: 5px;
                opacity: 0;
                visibility: hidden;
                font-size: 14px;
                transition: all 0.3s ease;
            }
            .example-2 .icon-content:hover .tooltip {
                opacity: 1;
                visibility: visible;
                top: -50px;
            }
            .example-2 .icon-content a {
                position: relative;
                overflow: hidden;
                display: flex;
                justify-content: center;
                align-items: center;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                color: #4d4d4d;
                background-color: #fff;
                transition: all 0.3s ease-in-out;
            }
            .example-2 .icon-content a:hover {
                box-shadow: 3px 2px 45px 0px rgb(0 0 0 / 12%);
            }
            .example-2 .icon-content a svg {
                position: relative;
                z-index: 1;
                width: 30px;
                height: 30px;
            }
            .example-2 .icon-content a:hover {
                color: white;
            }
            .example-2 .icon-content a .filled {
                position: absolute;
                top: auto;
                bottom: 0;
                left: 0;
                width: 100%;
                height: 0;
                background-color: #000;
                transition: all 0.3s ease-in-out;
            }
            .example-2 .icon-content a:hover .filled {
                height: 100%;
            }

            .example-2 .icon-content a[data-social="linkedin"] .filled,
            .example-2 .icon-content a[data-social="linkedin"] ~ .tooltip {
                background-color: #0274b3;
            }

            .example-2 .icon-content a[data-social="github"] .filled,
            .example-2 .icon-content a[data-social="github"] ~ .tooltip {
                background-color: #24262a;
            }
            .example-2 .icon-content a[data-social="instagram"] .filled,
            .example-2 .icon-content a[data-social="instagram"] ~ .tooltip {
                background: linear-gradient(
                    45deg,
                    #405de6,
                    #5b51db,
                    #b33ab4,
                    #c135b4,
                    #e1306c,
                    #fd1f1f
                    );
            }
            .example-2 .icon-content a[data-social="youtube"] .filled,
            .example-2 .icon-content a[data-social="youtube"] ~ .tooltip {
                background-color: #ff0000;
            }

        </style>
    </head>
    <body>
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
                        <li class="nav-item">
                            <a class="nav-link" href="#"> BUYING</a>
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
                                   href="${pageContext.request.contextPath}/selling">ABOUT
                                    SELLING</a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="response">APPRAISED ASSET
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="valuation">VALUATION REQUEST
                                </a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"> EXPLORE</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about"> ABOUT</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#contact"> CONTACT</a>
                        </li>
                        <c:choose>
                            <c:when test="${username == null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#"
                                       id="userDropdown" role="button"
                                       data-toggle="dropdown"
                                       aria-haspopup="true"
                                       aria-expanded="false">
                                        <i  class="fas fa-user"></i> USER <i
                                            class="fas fa-caret-down"></i>
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
                                           href="${url}">PROFILE</a>
                                        <a class="dropdown-item"
                                           href="${pageContext.request.contextPath}/logout">LOGOUT</a>
                                    </div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Banner -->
        <section class="welcome-section">
            <div class="banner">
                <div class="banner-image"></div>
                <div class="particle-background"></div>
                <div class="banner-text">
                    <h2 class="banner-heading">Welcome to F'RANKELLY</h2>
                    <p class="banner-subheading">
                        Where every piece of fine jewelry tells a story of elegance and timeless beauty<br>Explore our curated collection, <br><br>Meticulously crafted to captivate and inspire, <br>As each gem and setting whispers tales of luxury and sophistication.
                    </p>
                </div>
            </div>
        </section>


        <!-- Content -->
        <hr>
        <div class="content container mt-5">
            <div style="text-align: center; margin: 0; padding: 20px 0; font-family: Verdana; font-size: 1.75em">AUCTION HIGHLIGHTS</div>
            <div style="width: 100%" id="carouselExampleControls" class="carousel slide"
                 data-ride="carousel">
                <div class="carousel-inner">
                    <c:choose>
                        <c:when test="${not empty listJewelry}">
                            <c:forEach var="slide" begin="0" end="${fn:length(listJewelry) / 3}" step="1">
                                <div class="carousel-item ${slide == 0 ? 'active' : ''}">
                                    <div class="row">
                                        <c:forEach var="jewelry" items="${listJewelry}" begin="${slide * 3}" end="${slide * 3 + 2}" varStatus="status">
                                            <c:if test="${status.index < fn:length(listJewelry)}">
                                                <div class="col-md-4">
                                                    <a style="text-decoration: none" href="${pageContext.request.contextPath}/auction?auctionID=${jewelry.auctionID}">
                                                        <div class="card">
                                                            <img src="${pageContext.request.contextPath}/${fn:split(jewelry.photo, ';')[0]}" class="card-img-top" alt="${jewelry.jewelryName}">
                                                            <div style="background-color: #f5f5f5" class="card-body">
                                                                <div class="card-title">${jewelry.jewelryName}</div>
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
                                        <p>No upcoming auctions at the moment. Please check back later.</p>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <a class="carousel-control-prev" href="#carouselExampleControls"
                   role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon"
                          aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleControls"
                   role="button" data-slide="next">
                    <span class="carousel-control-next-icon"
                          aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>

            <!-- Services Section -->
            <section id="services" class="service-box mt-5">
                <h2>Our Services</h2>
                <div class="row">
                    <div class="col-md-4">
                        <div class="content-box text-center">
                            <div class="icon-box"><i
                                    class="fas fa-gem"></i></div>
                            <h3>Valuation Services</h3>
                            <p>We provide expert valuation services for all
                                types of jewelry and gemstones. Our experienced
                                appraisers ensure accurate and fair
                                valuations.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="content-box text-center">
                            <div class="icon-box"><i
                                    class="fas fa-handshake"></i></div>
                            <h3>Buying Assistance</h3>
                            <p>Our team assists buyers in making informed
                                decisions. We offer guidance on the best pieces
                                to invest in, ensuring you get value for your
                                money.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="content-box text-center">
                            <div class="icon-box"><i
                                    class="fas fa-cogs"></i></div>
                            <h3>Customized Jewelry</h3>
                            <p>Looking for something unique? We offer customized
                                jewelry services to help you create the perfect
                                piece tailored to your taste and style.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Gallery Section -->
            <section id="gallery" class="gallery-box mt-5">
                <h2>Gallery</h2>
                <div class="row">
                    <div class="col-md-3">
                        <img src="images/206-1.jpg" class="img-fluid"
                             alt="Gallery Image">
                    </div>
                    <div class="col-md-3">
                        <img src="images/209-4.jpg" class="img-fluid"
                             alt="Gallery Image">
                    </div>
                    <div class="col-md-3">
                        <img src="images/213-1.jpg" class="img-fluid"
                             alt="Gallery Image">
                    </div>
                    <div class="col-md-3">
                        <img src="images/251-5.jpg" class="img-fluid"
                             alt="Gallery Image">
                    </div>
                </div>
            </section>

            <!-- Team Section -->

            <!-- About Us Section -->
            <section id="about" class="about-box mt-5">
                <h2>About Us</h2>
                <div class="row">
                    <div class="col-md-6">
                        <img
                            src="images/z5546462796989_1ff9a9b729be11624975ca5db8d58b64.jpg"
                            alt="About Us Image"
                            class="img-fluid rounded hover-shadow">
                    </div>
                    <div class="col-md-6">
                        <div class="content-box hover-content">
                            <p>Welcome to Jewelry Auctioned! We offer a wide
                                range of discounted jewelry and gemstones
                                directly from verified manufacturers worldwide.
                                Shop top-quality pieces at a fraction of the
                                price. Our sellers meet high standards through a
                                rigorous application process.</p>
                            <p>At F'Rankelly, we pride ourselves on offering the
                                finest jewelry at auction. Our commitment to
                                quality and excellence is unmatched, ensuring
                                that every piece we present is of the highest
                                standard. Join us in discovering the timeless
                                beauty and elegance of our collections.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Contact Section -->
            <section id="contact" class="contact-box mt-5">
                <h2>Contact Us</h2>
                <div class="row">
                    <div class="col-md-6">
                        <img
                            src="images/z5546463061579_b12c3929fc6aa94bff2cbf559a6d5acd.jpg"
                            alt="Contact Us Image"
                            class="img-fluid rounded hover-shadow">
                    </div>
                    <div class="col-md-6">
                        <div class="content-box hover-content">
                            <p>We welcome your feedback and encourage you to
                                share your thoughts. Feel free to ask questions,
                                tell us what you like, and let us know how we
                                can improve. Your input is valuable to us!</p>
                            <p><i class="fas fa-phone-alt"></i> Phone Support:
                                +849872539999 (Available 7 days a week, 9:00 am
                                - 5:30 pm EST)</p>
                            <p><i class="fas fa-envelope"></i> Email Support:
                                support@jewelryauction.com</p>
                            <p>Fill out the form below for more assistance.</p>
                            <form>
                                <div class="form-group">
                                    <label for="name">Name:</label>
                                    <input type="text" class="form-control"
                                           id="name" placeholder="Enter your name">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email:</label>
                                    <input type="email" class="form-control"
                                           id="email"
                                           placeholder="Enter your email">
                                </div>
                                <div class="form-group">
                                    <label for="message">Message:</label>
                                    <textarea class="form-control" id="message"
                                              rows="4"
                                              placeholder="Enter your message"></textarea>
                                </div>
                                <button type="submit"
                                        class="btn btn-primary">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <footer class="text-center py-4 mt-auto"
                style="background-color: #1b1b1b; color: #fff; position: relative; overflow: hidden;">
            <div class="container">
                <div class="row">
                    <div style="color: lightgray" class="col-md-4">
                        <br><br>
                        <h5 style="font-family: 'Zapf-Chancery'">F'RANKELLY AUCTION HOUSE</h5>
                        <p style="font-family: Helvetica">Your premier destination for exquisite jewelry and
                            gemstones. Discover the timeless beauty and elegance
                            in our curated collections.</p>
                    </div>
                    <div style="color: lightgray" class="col-md-4">
                        <br><br>
                        <h5 style="font-family: 'Zapf-Chancery'">Quick Links</h5>
                        <ul  class="list-unstyled">
                            <li><a style="text-decoration: none"
                                   href="${pageContext.request.contextPath}/register"
                                   style="color: #fdfdc7;">Join us</a></li>
                            <li><a style="text-decoration: none"
                                   href="${pageContext.request.contextPath}/auctions"
                                   style="color: #ffc107;">Start auction</a></li>
                            <li><a style="text-decoration: none"
                                   href="${pageContext.request.contextPath}/selling"
                                   style="color: #ffc107;">Appraise jewelry</a></li>
                        </ul>
                    </div>
                    <div style="color: lightgray" class="col-md-4">
                        <hr>
                        <!-- Social -->
                        <div class="social-icons mt-3">
                            <ul  class="example-2">
                                <li class="icon-content">
                                    <a
                                        href="https://linkedin.com/"
                                        aria-label="LinkedIn"
                                        data-social="linkedin"
                                        >
                                        <div class="filled"></div>
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            width="16"
                                            height="16"
                                            fill="currentColor"
                                            class="bi bi-linkedin"
                                            viewBox="0 0 16 16"
                                            xml:space="preserve"
                                            >
                                        <path
                                            d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854zm4.943 12.248V6.169H2.542v7.225zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248S2.4 3.226 2.4 3.934c0 .694.521 1.248 1.327 1.248zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.274 0-1.845.7-2.165 1.193v.025h-.016l.016-.025V6.169h-2.4c.03.678 0 7.225 0 7.225z"
                                            fill="currentColor"
                                            ></path>
                                        </svg>
                                    </a>
                                    <div class="tooltip">LinkedIn</div>
                                </li>
                                <li class="icon-content">
                                    <a href="https://www.github.com/" aria-label="GitHub" data-social="github">
                                        <div class="filled"></div>
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            width="16"
                                            height="16"
                                            fill="currentColor"
                                            class="bi bi-github"
                                            viewBox="0 0 16 16"
                                            xml:space="preserve"
                                            >
                                        <path
                                            d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8"
                                            fill="currentColor"
                                            ></path>
                                        </svg>
                                    </a>
                                    <div class="tooltip">GitHub</div>
                                </li>
                                <li class="icon-content">
                                    <a
                                        href="https://www.instagram.com/"
                                        aria-label="Instagram"
                                        data-social="instagram"
                                        >
                                        <div class="filled"></div>
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            width="16"
                                            height="16"
                                            fill="currentColor"
                                            class="bi bi-instagram"
                                            viewBox="0 0 16 16"
                                            xml:space="preserve"
                                            >
                                        <path
                                            d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.9 3.9 0 0 0-1.417.923A3.9 3.9 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.9 3.9 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.9 3.9 0 0 0-.923-1.417A3.9 3.9 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599s.453.546.598.92c.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.5 2.5 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.5 2.5 0 0 1-.92-.598 2.5 2.5 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233s.008-2.388.046-3.231c.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92s.546-.453.92-.598c.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92m-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217m0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334"
                                            fill="currentColor"
                                            ></path>
                                        </svg>
                                    </a>
                                    <div class="tooltip">Instagram</div>
                                </li>
                                <li class="icon-content">
                                    <a href="https://youtube.com/" aria-label="Youtube" data-social="youtube">
                                        <div class="filled"></div>
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            width="16"
                                            height="16"
                                            fill="currentColor"
                                            class="bi bi-youtube"
                                            viewBox="0 0 16 16"
                                            xml:space="preserve"
                                            >
                                        <path
                                            d="M8.051 1.999h.089c.822.003 4.987.033 6.11.335a2.01 2.01 0 0 1 1.415 1.42c.101.38.172.883.22 1.402l.01.104.022.26.008.104c.065.914.073 1.77.074 1.957v.075c-.001.194-.01 1.108-.082 2.06l-.008.105-.009.104c-.05.572-.124 1.14-.235 1.558a2.01 2.01 0 0 1-1.415 1.42c-1.16.312-5.569.334-6.18.335h-.142c-.309 0-1.587-.006-2.927-.052l-.17-.006-.087-.004-.171-.007-.171-.007c-1.11-.049-2.167-.128-2.654-.26a2.01 2.01 0 0 1-1.415-1.419c-.111-.417-.185-.986-.235-1.558L.09 9.82l-.008-.104A31 31 0 0 1 0 7.68v-.123c.002-.215.01-.958.064-1.778l.007-.103.003-.052.008-.104.022-.26.01-.104c.048-.519.119-1.023.22-1.402a2.01 2.01 0 0 1 1.415-1.42c.487-.13 1.544-.21 2.654-.26l.17-.007.172-.006.086-.003.171-.007A100 100 0 0 1 7.858 2zM6.4 5.209v4.818l4.157-2.408z"
                                            fill="currentColor"
                                            ></path>
                                        </svg>
                                    </a>
                                    <div class="tooltip">Youtube</div>
                                </li>
                            </ul>
                        </div>
                        <!<!-- Social -->  <h5 style="font-family: 'Zapf-Chancery'">Contact Us</h5>
                        <p><i class="fas fa-phone-alt"></i> +849872539999</p>
                        <p><i class="fas fa-envelope"></i>
                            support@jewelryauction.com</p>
                        <p><i class="fas fa-map-marker-alt"></i> 123 Jewelry
                            Street, New York, NY</p>
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

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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