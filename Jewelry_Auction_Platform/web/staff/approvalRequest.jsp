<%-- 
    Document   : approvalRequest
    Created on : Jun 4, 2024, 8:41:54 AM
    Author     : User
--%>

<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pending Review Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="approvalRequest.css">
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
            
        
        <div class="container">
            <h1 class="text-center text-primary my-4">Approval Requests</h1>
            <%
                UserDAOImpl dao = new UserDAOImpl();
                List<Jewelry> listJewelry = dao.displayApprovedJewelry();
                if (listJewelry != null && !listJewelry.isEmpty()) {
            %>
            <div class="table-responsive">
                <table id="approvalTable" class="table table-bordered table-hover">
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
                            <td><img class="img-thumbnail" src="${pageContext.request.contextPath}/<%= photoArray[0] %>" alt="Jewelry Image"></td>
                            <td><%= jewelry.getJewelryName() %></td>
                            <td><%= jewelry.getArtist() %></td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm view-btn mr-2" data-toggle="modal" data-target="#detailModal" 
                                    data-photo="<%= photoArray[0] %>" 
                                    data-name="<%= jewelry.getJewelryName() %>" 
                                    data-artist="<%= jewelry.getArtist() %>" 
                                    data-circa="<%= jewelry.getCirca() %>" 
                                    data-material="<%= jewelry.getMaterial() %>" 
                                    data-dial="<%= jewelry.getDial() %>" 
                                    data-braceletmaterial="<%= jewelry.getBraceletMaterial() %>" 
                                    data-casedimensions="<%= jewelry.getCaseDimensions() %>" 
                                    data-braceletsize="<%= jewelry.getBraceletSize() %>" 
                                    data-serialnumber="<%= jewelry.getSerialNumber() %>" 
                                    data-referencenumber="<%= jewelry.getReferenceNumber() %>" 
                                    data-caliber="<%= jewelry.getCaliber() %>" 
                                    data-movement="<%= jewelry.getMovement() %>" 
                                    data-condition="<%= jewelry.getCondition() %>" 
                                    data-metal="<%= jewelry.getMetal() %>" 
                                    data-gemstones="<%= jewelry.getGemstones() %>" 
                                    data-measurements="<%= jewelry.getMeasurements() %>" 
                                    data-weight="<%= jewelry.getWeight() %>" 
                                    data-stamped="<%= jewelry.getStamped() %>" 
                                    data-ringsize="<%= jewelry.getRingSize() %>"
                                    data-finalprice="<%= jewelry.getFinal_Price() %>">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <form action="${pageContext.request.contextPath}/MainController" method="GET" onsubmit="confirmSend(event)" class="d-inline">
                                    <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                                    <button type="submit" name="action" class="btn btn-success btn-sm" value="Send to Seller"><i class="fas fa-paper-plane"></i> Send to Seller</button>
                                </form>
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

        <!-- Modal -->
        <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detailModalLabel">Jewelry Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <img id="modal-photo" src="" class="img-thumbnail" alt="Jewelry Image">
                        </div>
                        <table class="table table-bordered mt-3">
                            <tbody>
                                <tr><th>Jewelry Name</th><td id="modal-name"></td></tr>
                                <tr><th>Artist</th><td id="modal-artist"></td></tr>
                                <tr><th>Circa</th><td id="modal-circa"></td></tr>
                                <tr><th>Material</th><td id="modal-material"></td></tr>
                                <tr><th>Dial</th><td id="modal-dial"></td></tr>
                                <tr><th>Bracelet Material</th><td id="modal-braceletmaterial"></td></tr>
                                <tr><th>Case Dimensions</th><td id="modal-casedimensions"></td></tr>
                                <tr><th>Bracelet Size</th><td id="modal-braceletsize"></td></tr>
                                <tr><th>Serial Number</th><td id="modal-serialnumber"></td></tr>
                                <tr><th>Reference Number</th><td id="modal-referencenumber"></td></tr>
                                <tr><th>Caliber</th><td id="modal-caliber"></td></tr>
                                <tr><th>Movement</th><td id="modal-movement"></td></tr>
                                <tr><th>Condition</th><td id="modal-condition"></td></tr>
                                <tr><th>Metal</th><td id="modal-metal"></td></tr>
                                <tr><th>Gemstones</th><td id="modal-gemstones"></td></tr>
                                <tr><th>Measurements</th><td id="modal-measurements"></td></tr>
                                <tr><th>Weight</th><td id="modal-weight"></td></tr>
                                <tr><th>Stamped</th><td id="modal-stamped"></td></tr>
                                <tr><th>Ring Size</th><td id="modal-ringsize"></td></tr>
                                <tr><th>Final Price</th><td id="modal-finalprice"></td></tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="approvalRequest.js"></script>
    </body>
</html>