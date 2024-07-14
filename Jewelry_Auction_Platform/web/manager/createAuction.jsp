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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../staff/asset/finalValuation.css">
        <title>Create Auction</title>
    </head>
    <style>
        /* Sidebar */
        /* Google Font Link */
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins" , sans-serif;
        }
        .sidebar{
            position: fixed;
            left: 0;
            top: 0;
            height: 100%;
            width: 78px;
            background: #11101D;
            padding: 6px 14px;
            z-index: 99;
            transition: all 0.5s ease;
        }
        .sidebar.open{
            width: 270px;
        }
        .sidebar .logo-details{
            height: 60px;
            display: flex;
            align-items: center;
            position: relative;
        }
        .sidebar .logo-details .icon{
            opacity: 0;
            transition: all 0.5s ease;
        }
        .sidebar .logo-details .logo_name{
            color: #fff;
            font-size: 20px;
            font-weight: 600;
            opacity: 0;
            transition: all 0.5s ease;
        }
        .sidebar.open .logo-details .icon,
        .sidebar.open .logo-details .logo_name{
            opacity: 1;
        }
        .sidebar .logo-details #btn{
            position: absolute;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            font-size: 22px;
            transition: all 0.4s ease;
            font-size: 23px;
            text-align: center;
            cursor: pointer;
            transition: all 0.5s ease;
        }
        .sidebar.open .logo-details #btn{
            text-align: right;
        }
        .sidebar i{
            color: #fff;
            height: 60px;
            min-width: 50px;
            font-size: 28px;
            text-align: center;
            line-height: 60px;
        }
        .sidebar .nav-list{
            margin-top: 20px;
            height: 100%;
        }
        .sidebar li{
            position: relative;
            margin: 8px 0;
            list-style: none;
        }
        .sidebar li .tooltip{
            position: absolute;
            top: -20px;
            left: calc(100% + 15px);
            z-index: 3;
            background: #fff;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 400;
            opacity: 0;
            white-space: nowrap;
            pointer-events: none;
            transition: 0s;
        }
        .sidebar li:hover .tooltip{
            opacity: 1;
            pointer-events: auto;
            transition: all 0.4s ease;
            top: 50%;
            transform: translateY(-50%);
        }
        .sidebar.open li .tooltip{
            display: none;
        }
        .sidebar input{
            font-size: 15px;
            color: #FFF;
            font-weight: 400;
            outline: none;
            height: 50px;
            width: 100%;
            width: 50px;
            border: none;
            border-radius: 12px;
            transition: all 0.5s ease;
            background: #1d1b31;
        }
        .sidebar.open input{
            padding: 0 20px 0 50px;
            width: 100%;
        }
        .sidebar .bx-search{
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            font-size: 22px;
            background: #1d1b31;
            color: #FFF;
        }
        .sidebar.open .bx-search:hover{
            background: #1d1b31;
            color: #FFF;
        }
        .sidebar .bx-search:hover{
            background: #FFF;
            color: #11101d;
        }
        .sidebar li a{
            display: flex;
            width: 100%;
            border-radius: 12px;
            align-items: center;
            text-decoration: none;
            transition: all 0.4s ease;
            background: #11101D;
        }
        .sidebar li a:hover{
            background: #FFF;
        }
        .sidebar li a .links_name{
            color: #fff;
            font-size: 15px;
            font-weight: 400;
            white-space: nowrap;
            opacity: 0;
            pointer-events: none;
            transition: 0.4s;
        }
        .sidebar.open li a .links_name{
            opacity: 1;
            pointer-events: auto;
        }
        .sidebar li a:hover .links_name,
        .sidebar li a:hover i{
            transition: all 0.5s ease;
            color: #11101D;
        }
        .sidebar li i{
            height: 50px;
            line-height: 50px;
            font-size: 18px;
            border-radius: 12px;
        }
        .sidebar li.profile{
            position: fixed;
            height: 60px;
            width: 78px;
            left: 0;
            bottom: -8px;
            padding: 10px 14px;
            background: #1d1b31;
            transition: all 0.5s ease;
            overflow: hidden;
        }
        .sidebar.open li.profile{
            width: 250px;
        }
        .sidebar li .profile-details{
            display: flex;
            align-items: center;
            flex-wrap: nowrap;
        }
        .sidebar li img{
            height: 45px;
            width: 45px;
            object-fit: cover;
            border-radius: 6px;
            margin-right: 10px;
        }
        .sidebar li.profile .name,
        .sidebar li.profile .job{
            font-size: 15px;
            font-weight: 400;
            color: #fff;
            white-space: nowrap;
        }
        .sidebar li.profile .job{
            font-size: 12px;
        }
        .sidebar .profile #log_out{
            position: absolute;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            background: #1d1b31;
            width: 100%;
            height: 60px;
            line-height: 60px;
            border-radius: 0px;
            transition: all 0.5s ease;
        }
        .sidebar.open .profile #log_out{
            width: 50px;
            background: none;
        }
        .home-section{
            position: relative;
            background: #E4E9F7;
            min-height: 100vh;
            top: 0;
            left: 78px;
            width: calc(100% - 78px);
            transition: all 0.5s ease;
            z-index: 2;
        }
        .sidebar.open ~ .home-section{
            left: 270px;
            width: calc(100% - 270px);
        }
        .home-section .text{
            display: inline-block;
            color: #11101d;
            font-size: 25px;
            font-weight: 500;
            margin: 18px
        }
        @media (max-width: 420px) {
            .sidebar li .tooltip{
                display: none;
            }
        }
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1050;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            transition: all 0.3s ease;
        }

        .modal-dialog {
            margin: 1.75rem auto;
            max-width: 800px;
            transition: transform 0.3s ease-out;
        }

        .modal.fade .modal-dialog {
            transform: translateY(-100px);
        }

        .modal.show .modal-dialog {
            transform: translateY(0);
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.5s;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 10px;
        }

        .modal-title {
            margin: 0;
            font-size: 1.25rem;
        }

        .modal-header .close {
            background: none;
            border: none;
            font-size: 1.5rem;
            color: #aaa;
            cursor: pointer;
            transition: color 0.3s;
        }

        .modal-header .close:hover {
            color: #000;
        }

        .modal-body {
            margin-top: 20px;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            border-top: 1px solid #dee2e6;
            padding-top: 10px;
            margin-top: 20px;
        }

        .thumbnail-container {
            text-align: center;
            margin-top: 10px;
        }

        .thumbnail-container img {
            max-width: 100%;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .action-buttons .btn {
            margin-right: 10px;
        }

        /* Fade in animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10%);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        /* custom.css */
        .heading-main {
            color: #2563eb; /* Tailwind's blue-600 */
            margin-top: 1rem;
            margin-bottom: 1rem;
            font-size: 1.875rem; /* 3xl */
            font-weight: bold;
        }

        .heading-greeting {
            color: #4b5563; /* Tailwind's gray-700 */
            margin-top: 0.5rem;
            margin-bottom: 0.5rem;
            font-size: 1.5rem; /* 2xl */
            font-style: italic;
        }
        .gradient-line {
            height: 2px; /* Adjust the height as needed */
            width: 100%; /* Adjust the width as needed */
            background: linear-gradient(to right, #a8c0ff, #325fcf,#a8c0ff, #325fcf); /* Adjust the colors as needed */
            margin: 20px 0; /* Adjust the margin as needed */
        }
        .modal-backdrop {
            display: none;
            z-index: 1040 !important;
        }

        .modal-content {
            margin: 2px auto;
            z-index: 1100 !important;
        }

        /* Search Filter */
        .dataTables_filter {
            float: right;
            margin-bottom: 10px;
            margin-right: 8px;
        }

        .dataTables_filter label {
            font-weight: bold;
        }

        .dataTables_filter input {
            margin-left: 10px;
            padding: 5px 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            outline: none;
        }

        /* Pagination */
        .dataTables_paginate {
            margin-top: 20px;
            text-align: center;
            margin-bottom: 30px;
        }

        .dataTables_paginate a {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 4px;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border: 1px solid #007bff;
            transition: all 0.3s ease;
        }

        .dataTables_paginate a:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            transform: scale(1.1);
        }

        .dataTables_paginate .paginate_button.current {
            background-color: #0056b3;
            border-color: #0056b3;
            color: white;
            font-weight: bold;
        }

        .dataTables_paginate .paginate_button.disabled {
            background-color: #e9ecef;
            color: #6c757d;
            border-color: #e9ecef;
            pointer-events: none;
        }

        .dataTables_info {
            float: left;
            margin-top: 20px;
        }

        .dataTables_length {
            float: left;
            margin-right: 20px;
        }
        .custom-checkbox {
            position: absolute;
            opacity: 0;
        }

        .checkbox-custom {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #bfbfc0;
            border-radius: 4px;
            position: relative;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .custom-checkbox:checked + .checkbox-custom::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(45deg);
            width: 5px;
            height: 10px;
            border: solid #fff;
            border-width: 0 2px 2px 0;
            transform-origin: center;
            animation: checkmark 0.3s ease forwards;
        }

        @keyframes checkmark {
            0% {
                width: 0;
                height: 0;
                opacity: 1;
                transform: translate(-50%, -50%) rotate(45deg);
            }
            100% {
                width: 6px;
                height: 12px;
                opacity: 1;
                transform: translate(-50%, -50%) rotate(45deg);
            }
        }

        .custom-checkbox:checked + .checkbox-custom {
            background-color: #866efb;
            border-color: #866efb;
        }

        .custom-checkbox:checked + .checkbox-custom::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #fff;
            animation: ripple 0.4s ease-out forwards;
        }

        @keyframes ripple {
            0% {
                width: 0;
                height: 0;
                opacity: 1;
            }
            100% {
                width: 40px;
                height: 40px;
                opacity: 0;
            }
        }



    </style>
    <body>
        <div class="container-fluid">     
            <div class="row">
                <!-- Sidebar -->
                <div class="sidebar">
                    <div class="logo-details">
                        <i class='bx bxs-analyse icon'></i>
                        <div class="logo_name">Manager Portal</div>
                        <i class='bx bx-menu' id="btn" ></i>
                    </div>
                    <ul class="nav-list">
                        <li>
                            <i class='bx bx-search' ></i>
                            <input type="text" placeholder="Search...">
                            <span class="tooltip" style=>Search</span>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/manager">
                                <i class='bx bx-grid-alt'></i> 
                                <span class="links_name">Manager Control Panel</span>
                            </a>
                            <span class="tooltip">Manager Control Panel</span>
                        </li>
                        <li>
                            <a class="link_names" href="${pageContext.request.contextPath}/manager">
                                <i class='bx bx-edit'></i> 
                                <span class="links_name">Pending Requests</span>
                            </a>
                            <span class="tooltip">Pending Requests</span>
                        </li>
                        <li>
                            <a class="link_names" href="${pageContext.request.contextPath}/manager/createAuction.jsp">
                                <i class='bx bxs-calendar-plus'></i> 
                                <span class="links_name">Create Auction</span>
                            </a>
                            <span class="tooltip">Create Auction</span>
                        </li>
                        <li>
                            <a class="link_names" href="${pageContext.request.contextPath}/manageAuction">
                                <i class='bx bx-cog'></i> 
                                <span class="links_name">Manage Auction</span>
                            </a>
                            <span class="tooltip">Manage Auction</span>
                        </li>
                        <li>
                            <a class="link_names" href="${pageContext.request.contextPath}/manageUser">
                                <i class='bx bx-cog'></i> 
                                <span class="links_name">Manage User</span>
                            </a>
                            <span class="tooltip">Manage User</span>
                        </li>
                        <li class="profile">
                            <div class="profile-details">
                                <img src="data:image/png;base64,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" alt="profileImg">
                                <div class="name_job">
                                    <div class="name">Manager</div>
                                    <div class="job">Manager</div>
                                </div>
                            </div>
                            <a class="link_names" href="${pageContext.request.contextPath}/logout">
                                <i class='bx bx-log-out' id="log_out"> 
                                </i>
                            </a>
                        </li>
                    </ul>
                </div>
                <!-- Main Content -->
                <section class="home-section">
                    <main role="main" class="col-span-9 ml-auto col-span-10 px-4">
                        <div class="container mt-4">
                            <br>
                            <h1 class="heading-main">Create Auction</h1>
                            <h1 class="heading-greeting">Good <%= greeting%>!</h1>
                            <div class="gradient-line"></div>
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
                                    <label for="auctionDate" class="block text-sm font-medium text-gray-700">Bidding Open </label><br>
                                    <span class="block text-sm font-medium text-gray-700">from</span>
                                    <input type="date" id="auctionDate" name="auctionStartDate" class="bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 border border-gray-300 rounded-md py-2 px-3 text-sm mt-1 mb-2 w-full" required>
                                    <span class="block text-sm font-medium text-gray-700">to</span>
                                    <input type="date" id="auctionDate" name="auctionEndDate" class="bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 border border-gray-300 rounded-md py-2 px-3 text-sm mt-1 mb-2 w-full" required>
                                </div>
                                <div class="form-group">
                                    <label for="timeRange" class="block text-sm font-medium text-gray-700">Live Sale Conclusion on </label>
                                    <div class="flex">
                                        <input type="time" id="startTime" name="startTime" class="bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 border border-gray-300 rounded-md py-2 px-3 text-sm mt-1 mb-2 mr-2 w-1/2" required>
                                        <input type="time" id="endTime" name="endTime" class="bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 border border-gray-300 rounded-md py-2 px-3 text-sm mt-1 mb-2 w-1/2" required>
                                    </div>
                                </div>
                                <input type="hidden" id="selectedJewelryIDsInput" name="selectedJewelryIDs">
                                <div class="form-group">
                                    <button type="submit" name="action" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Create Auction</button>
                                </div>

                                <div class="table-responsive" style="overflow: hidden">
                                    <table id="jewelryTable" class="w-full divide-y divide-gray-200 table-auto">
                                        <thead>
                                            <tr style="background-color: #a8a1f7">
                                                <th class="px-6 py-3 text-left text-xs font-medium text-black uppercase tracking-wider">Select</th>
                                                <th class="px-6 py-3 text-left text-xs font-medium text-black uppercase tracking-wider">Photo</th>
                                                <th class="px-6 py-3 text-left text-xs font-medium text-black uppercase tracking-wider">Jewelry Name</th>
                                                <th class="px-6 py-3 text-left text-xs font-medium text-black uppercase tracking-wider">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody class="bg-white divide-y divide-gray-200">
                                            <%
                                                for (Jewelry jewelry : listJewelry) {
                                            %>
                                            <tr>
                                                <td class="py-4 text-center">
                                                    <label class="inline-flex items-center">
                                                        <input type="checkbox" name="jewelryID" value="<%= jewelry.getJewelryID()%>" onchange="handleCheckboxChange(this)" class="custom-checkbox">
                                                        <span class="checkbox-custom"></span>
                                                    </label>
                                                </td>
                                                <td class="py-4">
                                                    <% String[] photoArray = jewelry.getPhotos().split(";"); %>
                                                    <img class="img-thumbnail" style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%= photoArray[0]%>">
                                                </td>
                                                <td class="py-4">
                                                    <%= jewelry.getJewelryName()%>
                                                </td>
                                                <td class="py-4">
                                                    <button type="button" class="bg-indigo-400 hover:bg-indigo-700 text-white px-4 py-2 rounded-md" onclick='showJewelryDetails(<%= new Gson().toJson(jewelry)%>)'>View Details</button>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="pagination" style="display: none">
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
                        </div>
                        <% } else { %>
                        <p class="text-center text-gray-600 mt-8 py-4 bg-gray-100 border border-gray-200 rounded-md shadow-md">No jewelry found.</p>
                        <% } %>
                        </div>
                    </main>
                </section>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade fixed inset-0 z-50 overflow-auto" id="jewelryModal" tabindex="-1" aria-labelledby="jewelryModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg mx-auto mt-24">
                <div class="modal-content bg-white shadow-lg rounded-lg">
                    <div class="modal-header p-4 rounded-t" style="background-color: #a8a1f7">
                        <h5 class="modal-title text-lg text-gray-900" id="jewelryModalLabel">Jewelry Details</h5>
                    </div>
                    <div class="modal-body px-4 py-2">
                        <div class="grid grid-cols-2 gap-x-4 gap-y-2">
                            <div class="mb-2">
                                <p class="font-bold">Name:</p>
                                <p id="modalJewelryName"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Artist:</p>
                                <p id="modalArtist"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Circa:</p>
                                <p id="modalCirca"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Material:</p>
                                <p id="modalMaterial"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Dial:</p>
                                <p id="modalDial"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Bracelet Material:</p>
                                <p id="modalBraceletMaterial"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Case Dimensions:</p>
                                <p id="modalCaseDimensions"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Bracelet Size:</p>
                                <p id="modalBraceletSize"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Serial Number:</p>
                                <p id="modalSerialNumber"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Reference Number:</p>
                                <p id="modalReferenceNumber"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Caliber:</p>
                                <p id="modalCaliber"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Movement:</p>
                                <p id="modalMovement"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Condition:</p>
                                <p id="modalCondition"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Metal:</p>
                                <p id="modalMetal"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Gemstones:</p>
                                <p id="modalGemstones"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Measurements:</p>
                                <p id="modalMeasurements"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Weight:</p>
                                <p id="modalWeight"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Stamped:</p>
                                <p id="modalStamped"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Ring Size:</p>
                                <p id="modalRingSize"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Min Price:</p>
                                <p id="modalMinPrice"></p>
                            </div>
                            <div class="mb-2">
                                <p class="font-bold">Max Price:</p>
                                <p id="modalMaxPrice"></p>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer px-4 py-3 bg-gray-50 text-right rounded-b">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
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
    $(document).ready(function () {
        $('#jewelryTable').DataTable({
            "lengthChange": false,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": false,
            "pageLength": 10
        });
    });

    function goToPage(pageNumber) {
        const urlParams = new URLSearchParams(window.location.search);
        urlParams.set('page', pageNumber);
        window.location.search = urlParams.toString();
    }

    function updateSelectedJewelryIDs() {
        const checkboxes = document.querySelectorAll('input[name="jewelryID"]:checked');
        const selectedIDs = Array.from(checkboxes).map(cb => cb.value);
        document.getElementById('selectedJewelryIDsInput').value = selectedIDs.join(',');
    }
    let sidebar = document.querySelector(".sidebar");
    let closeBtn = document.querySelector("#btn");
    let searchBtn = document.querySelector(".bx-search");
    closeBtn.addEventListener("click", () => {
        sidebar.classList.toggle("open");
        menuBtnChange();//calling the function(optional)
    });
    searchBtn.addEventListener("click", () => { // Sidebar open when you click on the search iocn
        sidebar.classList.toggle("open");
        menuBtnChange(); //calling the function(optional)
    });
    // following are the code to change sidebar button(optional)
    function menuBtnChange() {
        if (sidebar.classList.contains("open")) {
            closeBtn.classList.replace("bx-menu", "bx-menu-alt-right");//replacing the iocns class
        } else {
            closeBtn.classList.replace("bx-menu-alt-right", "bx-menu");//replacing the iocns class
        }
    }
</script>
</body>
</html>
