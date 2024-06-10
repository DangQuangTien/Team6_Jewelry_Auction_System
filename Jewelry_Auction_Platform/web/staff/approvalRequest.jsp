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
        <style>
            body {
                font-family: Arial, sans-serif;
                padding-top: 20px;
            }
            .alert-warning {
                text-align: center;
            }
            .submit-btn {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .submit-btn:hover {
                background-color: #45a049;
            }
            .img-thumbnail {
                width: 100px;
                height: 100px;
            }
        </style>
        <script>
            function confirm(event) {
                if (!confirm("Are you sure you want to send this final valuation?")) {
                    event.preventDefault();
                }
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h1 class="text-center text-primary">Approval Requests</h1>
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
                            <th>Final Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Jewelry jewelry : listJewelry) { %>
                        <tr>
                            <% String[] photoArray = jewelry.getPhotos().split(";");%>
                            <td><img class="img-thumbnail" src="${pageContext.request.contextPath}/<%= photoArray[0]%>" alt="Jewelry Image"></td>
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
                            <td><%= jewelry.getFinal_Price()%></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/MainController" method="GET" onsubmit="confirm(event)">
                                    <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID()%>">
                                    <input class="submit-btn" type="submit" name="action" value="Send to Seller">
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <p class="alert alert-warning">No jewelry found</p>
            <% }%>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
