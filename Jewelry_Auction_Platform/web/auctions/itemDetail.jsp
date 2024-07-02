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
    display: flex;
    flex-direction: column;
    min-height: 100vh;
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
    padding-top: 10px;
    padding-bottom: 10px;
}

.navbar-brand .brand-name {
    font-size: 2em;
    font-family: 'Zapf-Chancery';
    font-weight: 700;
    color: black;
}

.navbar-brand img {
    max-width: 50px;
    height: auto;
    margin-right: 10px;
}

.nav-link {
    color: black !important;
    transition: color 0.3s;
    font-family: 'Andale Mono';
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

.navbar-nav .nav-link:hover::after {
    width: 100%;
    left: 0;
    visibility: visible;
}

.container {
    margin-top: 20px;
    flex: 1;
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
    color: #ffd700;
    border: none;
    border-radius: 50px;
    cursor: pointer;
    overflow: hidden;
    transition: background 0.3s, box-shadow 0.3s, transform 0.3s;
    margin: 5px 0;
    background-color: #000;
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
    background-color: #333;
    box-shadow: 0 4px 14px rgba(255, 112, 67, 0.4);
}

.custom-button:hover .material-icons {
    transform: translateX(5px);
}

.login-button {
    display: inline-block;
    font-size: 16px;
    padding: 10px 20px;
    color: #ffd700;
    background: none;
    border: 2px solid #ffd700;
    border-radius: 50px;
    cursor: pointer;
    overflow: hidden;
    transition: background 0.3s, color 0.3s;
    margin: 5px 0;
}

.login-button:hover {
    background: #ffd700;
    color: #000;
}

.standard-button {
    padding: 10px 20px;
    font-size: 16px;
    color: #ffd700;
    background-color: #000;
    border: none;
    border-radius: 50px;
    cursor: pointer;
    transition: background-color 0.3s ease, color 0.3s ease;
    margin: 5px 0;
    background-image: linear-gradient(to right, #000, #333);
}

.standard-button:hover {
    background-color: #333;
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
    background-color: #000;
    color: #fff;
    padding: 40px 0;
    text-align: center;
    flex-shrink: 0;
    position: relative;
    overflow: hidden;
}

.footer-logo img {
    width: 64px;
    margin-bottom: 20px;
}

footer h6 {
    font-size: 18px;
    margin-bottom: 10px;
}

footer p {
    font-size: 14px;
    margin-bottom: 20px;
}

.footer-links {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    padding: 0 20px;
    margin-bottom: 20px;
}

.footer-links div {
    margin-bottom: 15px;
}

.footer-links a {
    display: block;
    color: #ffc107;
    text-decoration: none;
    margin-bottom: 5px;
}

.footer-links a:hover {
    text-decoration: underline;
}

footer i {
    margin-right: 8px;
}

.social-media a {
    margin: 0 10px;
    color: #ffc107;
    font-size: 24px;
}

.social-media a:hover {
    color: #fff;
}

@media (max-width: 768px) {
    .footer-links {
        flex-direction: column;
        align-items: center;
    }
    
    .footer-links div {
        text-align: center;
    }
}

.footer-decoration {
    position: absolute;
    top: -20px;
    left: 50%;
    transform: translateX(-50%);
}

.footer-diamond {
    color: #ffc107;
    font-size: 50px;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.1);
    }
}

