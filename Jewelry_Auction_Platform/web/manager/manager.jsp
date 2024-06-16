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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Jewelry Auctions</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/manager/manager.jsp"><i class="fas fa-clipboard-list"></i> Request</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/manager/createAuction.jsp"><i class="fas fa-plus-circle"></i> Create Auction</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/manager/auctionManagement.jsp"><i class="fas fa-cogs"></i> Auction Management</a>
                    </li>
                </ul>
                <form action="${pageContext.request.contextPath}/MainController" method="POST" onsubmit="confirmLogout(event)" class="form-inline my-2 my-lg-0">
                    <button type="submit" name="action" class="btn btn-outline-danger my-2 my-sm-0" value="Log out"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </form>
            </div>
        </nav>
        <main class="container mt-4">
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
                                                    <p><strong>Final Price:</strong> <%= jewelry.getFinal_Price() %></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <form action="${pageContext.request.contextPath}/MainController" method="GET" onsubmit="confirmAuction(event)">
                                                <input type="hidden" name="action" value="Approve">
                                                <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <button type="submit" name="action" value="Approve" class="btn btn-success">Confirm</button>
                                            </form>
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
    </body>
</html>

