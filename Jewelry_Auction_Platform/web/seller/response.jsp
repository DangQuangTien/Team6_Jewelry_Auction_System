<%@page import="entity.request_shipment.RequestShipment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.product.Jewelry"%>
<%@page import="dao.UserDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Notification</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="asset/response.css">
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 60%;
            max-width: 700px;
            box-shadow: 0 5px 15px rgba(0,0,0,.5);
            border-radius: 10px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .img-fluid {
            max-width: 100px;
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Jewelry Auctions</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/seller/request.jsp">Request A Valuation</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/seller/shipmentRequest.jsp">Notification</a>
                </li>
            </ul>
        </div>
    </nav>
</header>
<div class="container mt-4">
    <h1 class="text-center text-primary">Overall Assessment for your requests</h1>
    <%
        String userID = (String) session.getAttribute("USERID");
        UserDAOImpl dao = new UserDAOImpl();
        List<Jewelry> listJewelry = dao.getJewelryByUserID(userID);
        if (listJewelry != null && !listJewelry.isEmpty()) {
    %>
    <div class="table-responsive mt-4">
        <table id="jewelryTable" class="table table-bordered table-hover">
            <thead class="thead-light">
                <tr>
                    <th>Photo</th>
                    <th>Jewelry Name</th>
                    <th>Temporary Price</th>
                    <th>Final Price</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="jewelryTableBody">
                <% for (Jewelry jewelry : listJewelry) {%>
                <tr>
                    <% String[] photoArray = jewelry.getPhotos().split(";");%>
                    <td><img class="img-fluid" src="${pageContext.request.contextPath}/<%= photoArray[0]%>" alt="Jewelry Image"></td>
                    <td><%= jewelry.getJewelryName()%></td>
                    <td><%= jewelry.getTemp_Price()%></td>
                    <% String status = jewelry.getStatus(); %>
                    <td><%= (jewelry.getFinal_Price() != null) ? jewelry.getFinal_Price() : "Updating"%></td>
                    <% if (status != null && status.equals("Re-Evaluated")) {%>
                    <td class="text-danger">Waiting for shipment</td>
                    <% } else if (status.equals("Received")) {%>
                    <td class="text-success">Received</td>
                    <% } else if (status.equals("Pending Confirm")) {%>
                    <td class="text-warning"><strong>Pending Confirm</strong></td>
                    <% } else if (status.equals("Confirmed")) {%>
                    <td class="text-info">Ready To Auction</td>
                    <% } else { %>
                    <td class="text-secondary">In Progress</td>
                    <% } %>
                    <td>
                        <button class="btn btn-primary view-details" data-id="<%= jewelry.getJewelryID() %>" data-details='{
                            "photo": "${pageContext.request.contextPath}/<%= photoArray[0] %>",
                            "name": "<%= jewelry.getJewelryName() %>",
                            "artist": "<%= jewelry.getArtist() %>",
                            "circa": "<%= jewelry.getCirca() %>",
                            "material": "<%= jewelry.getMaterial() %>",
                            "dial": "<%= jewelry.getDial() %>",
                            "braceletMaterial": "<%= jewelry.getBraceletMaterial() %>",
                            "caseDimensions": "<%= jewelry.getCaseDimensions() %>",
                            "braceletSize": "<%= jewelry.getBraceletSize() %>",
                            "serialNumber": "<%= jewelry.getSerialNumber() %>",
                            "referenceNumber": "<%= jewelry.getReferenceNumber() %>",
                            "caliber": "<%= jewelry.getCaliber() %>",
                            "movement": "<%= jewelry.getMovement() %>",
                            "condition": "<%= jewelry.getCondition() %>",
                            "metal": "<%= jewelry.getMetal() %>",
                            "gemstones": "<%= jewelry.getGemstones() %>",
                            "measurements": "<%= jewelry.getMeasurements() %>",
                            "weight": "<%= jewelry.getWeight() %>",
                            "stamped": "<%= jewelry.getStamped() %>",
                            "ringSize": "<%= jewelry.getRingSize() %>",
                            "minPrice": "<%= jewelry.getMinPrice() %>",
                            "maxPrice": "<%= jewelry.getMaxPrice() %>",
                            "tempPrice": "<%= jewelry.getTemp_Price() %>",
                            "finalPrice": "<%= (jewelry.getFinal_Price() != null) ? jewelry.getFinal_Price() : "Updating" %>",
                            "status": "<%= jewelry.getStatus() %>"
                        }'>View</button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } else { %>
    <p class="no-jewelry text-center">No jewelry found</p>
    <% }%>
</div>

<!-- The Modal -->
<div id="jewelryModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div id="jewelryDetails"></div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        // Get the modal
        var modal = document.getElementById("jewelryModal");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        // Event listener for view buttons
        $(document).on('click', '.view-details', function () {
            var details = $(this).data('details');
            var detailsHtml = '<table class="table table-striped">' +
                '<tr><th>Jewelry Name</th><td>' + details.name + '</td></tr>' +
                '<tr><th>Photo</th><td><img class="img-fluid" src="' + details.photo + '" alt="Jewelry Image"></td></tr>' +
                '<tr><th>Artist</th><td>' + details.artist + '</td></tr>' +
                '<tr><th>Circa</th><td>' + details.circa + '</td></tr>' +
                '<tr><th>Material</th><td>' + details.material + '</td></tr>' +
                '<tr><th>Dial</th><td>' + details.dial + '</td></tr>' +
                '<tr><th>Bracelet Material</th><td>' + details.braceletMaterial + '</td></tr>' +
                '<tr><th>Case Dimensions</th><td>' + details.caseDimensions + '</td></tr>' +
                '<tr><th>Bracelet Size</th><td>' + details.braceletSize + '</td></tr>' +
                '<tr><th>Serial Number</th><td>' + details.serialNumber + '</td></tr>' +
                '<tr><th>Reference Number</th><td>' + details.referenceNumber + '</td></tr>' +
                '<tr><th>Caliber</th><td>' + details.caliber + '</td></tr>' +
                '<tr><th>Movement</th><td>' + details.movement + '</td></tr>' +
                '<tr><th>Condition</th><td>' + details.condition + '</td></tr>' +
                '<tr><th>Metal</th><td>' + details.metal + '</td></tr>' +
                '<tr><th>Gemstones</th><td>' + details.gemstones + '</td></tr>' +
                '<tr><th>Measurements</th><td>' + details.measurements + '</td></tr>' +
                '<tr><th>Weight</th><td>' + details.weight + '</td></tr>' +
                '<tr><th>Stamped</th><td>' + details.stamped + '</td></tr>' +
                '<tr><th>Ring Size</th><td>' + details.ringSize + '</td></tr>' +
                '<tr><th>Min Price</th><td>' + details.minPrice + '</td></tr>' +
                '<tr><th>Max Price</th><td>' + details.maxPrice + '</td></tr>' +
                '<tr><th>Temporary Price</th><td>' + details.tempPrice + '</td></tr>' +
                '<tr><th>Final Price</th><td>' + details.finalPrice + '</td></tr>' +
                '<tr><th>Status</th><td>' + details.status + '</td></tr>' +
                '</table>';

            $('#jewelryDetails').html(detailsHtml);
            modal.style.display = "block";
        });
    });
</script>
</body>
</html>
