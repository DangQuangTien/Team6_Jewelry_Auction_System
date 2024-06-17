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
                    <a class="nav-link" href="${pageContext.request.contextPath}/MainController?action=Valuation Request"><i class="fas fa-file-invoice-dollar"></i> Valuation Request</a>
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
        <table id="approvalTable" class="table table-bordered table-hover">
            <thead class="thead-light">
                <tr>
                    <th>Photo</th>
                    <th>Jewelry Name</th>
                    <th>Final Price</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Jewelry jewelry : listJewelry) { %>
                <tr>
                    <% String[] photoArray = jewelry.getPhotos().split(";"); %>
                    <td>
                        <img class="img-thumbnail" style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%= photoArray[0] %>">
                    </td>
                    <td><%= jewelry.getJewelryName() %></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/MainController" method="POST" onsubmit="confirmAuction(event)">
                            <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                            <input type="number" name="finalPrice" value="<%= jewelry.getFinal_Price() %>" required>
                            <td>
                                <input type="submit" name="action" value="Send">
                                <button type="button" class="btn btn-info btn-sm ml-2" data-toggle="modal" data-target="#detailsModal<%= jewelry.getJewelryID() %>">Details</button>
                            </td>
                        </form>
                    </td>
                </tr>

                <!-- Modal -->
<!-- Modal -->
<div class="modal fade" id="detailsModal<%= jewelry.getJewelryID() %>" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel<%= jewelry.getJewelryID() %>" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/UpdateJewelry" method="POST">
                <div class="modal-header">
                    <h5 class="modal-title" id="detailsModalLabel<%= jewelry.getJewelryID() %>"><%= jewelry.getJewelryName() %> Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Include hidden field for Jewelry ID -->
                    <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                    <!-- Group 1: General Information -->
                    <h6>General Information</h6>
                    <div class="form-group">
                        <label for="artist<%= jewelry.getJewelryID() %>">Artist:</label>
                        <input type="text" class="form-control" id="artist<%= jewelry.getJewelryID() %>" name="artist" value="<%= jewelry.getArtist() %>">
                    </div>
                    <div class="form-group">
                        <label for="circa<%= jewelry.getJewelryID() %>">Circa:</label>
                        <input type="text" class="form-control" id="circa<%= jewelry.getJewelryID() %>" name="circa" value="<%= jewelry.getCirca() %>">
                    </div>
                    <div class="form-group">
                        <label for="condition<%= jewelry.getJewelryID() %>">Condition:</label>
                        <input type="text" class="form-control" id="condition<%= jewelry.getJewelryID() %>" name="condition" value="<%= jewelry.getCondition() %>">
                    </div>
                    <div class="form-group">
                        <label for="stamped<%= jewelry.getJewelryID() %>">Stamped:</label>
                        <input type="text" class="form-control" id="stamped<%= jewelry.getJewelryID() %>" name="stamped" value="<%= jewelry.getStamped() %>">
                    </div>

                    <!-- Group 2: Material Information -->
                    <h6>Material Information</h6>
                    <div class="form-group">
                        <label for="material<%= jewelry.getJewelryID() %>">Material:</label>
                        <input type="text" class="form-control" id="material<%= jewelry.getJewelryID() %>" name="material" value="<%= jewelry.getMaterial() %>">
                    </div>
                    <div class="form-group">
                        <label for="metal<%= jewelry.getJewelryID() %>">Metal:</label>
                        <input type="text" class="form-control" id="metal<%= jewelry.getJewelryID() %>" name="metal" value="<%= jewelry.getMetal() %>">
                    </div>
                    <div class="form-group">
                        <label for="gemstones<%= jewelry.getJewelryID() %>">Gemstones:</label>
                        <input type="text" class="form-control" id="gemstones<%= jewelry.getJewelryID() %>" name="gemstones" value="<%= jewelry.getGemstones() %>">
                    </div>

                    <!-- Group 3: Size and Weight -->
                    <h6>Size and Weight</h6>
                    <div class="form-group">
                        <label for="measurements<%= jewelry.getJewelryID() %>">Measurements:</label>
                        <input type="text" class="form-control" id="measurements<%= jewelry.getJewelryID() %>" name="measurements" value="<%= jewelry.getMeasurements() %>">
                    </div>
                    <div class="form-group">
                        <label for="weight<%= jewelry.getJewelryID() %>">Weight:</label>
                        <input type="text" class="form-control" id="weight<%= jewelry.getJewelryID() %>" name="weight" value="<%= jewelry.getWeight() %>">
                    </div>
                    <div class="form-group">
                        <label for="ringSize<%= jewelry.getJewelryID() %>">Ring Size:</label>
                        <input type="text" class="form-control" id="ringSize<%= jewelry.getJewelryID() %>" name="ringSize" value="<%= jewelry.getRingSize() %>">
                    </div>

                    <!-- Group 4: Bracelet/Watch Details (if applicable) -->
                    <h6>Bracelet/Watch Details</h6>
                    <div class="form-group">
                        <label for="dial<%= jewelry.getJewelryID() %>">Dial:</label>
                        <input type="text" class="form-control" id="dial<%= jewelry.getJewelryID() %>" name="dial" value="<%= jewelry.getDial() %>">
                    </div>
                    <div class="form-group">
                        <label for="braceletMaterial<%= jewelry.getJewelryID() %>">Bracelet Material:</label>
                        <input type="text" class="form-control" id="braceletMaterial<%= jewelry.getJewelryID() %>" name="braceletMaterial" value="<%= jewelry.getBraceletMaterial() %>">
                    </div>
                    <div class="form-group">
                        <label for="braceletSize<%= jewelry.getJewelryID() %>">Bracelet Size:</label>
                        <input type="text" class="form-control" id="braceletSize<%= jewelry.getJewelryID() %>" name="braceletSize" value="<%= jewelry.getBraceletSize() %>">
                    </div>
                    <div class="form-group">
                        <label for="caseDimensions<%= jewelry.getJewelryID() %>">Case Dimensions:</label>
                        <input type="text" class="form-control" id="caseDimensions<%= jewelry.getJewelryID() %>" name="caseDimensions" value="<%= jewelry.getCaseDimensions() %>">
                    </div>

                    <!-- Group 5: Additional Information -->
                    <h6>Additional Information</h6>
                    <div class="form-group">
                        <label for="serialNumber<%= jewelry.getJewelryID() %>">Serial Number:</label>
                        <input type="text" class="form-control" id="serialNumber<%= jewelry.getJewelryID() %>" name="serialNumber" value="<%= jewelry.getSerialNumber() %>">
                    </div>
                    <div class="form-group">
                        <label for="referenceNumber<%= jewelry.getJewelryID() %>">Reference Number:</label>
                        <input type="text" class="form-control" id="referenceNumber<%= jewelry.getJewelryID() %>" name="referenceNumber" value="<%= jewelry.getReferenceNumber() %>">
                    </div>
                    <div class="form-group">
                        <label for="caliber<%= jewelry.getJewelryID() %>">Caliber:</label>
                        <input type="text" class="form-control" id="caliber<%= jewelry.getJewelryID() %>" name="caliber" value="<%= jewelry.getCaliber() %>">
                    </div>
                    <div class="form-group">
                        <label for="movement<%= jewelry.getJewelryID() %>">Movement:</label>
                        <input type="text" class="form-control" id="movement<%= jewelry.getJewelryID() %>" name="movement" value="<%= jewelry.getMovement() %>">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
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
</body>
</html>                              