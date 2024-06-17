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
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= jewelry.getJewelryName()%> | Global F'Rankelly 's Premier Jewelry Auction House</title>
        <link rel="icon" type="image/png" sizes="64x64" href="../images/logo/Logo.png">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="../component/header.css">
        <link rel="stylesheet" type="text/css" href="../component/footer.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 20px;
            }
            .card {
                margin-top: 20px;
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
            .btn-primary {
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <c:set var="username" value="${sessionScope.USERNAME}" />
        <c:set var="role" value="${sessionScope.ROLE}" />
        <!-- START OF HEADER -->
        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="navbar-brand" href="#">Jewelry Auctions</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home.jsp">Home<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auctions/upcoming.jsp">Auction</a>
                        </li>
                        <c:if test="${role == 'Member' || role == null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/seller/selling.html">Sell</a>
                            </li>
                        </c:if>
                        <c:choose>
                            <c:when test="${username == null}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Register</a>
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
                                    <a class="nav-link" href="${pageContext.request.contextPath}/${url}">${username}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
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
        </header>
        <!-- END OF HEADER -->

        <%
            String userID = (String) session.getAttribute("USERID");
            Member member = dao.getInformation(userID);
            int status = 1;
            if (member != null) {
                status = member.getStatus();
            }
            if (jewelry != null) {
                String photos = jewelry.getPhotos();
                String[] photoArray = photos.split(";");
        %>
        <div class="container"> 
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <img src="${pageContext.request.contextPath}/<%=photoArray[0]%>" class="card-img-top">
                            <% for (int i = 0; i < photoArray.length; i++) {%><img style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%= photoArray[i]%>"><% }%>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="additional-info">
                        <h2><%= jewelry.getJewelryID()%></h2>
                        <h2><%= jewelry.getJewelryName()%></h2>
                        <div>Estimate: $<%= jewelry.getMinPrice()%> - $<%= jewelry.getMaxPrice()%></div>
                        <% if (status == 0 && member != null){ %>
                        <a href="registerBid.jsp?auctionID=<%= request.getParameter("auctionID")%>" class="btn btn-primary">PLACE BID</a>
                        <% } else if (status == 1 && member != null){ %>
                         <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal">PLACE BID</button>
                         <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal_">EDIT BID</button>
                        <% } else { %>
                        <a href="../login.jsp" class="btn btn-primary">PLACE BID</a>
                        <% } %>
                        <div>Live Auction</div>
                        <a href="detail.jsp?auctionID=<%= request.getParameter("auctionID")%>">Fine Jewels & Watches</a>
                        <div>Artist</div>
                        <div style="color: #0089ba"><%= jewelry.getArtist()%></div>
                        <% if ("Watch".equals(jewelry.getCategoryName())) {%>
                        <!-- Watch Fields -->
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
                        <% } else if ("Bracelet".equals(jewelry.getCategoryName())) {%>
                        <!-- Bracelet Fields -->
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
                        <% }%>
                    </div>
                    <div>Global Shipping</div>
                    <p>With customers in over 100 countries, we provide fully insured global shipping, expertly arranged by our team. The shipping costs, determined based on the insured value of the package and its destination, will be calculated post-auction and added to your invoice. Please note, VAT, duties, or any additional charges related to international shipping are not included in these costs and remain the responsibility of the buyer.</p>
                    <div>Post-Auction Support</div>
                    <p>As a full-service auction house, we take pride in the comprehensive range of post-auction services we offer, including ring resizing, stone replacement, and repair work. It's part of our commitment to ensure a seamless transaction and to cater to your needs even after the gavel falls. However, please note that the applicability of certain services may vary depending on the specifics of the lot. If you have any questions or need additional information such as a cost estimate, we encourage you to reach out to us.</p>
                    <div>Property Sold As-Is</div>
                    <p>Please be aware that all lots are sold "As Is". We do not guarantee that the lot is in pristine condition or devoid of imperfections, or wear and tear that is consistent with the age of the item. It falls under the buyer's responsibility to inspect the lot or request additional photos and condition details prior to bidding.</p>
                    <div>Bidding Guidelines</div>
                    <p>Please remember that once you have placed a bid on FORTUNA's platform, it cannot be retracted or reduced.</p>
                    <div>Buyer's Premium and Sales Tax</div>
                    <p>A buyer's premium of 25% (30% if bidding on LiveAuctioneers, Invaluable, and Bidsquare) is applicable to all winning bids and is not included in the online bid value.
                        We collect sales tax for lots shipped to the following states within the US: CA, CO, FL, GA, IL, MA, MD, MI, NJ, NY, OH, PA, RI, SC, TN, TX, and VA.</p>
                    <div>Conditions of Sale</div>
                    <p>We encourage all potential bidders to consult our Conditions of Sale for comprehensive details. By placing a bid, you acknowledge that you have read and are bound by these conditions.</p>
                </div>
            </div>
            <% } else { %>
            <p>No item details available.</p>
            <% }%>
        </div>

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
        <% String preBid_Amount = (String) request.getParameter("preBid_Amount");%>
<div class="modal fade" id="bidModal" tabindex="-1" role="dialog" aria-labelledby="bidModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bidModalLabel">Place Your Bid</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="bidForm" action="${pageContext.request.contextPath}/MainController" method="GET">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="bidAmount">Enter your bid amount:</label>
                            <input type="number" class="form-control" id="bidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                        </div>
                            <input type="hidden" id="auctionID" name="auctionID" value="<%= request.getParameter("auctionID") %>">
                        <input type="hidden" id="jewelryID" name="jewelryID" value="<%= request.getParameter("jewelryID") %>">
                        <input type="hidden" name="action" value="Place Bid">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Place Bid</button>
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
                <form id="editBidForm_" action="${pageContext.request.contextPath}/MainController" method="GET">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="editBidAmount">Enter your new bid amount:</label>
                            <input type="number" class="form-control" id="editBidAmount" name="preBid_Amount" value="<%= (preBid_Amount != null) ? preBid_Amount : ""%>" required>
                        </div>
                        <input type="hidden" id="auctionID" name="auctionID" value="<%= request.getParameter("auctionID") %>">
                        <input type="hidden" id="jewelryID" name="jewelryID" value="<%= request.getParameter("jewelryID") %>">
                        <input type="hidden" name="action" value="Edit Bid">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Edit Bid</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
        <!-- Include Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
