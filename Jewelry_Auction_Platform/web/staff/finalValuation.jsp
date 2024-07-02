<%-- 
    Document   : manager
    Created on : May 23, 2024, 1:23:38 AM
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
        <title>Final Valuation</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="asset/finalValuation.css">
        <style>
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                bottom: 0;
                width: 250px;
                background-color: #343a40;
                padding-top: 20px;
                overflow-y: auto;
                z-index: 1000;
                color: #fff;
                transition: width 0.3s;
            }
            .sidebar:hover {
                width: 280px;
            }
            .sidebar-brand {
                font-size: 1.5rem;
                font-weight: bold;
                text-align: center;
                margin-bottom: 20px;
                color: #fff;
            }
            .nav-link {
                color: #adb5bd;
                transition: color 0.3s;
            }
            .nav-link:hover {
                color: #fff;
                text-decoration: none;
            }
            .nav-link.active {
                color: #fff;
                font-weight: bold;
            }
            .nav-item {
                margin-bottom: 10px;
            }
            .sidebar .nav-item .nav-link i {
                width: 24px;
                text-align: center;
                margin-right: 10px;
            }

            /* Greeting container */
            .greeting-container {
                background-color: #f8f9fa;
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                text-align: center;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                animation: fadeInUp 0.5s ease;
            }
            .greeting {
                font-size: 1.5rem;
                margin-bottom: 5px;
                color: #007bff; /* Adjusted color */
            }
            .greeting-message {
                font-size: 1rem;
                color: #6c757d;
            }

            /* Modal */
            .modal {
                transition: opacity 0.3s ease;
            }
            .modal.fade .modal-dialog {
                transition: transform 0.3s ease-out, opacity 0.3s ease-out;
                transform: translate(0, -50px);
                opacity: 0;
            }
            .modal.show .modal-dialog {
                transform: translate(0, 0);
                opacity: 1;
            }
            .modal-header {
                background-color: #007bff;
                color: #fff;
                border-bottom: 1px solid #dee2e6;
                padding: 10px 20px;
                border-radius: 5px 5px 0 0;
            }
            .modal-title {
                font-weight: bold;
                font-size: 1.25rem;
                margin: 0;
            }
            .close {
                color: #fff;
                opacity: 0.75;
                font-size: 1.5rem;
            }
            .close:hover {
                opacity: 1;
                text-decoration: none;
            }
            .modal-body {
                padding: 20px;
            }
            .modal-body p {
                margin-bottom: 10px;
                font-size: 1rem;
            }
            .modal-body hr {
                margin: 20px 0;
                border-top: 1px solid #dee2e6;
            }
            .thumbnail-container {
                text-align: center;
                margin-bottom: 20px;
            }
            .thumbnail-container img {
                max-width: 100%;
                height: auto;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .action-buttons {
                text-align: right;
            }
            .action-buttons button {
                margin-left: 10px;
            }
            /* Table */
            .table {
                margin-top: 20px;
            }
            .table thead th {
                background-color: #007bff;
                color: #fff;
                border-color: #dee2e6;
            }
            .table-hover tbody tr:hover {
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body>
        <!-- Navigator -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/staff">Staff Portal</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </nav>
    <!-- Navigator -->

    <div class="container-fluid">
        <div class="row">
            <nav class="sidebar">
                <div class="sidebar-brand">Staff Portal</div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/staff">
                            <i class="fas fa-chart-line"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/requestList">
                            <i class="fas fa-file-invoice-dollar"></i> Valuation Requests
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/finalValuation">
                            <i class="fas fa-file-contract"></i> Final Valuation
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/approvedRequest">
                            <i class="fas fa-thumbs-up"></i> Approval Request
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                             Transaction History
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                </ul>
            </nav>
            <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                <div class="container mt-5">
                    <h1 class="text-center text-primary my-4">Final Valuation</h1>
                    <%
                        List<Jewelry> listJewelry = (List<Jewelry>) request.getAttribute("LISTJEWELRY");
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
                                    <% String[] photoArray = jewelry.getPhotos().split(";");%>
                                    <td>
                                        <img class="img-thumbnail" style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%= photoArray[0]%>">
                                    </td>
                                    <td><%= jewelry.getJewelryName()%></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/updateFinalPrice" method="POST" onsubmit="confirmAuction(event)">
                                            <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID()%>">
                                            <input type="number" name="finalPrice" value="<%= jewelry.getFinal_Price()%>" required>
                                            <td>
                                                <input type="submit" class="btn btn-primary btn-sm ml-2" name="action" value="Send">
                                                <button type="button" class="btn btn-info btn-sm ml-2" data-toggle="modal" data-target="#detailsModal<%= jewelry.getJewelryID()%>">Details</button>
                                            </td>
                                        </form>
                                    </td>
                                </tr>

                                <!-- Modal -->
                            <div class="modal fade" id="detailsModal<%= jewelry.getJewelryID()%>" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel<%= jewelry.getJewelryID()%>" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <form action="${pageContext.request.contextPath}/UpdateJewelry" method="POST">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="detailsModalLabel<%= jewelry.getJewelryID()%>"><%= jewelry.getJewelryName()%> Details</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <!-- Include hidden field for Jewelry ID -->
                                                <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID()%>">
                                                <!-- Group 1: General Information -->
                                                <h6>General Information</h6>
                                                 <div class="form-group">
                                                    <label for="name<%= jewelry.getJewelryID()%>">Name:</label>
                                                    <input type="text" class="form-control" id="name<%= jewelry.getJewelryID()%>" name="name" value="<%= jewelry.getJewelryName() %>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="artist<%= jewelry.getJewelryID()%>">Artist:</label>
                                                    <input type="text" class="form-control" id="artist<%= jewelry.getJewelryID()%>" name="artist" value="<%= jewelry.getArtist()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="circa<%= jewelry.getJewelryID()%>">Circa:</label>
                                                    <input type="text" class="form-control" id="circa<%= jewelry.getJewelryID()%>" name="circa" value="<%= jewelry.getCirca()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="condition<%= jewelry.getJewelryID()%>">Condition:</label>
                                                    <input type="text" class="form-control" id="condition<%= jewelry.getJewelryID()%>" name="condition" value="<%= jewelry.getCondition()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="stamped<%= jewelry.getJewelryID()%>">Stamped:</label>
                                                    <input type="text" class="form-control" id="stamped<%= jewelry.getJewelryID()%>" name="stamped" value="<%= jewelry.getStamped()%>">
                                                </div>

                                                <!-- Group 2: Material Information -->
                                                <h6>Material Information</h6>
                                                <div class="form-group">
                                                    <label for="material<%= jewelry.getJewelryID()%>">Material:</label>
                                                    <input type="text" class="form-control" id="material<%= jewelry.getJewelryID()%>" name="material" value="<%= jewelry.getMaterial()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="metal<%= jewelry.getJewelryID()%>">Metal:</label>
                                                    <input type="text" class="form-control" id="metal<%= jewelry.getJewelryID()%>" name="metal" value="<%= jewelry.getMetal()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="gemstones<%= jewelry.getJewelryID()%>">Gemstones:</label>
                                                    <input type="text" class="form-control" id="gemstones<%= jewelry.getJewelryID()%>" name="gemstones" value="<%= jewelry.getGemstones()%>">
                                                </div>

                                                <!-- Group 3: Size and Weight -->
                                                <h6>Size and Weight</h6>
                                                <div class="form-group">
                                                    <label for="measurements<%= jewelry.getJewelryID()%>">Measurements:</label>
                                                    <input type="text" class="form-control" id="measurements<%= jewelry.getJewelryID()%>" name="measurements" value="<%= jewelry.getMeasurements()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="weight<%= jewelry.getJewelryID()%>">Weight:</label>
                                                    <input type="text" class="form-control" id="weight<%= jewelry.getJewelryID()%>" name="weight" value="<%= jewelry.getWeight()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="ringSize<%= jewelry.getJewelryID()%>">Ring Size:</label>
                                                    <input type="text" class="form-control" id="ringSize<%= jewelry.getJewelryID()%>" name="ringSize" value="<%= jewelry.getRingSize()%>">
                                                </div>

                                                <!-- Group 4: Bracelet/Watch Details (if applicable) -->
                                                <h6>Bracelet/Watch Details</h6>
                                                <div class="form-group">
                                                    <label for="dial<%= jewelry.getJewelryID()%>">Dial:</label>
                                                    <input type="text" class="form-control" id="dial<%= jewelry.getJewelryID()%>" name="dial" value="<%= jewelry.getDial()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="braceletMaterial<%= jewelry.getJewelryID()%>">Bracelet Material:</label>
                                                    <input type="text" class="form-control" id="braceletMaterial<%= jewelry.getJewelryID()%>" name="braceletMaterial" value="<%= jewelry.getBraceletMaterial()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="braceletSize<%= jewelry.getJewelryID()%>">Bracelet Size:</label>
                                                    <input type="text" class="form-control" id="braceletSize<%= jewelry.getJewelryID()%>" name="braceletSize" value="<%= jewelry.getBraceletSize()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="caseDimensions<%= jewelry.getJewelryID()%>">Case Dimensions:</label>
                                                    <input type="text" class="form-control" id="caseDimensions<%= jewelry.getJewelryID()%>" name="caseDimensions" value="<%= jewelry.getCaseDimensions()%>">
                                                </div>

                                                <!-- Group 5: Additional Information -->
                                                <h6>Additional Information</h6>
                                                <div class="form-group">
                                                    <label for="serialNumber<%= jewelry.getJewelryID()%>">Serial Number:</label>
                                                    <input type="text" class="form-control" id="serialNumber<%= jewelry.getJewelryID()%>" name="serialNumber" value="<%= jewelry.getSerialNumber()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="referenceNumber<%= jewelry.getJewelryID()%>">Reference Number:</label>
                                                    <input type="text" class="form-control" id="referenceNumber<%= jewelry.getJewelryID()%>" name="referenceNumber" value="<%= jewelry.getReferenceNumber()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="caliber<%= jewelry.getJewelryID()%>">Caliber:</label>
                                                    <input type="text" class="form-control" id="caliber<%= jewelry.getJewelryID()%>" name="caliber" value="<%= jewelry.getCaliber()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="movement<%= jewelry.getJewelryID()%>">Movement:</label>
                                                    <input type="text" class="form-control" id="movement<%= jewelry.getJewelryID()%>" name="movement" value="<%= jewelry.getMovement()%>">
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
                    <% }%>
                </div>
            </main>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="asset/finalValuation.js"></script>
</body>
</html>
