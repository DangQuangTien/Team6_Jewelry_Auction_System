<%@page import="entity.member.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="dao.UserDAOImpl"%>
<%@page import="entity.product.Jewelry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserDAOImpl dao = new UserDAOImpl();
    String jewelryID = request.getParameter("jewelryID");
    Jewelry jewelry = dao.getJewelryDetails(jewelryID);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= jewelry != null ? jewelry.getJewelryName() : "Jewelry" %> | Global F'Rankelly's Premier Jewelry Auction House</title>
    <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Material+Icons');

        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            scroll-behavior: smooth;
        }
        nav {
            background-color: #fff;
            color: #000;
            padding: 10px 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        nav .navbar-brand img {
            max-width: 50px;
            margin-right: 10px;
        }
        nav a {
            color: #000;
            text-decoration: none;
            margin-right: 10px;
            padding: 8px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        nav a:hover {
            background-color: rgba(85, 85, 85, 0.5);
            color: #fff;
        }
        .container {
            margin-top: 20px;
        }
        .card {
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s;
        }
        .card:hover {
            transform: scale(1.02);
        }
        .card-body {
            padding: 20px;
        }
        .card-title {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .card img {
            border-radius: 10px;
            margin-bottom: 20px;
            max-width: 100%;
            transition: transform 0.3s;
        }
        .card img:hover {
            transform: scale(1.05);
        }
        .card-text {
            margin-bottom: 10px;
        }
        .additional-info {
            margin-top: 20px;
        }
        .additional-info h2 {
            font-size: 22px;
            margin-bottom: 10px;
        }
        .additional-info h3 {
            font-size: 18px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .additional-info label {
            font-weight: bold;
            margin-top: 5px;
        }
        .additional-info input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
        }
        .custom-button {
            position: relative;
            display: inline-block;
            font-size: 16px;
            padding: 10px 20px;
            color: #fff;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            overflow: hidden;
            transition: background 0.3s, box-shadow 0.3s, transform 0.3s;
            margin: 5px 0;
            background-color: #6D5BBA;
            background-image: linear-gradient(to right, #6D5BBA, #8D58BF);
        }

        .custom-button .material-icons {
            font-size: 24px;
            vertical-align: middle;
            margin-right: 8px;
            transition: transform 0.3s;
        }

        .custom-button span {
            vertical-align: middle;
        }

        .custom-button:hover {
            background-color: #8D58BF;
            box-shadow: 0 4px 14px rgba(255, 112, 67, 0.4);
        }

        .custom-button:hover .material-icons {
            transform: translateX(5px);
        }

        .edit-button::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 300%;
            height: 300%;
            background: rgba(0, 0, 0, 0.1);
            border-radius: 50%;
            transform: translate(-50%, -50%) scale(0);
            transition: transform 0.3s;
        }

        .edit-button:hover::before {
            transform: translate(-50%, -50%) scale(1);
        }

        .login-button {
            display: inline-block;
            font-size: 16px;
            padding: 10px 20px;
            color: #6D5BBA;
            background: none;
            border: 2px solid #6D5BBA;
            border-radius: 50px;
            cursor: pointer;
            overflow: hidden;
            transition: background 0.3s, color 0.3s;
            margin: 5px 0;
        }

        .login-button:hover {
            background: #6D5BBA;
            color: #fff;
        }

        .standard-button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
            margin: 5px 0;
            background-image: linear-gradient(to right, #007bff, #0056b3);
        }

        .standard-button:hover {
            background-color: #0056b3;
        }

        .thumbnail {
            width: 100px;
            height: 100px;
            object-fit: cover;
            cursor: pointer;
            transition: transform 0.3s;
            margin-right: 10px;
        }
        .thumbnail:hover {
            transform: scale(1.1);
        }
        footer {
            background-color: #f9f9f9;
            padding: 20px 0;
            text-align: center;
        }
        footer a {
            color: #007bff;
            text-decoration: none;
            margin: 0 10px;
        }
        footer a:hover {
            text-decoration: underline;
        }
        .footer-links {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        .footer-links div {
            margin-bottom: 15px;
        }
        .social-media a {
            margin: 0 10px;
            color: #000;
            font-size: 24px;
        }
        .progress {
            height: 25px;
        }
        .collapse {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <c:set var="member" value="${sessionScope.MEMBER}" />
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <img src="../images/logo/Logo.png" alt="Logo">
            Home
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/auctions">Auctions</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/mybids">My Bids</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Watched Lots</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        ${member != null ? member.firstName : 'Account'}
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <c:choose>
                            <c:when test="${member != null}">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Profile</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a>
                            </c:when>
                            <c:otherwise>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/login">Login</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/register">Register</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </li>
                <li class="nav-item">
                    <form class="form-inline my-2 my-lg-0">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>
    <c:set var="username" value="${sessionScope.USERNAME}" />
    <c:set var="role" value="${sessionScope.ROLE}" />
    <%
        String userID = (String) session.getAttribute("USERID");
        Member member = dao.getInformation(userID);
        int status = 1;
        if (member != null) {
            status = member.getStatus();
        }
        if (jewelry != null) {
            String photos = jewelry.getPhotos();
            String[] photoArray = photos != null ? photos.split(";") : new String[0];
    %>
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <% for (int i = 0; i < photoArray.length; i++) { %>
                            <li data-target="#carouselExampleIndicators" data-slide-to="<%= i %>" class="<%= i == 0 ? "active" : "" %>"></li>
                        <% } %>
                    </ol>
                    <div class="carousel-inner">
                        <% for (int i = 0; i < photoArray.length; i++) { %>
                            <div class="carousel-item <%= i == 0 ? "active" : "" %>">
                                <img class="d-block w-100" src="${pageContext.request.contextPath}/<%= photoArray[i] %>" alt="Slide <%= i+1 %>">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Slide <%= i+1 %></h5>
                                </div>
                            </div>
                        <% } %>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
            <div class="col-md-6">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="details-tab" data-toggle="tab" href="#details" role="tab" aria-controls="details" aria-selected="true">
                            <i class="fas fa-info-circle"></i> Details
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="specifications-tab" data-toggle="tab" href="#specifications" role="tab" aria-controls="specifications" aria-selected="false">
                            <i class="fas fa-cogs"></i> Specifications
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="shipping-tab" data-toggle="tab" href="#shipping" role="tab" aria-controls="shipping" aria-selected="false">
                            <i class="fas fa-shipping-fast"></i> Shipping Info
                        </a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="details" role="tabpanel" aria-labelledby="details-tab">
                        <div class="additional-info">
                            <h2><%= jewelry.getJewelryID()%></h2>
                            <h2><%= jewelry.getJewelryName()%></h2>
                            <div>Estimate: $<%= jewelry.getMinPrice()%> - $<%= jewelry.getMaxPrice()%></div>
                            <% if (status == 0 && member != null) { %>
                                <a href="registerBid.jsp?auctionID=<%= request.getParameter("auctionID")%>" class="custom-button wallet-button">
                                    <span class="material-icons">account_balance_wallet</span>
                                    <span>PLACE BID</span>
                                </a>
                            <% } else if (status == 1 && member != null) { %>
                                <button type="button" class="custom-button edit-button" data-toggle="modal" data-target="#bidModal">
                                    <span class="material-icons">edit</span>
                                    <span>PLACE BID</span>
                                </button>
                                <button type="button" class="custom-button edit-button" data-toggle="modal" data-target="#bidModal_">
                                    <span class="material-icons">edit</span>
                                    <span>EDIT BID</span>
                                </button>
                            <% } else { %>
                                <a href="${pageContext.request.contextPath}/login" class="custom-button login-button">
                                    <span class="material-icons">login</span>
                                    <span>PLACE BID</span>
                                </a>
                            <% } %>
                            <div>Live Auction</div>
                            <a href="${pageContext.request.contextPath}/auction?auctionID=<%= request.getParameter("auctionID")%>">Fine Jewels & Watches</a>
                            <div>Artist</div>
                            <div style="color: #0089ba"><%= jewelry.getArtist()%></div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="specifications" role="tabpanel" aria-labelledby="specifications-tab">
                        <% if ("Watch".equals(jewelry.getCategoryName())) { %>
                            <div id="watchFields" class="form-section">
                                <div>Category</div>
                                <div style="color: #0089ba"><%= jewelry.getCategoryName()%></div>
                                <div>Description</div>
                                <div>Summary of Key Characteristics</div>
                                <ul>
                                    <li>CIRCA: <%= jewelry.getCirca()%></li>
                                    <li>SERIAL NUMBER: <%= jewelry.getSerialNumber()%></li>
                                    <li>REF: <%= jewelry.getReferenceNumber()%></li>
                                    <li>CASE MATERIAL: <%= jewelry.getMaterial()%></li>
                                    <li>CASE DIMENSIONS: <%= jewelry.getCaseDimensions()%></li>
                                    <li>DIAL: <%= jewelry.getDial()%></li>
                                    <li>BRACELET MATERIAL: <%= jewelry.getBraceletMaterial()%></li>
                                    <li>BRACELET SIZE: <%= jewelry.getBraceletSize()%></li>
                                    <li>MOVEMENT: <%= jewelry.getMovement()%></li>
                                    <li>CALIBER: <%= jewelry.getCaliber()%></li>
                                    <li>Condition: <%= jewelry.getCondition()%></li>
                                </ul>
                            </div>
                        <% } else if ("Bracelet".equals(jewelry.getCategoryName())) { %>
                            <div id="braceletFields" class="form-section">
                                <div>Category</div>
                                <div style="color: #0089ba"><%= jewelry.getCategoryName()%></div>
                                <div>Description</div>
                                <div>Summary of Key Characteristics</div>
                                <ul>
                                    <li>Metal: <%= jewelry.getMetal()%></li>
                                    <li>Gemstone(s): <%= jewelry.getGemstones()%></li>
                                    <li>Measurements: <%= jewelry.getMeasurements()%></li>
                                    <li>Weight: <%= jewelry.getWeight()%></li>
                                    <li>Condition: <%= jewelry.getCondition()%></li>
                                </ul>
                            </div>
                        <% } %>
                    </div>
                    <div class="tab-pane fade" id="shipping" role="tabpanel" aria-labelledby="shipping-tab">
                        <div class="collapse" id="globalShipping">
                            <div class="card card-body">
                                <div>Global Shipping</div>
                                <p>With customers in over 100 countries, we provide fully insured global shipping, expertly arranged by our team. The shipping costs, determined based on the insured value of the package and its destination, will be calculated post-auction and added to your invoice. Please note, VAT, duties, or any additional charges related to international shipping are not included in these costs and remain the responsibility of the buyer.</p>
                            </div>
                        </div>
                        <button class="custom-button standard-button" type="button" data-toggle="collapse" data-target="#globalShipping" aria-expanded="false" aria-controls="globalShipping">
                            View Global Shipping Info
                        </button>
                    
                        <div class="collapse" id="postAuctionSupport">
                            <div class="card card-body">
                                <div>Post-Auction Support</div>
                                <p>As a full-service auction house, we take pride in the comprehensive range of post-auction services we offer, including ring resizing, stone replacement, and repair work. It's part of our commitment to ensure a seamless transaction and to cater to your needs even after the gavel falls. However, please note that the applicability of certain services may vary depending on the specifics of the lot. If you have any questions or need additional information such as a cost estimate, we encourage you to reach out to us.</p>
                            </div>
                        </div>
                        <button class="custom-button standard-button" type="button" data-toggle="collapse" data-target="#postAuctionSupport" aria-expanded="false" aria-controls="postAuctionSupport">
                            View Post-Auction Support
                        </button>
                    
                        <div class="collapse" id="propertySoldAsIs">
                            <div class="card card-body">
                                <div>Property Sold As-Is</div>
                                <p>Please be aware that all lots are sold "As Is". We do not guarantee that the lot is in pristine condition or devoid of imperfections, or wear and tear that is consistent with the age of the item. It falls under the buyer's responsibility to inspect the lot or request additional photos and condition details prior to bidding.</p>
                            </div>
                        </div>
                        <button class="custom-button standard-button" type="button" data-toggle="collapse" data-target="#propertySoldAsIs" aria-expanded="false" aria-controls="propertySoldAsIs">
                            View Property Sold As-Is Info
                        </button>
                    
                        <div class="collapse" id="biddingGuidelines">
                            <div class="card card-body">
                                <div>Bidding Guidelines</div>
                                <p>Please remember that once you have placed a bid on FORTUNA's platform, it cannot be retracted or reduced.</p>
                            </div>
                        </div>
                        <button class="custom-button standard-button" type="button" data-toggle="collapse" data-target="#biddingGuidelines" aria-expanded="false" aria-controls="biddingGuidelines">
                            View Bidding Guidelines
                        </button>
                    
                        <div class="collapse" id="buyersPremium">
                            <div class="card card-body">
                                <div>Buyer's Premium and Sales Tax</div>
                                <p>A buyer's premium of 25% (30% if bidding on LiveAuctioneers, Invaluable, and Bidsquare) is applicable to all winning bids and is not included in the online bid value. We collect sales tax for lots shipped to the following states within the US: CA, CO, FL, GA, IL, MA, MD, MI, NJ, NY, OH, PA, RI, SC, TN, TX, and VA.</p>
                            </div>
                        </div>
                        <button class="custom-button standard-button" type="button" data-toggle="collapse" data-target="#buyersPremium" aria-expanded="false" aria-controls="buyersPremium">
                            View Buyer's Premium Info
                        </button>
                    
                        <div class="collapse" id="conditionsOfSale">
                            <div class="card card-body">
                                <div>Conditions of Sale</div>
                                <p>We encourage all potential bidders to consult our Conditions of Sale for comprehensive details. By placing a bid, you acknowledge that you have read and are bound by these conditions.</p>
                            </div>
                        </div>
                        <button class="custom-button standard-button" type="button" data-toggle="collapse" data-target="#conditionsOfSale" aria-expanded="false" aria-controls="conditionsOfSale">
                            View Conditions of Sale
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } else { %>
    <p>No item details available.</p>
    <% } %>
    
    <footer class="text-center py-3 mt-auto">
        <div class="container">
            <div class="footer-links">
                <div>
                    <h6>Quick Links</h6>
                    <a href="register.jsp">Register</a> |
                    <a href="login.jsp">Login</a> |
                    <a href="#">Help & FAQ</a> |
                    <a href="#">Support</a> |
                    <a href="#">Sitemap</a>
                </div>
                <div>
                    <h6>About Us</h6>
                    <a href="#">Company Info</a> |
                    <a href="#">Careers</a> |
                    <a href="#">Privacy Policy</a> |
                    <a href="#">Terms of Service</a>
                </div>
                <div>
                    <h6>Contact Us</h6>
                    <a href="#">Customer Service</a> |
                    <a href="#">Contact Form</a> |
                    <a href="#">Locations</a>
                </div>
                <div>
                    <h6>Subscribe to our Newsletter</h6>
                    <form>
                        <input type="email" class="form-control" placeholder="Enter your email">
                        <button type="submit" class="custom-button standard-button mt-2">Subscribe</button>
                    </form>
                </div>
            </div>
            <div class="mt-3 social-media">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin"></i></a>
            </div>
            <div class="mt-2">
                <p>&copy; 2024 Global F'Rankelly's Premier Jewelry Auction House. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <% String preBid_Amount = (String) request.getParameter("preBid_Amount"); %>
    <div class="modal fade" id="bidModal" tabindex="-1" role="dialog" aria-labelledby="bidModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bidModalLabel">Place Your Bid</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="bidForm" action="${pageContext.request.contextPath}/placebid" method="GET">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="bidAmount">Enter your bid amount:</label>
                            <input type="number" class="form-control" id="bidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                        </div>
                        <input type="hidden" id="auctionID" name="auctionID" value="<%= request.getParameter("auctionID")%>">
                        <input type="hidden" id="jewelryID" name="jewelryID" value="<%= request.getParameter("jewelryID")%>">
                        <input type="hidden" name="action" value="Place Bid">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="custom-button standard-button" data-dismiss="modal">Close</button>
                        <button type="submit" class="custom-button standard-button">Place Bid</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="bidModal_" tabindex="-1" role="dialog" aria-labelledby="bidModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bidModalLabel">Edit Your Bid</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="editBidForm_" action="${pageContext.request.contextPath}/editbid" method="GET">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="editBidAmount">Enter your new bid amount:</label>
                            <input type="number" class="form-control" id="editBidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                        </div>
                        <input type="hidden" id="auctionID" name="auctionID" value="<%= request.getParameter("auctionID")%>">
                        <input type="hidden" id="jewelryID" name="jewelryID" value="<%= request.getParameter("jewelryID")%>">
                        <input type="hidden" name="action" value="Edit Bid">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="custom-button standard-button" data-dismiss="modal">Close</button>
                        <button type="submit" class="custom-button standard-button">Edit Bid</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });

        $(document).ready(function() {
            $('.collapse').on('show.bs.collapse', function() {
                $('.collapse').not(this).collapse('hide');
            });

            $('[data-toggle="collapse"]').click(function() {
                var $this = $(this);
                if ($this.hasClass('active')) {
                    $this.removeClass('active');
                } else {
                    $('[data-toggle="collapse"]').removeClass('active');
                    $this.addClass('active');
                }
            });

            $('.collapse').on('hide.bs.collapse', function() {
                var target = $(this).attr('id');
                $('[data-target="#' + target + '"]').removeClass('active');
            });
        });

        function changeMainImage(imageSrc) {
            document.getElementById('mainImage').src = '${pageContext.request.contextPath}/' + imageSrc;
        }
    </script>
</body>
</html>
