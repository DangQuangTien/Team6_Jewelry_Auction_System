<%-- 
    Document   : manager
    Created on : May 23, 2024, 1:23:38 AM
    Author     : User
--%>
<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="java.time.LocalTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="asset/finalValuation.css">
    <style>
        .details-row {
            display: none;
        }
    </style>
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
                    <td><button class="btn btn-info" onclick="toggleDetails(this)">Show Details</button></td>
                </tr>
                <tr class="details-row">
                    <td colspan="4">
                        <table class="table table-bordered">
                            <tr>
                                <th>Circa</th><td><%= jewelry.getCirca() %></td>
                                <th>Material</th><td><%= jewelry.getMaterial() %></td>
                                <th>Dial</th><td><%= jewelry.getDial() %></td>
                                <th>Bracelet Material</th><td><%= jewelry.getBraceletMaterial() %></td>
                            </tr>
                            <tr>
                                <th>Case Dimensions</th><td><%= jewelry.getCaseDimensions() %></td>
                                <th>Bracelet Size</th><td><%= jewelry.getBraceletSize() %></td>
                                <th>Serial Number</th><td><%= jewelry.getSerialNumber() %></td>
                                <th>Reference Number</th><td><%= jewelry.getReferenceNumber() %></td>
                            </tr>
                            <tr>
                                <th>Caliber</th><td><%= jewelry.getCaliber() %></td>
                                <th>Movement</th><td><%= jewelry.getMovement() %></td>
                                <th>Condition</th><td><%= jewelry.getCondition() %></td>
                                <th>Metal</th><td><%= jewelry.getMetal() %></td>
                            </tr>
                            <tr>
                                <th>Gemstones</th><td><%= jewelry.getGemstones() %></td>
                                <th>Measurements</th><td><%= jewelry.getMeasurements() %></td>
                                <th>Weight</th><td><%= jewelry.getWeight() %></td>
                                <th>Stamped</th><td><%= jewelry.getStamped() %></td>
                            </tr>
                            <tr>
                                <th>Ring Size</th><td><%= jewelry.getRingSize() %></td>
                                <form action="MainController" method="GET">
                                    <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                                    <th>Final Price</th><td><input type="number" name="finalPrice" value="<%= jewelry.getFinal_Price() %>" required></td>
                                    <td><input type="submit" name="action" value="Send" class="btn btn-success"></td>
                                </form>
                            </tr>
                        </table>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } else { %>
    <p class="alert alert-warning">No jewelry found</p>
    <% } %>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="asset/finalValuation.js"></script>
<script>
    function toggleDetails(button) {
        var row = button.closest('tr').nextElementSibling;
        if (row.style.display === 'none' || row.style.display === '') {
            row.style.display = 'table-row';
            button.textContent = 'Hide Details';
        } else {
            row.style.display = 'none';
            button.textContent = 'Show Details';
        }
    }
</script>
</body>
</html>
