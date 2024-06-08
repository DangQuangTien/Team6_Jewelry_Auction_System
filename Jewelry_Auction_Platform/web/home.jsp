<%@page import="entity.Auction.Auction" %>
<%@page import="java.util.List" %>
<%@page import="dao.UserDAOImpl" %>
<%@page import="java.util.ArrayList" %>
<%@page import="entity.product.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewelry Auctions Online</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="component/home.css">
</head>

<body>
    <c:set var="dao" value="<%= new dao.UserDAOImpl() %>" />
    <c:set var="username" value="${sessionScope.USERNAME}" />
    <c:set var="role" value="${sessionScope.ROLE}" />
    <c:set var="listCategory" value="${dao.listCategory()}" />

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Jewelry Auctions</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#">Home<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="auctions/upcoming.jsp">Auction</a>
                </li>
                <c:if test="${role == 'Member' || role == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="seller/selling.html">Sell</a>
                    </li>
                </c:if>
                <c:choose>
                    <c:when test="${username == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="register.jsp">Register</a>
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
                            <a class="nav-link" href="${url}">${username}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
                <li class="nav-item">
                    <% 
                    UserDAOImpl _dao = new UserDAOImpl(); 
                    Auction auction = null; // Declare auction variable outside of try-catch block
                    try {
                        List<Auction> auctions = _dao.displayAuction(); // Use the correct case for Auction
                        if (auctions != null && !auctions.isEmpty()) {
                            auction = auctions.get(0);
                        } else {
                            // Handle case where no auctions are available
                            // For example, set a default value or display a message
                        }
                    } catch (Exception ex) {
                        // Handle exception appropriately
                        ex.printStackTrace(); // Print the exception trace for debugging
                    }
                    if(auction != null) { // Check if auction is not null before using it
                    %>
                    <form id="viewAuctionForm" action="auctions/detail.jsp" method="GET">
                        <input type="hidden" name="auctionID" value="<%= auction.getAuctionID() %>">
                        <button type="submit" class="btn btn-danger">View Auction</button>
                    </form>
                    <% } else {
                        // Display a message or handle the null case
                    }
                    %>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="notification.jsp" id="bell-icon"><i class="fas fa-bell"></i></a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search for anything" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
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
                <div class="carousel-item active">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card">
                                <img src="" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">Item 1</h5>
                                    <p class="card-text">Description for Item 1.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <img src="" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">Item 2</h5>
                                    <p class="card-text">Description for Item 2.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <img src="" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">Item 3</h5>
                                    <p class="card-text">Description for Item 3.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card">
                                <img src="" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">Item 4</h5>
                                    <p class="card-text">Description for Item 4.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <img src="" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">Item 5</h5>
                                    <p class="card-text">Description for Item 5.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <img src="" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">Item 6</h5>
                                    <p class="card-text">Description for Item 6.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
</body>

</html>