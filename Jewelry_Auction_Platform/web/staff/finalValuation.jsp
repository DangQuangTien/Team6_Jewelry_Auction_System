<%-- 
    Document   : manager
    Created on : May 23, 2024, 1:23:38 AM
    Author     : User
--%>
<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="java.time.LocalTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Final Valuation</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="asset/finalValuation.css">
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
                                        <img class="img-thumbnail" style="width: 100px; height: 100px" src="<%= photoArray[0]%>" alt="jewelry photo">
                                    </td>
                                    <td><%= jewelry.getName() %></td>
                                    <td><%= jewelry.getFinalPrice() %></td>
                                    <td>
                                        <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#detailsModal<%= jewelry.getId() %>">
                                            View Details
                                        </button>
                                        <!-- Modal -->
                                        <div class="modal fade" id="detailsModal<%= jewelry.getId() %>" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel<%= jewelry.getId() %>" aria-hidden="true">
                                            <div class="modal-dialog modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="detailsModalLabel<%= jewelry.getId() %>"><%= jewelry.getName() %></h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="container">
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <img class="img-thumbnail" src="<%= photoArray[0] %>" alt="Jewelry Image">
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <p><strong>Jewelry Name:</strong> <%= jewelry.getName() %></p>
                                                                    <p><strong>Category:</strong> <%= jewelry.getCategory() %></p>
                                                                    <p><strong>Material:</strong> <%= jewelry.getMaterial() %></p>
                                                                    <p><strong>Gemstone:</strong> <%= jewelry.getGemstone() %></p>
                                                                    <p><strong>Weight:</strong> <%= jewelry.getWeight() %></p>
                                                                    <p><strong>Final Price:</strong> <%= jewelry.getFinalPrice() %></p>
                                                                </div>
                                                            </div>
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
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% } else { %>
                    <p class="text-center">No jewelry items available for final valuation.</p>
                    <% } %>
                </div>
            </main>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#approvalTable').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": false,
                "ordering": true,
                "info": true,
                "autoWidth": false,
                "pageLength": 5 // Change this value to adjust the number of items per page
            });
        });
    </script>
</body>
</html>
