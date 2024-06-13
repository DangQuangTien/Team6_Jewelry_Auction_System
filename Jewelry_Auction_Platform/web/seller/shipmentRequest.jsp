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
</head>
<body>
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
</body>
</html>
