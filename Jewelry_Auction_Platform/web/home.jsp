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
            background-color: rgba(0, 0, 0, 0.8);
            transition: background-color 0.3s, box-shadow 0.3s, padding-top 0.3s, padding-bottom 0.3s;
            padding-top: 15px;
            padding-bottom: 15px;
            z-index: 1000;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .navbar-scrolled {
            background-color: black;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            padding-top: 10px;
            padding-bottom: 10px;
        }

        .navbar-brand, .nav-link {
            color: #fff !important;
            transition: color 0.3s;
        }

        .navbar-scrolled .navbar-brand,
        .navbar-scrolled .nav-link {
            color: #ffc107 !important;
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

        .navbar-nav .nav-link:hover::after {
            width: 100%;
            left: 0;
            visibility: visible;
        }

        .dropdown-menu {
            background-color: #000;
            border: 1px solid rgba(255, 255, 255, 0.1);
            animation: fadeIn 0.5s;
        }

        .dropdown-item {
            color: #fff !important;
            transition: background-color 0.3s, color 0.3s;
        }

        .dropdown-item:hover {
            background-color: rgba(255, 255, 255, 0.1) !important;
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
            font-size: 18px;
            font-weight: bold;
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
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideInFromLeft {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }

        @keyframes slideInFromRight {
            from { transform: translateX(100%); }
            to { transform: translateX(0); }
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
        width: 100%;
        height: 600px;
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
        background: url('https://png.pngtree.com/thumb_back/fw800/background/20190223/ourmid/pngtree-beautiful-romantic-golden-jewelry-banner-background-spheresmall-golden-ballgold-image_83218.jpg') center/cover no-repeat;
        will-change: transform;
        transition: transform 0.5s ease;
    }

    .banner:hover .banner-image {
        transform: scale(1.1);
    }

    .particle-background {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 0;
        overflow: hidden;
    }

    .banner-text {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: #fff;
        text-align: center;
        z-index: 1;
    }

    .banner-heading {
        font-size: 48px;
        margin-bottom: 20px;
        opacity: 0;
        transform: translateY(-20px);
        animation: slideIn 1s forwards 0.5s;
        text-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    }

    .banner-subheading {
        font-size: 24px;
        margin-bottom: 30px;
        opacity: 0;
        transform: translateY(20px);
        animation: slideIn 1s forwards 0.7s;
        text-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    }

    .btn-banner {
        font-size: 18px;
        padding: 12px 30px;
        border-radius: 25px;
        background-color: #000;
        color: #ffc107;
        transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease;
        opacity: 0;
        transform: translateY(40px);
        animation: slideIn 1s forwards 0.9s;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    }

    .btn-banner:hover {
        background-color: #333;
        color: #e4af11;
        transform: scale(1.1);
    }

    @keyframes slideIn {
        to {
            opacity: 1;
            transform: translateY(0);
        }
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
                    <span class="brand-name">F'Rankelly</span>
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
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/auctions">UPCOMING
                                    AUCTIONS</a>
                                <a class="dropdown-item" href="#">PAST
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
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/selling">ABOUT
                                    SELLING</a>
                                <a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/valuation">VALUATION
                                    REQUEST</a>
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
                                        <i class="fas fa-user"></i> USER <i
                                            class="fas fa-caret-down"></i>
                                    </a>
                                    <div class="dropdown-menu"
                                        aria-labelledby="userDropdown">
                                        <a class="dropdown-item"
                                            href="${pageContext.request.contextPath}/register">Register</a>
                                        <a class="dropdown-item"
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

        <!-- Banner -->
        <section class="welcome-section">
            <div class="banner">
                <div class="banner-image"></div>
                <div class="particle-background"></div>
                <div class="banner-text">
                    <h2 class="banner-heading">Welcome to F'Rankelly
                        Auction</h2>
                    <p class="banner-subheading">Explore our curated selection
                        of fine jewelry. Each piece is a treasure waiting to be
                        discovered.</p>
                    <button id="btn-start-bidding" class="btn btn-banner">Start
                        Bidding</button>
                </div>
            </div>
        </section>

        <!-- Content -->
        <div class="content container mt-5">
            <h2>Upcoming Auction</h2>
            <div id="carouselExampleControls" class="carousel slide"
                data-ride="carousel">
                <div class="carousel-inner">
                    <c:choose>
                        <c:when test="${not empty listJewelry}">
                            <c:foreach var="slide" begin="0"
                                end="${fn:length(listJewelry) / 3}" step="1">
                                <div
                                    class="carousel-item ${slide == 0 ? 'active' : ''}">
                                    <div class="row">
                                        <c:foreach var="jewelry"
                                            items="${listJewelry}"
                                            begin="${slide * 3}"
                                            end="${slide * 3 + 2}"
                                            varStatus="status">
                                            <c:if
                                                test="${status.index < fn:length(listJewelry)}">
                                                <div class="col-md-4">
                                                    <a
                                                        style="text-decoration: none"
                                                        href="${pageContext.request.contextPath}/auction?auctionID=${jewelry.auctionID}">
                                                        <div class="card">
                                                            <img
                                                                src="${pageContext.request.contextPath}/${fn:split(jewelry.photo, ';')[0]}"
                                                                class="card-img-top"
                                                                alt="${jewelry.jewelryName}">
                                                            <div
                                                                class="card-body">
                                                                <h5
                                                                    class="card-title">${jewelry.jewelryName}</h5>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/auctions/detail.jsp?auctionID=${jewelry.getAuctionID()}"
                                                                    class="btn btn-primary">Bid
                                                                    Now</a>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </c:if>
                                        </c:foreach>
                                    </div>
                                </div>
                            </c:foreach>
                        </c:when>
                        <c:otherwise>
                            <div class="carousel-item active">
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>No upcoming auctions at the moment.
                                            Please check back later.</p>
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
            <section id="team" class="team-box mt-5">
                <h2>Our Team</h2>
                <div class="row">
                    <div class="col-md-4">
                        <div class="content-box text-center">
                            <div class="icon-box"><i
                                    class="fas fa-user-tie"></i></div>
                            <h3>Ben Nguyen</h3>
                            <p>CEO & Founder</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="content-box text-center">
                            <div class="icon-box"><i
                                    class="fas fa-user-check"></i></div>
                            <h3>Viet Thang</h3>
                            <p>Chief Appraiser</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="content-box text-center">
                            <div class="icon-box"><i
                                    class="fas fa-user-cog"></i></div>
                            <h3>Hoang Trung</h3>
                            <p>Marketing Director</p>
                        </div>
                    </div>
                </div>
            </section>

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
