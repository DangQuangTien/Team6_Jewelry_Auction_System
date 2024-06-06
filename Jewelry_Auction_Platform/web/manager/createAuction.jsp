<%@page import="entity.product.Jewelry"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create Auction</title>
    <script>
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
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            color: #333;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .table-container {
            max-height: 500px;
            overflow-y: auto;
            margin-top: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            position: sticky;
            top: 0;
            z-index: 1;
        }
        .alert {
            padding: 15px;
            background-color: #f9edbe;
            color: #856404;
            border: 1px solid #ffeeba;
            border-radius: 5px;
        }
        .img-thumbnail {
            width: 100px;
            height: 100px;
            object-fit: cover;
        }
        .submit-btn {
            background-color: #007bff;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #0056b3;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .pagination a {
            color: black;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            margin: 0 4px;
            border-radius: 5px;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        .pagination a:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/manager/manager.jsp"">Home Page</a>
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
                            <td><input type="checkbox" value="<%= jewelry.getJewelryID() %>" onchange="handleCheckboxChange(this)"></td>
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
</body>
</html>
