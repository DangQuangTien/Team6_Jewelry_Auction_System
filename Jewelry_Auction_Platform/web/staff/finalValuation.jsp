<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="asset/finalValuation.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Staff Portal</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/staff/staff.jsp"><i class="fas fa-user"></i> Staff</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/MainController?action=ValuationRequest"><i class="fas fa-file-invoice-dollar"></i> Valuation Request</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/staff/approvalRequest.jsp"><i class="fas fa-thumbs-up"></i> Approval Request</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/staff/finalValuation.jsp"><i class="fas fa-check-double"></i> Final Valuation</a>
            </li>
            <li class="nav-item">
                <form action="${pageContext.request.contextPath}/MainController" method="POST" onsubmit="confirmLogout(event)">
                    <button type="submit" name="action" class="btn btn-link nav-link" value="Log out"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-5">
    <%
        UserDAOImpl dao = new UserDAOImpl();
        List<Jewelry> listJewelry = dao.displayAllJewelryForStaff();
        if (listJewelry != null && !listJewelry.isEmpty()) {
    %>
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="thead-light">
                <tr>
                    <th>Photo</th>
                    <th>Jewelry Name</th>
                    <th>Artist</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Jewelry jewelry : listJewelry) { %>
                <tr>
                    <% String[] photoArray = jewelry.getPhotos().split(";"); %>
                    <td><img class="img-thumbnail" style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%= photoArray[0] %>"></td>
                    <td><%= jewelry.getJewelryName() %></td>
                    <td><%= jewelry.getArtist() %></td>
                    <td><button class="btn btn-info" data-toggle="modal" data-target="#detailsModal" onclick="showDetails(<%= jewelry.getJewelryID() %>)">Show Details</button></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } else { %>
    <p class="alert alert-warning">No jewelry found</p>
    <% } %>
</div>

<!-- Modal -->
<div class="modal fade" id="detailsModal" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailsModalLabel">Jewelry Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <tr>
                        <th>Circa</th><td id="circa"></td>
                        <th>Material</th><td id="material"></td>
                        <th>Dial</th><td id="dial"></td>
                        <th>Bracelet Material</th><td id="braceletMaterial"></td>
                    </tr>
                    <tr>
                        <th>Case Dimensions</th><td id="caseDimensions"></td>
                        <th>Bracelet Size</th><td id="braceletSize"></td>
                        <th>Serial Number</th><td id="serialNumber"></td>
                        <th>Reference Number</th><td id="referenceNumber"></td>
                    </tr>
                    <tr>
                        <th>Caliber</th><td id="caliber"></td>
                        <th>Movement</th><td id="movement"></td>
                        <th>Condition</th><td id="condition"></td>
                        <th>Metal</th><td id="metal"></td>
                    </tr>
                    <tr>
                        <th>Gemstones</th><td id="gemstones"></td>
                        <th>Measurements</th><td id="measurements"></td>
                        <th>Weight</th><td id="weight"></td>
                        <th>Stamped</th><td id="stamped"></td>
                    </tr>
                    <tr>
                        <th>Ring Size</th><td id="ringSize"></td>
                        <form action="MainController" method="GET">
                            <input type="hidden" name="jewelryID" id="jewelryID">
                            <th>Final Price</th><td><input type="number" name="finalPrice" id="finalPrice" required></td>
                            <td><input type="submit" name="action" value="Send" class="btn btn-success"></td>
                        </form>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="asset/finalValuation.js"></script>
<script>
    function showDetails(jewelryID) {
        
        var jewelry = jewelryDetails[jewelryID];
        
        // Fill modal with jewelry details
        document.getElementById('circa').innerText = jewelry.circa;
        document.getElementById('material').innerText = jewelry.material;
        document.getElementById('dial').innerText = jewelry.dial;
        document.getElementById('braceletMaterial').innerText = jewelry.braceletMaterial;
        document.getElementById('caseDimensions').innerText = jewelry.caseDimensions;
        document.getElementById('braceletSize').innerText = jewelry.braceletSize;
        document.getElementById('serialNumber').innerText = jewelry.serialNumber;
        document.getElementById('referenceNumber').innerText = jewelry.referenceNumber;
        document.getElementById('caliber').innerText = jewelry.caliber;
        document.getElementById('movement').innerText = jewelry.movement;
        document.getElementById('condition').innerText = jewelry.condition;
        document.getElementById('metal').innerText = jewelry.metal;
        document.getElementById('gemstones').innerText = jewelry.gemstones;
        document.getElementById('measurements').innerText = jewelry.measurements;
        document.getElementById('weight').innerText = jewelry.weight;
        document.getElementById('stamped').innerText = jewelry.stamped;
        document.getElementById('ringSize').innerText = jewelry.ringSize;
        document.getElementById('finalPrice').value = jewelry.finalPrice;
        document.getElementById('jewelryID').value = jewelryID;
    }
</script>
</body>
</html>

