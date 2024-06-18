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
        <link rel="stylesheet" type="text/css" href="component/home.css">
        <link rel="icon" type="image/png" sizes="64x64" href="images/logo/LogoFinal.png">
    </head>
    <body>
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
                        <a class="nav-link" href="home"><i class="fas fa-home"></i> HOME<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="auctions"><i class="fas fa-gavel"></i> AUCTIONS</a>
                    </li>
                    <c:if test="${role == 'Member' || role == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="seller"><i class="fas fa-dollar-sign"></i> SELLING</a>
                        </li>
                    </c:if>
                    <c:choose>
                        <c:when test="${username == null}">
                            <li class="nav-item">
                                <a class="nav-link" href="login"><i class="fas fa-sign-in-alt"></i> LOGIN</a>
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
            <h2><a href="all">Upcoming Auction</a></h2>
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

        <footer class="text-center py-3 mt-auto">
            <div>
                <h6>Jewelry Auction</h6>
                <a href="register.jsp">Register</a> |
                <a href="login.jsp">Login</a> |
                <a href="#">Auctions</a> |
                <a href="#">Selling</a>
            </div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
