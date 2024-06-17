<%-- 
    Document   : notification
    Created on : Jun 4, 2024, 2:38:00 AM
    Author     : User
--%>

<%@page import="dao.UserDAOImpl"%>
<%@page import="entity.request_shipment.RequestShipment"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Shipment Requests</title>
    <link rel="stylesheet" type="text/css" href="asset/Shipment Requests.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <style>
             body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-color: #f5eded;
            }

            .navbar {
                position: sticky;
                top: 0;
                z-index: 1000;
                background-color: #343a40;
                border-bottom: 3px solid #e4af11;
            }

            .navbar-brand, .nav-link, .navbar-toggler-icon {
                color: #ffc107 !important;
            }

            .navbar-brand:hover, .nav-link:hover {
                color: #0a0800 !important;
            }
    </style>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="home.jsp">
            <i class="fas fa-gem"> F'Rankelly</i><br>
            <span style="font-size: 0.5em;">Auctioneers & Appraisers</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">          
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home.jsp"><i class="fas fa-home"></i> Home <span class="sr-only">(current)</span></a>
                </li>                
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/auctions/upcoming.jsp"><i class="fas fa-gavel"></i> Auction</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/seller/request.jsp"><i class="fas fa-clipboard"></i> Request A Valuation</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/seller/response.jsp"><i class="fas fa-reply"></i> Response</a>                                   
                </li>                
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/seller/shipmentRequest.jsp"><i class="fas fa-bell"></i> Notification</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h1 class="text-center text-primary">
            <a href="${pageContext.request.contextPath}/home.jsp">Request to Ship Jewelry</a>
        </h1>
        <%
            UserDAOImpl dao = new UserDAOImpl();
            String userID = (String) session.getAttribute("USERID");
            List<RequestShipment> listRequestShipment = dao.displayRequestShipment(userID);
            if (listRequestShipment != null && !listRequestShipment.isEmpty()) {
        %>
        <div class="table-responsive">
            <table id="requestShipment" class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>No</th>
                        <th>Content</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int i = 1;
                        for (RequestShipment r : listRequestShipment) {
                    %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><%= r.getContent() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p class="no-jewelry">There are no shipment requests at the moment.</p>
        <% } %>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
</body>
</html>
