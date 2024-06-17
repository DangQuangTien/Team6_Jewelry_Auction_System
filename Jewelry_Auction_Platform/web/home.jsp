<%@page import="entity.product.RandomJewelry"%>
<%@page import="java.util.List" %>
<%@page import="dao.UserDAOImpl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Global F'Rankelly's Premier Jewelry Auction House</title>
        <!-- Include Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="component/home.css">
        <link rel="icon" type="image/png" sizes="64x64" href="images/logo/LogoFinal.png">
        <style>
body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    font-family: 'Georgia', serif;
    background-color: #f5eded;
}

.navbar {
    position: sticky;
    top: 0;
    z-index: 1000;
    background-color: #343a40;
    border-bottom: 3px solid #e4af11;
}

.navbar-brand, .nav-link, .navbar-toggler-icon {
    color: #ffc107 !important;
}

.navbar-brand:hover, .nav-link:hover {
    color: #0a0800 !important;
}

.content {
    flex: 1;
    padding: 20px;
}

footer {
    background-color: #343a40;
    color: #fff;
    padding: 1rem;
    text-align: center;
}

footer a {
    color: #ffc107;
    margin: 0 10px;
}

.content-box, .highlight-box {
    background-color: #fff;
    padding: 1.5rem;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.highlight-box {
    background-color: #f5eded;
    padding: 1.5rem;
    border-radius: 5px;
    border: 1px solid #c6a9a9;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.highlight-box h2 {
    color: #343a40;
    font-weight: bold;
    margin-bottom: 20px;
}

.highlight-box p {
    color: #666;
    font-size: 1rem;
    line-height: 1.8;
}

.carousel-inner {
    margin-top: 30px;
}

.carousel-item {                
    justify-content: center;
}

.carousel-item .row {
    width: 100%;
    justify-content: center;
}

.carousel-item .card {
    margin: 10px;
    border: none;
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.carousel-item .card:hover {
    transform: scale(1.05);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.card img {
    max-height: 250px;
    object-fit: cover;
    border-radius: 10px;
    border-bottom: 1px solid #ddd;
}

.card-title {
    color: #343a40;
    font-weight: bold;
    font-size: 1.2rem;
}

.card-body {
    padding: 10px;
}

.banner {
    position: relative;
    width: 100%;
    height: 300px;
    overflow: hidden;
}

.banner img {
    width: 100%;
    height: auto;
    filter: brightness(0.5);
}

.banner-text {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: #fff;
    text-align: center;
    padding: 20px;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
}

@media (max-width: 768px) {
    .banner-text {
        font-size: 14px;
        padding: 10px;
    }
}

#viewAuctionButton {
    background-color: #dc3545;
    color: #fff;
    border: none;
    font-size: 16px;
    padding: 10px 20px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#viewAuctionButton:hover {
    background-color: #c82333;
}

#viewAuctionButton[disabled] {
    background-color: #6c757d;
    cursor: not-allowed;
}

#noAuctionBox {
    background-color: #ffc107;
    padding: 5px 10px;
    border-radius: 5px;
    color: #343a40;
    font-weight: bold;
    margin-left: 10px;
    display: none;
}

#viewAuctionForm.no-auction #noAuctionBox {
    display: inline-block;
}

.about-contact-section {
    margin-top: 50px;
    padding: 20px 0;
}

.about-contact-section .row {
    margin-bottom: 50px;
}

.about-contact-section img {
    width: 100%;
    border-radius: 10px;
    transition: transform 0.3s ease-in-out;
}

.about-contact-section img:hover {
    transform: scale(1.05);
}

.about-contact-section h2 {
    font-size: 2.5rem;
    color: #222;
    margin-bottom: 20px;
}

.about-contact-section p.lead {
    font-size: 1.25rem;
    color: #555;
    margin-bottom: 10px;
}

.about-contact-section p {
    color: #666;
    font-size: 1rem;
    line-height: 1.8;
}

@media (max-width: 768px) {
    .banner-text {
        font-size: 14px;
        padding: 10px;
    }

    .about-contact-section .row {
        flex-direction: column;
    }

    .about-contact-section .order-md-1, .about-contact-section .order-md-2 {
        order: initial;
    }

    .about-contact-section img {
        margin-bottom: 20px;
    }
}

