<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.google.gson.Gson"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <title>Create Auction</title>
    </head>
    <style>
        .container-fluid {
            padding-top: 20px;
        }
        .content-container {
            margin-top: 5px;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
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
        .modal-content {
            transition: transform 0.3s ease-out, opacity 0.3s ease-out;
        }
        .modal.fade .modal-dialog {
            transform: translateY(-100px);
            opacity: 0;
            transition: transform 0.3s ease-out, opacity 0.3s ease-out;
        }
        .modal.show .modal-dialog {
            transform: translateY(0);
            opacity: 1;
        }
    </style>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/manager">Manager Portal</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <div class="greeting-container">
                        <h3 class="greeting">Good <%= greeting%>!</h3>
                        <p class="greeting-message">Welcome back to the Manager Portal.</p>
                    </div>
                </ul>
            </div>
        </nav>
        <div class="container-fluid">     
            <div class="row">
                <!-- Sidebar -->
                <nav class="sidebar">
                    <div class="sidebar-brand">Manager Portal</div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/manager">
                                <i class="fas fa-chart-line"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/manager">
                                <i class="fas fa-file-invoice-dollar"></i> Pending Requests
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/manager/createAuction.jsp">
                                <i class="fas fa-file-contract"></i> Create Auction
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/manageAuction">
                                <i class="fas fa-thumbs-up"></i> Auction Managemnet
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
                    <div class="container light-style flex-grow-1 container-p-y">
                        <div align="center" style="color: #007bff"><h2 class="font-weight-bold py-3 mb-2">Create Auction</h2></div>
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
                        <form method="POST" action="${pageContext.request.contextPath}/createAuction" onsubmit="updateSelectedJewelryIDs()">
                            <div class="form-group">
                                <label for="auctionDate">Bidding Open </label><br>
                                from
                                <input type="date" id="auctionDate" name="auctionStartDate" class="form-control" required>
                                to 
                                <input type="date" id="auctionDate" name="auctionEndDate" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="timeRange">Live Sale Conclusion on </label>
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
                                                <input type="checkbox" name="jewelryID" value="<%= jewelry.getJewelryID()%>" onchange="handleCheckboxChange(this)">
                                            </td>
                                            <td>
                                                <% String[] photoArray = jewelry.getPhotos().split(";");%>
                                                <img class="img-thumbnail" style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%= photoArray[0]%>">
                                            </td>
                                            <td>
                                                <%= jewelry.getJewelryName()%>
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-info" onclick='showJewelryDetails(<%= new Gson().toJson(jewelry)%>)'>View Details</button>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="pagination">
                                <% if (currentPage > 1) {%>
                                <a href="javascript:goToPage(<%= currentPage - 1%>)">Previous</a>
                                <% } %>
                                <% for (int i = 1; i <= totalPages; i++) { %>
                                <% if (i == currentPage) {%>
                                <a href="javascript:void(0)" class="active"><%= i%></a>
                                <% } else {%>
                                <a href="javascript:goToPage(<%= i%>)"><%= i%></a>
                                <% } %>
                                <% } %>
                                <% if (currentPage < totalPages) {%>
                                <a href="javascript:goToPage(<%= currentPage + 1%>)">Next</a>
                                <% } %>
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
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <script src="asset/createAuction.js"></script>
        <script>
                                                    function showJewelryDetails(jewelry) {
                                                        $('#modalJewelryName').text(jewelry.jewelryName);
                                                        $('#modalArtist').text(jewelry.artist);
                                                        $('#modalCirca').text(jewelry.circa);
                                                        $('#modalMaterial').text(jewelry.material);
                                                        $('#modalDial').text(jewelry.dial);
                                                        $('#modalBraceletMaterial').text(jewelry.braceletMaterial);
                                                        $('#modalCaseDimensions').text(jewelry.caseDimensions);
                                                        $('#modalBraceletSize').text(jewelry.braceletSize);
                                                        $('#modalSerialNumber').text(jewelry.serialNumber);
                                                        $('#modalReferenceNumber').text(jewelry.referenceNumber);
                                                        $('#modalCaliber').text(jewelry.caliber);
                                                        $('#modalMovement').text(jewelry.movement);
                                                        $('#modalCondition').text(jewelry.condition);
                                                        $('#modalMetal').text(jewelry.metal);
                                                        $('#modalGemstones').text(jewelry.gemstones);
                                                        $('#modalMeasurements').text(jewelry.measurements);
                                                        $('#modalWeight').text(jewelry.weight);
                                                        $('#modalStamped').text(jewelry.stamped);
                                                        $('#modalRingSize').text(jewelry.ringSize);
                                                        $('#modalMinPrice').text(jewelry.minPrice);
                                                        $('#modalMaxPrice').text(jewelry.maxPrice);
                                                        $('#jewelryModal').modal('show');
                                                    }
        </script>
        <script>
            function goToPage(pageNumber) {
                const urlParams = new URLSearchParams(window.location.search);
                urlParams.set('page', pageNumber);
                window.location.search = urlParams.toString();
            }

<<<<<<< HEAD

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
=======
            function updateSelectedJewelryIDs() {
                const checkboxes = document.querySelectorAll('input[name="jewelryID"]:checked');
                const selectedIDs = Array.from(checkboxes).map(cb => cb.value);
                document.getElementById('selectedJewelryIDsInput').value = selectedIDs.join(',');
            }
        </script>
    </body>
</html>
>>>>>>> bennguyendev_03
