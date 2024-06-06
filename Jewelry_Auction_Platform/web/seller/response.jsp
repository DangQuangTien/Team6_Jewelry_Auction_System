<%-- 
    Document   : manager
    Created on : May 23, 2024, 1:23:38 AM
    Author     : User
--%>

<%@page import="entity.request_shipment.RequestShipment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.product.Jewelry"%>
<%@page import="dao.UserDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Notification</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                padding-top: 60px;
            }
            .text-primary {
                color: #007BFF;
            }
            .no-jewelry {
                text-align: center;
                font-style: italic;
                color: #888;
                margin-top: 20px;
            }
            .action-btn {
                background-color: #007BFF;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .action-btn:hover {
                background-color: #0056b3;
            }
            .hidden {
                display: none;
            }
            .navbar-nav .nav-link, .navbar-brand {
                color: black !important;
            }
            .table-responsive {
                margin-top: 20px;
                padding: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                padding: 12px 15px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #e9ecef;
                font-size: 1.1em;
            }
            td {
                font-size: 1em;
            }
            .thead-light {
                background-color: #e9ecef;
            }
            .text-danger {
                color: red;
            }
            .img-thumbnail {
                max-width: 150px;
                max-height: 150px;
                border: none;
                border-radius: 8px;
            }
            .navbar-brand, .navbar-nav .nav-link {
                color: black !important;
            }
            .navbar {
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            footer {
                background-color: #f8f9fa;
                padding: 20px 0;
                text-align: center;
                margin-top: 20px;
                box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
            }
            .btn-group-vertical .btn {
                width: 100%;
                margin-bottom: 5px;
            }
        </style>
    </head>
    <body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
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

    <div class="container">
        <h1 class="text-center text-primary mt-5">Overall Assessment for Your Requests</h1>
        <%
            String userID = (String) session.getAttribute("USERID");
            UserDAOImpl dao = new UserDAOImpl();
            List<Jewelry> listJewelry = dao.getJewelryByUserID(userID);
            if (listJewelry != null && !listJewelry.isEmpty()) {
        %>
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>Photo</th>
                        <th>Jewelry Name</th>
                        <th>Artist</th>
                        <th>Circa</th>
                        <th>Material</th>
                        <th>Dial</th>
                        <th>Bracelet Material</th>
                        <th>Case Dimensions</th>
                        <th>Bracelet Size</th>
                        <th>Serial Number</th>
                        <th>Reference Number</th>
                        <th>Caliber</th>
                        <th>Movement</th>
                        <th>Condition</th>
                        <th>Metal</th>
                        <th>Gemstones</th>
                        <th>Measurements</th>
                        <th>Weight</th>
                        <th>Stamped</th>
                        <th>Ring Size</th>
                        <th>Min Price</th>
                        <th>Max Price</th>
                        <th>Temporary Price</th>
                        <th>Final Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Jewelry jewelry : listJewelry) {%>
                    <tr>
                        <% String[] photoArray = jewelry.getPhotos().split(";");%>
                        <td><img class="img-fluid img-thumbnail" src="${pageContext.request.contextPath}/<%= photoArray[0]%>" alt="Jewelry Image"></td>
                        <td><%= jewelry.getJewelryName()%></td>
                        <td><%= jewelry.getArtist()%></td>
                        <td><%= jewelry.getCirca()%></td>
                        <td><%= jewelry.getMaterial()%></td>
                        <td><%= jewelry.getDial()%></td>
                        <td><%= jewelry.getBraceletMaterial()%></td>
                        <td><%= jewelry.getCaseDimensions()%></td>
                        <td><%= jewelry.getBraceletSize()%></td>
                        <td><%= jewelry.getSerialNumber()%></td>
                        <td><%= jewelry.getReferenceNumber()%></td>
                        <td><%= jewelry.getCaliber()%></td>
                        <td><%= jewelry.getMovement()%></td>
                        <td><%= jewelry.getCondition()%></td>
                        <td><%= jewelry.getMetal()%></td>
                        <td><%= jewelry.getGemstones()%></td>
                        <td><%= jewelry.getMeasurements()%></td>
                        <td><%= jewelry.getWeight()%></td>
                        <td><%= jewelry.getStamped()%></td>
                        <td><%= jewelry.getRingSize()%></td>
                        <td><%= jewelry.getMinPrice()%></td>
                        <td><%= jewelry.getMaxPrice()%></td>
                        <td><%= jewelry.getTemp_Price()%></td>
                        <% String status = jewelry.getStatus(); %>
                        <% if (status != null && status.equals("Re-Evaluated")) {%>
                        <td style="color: red"><%= (jewelry.getFinal_Price() != null) ? jewelry.getFinal_Price() : "Updating"%></td>
                        <td class="text-danger">Waiting for shipment</td>
                        <% } else if (status.equals("Received")) {%>
                        <td style="color: red"><%= (jewelry.getFinal_Price() != null) ? jewelry.getFinal_Price() : "Updating"%></td>
                        <td style="color: green">Received</td>
                        <% } else if (status.equals("Pending Confirm")) {%>
                        <td style="color: red"> <%= jewelry.getFinal_Price()%> </td>
                        <td style="color: green"><strong>Pending Confirm</strong><br>
                            <div class="btn-group-vertical">
                                <form action="${pageContext.request.contextPath}/MainController">
                                    <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID()%>">
                                    <input type="submit" name="action" value="Confirm" class="btn btn-success btn-sm"> 
                                </form>
                                <form action="${pageContext.request.contextPath}/MainController">
                                    <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID()%>">
                                    <input type="submit" name="action" value="Reject" class="btn btn-danger btn-sm"> 
                                </form>
                            </div>
                        </td>
                        <% } else if (status.equals("Confirmed")) {%>
                        <td style="color: red"> <%= jewelry.getFinal_Price()%> </td>
                        <td style="color: red">Ready To Auction</td>
                        <% } else { %>
                        <td style="color: red">Updating</td>
                        <td style="color: red">In Progress</td>
                        <% } %>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p class="no-jewelry">No jewelry found</p>
        <% }%>
    </div>
    
    <footer>
        <p>&copy; 2024 Jewelry Auctions. All rights reserved.</p>
    </footer>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

