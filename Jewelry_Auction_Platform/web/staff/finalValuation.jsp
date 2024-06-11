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
                        <form action="${pageContext.request.contextPath}/MainController" method="GET" onsubmit="confirmAuction(event)">
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
                <div class="modal fade" id="detailsModal<%= jewelry.getJewelryID() %>" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel<%= jewelry.getJewelryID() %>" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="detailsModalLabel<%= jewelry.getJewelryID() %>"><%= jewelry.getJewelryName() %> Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p><strong>Artist:</strong> <%= jewelry.getArtist() %></p>
                                <p><strong>Circa:</strong> <%= jewelry.getCirca() %></p>
                                <p><strong>Material:</strong> <%= jewelry.getMaterial() %></p>
                                <p><strong>Dial:</strong> <%= jewelry.getDial() %></p>
                                <p><strong>Bracelet Material:</strong> <%= jewelry.getBraceletMaterial() %></p>
                                <p><strong>Case Dimensions:</strong> <%= jewelry.getCaseDimensions() %></p>
                                <p><strong>Bracelet Size:</strong> <%= jewelry.getBraceletSize() %></p>
                                <p><strong>Serial Number:</strong> <%= jewelry.getSerialNumber() %></p>
                                <p><strong>Reference Number:</strong> <%= jewelry.getReferenceNumber() %></p>
                                <p><strong>Caliber:</strong> <%= jewelry.getCaliber() %></p>
                                <p><strong>Movement:</strong> <%= jewelry.getMovement() %></p>
                                <p><strong>Condition:</strong> <%= jewelry.getCondition() %></p>
                                <p><strong>Metal:</strong> <%= jewelry.getMetal() %></p>
                                <p><strong>Gemstones:</strong> <%= jewelry.getGemstones() %></p>
                                <p><strong>Measurements:</strong> <%= jewelry.getMeasurements() %></p>
                                <p><strong>Weight:</strong> <%= jewelry.getWeight() %></p>
                                <p><strong>Stamped:</strong> <%= jewelry.getStamped() %></p>
                                <p><strong>Ring Size:</strong> <%= jewelry.getRingSize() %></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
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
<script>
    function confirmAuction(event) {
        if (!confirm('Are you sure you want to send this final price?')) {
            event.preventDefault();
        }
    }

    function confirmLogout(event) {
        if (!confirm('Are you sure you want to log out?')) {
            event.preventDefault();
        }
    }
</script>
</body>
</html>                              