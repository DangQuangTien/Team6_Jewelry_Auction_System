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
                <input type="date" id="auctionDate" name="auctionDate" >
            </div>
            <div class="form-group">
                <label for="startTime">Start Time:</label>
                <input type="time" id="startTime" name="startTime" >
            </div>
            <div class="form-group">
                <label for="endTime">End Time:</label>
                <input type="time" id="endTime" name="endTime">
            </div>
            <h1>Available Jewelry</h1>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Select</th>
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
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Jewelry jewelry : listJewelry) { %>
                        <tr>
                            <td><input type="checkbox" value="<%= jewelry.getJewelryID() %>" onchange="handleCheckboxChange(this)" required=""></td>
                            <td><img class="img-thumbnail" src="${pageContext.request.contextPath}/<%= jewelry.getPhotos().split(";")[0] %>" alt="Jewelry Photo"></td>
                            <td><%= jewelry.getJewelryName() %></td>
                            <td><%= jewelry.getArtist() %></td>
                            <td><%= jewelry.getCirca() %></td>
                            <td><%= jewelry.getMaterial() %></td>
                            <td><%= jewelry.getDial() %></td>
                            <td><%= jewelry.getBraceletMaterial() %></td>
                            <td><%= jewelry.getCaseDimensions() %></td>
                            <td><%= jewelry.getBraceletSize() %></td>
                            <td><%= jewelry.getSerialNumber() %></td>
                            <td><%= jewelry.getReferenceNumber() %></td>
                            <td><%= jewelry.getCaliber() %></td>
                            <td><%= jewelry.getMovement() %></td>
                            <td><%= jewelry.getCondition() %></td>
                            <td><%= jewelry.getMetal() %></td>
                            <td><%= jewelry.getGemstones() %></td>
                            <td><%= jewelry.getMeasurements() %></td>
                            <td><%= jewelry.getWeight() %></td>
                            <td><%= jewelry.getStamped() %></td>
                            <td><%= jewelry.getRingSize() %></td>
                            <td><%= jewelry.getMinPrice() %></td>
                            <td><%= jewelry.getMaxPrice() %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <br>
            <input type="hidden" id="selectedJewelryIDsInput" name="selectedJewelryIDs" value="">
            <input type="submit" name="action" class="submit-btn" value="Create Auction">
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
        <p class="alert">No jewelry found</p>
        <% } %>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQ+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>
