<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="java.time.LocalTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="asset/manager.css">
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
        </style>
        <script>
            function confirmLogout(event) {
                if (!confirm("Are you sure you want to log out?")) {
                    event.preventDefault();
                }
            }
            function confirmAuction(event) {
                if (!confirm("Do you confirm approving this bid?")) {
                    event.preventDefault();
                }
            }
            $(document).ready(function() {
                $('[data-toggle="modal"]').on('click', function() {
                    var targetModal = $(this).data('target');
                    $(targetModal).modal('show');
                });
            });
        </script>
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
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav class="sidebar">
                    <div class="sidebar-brand">Manager Portal</div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/manager/manager.jsp">
                                <i class="fas fa-chart-line"></i> Approval Request
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/manager/createAuction.jsp">
                                <i class="fas fa-gavel"></i> Create Auction
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/manager/auctionManagement.jsp">
                                <i class="fas fa-tasks"></i> Auction Management
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
                        <h3>Good <%= greeting %> Welcome back, Manager</h3>
                        <div class="container light-style flex-grow-1 container-p-y">
                            <h2 class="font-weight-bold py-3 mb-2">Approval Requests</h2>
                            <%
                                UserDAOImpl dao = new UserDAOImpl();
                                List<Jewelry> listJewelry = dao.displayAllJewelryForManager();
                                if (listJewelry != null && !listJewelry.isEmpty()) {
                            %>
                            <div class="table-responsive">
                                <table id="approvalTable" class="table table-bordered table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Photo</th>
                                            <th>Jewelry Name</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Jewelry jewelry : listJewelry) { %>
                                        <form action="${pageContext.request.contextPath}/MainController" method="GET" onsubmit="confirmAuction(event)">
                                            <tr>
                                                <% String[] photoArray = jewelry.getPhotos().split(";"); %>
                                                <td><img class="img-thumbnail" style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%= photoArray[0] %>"></td>
                                                <td><%= jewelry.getJewelryName() %></td>
                                                <td>
                                                    <input type="hidden" name="action" value="Approve">
                                                    <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#jewelryModal<%= jewelry.getJewelryID() %>">View</button>
                                                    <button type="submit" name="action" value="Approve" class="btn btn-success">Confirm</button>
                                                </td>
                                            </tr>
                                        </form>
                                        <!-- Modal -->
                                        <div class="modal fade" id="jewelryModal<%= jewelry.getJewelryID() %>" tabindex="-1" aria-labelledby="exampleModalLabel<%= jewelry.getJewelryID() %>" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel<%= jewelry.getJewelryID() %>"><%= jewelry.getJewelryName() %></h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <img class="img-fluid" src="${pageContext.request.contextPath}/<%= photoArray[0] %>" alt="Jewelry Photo">
                                                            </div>
                                                            <div class="col-6">
                                                                <p><strong>Artist:</strong> <%= jewelry.getArtist() %></p>
                                                                <p><strong>Circa:</strong> <%= jewelry.getCirca() %></p>
                                                                <p><strong>Material:</strong> <%= jewelry.getMaterial() %></p>
                                                                <p><strong>Dial:</strong> <%= jewelry.getDial() %></p>
                                                                <p><strong>Bracelet Material:</strong> <%= jewelry.getBraceletMaterial() %></p>
                                                                <p><strong>Case Material:</strong> <%= jewelry.getCaseMaterial() %></p>
                                                                <p><strong>Estimate Price:</strong> $<%= jewelry.getEstimatePrice() %></p>
                                                            </div>
                                                        </div>
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
                            <p>No jewelry items found for approval.</p>
                            <% } %>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
