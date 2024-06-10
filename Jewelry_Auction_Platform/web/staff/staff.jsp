<%@page import="dao.UserDAOImpl"%>
<%@page import="entity.valuation.Valuation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="asset/staff.css">

    </head>
    <%
        String greeting = "day!";
        try {
            LocalTime now = LocalTime.now();
            int hour = now.getHour();
            if (hour < 12) {
                greeting = "Morning!";
            } else if (hour < 17) {
                greeting = "Afternoon!";
            } else {
                greeting = "Evening!";
            }
        } catch (Exception ex) {
            ex.getMessage();
        }
    %>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Staff Portal</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-user"></i>Staff</a>
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
        <h3 class="text-center mt-4">Approval Request</h3>

        <div class="container mt-4">
            <c:set var="listValuationRequest" value="${requestScope.listValuationRequest}" />
            <c:if test="${not empty listValuationRequest}">
                <h2>Valuation Requests</h2>
                <table class="table table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th>No</th>
                            <th>Photo</th>
                            <th>Name</th>
                            <th>More Info</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="val" items="${listValuationRequest}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>
                                    <c:set var="photoArray" value="${fn:split(val.photo, ';')}" />
                                    <img src="${photoArray[0]}" alt="Photo" class="img-thumbnail" style="max-width: 100px;">
                                </td>
                                <td>${val.name}</td>
                                <td>
                                    <button class="btn btn-info btn-sm" data-toggle="modal" data-target="#infoModal${loop.index}">View</button>
                                    <div class="modal fade" id="infoModal${loop.index}" tabindex="-1" role="dialog" aria-labelledby="infoModalLabel${loop.index}" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="infoModalLabel${loop.index}">Detailed Information</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <p><strong>Phone Number:</strong> ${val.phone}</p>
                                                    <p><strong>Communication Preference:</strong> ${val.communication}</p>
                                                    <p><strong>Description:</strong> ${val.description}</p>
                                                    <p><strong>Action:</strong></p>
                                                    <div>
                                                        <c:choose>
                                                            <c:when test="${val.status == 0}">
                                                                <form action="${pageContext.request.contextPath}/staff/valuation.jsp" method="GET">
                                                                    <input type="hidden" name="photoURL" value="${val.photo}">
                                                                    <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                                    <button type="submit" class="btn btn-primary">Evaluate</button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-secondary" disabled>Evaluated</button>
                                                                <c:if test="${val.status == 1}">
                                                                    <form action="${pageContext.request.contextPath}/MainController" method="GET">
                                                                        <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                                        <input type="hidden" name="name" value="${val.name}">
                                                                        <button type="submit" name="action" class="btn btn-primary mt-2">Request to Ship</button>
                                                                    </form>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <p><strong>Confirmation of Receipt:</strong></p>
                                                    <div>
                                                        <c:choose>
                                                            <c:when test="${val.final_Status == 0 && val.status == 1}">
                                                                <form action="${pageContext.request.contextPath}/MainController" method="POST" onsubmit="confirmReceipt(event)">
                                                                    <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                                    <button type="submit" name="action" class="btn btn-success mt-2">Confirm Receipt</button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:if test="${val.final_Status == 1}">
                                                                    <p class="text-danger mt-2">Confirmed</p>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <p><strong>Final Valuation:</strong></p>
                                                    <div>
                                                        <c:if test="${val.final_Status == 1}">
                                                            <form action="${pageContext.request.contextPath}/staff/finalValuation.jsp" method="POST">
                                                                <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                                <button type="submit" name="action" class="btn btn-warning mt-2">Final Evaluate</button>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <script src="asset/staff.js"></script>
    </body>
</html>