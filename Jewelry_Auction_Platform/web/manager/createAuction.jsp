<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="java.time.LocalTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="../admin/style/styles.css">
    <title>Create Auction</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .main-content {
            padding: 20px;
            background-color: #f8f9fa;
            height: 100%;
        }

        .title {
            display: flex;
            align-items: center;
        }

        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-group input {
            margin-bottom: 10px;
        }

        .table-container {
            margin-top: 20px;
            overflow-y: auto;
        }

        .table-container table {
            width: 100%;
            border-collapse: collapse;
        }

        .table-container th, .table-container td {
            padding: 20px;
            text-align: left;
        }

        .table-container td img {
            width: 50px;
            height: auto;
            border-radius: 4px;
        }

        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 5px;
        }

        .pagination a {
            padding: 8px 12px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        .pagination a.active, .pagination a:hover {
            background-color: #0056b3;
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
        function toggleApprovalTable() {
            var table = document.getElementById("approvalTable");
            if (table.style.display === "none" || table.style.display === "") {
                table.style.display = "table";
            } else {
                table.style.display = "none";
            }
        }
        var selectedJewelryIDs = [];

        function handleCheckboxChange(checkbox) {
            var jewelryID = checkbox.value;
            if (checkbox.checked) {
                selectedJewelryIDs.push(jewelryID);
            } else {
                var index = selectedJewelryIDs.indexOf(jewelryID);
                if (index !== -1) {
                    selectedJewelryIDs.splice(index, 1);
                }
            }
        }

        function updateSelectedJewelryIDs() {
            var selectedJewelryIDsInput = document.getElementById('selectedJewelryIDsInput');
            selectedJewelryIDsInput.value = selectedJewelryIDs.join(',');
        }

        function goToPage(page) {
            document.getElementById('page').value = page;
            document.getElementById('paginationForm').submit();
        }

        function showJewelryDetails(jewelry) {
            document.getElementById('modalJewelryName').innerText = jewelry.jewelryName;
            document.getElementById('modalArtist').innerText = jewelry.artist;
            document.getElementById('modalCirca').innerText = jewelry.circa;
            document.getElementById('modalMaterial').innerText = jewelry.material;
            document.getElementById('modalDial').innerText = jewelry.dial;
            document.getElementById('modalBraceletMaterial').innerText = jewelry.braceletMaterial;
            document.getElementById('modalCaseDimensions').innerText = jewelry.caseDimensions;
            document.getElementById('modalBraceletSize').innerText = jewelry.braceletSize;
            document.getElementById('modalSerialNumber').innerText = jewelry.serialNumber;
            document.getElementById('modalReferenceNumber').innerText = jewelry.referenceNumber;
            document.getElementById('modalCaliber').innerText = jewelry.caliber;
            document.getElementById('modalMovement').innerText = jewelry.movement;
            document.getElementById('modalCondition').innerText = jewelry.condition;
            document.getElementById('modalMetal').innerText = jewelry.metal;
            document.getElementById('modalGemstones').innerText = jewelry.gemstones;
            document.getElementById('modalMeasurements').innerText = jewelry.measurements;
            document.getElementById('modalWeight').innerText = jewelry.weight;
            document.getElementById('modalStamped').innerText = jewelry.stamped;
            document.getElementById('modalRingSize').innerText = jewelry.ringSize;
            document.getElementById('modalMinPrice').innerText = jewelry.minPrice;
            document.getElementById('modalMaxPrice').innerText = jewelry.maxPrice;

            var modal = new bootstrap.Modal(document.getElementById('jewelryModal'));
            modal.show();
        }
    </script>
</head>
<body>
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
<div class="container-fluid">
    <div class="row">
        <div class="col-2 d-flex flex-column bg-dark min-vh-100 sidebar">
            <div class="text-center mt-4">
                <a href="#" class="text-white text-decoration-none d-flex align-items-center justify-content-center sidebar-logo">
                    <img src="../images/logo/auction_jewelry.png" alt="Logo">
                </a>
                <hr class="text-white d-none d-sm-block" />
                <ul class="nav nav-pills flex-column" id="menu">
                    <li class="nav-item mb-2">
                        <a class="nav-link text-white" href="createAuction.jsp">
                            <i class="fas fa-plus-circle"></i>
                            <span class="ms-2 d-none d-sm-inline">Create Auction</span>
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a class="nav-link text-white" href="auctionManagement.jsp">
                            <i class="fas fa-tasks"></i>
                            <span class="ms-2 d-none d-sm-inline">Auction Management</span>
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a class="nav-link text-white" href="auctionAssignment.jsp">
                            <i class="fas fa-user-tag"></i>
                            <span class="ms-2 d-none d-sm-inline">Auction Assignment</span>
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a class="nav-link text-white" href="manager.jsp">
                            <i class="fas fa-check-circle"></i>
                            <span class="ms-2 d-none d-sm-inline">Approval Requests</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="text-center text-white mb-4">
                <p>Good <%= greeting %>, welcome back, Staff</p>
            </div>
        </div>
        <main class="col-10 main-content m-0 p-0">
            <div class="bg-dark w-100 d-flex justify-content-between align-items-center py-2">
                <div class="title navbar">
                    <h2 class="text-white ps-4">Manager</h2>
                </div>
                <div class="dropdown me-5">
                    <a class="btn border-none outline-none text-white dropdown-toggle" type="button" id="triggerId" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-user"></i>
                        <h6 class="text-white ms-2 d-none d-sm-inline">Manager</h6>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="triggerId">
                        <a class="dropdown-item" href="managerProfile.jsp">Profile</a>
                        <a class="dropdown-item" href="#">Change Password</a>
                        <a class="dropdown-item" href="#">Logout</a>
                    </div>
                </div>
            </div>
            <div class="container light-style flex-grow-1 container-p-y">
                <h2>Create Auction</h2>
                <div class="form-container">
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
                    <form id="paginationForm" method="POST" action="${pageContext.request.contextPath}/manager/createAuction.jsp">
                        <input type="hidden" id="page" name="page" value="<%= currentPage %>">
                    </form>
                    <form action="${pageContext.request.contextPath}/MainController" method="GET" onsubmit="updateSelectedJewelryIDs()">
                        <div class="form-group">
                            <label for="auctionDate">Select Auction Date:</label>
                            <input type="date" id="auctionDate" name="auctionDate" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="startTime">Start Time:</label>
                            <input type="time" id="startTime" name="startTime" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="endTime">End Time:</label>
                            <input type="time" id="endTime" name="endTime" class="form-control">
                        </div>
                        <h1>Available Jewelry</h1>
                        <div class="table-container">
                            <table class="table table-bordered table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Select</th>
                                        <th>Jewelry Name</th>
                                        <th>Artist</th>
                                        <th>Photo</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Jewelry jewelry : listJewelry) { %>
                                    <tr>
                                        <td><input type="checkbox" value="<%= jewelry.getJewelryID() %>" onchange="handleCheckboxChange(this)"></td>
                                        <td><%= jewelry.getJewelryName() %></td>
                                        <td><%= jewelry.getArtist() %></td>
                                        <td><img class="img-thumbnail" src="${pageContext.request.contextPath}/<%= jewelry.getPhotos().split(";")[0] %>" alt="Jewelry Photo"></td>
                                        <td><button type="button" class="btn btn-primary" onclick='showJewelryDetails(<%= jewelry %>)'>View</button></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <input type="hidden" id="selectedJewelryIDsInput" name="selectedJewelryIDs" value="">
                        <input type="hidden" name="action" value="Create Auction">
                        <button type="submit" class="btn btn-primary" onclick="confirmAuction(event)">Create Auction</button>
                    </form>
                    <div class="pagination">
                        <% if (currentPage > 1) { %>
                        <a href="javascript:void(0);" onclick="goToPage(<%= currentPage - 1 %>)">&laquo; Previous</a>
                        <% } %>
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <a href="javascript:void(0);" class="<%= (i == currentPage) ? "active" : "" %>" onclick="goToPage(<%= i %>)"><%= i %></a>
                        <% } %>
                        <% if (currentPage < totalPages) { %>
                        <a href="javascript:void(0);" onclick="goToPage(<%= currentPage + 1 %>)">Next &raquo;</a>
                        <% } %>
                    </div>
                    <% } else { %>
                    <h2>No confirmed jewelry items available</h2>
                    <% } %>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Jewelry Details Modal -->
<div class="modal fade" id="jewelryModal" tabindex="-1" aria-labelledby="jewelryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="jewelryModalLabel">Jewelry Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>Jewelry Name:</strong> <span id="modalJewelryName"></span></p>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-ON8zOe5tGDr0nsDDZKHL6vU/WP+4mTTx92ef/F91cJmPF5pM7WeAM2U9YRXZGU0V" crossorigin="anonymous"></script>
</body>
</html>