.section-title {
    font-family: 'Georgia', serif;
    font-size: 2rem;
    color: #343a40;
    text-align: center;
    margin-bottom: 1.5rem;
}

.section-description {
    font-size: 1.1rem;
    color: #666;
    text-align: center;
    margin-bottom: 1.5rem;
}

.testimonial-card {
    border: none;
    background-color: #fdfdfd;
    margin-bottom: 1.5rem;
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.testimonial-card:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

.testimonial-card .card-body {
    padding: 2rem;
    text-align: center;
    font-style: italic;
}

.testimonial-card .card-text {
    font-size: 1rem;
    color: #555;
}

.newsletter-input {
    border: 2px solid #ccc;
    border-radius: 30px;
    padding: 10px 20px;
    font-size: 1rem;
}

.newsletter-button {
    background-color: #343a40;
    color: #fff;
    border: none;
    font-size: 1rem;
    padding: 7px 20px;
    border-radius: 30px;
    transition: background-color 0.3s ease-in-out;
}

.newsletter-button:hover {
    background-color: #e4af11;
}

@media (max-width: 768px) {
    .section-title {
        font-size: 1.5rem;
    }

    .section-description {
        font-size: 1rem;
    }

    .testimonial-card .card-body {
        padding: 1rem;
    }
}

.carousel-control-prev, .carousel-control-next {
    width: 5%;
}

.carousel-control-prev {
    left: -5%;
}

.carousel-control-next {
    right: -5%;
}
        </style>
    </head>
    <body>
        <c:set var="dao" value="<%= new dao.UserDAOImpl()%>" />
        <c:set var="username" value="${sessionScope.USERNAME}" />
        <c:set var="role" value="${sessionScope.ROLE}" />
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="home.jsp">
                <i class="fas fa-gem"> F'Rankelly</i><br>
                <span style="font-size: 0.5em;">Auctioneers & Appraisers</span>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">

                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="home.jsp"><i class="fas fa-home"></i> HOME<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="auctions/upcoming.jsp"><i class="fas fa-gavel"></i> AUCTIONS</a>
                    </li>
                    <c:if test="${role == 'Member' || role == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="seller/selling.html"><i class="fas fa-dollar-sign"></i> SELLING</a>
                        </li>
                    </c:if>
                    <c:choose>
                        <c:when test="${username == null}">
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> LOGIN</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="register.jsp"><i class="fas fa-user-plus"></i> REGISTER</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:set var="url">
                                <c:choose>
                                    <c:when test="${role == 'Member'}">bidder/profile.jsp</c:when>
                                    <c:when test="${role == 'Staff'}">staff/staff.jsp</c:when>
                                    <c:when test="${role == 'Manager'}">manager/manager.jsp</c:when>
                                    <c:otherwise>admin/admin.jsp</c:otherwise>
                                </c:choose>
                            </c:set>
                            <li class="nav-item">
                                <a class="nav-link" href="${url}"><i class="fas fa-user"></i>${username}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search for anything" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit"><i class="fas fa-search"></i> Search</button>
                </form>
            </div>
        </nav>

        <section class="welcome-section">
            <div class="banner">
                <img src="https://png.pngtree.com/thumb_back/fw800/background/20190223/ourmid/pngtree-beautiful-romantic-golden-jewelry-banner-background-spheresmall-golden-ballgold-image_83218.jpg" alt="Banner Image">
                <div class="banner-text">
                    <h2>Welcome to Jewelry Auction</h2>
                    <p>We're delighted to have you explore our curated selection of fine jewelry. Each piece is a treasure waiting to be discovered. Join our community of connoisseurs and start your bidding journey today.</p>
                </div>
            </div>
        </section>

        <div class="content container mt-5">
            <h2>Upcoming Auction</h2>
            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <%
                        UserDAOImpl _dao = new UserDAOImpl();
                        List<RandomJewelry> listJewelry = _dao.displayRandomJewelry();
                        if (listJewelry != null && !listJewelry.isEmpty()) {
                            int itemsPerSlide = 3;
                            int totalItems = listJewelry.size();
                            int numberOfSlides = (int) Math.ceil((double) totalItems / itemsPerSlide);
        
                            for (int i = 0; i < numberOfSlides; i++) {
                    %>
                    <div class="carousel-item <%= (i == 0) ? "active" : "" %>">
                        <div class="row">
                            <%
                                for (int j = 0; j < itemsPerSlide; j++) {
                                    int currentIndex = i * itemsPerSlide + j;
                                    if (currentIndex >= totalItems) break;
                                    RandomJewelry jewelry = listJewelry.get(currentIndex);
                            %>
                            <div class="col-md-4">
                                <div class="card">
                                    <img src="<%= jewelry.getPhoto() %>" class="card-img-top" alt="Jewelry Image">
                                    <div class="card-body">
                                        <h5 class="card-title"><%= jewelry.getJewelryName() %></h5>
                                        <a href="${pageContext.request.contextPath}/auctions/detail.jsp?auctionID=<%= jewelry.getAuctionID() %>" class="btn btn-primary">Bid Now</a>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="carousel-item active">
                        <div class="row">
                            <div class="col-md-12">
                                <p>No upcoming auctions at the moment. Please check back later.</p>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
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
        </div>
        
        <div class="about-contact-section container mt-5">
            <div class="row">
                <div class="col-md-6">
                    <img src="./images/z5546462796989_1ff9a9b729be11624975ca5db8d58b64.jpg" alt="About Us Image">
                </div>
                <div class="col-md-6">
                    <h2>About Us</h2>
                    <p class="lead">F'Rankelly's Premier Jewelry Auction House</p>
                    <p>At F'Rankelly, we pride ourselves on offering the finest jewelry at auction. Our commitment to quality and excellence is unmatched, ensuring that every piece we present is of the highest standard. Join us in discovering the timeless beauty and elegance of our collections.</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 order-md-2">
                    <img src="./images/z5546463061579_b12c3929fc6aa94bff2cbf559a6d5acd.jpg" alt="Contact Us Image">
                </div>
                <div class="col-md-6 order-md-1">
                    <h2>Contact Us</h2>
                    <p class="lead">Get in Touch with Our Team</p>
                    <p>Whether you have a question about our auctions, need assistance with a purchase, or simply want to learn more about our services, our team is here to help. Reach out to us through our contact page or visit us at our showroom for a personal consultation.</p>
                </div>
            </div>
        </div>
        <div class="content container mt-5">
            <h2 class="section-title">What Our Customers Say</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="card testimonial-card">
                        <div class="card-body">
                            <p class="card-text">"I had a wonderful experience at F'Rankelly's auction. The staff was knowledgeable, and the jewelry was exquisite."</p>
                            <p class="card-text"><strong>- Alice Smith</strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card testimonial-card">
                        <div class="card-body">
                            <p class="card-text">"I found the perfect piece for my collection. The bidding process was smooth and exciting."</p>
                            <p class="card-text"><strong>- John Doe</strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card testimonial-card">
                        <div class="card-body">
                            <p class="card-text">"Great selection and professional service. I highly recommend F'Rankelly's to any jewelry enthusiast."</p>
                            <p class="card-text"><strong>- Emma Johnson</strong></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="content container mt-5">
            <h2 class="section-title">Stay Updated</h2>
            <p class="section-description">Sign up for our newsletter to get the latest news and updates on upcoming auctions and exclusive offers.</p>
            <form class="newsletter-form">
                <div class="form-row">
                    <div class="col-md-8 mb-3">
                        <input type="email" class="form-control newsletter-input" placeholder="Enter your email">
                    </div>
                    <div class="col-md-4 mb-3">
                        <button class="btn btn-primary btn-block newsletter-button" type="submit">Subscribe</button>
                    </div>
                </div>
            </form>
        </div>
        <footer class="text-center py-3 mt-auto">
            <div>
                <h6>Jewelry Auction</h6>
                <a href="register.jsp">Register</a> |
                <a href="login.jsp">Login</a> |
                <a href="#">Help & FAQ</a> |
                <a href="#">Support</a> |
                <a href="#">Sitemap</a>
            </div>
        </footer>

        <!-- Include Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var auctionButton = document.getElementById('viewAuctionButton');
                auctionButton.addEventListener('click', function (event) {
                    var auctionID = document.querySelector('input[name="auctionID"]').value;
                    if (!auctionID) {
                        event.preventDefault();
                        alert('No auction available');
                    }
                });
            });
        </script>
    </body>
</html>
