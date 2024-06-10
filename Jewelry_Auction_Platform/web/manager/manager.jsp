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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
        <style>
            h3 {
                font-size: 2em;
                color: #4CAF50;
                text-align: center;
                padding: 20px;
                border-radius: 10px;
                background: linear-gradient(135deg, #ff6f91, #ff9671, #ffc75f, #f9f871, #d65db1, #845ec2, #2c73d2, #0081cf, #0089ba, #008e9b, #00c9a7);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                box-shadow: 0 0 20px rgba(255, 255, 255, 0.8);
                animation: wave 3s linear infinite;
            }

            @keyframes wave {
                0%, 100% {
                    transform: translateY(0);
                }
                25% {
                    transform: translateY(-5px);
                }
                50% {
                    transform: translateY(0);
                }
                75% {
                    transform: translateY(5px);
                }
            }
            .table-responsive {
                margin: 20px auto;
            }
            table {
                width: 100%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                border: 1px solid #ddd;
            }


            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
                border-right: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
                border-top: 1px solid #ddd;
            }
            tr:hover {
                background-color: #f5f5f5;
            }

            .submit-btn, .action-btn {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .submit-btn:hover, .action-btn:hover {
                background-color: #45a049;
            }
        </style>
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
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Jewelry Auctions</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/manager/auctionManagement.jsp">Auction Management</a>
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
