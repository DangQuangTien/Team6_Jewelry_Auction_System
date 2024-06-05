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
                            <link rel="stylesheet"
                                href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
                            <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
                                rel="stylesheet">
                            <link rel="stylesheet"
                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

                            <link rel="stylesheet" type="text/css" href="component/header.css">
                            <link rel="stylesheet" type="text/css" href="component/footer.css">
                            <link rel="stylesheet" type="text/css" href="component/home.css">
                            <link rel="stylesheet" type="text/css" href="component/NavBar.css">

                        </head>

                        <body>
                            <c:set var="dao" value="<%= new dao.UserDAOImpl() %>" />
                            <c:set var="username" value="${sessionScope.USERNAME}" />
                            <c:set var="role" value="${sessionScope.ROLE}" />
                            <c:set var="listCategory" value="${dao.listCategory()}" />

                            <!-- START OF HEADER -->
                            <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top custom-navbar">
                                <div class="navbar-bg"></div>
                                <div class="gradient-overlay"></div>
                                <a class="navbar-brand" href="#">The V Rising</a>
                                <button class="navbar-toggler" type="button" data-toggle="collapse"
                                    data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                                    aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div class="collapse navbar-collapse" id="navbarNav">
                                    <ul class="navbar-nav ml-auto">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="home.jsp"><i class="fas fa-home"></i>Home <span
                                                    class="sr-only">(current)</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="Auction.jsp"><i
                                                    class="fas fa-cogs"></i>Auction</a>
                                        </li>
                                        <!-- Conditional rendering based on user role -->
                                        <c:if test="${role == 'Member' || role == null}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="seller/selling.html"><i
                                                        class="fas fa-dollar-sign"></i>Sell</a>
                                            </li>
                                        </c:if>
                                        <!-- Conditional rendering based on user authentication -->
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
                                            <a class="nav-link" href="seller/notification.jsp"><i
                                                    class="fas fa-bell"></i></a>
                                        </li>
                                    </ul>

                                    <form class="form-inline my-2 my-lg-0">
                                        <input class="form-control mr-sm-2" type="search"
                                            placeholder="Search for anything" aria-label="Search">
                                        <button class="btn btn-outline-success my-2 my-sm-0"
                                            type="submit">Search</button>
                                    </form>

                                    <!-- WELCOME SECTION -->
                                    <section class="welcome-section">
                                        <h2>Welcome To V Rising</h2>
                                        <p class="welcome-text">
                                            We're delighted to have you explore our curated selection of fine
                                            jewelry. Each piece is a treasure waiting to be discovered. Join our
                                            community of connoisseurs and start your bidding journey today.
                                        </p>
                                    </section>
                                    <hr>
                                </div>
                            </nav>

                            <main class="container mt-4">
                                <br>
                                <h2>Top Categories</h2>
                                <c:if test="${not empty listCategory}">
                                    <div class="category-container">
                                        <c:forEach var="category" items="${listCategory}">
                                            <div class="category-name">
                                                ${category.categoryName}
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <br>
                                <hr>
                                <h2>Upcoming Auction</h2>
                                <section class="upcoming-auction">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mySlides slide">
                                                    <div class="card mb-4">
                                                        <img src="https://a.1stdibscdn.com/archivesE/upload/1121189/j_130196821629192638945/13019682_datamatics.jpg"
                                                            class="card-img-top"
                                                            alt="Tiny Crystal Heart Pendant Necklace in Rose Gold">
                                                        <div class="card-body">
                                                            <h5 class="card-title">Tiny Crystal Heart Pendant Necklace
                                                                in Rose Gold</h5>
                                                            <p class="card-text">Start: Wed, May 22, 12:00 PM GMT+3</p>
                                                            <p class="card-text">Auction ID: 159234</p>
                                                            <button class="btn btn-primary">Notify me</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mySlides slide">
                                                    <div class="card mb-4">
                                                        <img src="https://nhj.com.vn/wp-content/uploads/2019/04/vong-tay-vang-24k-8.jpg"
                                                            class="card-img-top"
                                                            alt="14K Rose Gold Full Round Moissanite Diamond Ring">
                                                        <div class="card-body">
                                                            <h5 class="card-title">14K Rose Gold Full Round Moissanite
                                                                Diamond Ring</h5>
                                                            <p class="card-text">Start: Wed, May 22, 12:00 PM GMT+3</p>
                                                            <p class="card-text">Auction ID: 294819</p>
                                                            <button class="btn btn-primary">Notify me</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mySlides slide">
                                                    <div class="card mb-4">
                                                        <img src="https://a.1stdibscdn.com/archivesE/upload/1121189/j_130196821629192638945/13019682_datamatics.jpg"
                                                            class="card-img-top"
                                                            alt="Tiny Crystal Heart Pendant Necklace in Rose Gold">
                                                        <div class="card-body">
                                                            <h5 class="card-title">Tiny Crystal Heart Pendant Necklace
                                                                in Rose Gold</h5>
                                                            <p class="card-text">Start: Wed, May 22, 12:00 PM GMT+3</p>
                                                            <p class="card-text">Auction ID: 159234</p>
                                                            <button class="btn btn-primary">Notify me</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mySlides slide">
                                                    <div class="card mb-4">
                                                        <img src="https://a.1stdibscdn.com/archivesE/upload/1121189/j_130196821629192638945/13019682_datamatics.jpg"
                                                            class="card-img-top"
                                                            alt="Tiny Crystal Heart Pendant Necklace in Rose Gold">
                                                        <div class="card-body">
                                                            <h5 class="card-title">Tiny Crystal Heart Pendant Necklace
                                                                in Rose Gold</h5>
                                                            <p class="card-text">Start: Wed, May 22, 12:00 PM GMT+3</p>
                                                            <p class="card-text">Auction ID: 159234</p>
                                                            <button class="btn btn-primary">Notify me</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Next and previous buttons -->
                                    <div class="next-prev-btn">
                                        <a class="prev" onclick="plusSlides(-2)">&#10094;</a>
                                        <a class="next" onclick="plusSlides(2)">&#10095;</a>
                                    </div>
                                    <br>
                                    <!-- The dots/circles -->
                                    <div style="text-align:center">
                                        <span class="dot" onclick="currentSlide(1)"></span>
                                        <span class="dot" onclick="currentSlide(2)"></span>
                                    </div>
                                </section>

                                <br>
                                <hr>
                                <section class="contact mt-5">
                                    <h2>About Us</h2>
                                    <p>Welcome to Jewelry Auctioned! We offer a wide range of discounted jewelry and
                                        gemstones directly from verified manufacturers worldwide.
                                        Shop top-quality pieces at a fraction of the price. Our sellers meet high
                                        standards through a rigorous application process.</p>
                                </section>

                                <section class="contact mt-5">
                                    <h2>Contact</h2>
                                    <p>We welcome your feedback and encourage you to share your thoughts. Feel free to
                                        ask questions, tell us what you like, and let us know how we can improve. Your
                                        input is valuable to us!</p>
                                    <p>Phone Support: +849872539999 (Available 7 days a week, 9:00 am - 5:30 pm EST)</p>
                                    <p>Email Support: support@jewelryauction.com</p>
                                    <p>Fill out the form below for more assistance.</p>
                                </section>
                                <hr>
                            </main>
                            <!-- START OF FOOTER -->
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
                            <!-- END OF FOOTER -->

                            <!-- Include Bootstrap JS and dependencies -->
                            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                            <script
                                src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
                            <script
                                src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                            <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
                            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                            <script src="javascript/home.js"></script>
                        </body>

                        </html>