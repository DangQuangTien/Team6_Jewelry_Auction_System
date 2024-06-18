<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.google.gson.Gson"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="asset/createAuction.css">
    <title>Create Auction</title>
</head>
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
        ex.printStackTrace(); // Or use a logger to log the exception
    }
%>
<body>
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
    <main class="container mt-4">
        <div class="container light-style flex-grow-1 container-p-y">
            <h3>Good <%= greeting %> Welcome back, Manager</h3>
            <h2>Create New Auction</h2>
            <%
                int currentPage = 1;
                int pageSize = 3;
                if (request.getParameter("page") != null) {
                    currentPage = Integer.parseInt(request.getParameter("page"));
                }

                UserDAOImpl dao = new UserDAOImpl();
                List<Jewelry> listJewelry = dao.displayConfirmedJewelry(currentPage, pageSize);
                int totalItems = dao.getTotalConfirmedJewelryCount();
                int totalPages = (int) Math.ceil((double) totalItems / pageSize);

                if (listJewelry != null && !listJewelry.isEmpty()) {
            %>
            <form method="POST" action="${pageContext.request.contextPath}/MainController" onsubmit="updateSelectedJewelryIDs()">
                <div class="form-group">
                    <label for="auctionDate">Select Auction Date:</label>
                    <input type="date" id="auctionDate" name="auctionDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="timeRange">Time Range:</label>
                    <div class="d-flex">
                        <input type="time" id="startTime" name="startTime" class="form-control me-2" required>
                        <input type="time" id="endTime" name="endTime" class="form-control" required>
                    </div>
                </div>
                <input type="hidden" id="selectedJewelryIDsInput" name="selectedJewelryIDs">
                <div class="form-group">
                    <button type="submit" name="action" class="btn btn-primary" value="Create Auction">Create Auction</button>
                </div>
                <div class="table-container">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Select</th>
                                <th>Photo</th>
                                <th>Jewelry Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Jewelry jewelry : listJewelry) {
                            %>
                            <tr>
                                <td>
                                    <input type="checkbox" name="jewelryID" value="<%= jewelry.getJewelryID() %>" onchange="handleCheckboxChange(this)">
                                </td>
                                <td>
                                    <% String[] photoArray = jewelry.getPhotos().split(";"); %>
                                    <img class="img-thumbnail" style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%= photoArray[0] %>">
                                </td>
                                <td>
                                    <%= jewelry.getJewelryName() %>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-info" onclick='showJewelryDetails(<%= new Gson().toJson(jewelry) %>)'>View Details</button>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="pagination">
                    <%
                        if (currentPage > 1) {
                    %>
                    <a href="javascript:goToPage(<%= currentPage - 1 %>)">Previous</a>
                    <%
                        }
                        for (int i = 1; i <= totalPages; i++) {
                            if (i == currentPage) {
                    %>
                    <a href="javascript:void(0)" class="active"><%= i %></a>
                    <%
                            } else {
                    %>
                    <a href="javascript:goToPage(<%= i %>)"><%= i %></a>
                    <%
                            }
                        }
                        if (currentPage < totalPages) {
                    %>
                    <a href="javascript:goToPage(<%= currentPage + 1 %>)">Next</a>
                    <%
                        }
                    %>
                </div>
            </form>
            <%
                } else {
            %>
            <p>No confirmed jewelry found.</p>
            <%
                }
            %>
        </div>
    </main>


<!-- Modal -->
<div class="modal fade" id="jewelryModal" tabindex="-1" aria-labelledby="jewelryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="jewelryModalLabel">Jewelry Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>Name:</strong> <span id="modalJewelryName"></span></p>
                <p><strong>Artist:</strong> <span id="modalArtist"></span></p>
                <p><strong>Circa:</strong> <span id="modalCirca"></span></p>
                <p><strong>Material:</strong> <span id="modalMaterial"></span></p>
                <p><strong>Dial:</strong> <span id="modalDial"></span></p>
                <p><strong>Bracelet Material:</strong> <span id="modalBraceletMaterial"></span></p>
                <p><strong>Case Dimensions:</strong> <span id="modalCaseDimensions"></span></p>
                <p><strong>Bracelet Size:</strong> <span id="modalBraceletSize"></span></p>
                <p><strong>Serial Number:</strong> <span id="modalSerialNumber"></span></p>
                <p><strong>Reference Number:</strong> <span id="modalReferenceNumber"></span></p>
                <p><strong>Caliber:</strong> <span id="modalCaliber"></span></p>
                <p><strong>Movement:</strong> <span id="modalMovement"></span></p>
                <p><strong>Condition:</strong> <span id="modalCondition"></span></p>
                <p><strong>Metal:</strong> <span id="modalMetal"></span></p>
                <p><strong>Gemstones:</strong> <span id="modalGemstones"></span></p>
                <p><strong>Measurements:</strong> <span id="modalMeasurements"></span></p>
                <p><strong>Weight:</strong> <span id="modalWeight"></span></p>
                <p><strong>Stamped:</strong> <span id="modalStamped"></span></p>
                <p><strong>Ring Size:</strong> <span id="modalRingSize"></span></p>
                <p><strong>Min Price:</strong> <span id="modalMinPrice"></span></p>
                <p><strong>Max Price:</strong> <span id="modalMaxPrice"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
    </div>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <script src="asset/createAuction.js"></script>
</body>
</html>