@keyframes slide {
    0% {
        left: -100%;
    }
    100% {
        left: 100%;
    }
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
                        <div class="accordion" id="shippingAccordion">
                            <div class="card octahedron-card">
                                <div class="card-header" id="headingGlobalShipping">
                                    <h5 class="mb-0">
                                        <button class="btn btn-link custom-button-shipping" type="button" data-toggle="collapse" data-target="#collapseGlobalShipping" aria-expanded="true" aria-controls="collapseGlobalShipping">
                                            <i class="fas fa-globe"></i> Global Shipping
                                        </button>
                                    </h5>
                                </div>
                                <div id="collapseGlobalShipping" class="collapse show" aria-labelledby="headingGlobalShipping" data-parent="#shippingAccordion">
                                    <div class="card-body">
                                        With customers in over 100 countries, we provide fully insured global shipping, expertly arranged by our team. The shipping costs, determined based on the insured value of the package and its destination, will be calculated post-auction and added to your invoice. Please note, VAT, duties, or any additional charges related to international shipping are not included in these costs and remain the responsibility of the buyer.
                                    </div>
                                </div>
                            </div>
                    
                            <div class="card octahedron-card">
                                <div class="card-header" id="headingPostAuctionSupport">
                                    <h5 class="mb-0">
                                        <button class="btn btn-link custom-button-shipping collapsed" type="button" data-toggle="collapse" data-target="#collapsePostAuctionSupport" aria-expanded="false" aria-controls="collapsePostAuctionSupport">
                                            <i class="fas fa-tools"></i> Post-Auction Support
                                        </button>
                                    </h5>
                                </div>
                                <div id="collapsePostAuctionSupport" class="collapse" aria-labelledby="headingPostAuctionSupport" data-parent="#shippingAccordion">
                                    <div class="card-body">
                                        As a full-service auction house, we take pride in the comprehensive range of post-auction services we offer, including ring resizing, stone replacement, and repair work. It's part of our commitment to ensure a seamless transaction and to cater to your needs even after the gavel falls. However, please note that the applicability of certain services may vary depending on the specifics of the lot. If you have any questions or need additional information such as a cost estimate, we encourage you to reach out to us.
                                    </div>
                                </div>
                            </div>
                    
                            <div class="card octahedron-card">
                                <div class="card-header" id="headingPropertySoldAsIs">
                                    <h5 class="mb-0">
                                        <button class="btn btn-link custom-button-shipping collapsed" type="button" data-toggle="collapse" data-target="#collapsePropertySoldAsIs" aria-expanded="false" aria-controls="collapsePropertySoldAsIs">
                                            <i class="fas fa-exclamation-circle"></i> Property Sold As-Is
                                        </button>
                                    </h5>
                                </div>
                                <div id="collapsePropertySoldAsIs" class="collapse" aria-labelledby="headingPropertySoldAsIs" data-parent="#shippingAccordion">
                                    <div class="card-body">
                                        Please be aware that all lots are sold "As Is". We do not guarantee that the lot is in pristine condition or devoid of imperfections, or wear and tear that is consistent with the age of the item. It falls under the buyer's responsibility to inspect the lot or request additional photos and condition details prior to bidding.
                                    </div>
                                </div>
                            </div>
                    
                            <div class="card octahedron-card">
                                <div class="card-header" id="headingBiddingGuidelines">
                                    <h5 class="mb-0">
                                        <button class="btn btn-link custom-button-shipping collapsed" type="button" data-toggle="collapse" data-target="#collapseBiddingGuidelines" aria-expanded="false" aria-controls="collapseBiddingGuidelines">
                                            <i class="fas fa-gavel"></i> Bidding Guidelines
                                        </button>
                                    </h5>
                                </div>
                                <div id="collapseBiddingGuidelines" class="collapse" aria-labelledby="headingBiddingGuidelines" data-parent="#shippingAccordion">
                                    <div class="card-body">
                                        Please remember that once you have placed a bid on FORTUNA's platform, it cannot be retracted or reduced.
                                    </div>
                                </div>
                            </div>
                    
                            <div class="card octahedron-card">
                                <div class="card-header" id="headingBuyersPremium">
                                    <h5 class="mb-0">
                                        <button class="btn btn-link custom-button-shipping collapsed" type="button" data-toggle="collapse" data-target="#collapseBuyersPremium" aria-expanded="false" aria-controls="collapseBuyersPremium">
                                            <i class="fas fa-coins"></i> Buyer's Premium and Sales Tax
                                        </button>
                                    </h5>
                                </div>
                                <div id="collapseBuyersPremium" class="collapse" aria-labelledby="headingBuyersPremium" data-parent="#shippingAccordion">
                                    <div class="card-body">
                                        A buyer's premium of 25% (30% if bidding on LiveAuctioneers, Invaluable, and Bidsquare) is applicable to all winning bids and is not included in the online bid value. We collect sales tax for lots shipped to the following states within the US: CA, CO, FL, GA, IL, MA, MD, MI, NJ, NY, OH, PA, RI, SC, TN, TX, and VA.
                                    </div>
                                </div>
                            </div>
                    
                            <div class="card octahedron-card">
                                <div class="card-header" id="headingConditionsOfSale">
                                    <h5 class="mb-0">
                                        <button class="btn btn-link custom-button-shipping collapsed" type="button" data-toggle="collapse" data-target="#collapseConditionsOfSale" aria-expanded="false" aria-controls="collapseConditionsOfSale">
                                            <i class="fas fa-file-contract"></i> Conditions of Sale
                                        </button>
                                    </h5>
                                </div>
                                <div id="collapseConditionsOfSale" class="collapse" aria-labelledby="headingConditionsOfSale" data-parent="#shippingAccordion">
                                    <div class="card-body">
                                        We encourage all potential bidders to consult our Conditions of Sale for comprehensive details. By placing a bid, you acknowledge that you have read and are bound by these conditions.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <style>
                        .octahedron-card {
                            position: relative;
                            overflow: hidden;
                            margin-bottom: 20px;
                            border: 2px solid #000;
                            border-radius: 10px;
                            background: #fff;
                        }
                    
                        .octahedron-card::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 50%;
                            width: 200%;
                            height: 200%;
                            background: linear-gradient(to bottom right, rgba(255, 215, 0, 0.3) 50%, transparent 50%);
                            transform: rotate(45deg) translate(-50%, -50%);
                            z-index: 1;
                        }
                    
                        .octahedron-card::after {
                            content: '';
                            position: absolute;
                            top: 50%;
                            left: 0;
                            width: 200%;
                            height: 200%;
                            background: linear-gradient(to top left, rgba(0, 0, 0, 0.1) 50%, transparent 50%);
                            transform: rotate(45deg) translate(-50%, -50%);
                            z-index: 1;
                        }
                    
                        .custom-button-shipping {
                            position: relative;
                            display: inline-block;
                            font-size: 16px;
                            padding: 10px 20px;
                            color: #ffd700;
                            border: none;
                            border-radius: 50px;
                            cursor: pointer;
                            overflow: hidden;
                            transition: background 0.3s, box-shadow 0.3s, transform 0.3s;
                            margin: 5px 0;
                            background-color: #000;
                            width: 100%;
                            text-align: left;
                            z-index: 2;
                        }
                    
                        .custom-button-shipping .material-icons, .custom-button-shipping i {
                            font-size: 24px;
                            vertical-align: middle;
                            margin-right: 8px;
                            transition: transform 0.3s;
                        }
                    
                        .custom-button-shipping span {
                            vertical-align: middle;
                        }
                    
                        .custom-button-shipping:hover {
                            background-color: #333;
                            box-shadow: 0 4px 14px rgba(255, 112, 67, 0.4);
                            transform: scale(1.05);
                        }
                    
                        .custom-button-shipping:hover .material-icons, .custom-button-shipping:hover i {
                            transform: translateX(5px);
                        }
                    
                        .card-body {
                            animation: fadeInUp 0.5s ease;
                            position: relative;
                            z-index: 2;
                        }
                    
                        @keyframes fadeInUp {
                            from {
                                opacity: 0;
                                transform: translateY(20px);
                            }
                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }
                    
                        .card-header {
                            background-color: #f8f9fa;
                            position: relative;
                            z-index: 2;
                        }
                    
                        .btn-link {
                            text-decoration: none;
                        }
                        
                        .btn-link.collapsed {
                            color: #666;
                        }
                        
                        .btn-link:not(.collapsed) {
                            color: #ffd700;
                        }
                    
                        .btn-link:hover {
                            text-decoration: none;
                        }
                    </style>
                                                                                                                  
                </div>
            </div>
        </div>
    </div>
    <% } else { %>
    <p>No item details available.</p>
    <% } %>
    
    <footer class="text-center py-4 mt-auto">
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
            <div class="footer-diamond">
                <i class="fas fa-gem"></i>
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
