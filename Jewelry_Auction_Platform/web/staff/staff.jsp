<%@page import="entity.valuation.Valuation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Control Panel</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="asset/admin.css">
        <style>
            /* Sidebar */
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
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/staff">Staff Portal</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <!-- Professional greeting -->
                <div class="greeting-container">
                    <h3 class="greeting">Good <%= greeting%>!</h3>
                    <p class="greeting-message">Welcome back to the Staff Portal.</p>
                </div>
            </ul>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- Main content area -->
            <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                <div class="container mt-4">
                    <c:set var="listValuationRequest" value="${requestScope.listValuationRequest}" />
                    <c:if test="${not empty listValuationRequest}">
                        <h1 class="text-center text-primary my-4">Valuation Requests</h1>
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
                                            <img src="${pageContext.request.contextPath}/${photoArray[0]}" alt="Photo" class="img-thumbnail" style="max-width: 100px;">
                                        </td>
                                        <td>${val.name}</td>
                                        <td>
                                            <button class="btn btn-info btn-sm" data-toggle="modal" data-target="#infoModal${loop.index}">View</button>
                                            <!-- Modal -->
                                            <div class="modal fade" id="infoModal${loop.index}" tabindex="-1" role="dialog" aria-labelledby="infoModalLabel${loop.index}" aria-hidden="true">
                                                <div class="modal-dialog modal-lg" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="infoModalLabel${loop.index}">Detailed Information</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <!-- Basic Info -->
                                                                    <p><strong>Name:</strong> ${val.name}</p>
                                                                    <p><strong>Phone Number:</strong> ${val.phone}</p>
                                                                    <p><strong>Communication Preference:</strong> ${val.communication}</p>
                                                                    <p><strong>Description:</strong> ${val.description}</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <!-- Images and Description -->
                                                                    <div class="thumbnail-container">
                                                                        <c:set var="photoArray" value="${fn:split(val.photo, ';')}" />
                                                                        <img src="${pageContext.request.contextPath}/${photoArray[0]}" alt="Photo" class="img-thumbnail">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <hr>
                                                            <!-- Action buttons -->
                                                            <div class="action-buttons">
                                                                <!-- Evaluate Button -->
                                                                <c:choose>
                                                                    <c:when test="${val.status == 0}">
                                                                        <form action="${pageContext.request.contextPath}/staff/valuation.jsp" method="POST">
                                                                            <input type="hidden" name="photoURL" value="${val.photo}">
                                                                            <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                                            <button type="submit" class="btn btn-primary">Evaluate</button>
                                                                        </form>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <!-- Evaluated Button -->
                                                                        <button class="btn btn-secondary" disabled>Evaluated</button>
                                                                        <!-- Request to Ship Button -->
                                                                        <br><br>
                                                                        <c:if test="${val.status == 1}">
                                                                            <form action="${pageContext.request.contextPath}/MainController" method="GET">
                                                                                <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                                                <input type="hidden" name="name" value="${val.name}">
                                                                                <button type="submit" name="action" class="btn btn-primary" value="Request to Ship">Request to Ship</button>
                                                                            </form>
                                                                        </c:if>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <!-- Confirm Receipt Button -->
                                                            <div class="action-buttons mt-3">
                                                                <c:choose>
                                                                    <c:when test="${val.final_Status == 0 && val.status == 1}">
                                                                        <form action="${pageContext.request.contextPath}/confirmReceipt" method="POST" onsubmit="confirmReceipt(event)">
                                                                            <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                                            <button type="submit" name="action" class="btn btn-success">Confirm Receipt</button>
                                                                        </form>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <!-- Confirmed Text -->
                                                                        <c:if test="${val.final_Status == 1}">
                                                                            <p class="text-success mt-2">Confirmed</p>
                                                                        </c:if>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <!-- Final Evaluate Button -->
                                                            <div class="action-buttons mt-3">
                                                                <c:if test="${val.final_Status == 1}">
                                                                    <form action="${pageContext.request.contextPath}/finalValuation" method="POST">
                                                                        <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                                        <button type="submit" name="action" class="btn btn-warning">Final Evaluate</button>
                                                                    </form>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
            </main>
        </div>
    </div>
    <!-- JavaScript libraries -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <script src="asset/admin.js"></script>
    <!-- Script to highlight active link in sidebar -->
    <script>
                                                                            $(document).ready(function () {
                                                                                // Smooth modal transition
                                                                                $('.modal').on('shown.bs.modal', function (e) {
                                                                                    $(this).find('.modal-dialog').addClass('show');
                                                                                });

                                                                                $('.modal').on('hidden.bs.modal', function (e) {
                                                                                    $(this).find('.modal-dialog').removeClass('show');
                                                                                });
                                                                            });
    </script>
</body>
</html>

