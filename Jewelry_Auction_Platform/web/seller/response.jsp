<%@page import="entity.request_shipment.RequestShipment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.product.Jewelry"%>
<%@page import="dao.UserDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Notification</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
body {
    font-family: Arial, sans-serif;
    background-color: #f5eded;
    color: #000000;
    padding-top: 70px;
    min-height: 100vh; /* Ensure the body takes at least the full viewport height */
    position: relative; /* Needed for the footer to be positioned relative to the body */
    box-sizing: border-box; /* Include padding and border in the element's total width and height */
    padding-bottom: 100px; /* Add padding to the bottom to ensure content is not covered by the footer */
}

.footer {
    background-color: #343a40;
    color: #e4af11;
    padding: 20px 0;
    position: absolute; /* Position the footer at the bottom */
    bottom: 0; /* Align the footer to the bottom */
    width: 100%;
    text-align: center;
}

.footer a {
    color: #e4af11;
    text-decoration: none;
    padding: 0 10px;
}

.footer a:hover {
    text-decoration: underline;
}

.footer h6 {
    margin: 0;
    padding-bottom: 10px;
    font-size: 1.2em;
}

.footer span {
    font-size: 0.9em;
}


        .navbar-dark .navbar-nav .nav-link,
        .navbar-dark .navbar-brand {
            color: #e4af11 !important;
        }

        .navbar-dark .navbar-toggler {
            border-color: #e4af11;
        }

        .navbar-dark .navbar-toggler-icon {
            color: #e4af11;
        }

        @keyframes shimmer {
            0% {
                background-position: -500px 0;
            }
            100% {
                background-position: 500px 0;
            }
        }

        h1.luminous-gold {
            font-weight: bold;
            background: linear-gradient(90deg, 
                #e4af11 0%, 
                #e4af11 20%, 
                #FFA500 40%, 
                #FFC700 60%, 
                #e4af11 80%, 
                #e4af11 100%);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: shimmer 2s infinite linear;
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.7),
                         0 0 20px rgba(255, 215, 0, 0.5),
                         0 0 30px rgba(255, 215, 0, 0.3),
                         0 0 40px rgba(255, 215, 0, 0.1);
        }

        .table-responsive {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: #ebebe5;
            color: #000000;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #e9ecef;
            font-size: 1.1em;
        }

        td {
            font-size: 1em;
        }

        .thead-light {
            background-color: #e9ecef;
        }

        .text-danger {
            color: red;
        }

        .details-btn {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .details-btn:hover {
            background-color: #0056b3;
        }

        .modal-body p {
            margin-bottom: 10px;
            color: #000000;
        }

        .modal-dialog {
            max-width: 400px;
        }

        .modal-content {
            padding: 20px;
            background-color: #ffffff;
            color: #000000;
        }

        .modal-header {
            border-bottom: none;
        }

        .modal-title {
            font-size: 1.5rem;
            color: #e4af11;
        }

        .close {
            color: #888;
        }

        .close:hover {
            color: #000;
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <a class="navbar-brand" href="#"><i class="fas fa-gem"></i> Jewelry Auctions</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home.jsp"><i class="fas fa-home"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/auctions/upcoming.jsp"><i class="fas fa-gavel"></i> Auction</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/seller/request.jsp"><i class="fas fa-clipboard"></i> Request A Valuation</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/seller/response.jsp"> <i class="fas fa-reply"></i> Response</a>                                                  
                   </li>                   
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/seller/shipmentRequest.jsp"><i class="fas fa-bell"></i> Notification</a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <div class="container">
        <h1 class="text-center luminous-gold">Overall Assessment for your requests</h1>
        <%
            String userID = (String) session.getAttribute("USERID");
            UserDAOImpl dao = new UserDAOImpl();
            List<Jewelry> listJewelry = dao.getJewelryByUserID(userID);
            if (listJewelry != null && !listJewelry.isEmpty()) {
        %>
        <div class="table-responsive">
            <table id="jewelryTable" class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr id="table">
                        <th>Photo</th>
                        <th>Jewelry Name</th>
                        <th>Artist</th>
                        <th>Final Price</th>
                        <th>Status</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody id="jewelryTableBody">
                    <% for (Jewelry jewelry : listJewelry) { %>
                    <tr>
                        <% String[] photoArray = jewelry.getPhotos().split(";"); %>
                        <td><img class="img-fluid" src="${pageContext.request.contextPath}/<%= photoArray[0] %>" alt="Jewelry Image" style="max-width: 100px; max-height: 100px;"></td>
                        <td><%= jewelry.getJewelryName() %></td>
                        <td><%= jewelry.getArtist() %></td>
                        <% String status = jewelry.getStatus(); %>
                        <% String finalPrice = (jewelry.getFinal_Price() != null) ? jewelry.getFinal_Price() : "Updating"; %>
                        <% if (status.equals("Re-Evaluated")) { %>
                        <td style="color: red"><%= finalPrice %></td>
                        <td class="text-danger">Waiting for shipment</td>
                        <% } else if (status.equals("Received")) { %>
                        <td style="color: red"><%= finalPrice %></td>
                        <td style="color: green">Received</td>
                        <% } else if (status.equals("Pending Confirm")) { %>
                        <td style="color: red"> <%= finalPrice %> </td>
                        <td style="color: green"><strong>Pending Confirm</strong><br>
                            <form action="${pageContext.request.contextPath}/MainController">
                                <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                                <input type="submit" class="btn btn-success btn-sm" name="action" value="Confirm">
                            </form><br>
                            <form action="${pageContext.request.contextPath}/MainController">
                                <input type="hidden" name="jewelryID" value="<%= jewelry.getJewelryID() %>">
                                <input type="submit" class="btn btn-danger btn-sm" name="action" value="Reject">
                            </form>
                        </td>
                        <% } else if (status.equals("Confirmed")) { %>
                        <td style="color: rgb(23, 163, 213)"> <%= finalPrice %> </td>
                        <td style="color: rgb(11, 224, 71)">Ready To Auction</td>
                        <% } else { %>
                        <td style="color: rgb(215, 218, 33)">Updating</td>
                        <td style="color: red">In Progress</td>
                        <% } %>
                        <td><button class="btn btn-primary details-btn" data-toggle="modal" data-target="#detailsModal" data-jewelry='<%= jewelry %>'>Details</button></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p class="no-jewelry">No jewelry found</p>
        <% } %>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="detailsModal" tabindex="-1" aria-labelledby="detailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="detailsModalLabel">Jewelry Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Jewelry details will be loaded here -->
                </div>
            </div>
        </div>
    </div>

    <footer class="footer mt-auto py-3 bg-dark text-white text-center">
        <div>
            <h6>Jewelry Auction</h6>
            <a href="register.jsp">Register</a> |
            <a href="login.jsp">Login</a> |
            <a href="#">Help & FAQ</a> |
            <a href="#">Support</a> |
            <a href="#">Sitemap</a>
        </div>
        <div>
            <span>&copy; <script>document.write(new Date().getFullYear())</script> Jewelry Auction. All rights reserved.</span>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script>
        function fetchJewelryData() {
            $.ajax({
                url: '${pageContext.request.contextPath}/UpdateJewelryServlet',
                type: 'GET',
                success: function (data) {
                    var tableBody = $('#jewelryTableBody');
                    tableBody.empty();

                    if (data.length === 0) {
                        $('.no-jewelry').removeClass('hidden');
                        $('#jewelryTable').addClass('hidden');
                    } else {
                        $('.no-jewelry').addClass('hidden');
                        $('#jewelryTable').removeClass('hidden');

                        data.forEach(function (jewelry) {
                            var photos = jewelry.photos.split(";");
                            var status = jewelry.status;
                            var finalPrice = (jewelry.final_Price != null) ? jewelry.final_Price : "Updating";
                            var statusText = '';

                            if (status === 'Re-Evaluated') {
                                statusText = '<td style="color: red">' + finalPrice + '</td><td class="text-danger">Waiting for shipment</td>';
                            } else if (status === 'Received') {
                                statusText = '<td style="color: red">' + finalPrice + '</td><td style="color: green">Received</td>';
                            } else if (status === 'Pending Confirm') {
                                statusText = '<td style="color: red">' + finalPrice + '</td><td style="color: green"><strong>Pending Confirm</strong><br>' +
                                        '<form action="${pageContext.request.contextPath}/MainController"><input type="hidden" name="jewelryID" value="' + jewelry.jewelryID + '"><input type="submit" class="btn btn-success btn-sm" name="action" value="Confirm"></form><br>' +
                                        '<form action="${pageContext.request.contextPath}/MainController"><input type="hidden" name="jewelryID" value="' + jewelry.jewelryID + '"><input type="submit" class="btn btn-danger btn-sm" name="action" value="Reject"></form></td>';
                            } else if (status === 'Confirmed') {
                                statusText = '<td style="color: rgb(23, 163, 213)">' + finalPrice + '</td><td style="color: rgb(11, 224, 71)">Ready To Auction</td>';
                            } else {
                                statusText = '<td style="color: rgb(215, 218, 33)">Updating</td><td style="color: red">In Progress</td>';
                            }

                            tableBody.append(
                                    '<tr>' +
                                    '<td><img class="img-fluid" src="${pageContext.request.contextPath}/' + photos[0] + '" alt="Jewelry Image" style="max-width: 100px; max-height: 100px;"></td>' +
                                    '<td>' + jewelry.jewelryName + '</td>' +
                                    '<td>' + jewelry.artist + '</td>' +
                                    statusText +
                                    '<td><button class="btn btn-primary details-btn" data-toggle="modal" data-target="#detailsModal" data-jewelry=\'' + JSON.stringify(jewelry) + '\'>Details</button></td>' +
                                    '</tr>'
                            );
                        });
                    }
                },
                error: function () {
                    console.error('Failed to fetch jewelry data');
                }
            });
        }

        $(document).ready(function () {
            // Fetch jewelry data initially
            fetchJewelryData();

            // Set interval to fetch jewelry data periodically (every minute)
            setInterval(fetchJewelryData, 60000);

            // Load jewelry details into the modal
            $('#detailsModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var jewelry = button.data('jewelry');
                var modal = $(this);
                modal.find('.modal-body').html(
                    '<p><strong>Jewelry Name:</strong> ' + jewelry.jewelryName + '</p>' +
                    '<p><strong>Artist:</strong> ' + jewelry.artist + '</p>' +
                    '<p><strong>Circa:</strong> ' + jewelry.circa + '</p>' +
                    '<p><strong>Material:</strong> ' + jewelry.material + '</p>' +
                    '<p><strong>Dial:</strong> ' + jewelry.dial + '</p>' +
                    '<p><strong>Bracelet Material:</strong> ' + jewelry.braceletMaterial + '</p>' +
                    '<p><strong>Case Dimensions:</strong> ' + jewelry.caseDimensions + '</p>' +
                    '<p><strong>Bracelet Size:</strong> ' + jewelry.braceletSize + '</p>' +
                    '<p><strong>Serial Number:</strong> ' + jewelry.serialNumber + '</p>' +
                    '<p><strong>Reference Number:</strong> ' + jewelry.referenceNumber + '</p>' +
                    '<p><strong>Caliber:</strong> ' + jewelry.caliber + '</p>' +
                    '<p><strong>Movement:</strong> ' + jewelry.movement + '</p>' +
                    '<p><strong>Condition:</strong> ' + jewelry.condition + '</p>' +
                    '<p><strong>Metal:</strong> ' + jewelry.metal + '</p>' +
                    '<p><strong>Gemstones:</strong> ' + jewelry.gemstones + '</p>' +
                    '<p><strong>Measurements:</strong> ' + jewelry.measurements + '</p>' +
                    '<p><strong>Weight:</strong> ' + jewelry.weight + '</p>' +
                    '<p><strong>Stamped:</strong> ' + jewelry.stamped + '</p>' +
                    '<p><strong>Ring Size:</strong> ' + jewelry.ringSize + '</p>' +
                    '<p><strong>Min Price:</strong> ' + jewelry.minPrice + '</p>' +
                    '<p><strong>Max Price:</strong> ' + jewelry.maxPrice + '</p>' +
                    '<p><strong>Temporary Price:</strong> ' + jewelry.temp_Price + '</p>'
                );
            });
        });
    </script>
</body>
</html>
