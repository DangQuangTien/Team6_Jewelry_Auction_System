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
                    <div class="carousel-item <%= (i == 0) ? "active" : ""%>">
                        <div class="row">
                            <%
                                for (int j = 0; j < itemsPerSlide; j++) {
                                    int currentIndex = i * itemsPerSlide + j;
                                    if (currentIndex >= totalItems) break;
                                    RandomJewelry jewelry = listJewelry.get(currentIndex);
                            %>
                            <div class="col-md-4">
                                <div class="card">
                                    <img src="<%= jewelry.getImageURL() %>" class="card-img-top" alt="Jewelry Image">
                                    <div class="card-body">
                                        <h5 class="card-title"><%= jewelry.getName() %></h5>
                                        <p class="card-text">Starting Bid: $<%= jewelry.getStartingBid() %></p>
                                        <a href="#" class="btn btn-primary">Bid Now</a>
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

        <div class="about-contact-section container">
            <div class="row">
                <div class="col-md-6">
                    <img src="https://images.unsplash.com/photo-1603974372039-adc49044b6bd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8amV3ZWxsZXJ5fGVufDB8fDB8fHww" alt="About Us Image">
                </div>
                <div class="col-md-6">
                    <h2>About Us</h2>
                    <p class="lead">F'Rankelly's Premier Jewelry Auction House</p>
                    <p>At F'Rankelly, we pride ourselves on offering the finest jewelry at auction. Our commitment to quality and excellence is unmatched, ensuring that every piece we present is of the highest standard. Join us in discovering the timeless beauty and elegance of our collections.</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 order-md-2">
                    <img src="https://images.unsplash.com/photo-1602173574767-37ac01994b2a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8amV3ZWxsZXJ5fGVufDB8fDB8fHww" alt="Contact Us Image">
                </div>
                <div class="col-md-6 order-md-1">
                    <h2>Contact Us</h2>
                    <p class="lead">Get in Touch with Our Team</p>
                    <p>Whether you have a question about our auctions, need assistance with a purchase, or simply want to learn more about our services, our team is here to help. Reach out to us through our contact page or visit us at our showroom for a personal consultation.</p>
                </div>
            </div>
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
