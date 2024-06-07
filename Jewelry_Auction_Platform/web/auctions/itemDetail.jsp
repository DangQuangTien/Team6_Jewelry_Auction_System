<%@page import="dao.UserDAOImpl"%>
<%@page import="entity.product.Jewelry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Detail</title>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/upcoming.jsp">Auction</a>
                    </li>
                    <c:if test="${role == 'Member' || role == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/selling.html">Sell</a>
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
                                <a class="nav-link" href="${url}">${username}</a>
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

    <div class="container">
        <h1>Item Detail</h1>

        <%
            UserDAOImpl dao = new UserDAOImpl();
            String jewelryID = request.getParameter("jewelryID");
            Jewelry jewelry = dao.getJewelryDetails(jewelryID);
        %>
        <% if (jewelry != null) { %>
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title"><%= jewelry.getJewelryName() %></h2>
                        <img src="<%= jewelry.getPhotos() %>" class="card-img-top" alt="<%= jewelry.getJewelryName() %>">
                        <p class="card-text"><strong>Category:</strong> <%= jewelry.getCategoryName() %></p>
                        <p class="card-text"><strong>Min Price:</strong> <%= jewelry.getMinPrice() %></p>
                        <p class="card-text"><strong>Max Price:</strong> <%= jewelry.getMaxPrice() %></p>
                        <a href="#" class="btn btn-primary">Place Bid</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="additional-info">
                    <h2>Additional Information</h2>
                    <div>
                        <label for="jewelryName">Jewelry Name</label>
                        <input type="text" id="jewelryName" name="jewelryName" value="<%= jewelry.getJewelryName() %>" readonly>
                    </div>
                    <div>
                        <label for="artist">Artist</label>
                        <input type="text" id="artist" name="artist" value="<%= jewelry.getArtist() %>" readonly>
                    </div>

                    <% if ("Watch".equals(jewelry.getCategoryName())) { %>
                    <!-- Watch Fields -->
                    <div id="watchFields" class="form-section">
                        <h3>Watch Details</h3>
                        <div>
                            <label for="circa">Circa</label>
                            <input type="text" id="circa" name="circa" value="<%= jewelry.getCirca() %>" readonly>
                        </div>
                        <div>
                            <label for="material">Case Material</label>
                            <input type="text" id="material" name="material" value="<%= jewelry.getCaseDimensions() %>" readonly>
                        </div>
                        <div>
                            <label for="dial">Dial</label>
                            <input type="text" id="dial" name="dial" value="<%= jewelry.getDial() %>" readonly>
                        </div>
                        <div>
                            <label for="braceletMaterial">Bracelet Material</label>
                            <input type="text" id="braceletMaterial" name="braceletMaterial" value="<%= jewelry.getBraceletMaterial() %>" readonly>
                        </div>
                        <div>
                            <label for="caseDimensions">Case Dimensions</label>
                            <input type="text" id="caseDimensions" name="caseDimensions" value="<%= jewelry.getCaseDimensions() %>" readonly>
                        </div>
                        <div>
                            <label for="braceletSize">Bracelet Size</label>
                            <input type="text" id="braceletSize" name="braceletSize" value="<%= jewelry.getBraceletSize() %>" readonly>
                        </div>
                        <div>
                            <label for="serialNumber">Serial Number</label>
                            <input type="text" id="serialNumber" name="serialNumber" value="<%= jewelry.getSerialNumber() %>" readonly>
                        </div>
                        <div>
                            <label for="referenceNumber">Reference Number</label>
                            <input type="text" id="referenceNumber" name="referenceNumber" value="<%= jewelry.getReferenceNumber() %>" readonly>
                        </div>
                        <div>
                            <label for="caliber">Caliber</label>
                            <input type="text" id="caliber" name="caliber" value="<%= jewelry.getCaliber() %>" readonly>
                        </div>
                        <div>
                            <label for="movement">Movement</label>
                            <input type="text" id="movement" name="movement" value="<%= jewelry.getMovement() %>" readonly>
                        </div>
                        <div>
                            <label for="condition">Condition</label>
                            <input type="text" id="condition" name="condition" value="<%= jewelry.getCondition() %>" readonly>
                        </div>
                    </div>
                    <% } else if ("Bracelet".equals(jewelry.getCategoryName())) { %>
                    <!-- Bracelet Fields -->
                    <div id="braceletFields" class="form-section">
                        <h3>Bracelet Details</h3>
                        <div>
                            <label for="metal">Metal</label>
                            <input type="text" id="metal" name="metal" value="<%= jewelry.getMetal() %>" readonly>
                        </div>
                        <div>
                            <label for="gemstones">Gemstone(s)</label>
                            <input type="text" id="gemstones" name="gemstones" value="<%= jewelry.getGemstones() %>" readonly>
                        </div>
                        <div>
                            <label for="measurements">Measurements</label>
                            <input type="text" id="measurements" name="measurements" value="<%= jewelry.getMeasurements() %>" readonly>
                        </div>
                        <div>
                            <label for="weight">Weight</label>
                            <input type="text" id="weight" name="weight" value="<%= jewelry.getWeight() %>" readonly>
                        </div>
                        <div>
                            <label for="condition">Condition</label>
                            <input type="text" id="condition" name="condition" value="<%= jewelry.getCondition() %>" readonly>
                        </div>
                        <div>
                            <label for="stamped">Stamped</label>
                            <input type="text" id="stamped" name="stamped" value="<%= jewelry.getStamped() %>" readonly>
                        </div>
                    </div>
                    <% } %>
                    <div>
                        <label for="minPrice">Min Price</label>
                        <input type="text" id="minPrice" name="minPrice" value="<%= jewelry.getMinPrice() %>" readonly>
                    </div>
                    <div>
                        <label for="maxPrice">Max Price</label>
                        <input type="text" id="maxPrice" name="maxPrice" value="<%= jewelry.getMaxPrice() %>" readonly>
                    </div>
                </div>
            </div>
        </div>
        <% } else { %>
        <p>No item details available.</p>
        <% } %>
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

    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
