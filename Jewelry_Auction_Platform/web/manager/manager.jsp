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
    <title>Jewelry Manager</title>
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
                        <a class="nav-link text-white" href="#" onclick="toggleApprovalTable()">
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
                <h4 class="font-weight-bold py-3 mb-2">Approval Requests</h4>
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
                                        <input type="hidden" name="action" value="ApproveJewelryAuction">
                                        <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#jewelryModal<%= jewelry.getJewelryID() %>">View</button>
                                        <button type="submit" class="btn btn-success">Confirm</button>
                                    </td>
                                </tr>
                            </form>
                            <!-- Modal -->
                            <div class="modal fade" id="jewelryModal<%= jewelry.getJewelryID() %>" tabindex="-1" aria-labelledby="exampleModalLabel<%= jewelry.getJewelryID() %>" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel<%= jewelry.getJewelryID() %>"><%= jewelry.getJewelryName() %></h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                                                    <p><strong>Case Dimensions:</strong> <%= jewelry.getCaseDimensions() %></p>
                                                    <p><strong>Bracelet Size:</strong> <%= jewelry.getBraceletSize() %></p>
                                                    <p><strong>Serial Number:</strong> <%= jewelry.getSerialNumber() %></p>
                                                    <p><strong>Reference Number:</strong> <%= jewelry.getReferenceNumber() %></p>
                                                    <p><strong>Caliber:</strong> <%= jewelry.getCaliber() %></p>
                                                    <p><strong>Movement:</strong> <%= jewelry.getMovement() %></p>
                                                    <p><strong>Condition:</strong> <%= jewelry.getCondition() %></p>
                                                    <p><strong>Metal:</strong> <%= jewelry.getMetal() %></p>
                                                    <p><strong>Gemstones:</strong> <%= jewelry.getGemstones() %></p>
                                                    <p><strong>Measurements:</strong> <%= jewelry.getMeasurements() %></p>
                                                    <p><strong>Weight:</strong> <%= jewelry.getWeight() %></p>
                                                    <p><strong>Stamped:</strong> <%= jewelry.getStamped() %></p>
                                                    <p><strong>Ring Size:</strong> <%= jewelry.getRingSize() %></p>
                                                    <p><strong>Final Price:</strong> <%= jewelry.getFinalPrice() %></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } else { %>
                <p>No approval requests found.</p>
                <% } %>
            </div>
        </main>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQ+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>
