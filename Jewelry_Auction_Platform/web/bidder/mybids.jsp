<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Bids</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <style>
            body, html {
                height: 100%;
                margin: 0;
                font-family: Arial, sans-serif;
            }
            nav {
                background-color: white;
                color: #000000;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: fixed;
                top: 0;
                width: 100%; /* Full width */
                z-index: 1000; /* Ensure it's above other content */
                box-shadow: 0 2px 4px rgba(0,0,0,0.1); /* Optional: Add shadow for depth */
            }

            .nav-links {
                display: flex;
            }

            .nav-links a {
                color: #000000;
                text-decoration: none;
                margin-right: 10px;
                padding: 8px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .nav-links a:hover {
                background-color: rgba(85, 85, 85, 0.5);
                color: white;
            }

            .nav-logout {
                margin-left: auto; /* Pushes the logout link to the right */
                margin-right:  40px
            }

            .nav-logout a {
                color: #000000;
                text-decoration: none;
                padding: 8px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .nav-logout a:hover {
                background-color: rgba(85, 85, 85, 0.5);
                color: white;
            }


            .container {
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                background-color: #f0f0f0;
                padding: 20px;
                overflow: hidden;
            }
            .jewelry-list {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 30px;
                max-width: 1200px;
                width: 100%;
                overflow: auto;
                padding: 20px;
            }
            .jewelry-item {
                display: flex;
                flex-direction: column;
                background-color: #ffffff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .jewelry-id {
                font-weight: bold;
                margin-bottom: 10px;
                text-align: right
            }
            .jewelry-photos {
                display: flex;
                justify-content: center;
                margin-bottom: 10px;
            }
            .jewelry-photos img {
                max-width: 100%;
                height: auto;
                object-fit: cover;
                margin-right: 10px;
            }
            .jewelry-prebid {
                color: #4CAF50;
                font-weight: bold;
                margin-top: 10px;
                font-size: 15px;
                font-family: Helvetica;
                text-align: left;

            }
            .jewelry-status {
                text-align: left;
                margin-top: 10px;
                font-weight: bold;
                color: #337ab7;
                font-size: 15px;
                font-family: Helvetica
            }
            h2 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
            }
            .btn {
                width: 140px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: space-evenly;
                text-transform: uppercase;
                letter-spacing: 1px;
                border: none;
                position: relative;
                background-color: transparent;
                transition: .2s cubic-bezier(0.19, 1, 0.22, 1);
                opacity: 0.6;
            }

            .btn::after {
                content: '';
                border-bottom: 3px double rgb(214, 207, 113);
                width: 0;
                height: 100%;
                position: absolute;
                margin-top: -5px;
                top: 0;
                left: 5px;
                visibility: hidden;
                opacity: 1;
                transition: .2s linear;
            }

            .btn .icon {
                transform: translateX(0%);
                transition: .2s linear;
                animation: attention 1.2s linear infinite;
            }

            .btn:hover::after {
                visibility: visible;
                opacity: 0.7;
                width: 90%;
            }

            .btn:hover {
                letter-spacing: 2px;
                opacity: 1;
            }

            .btn:hover > .icon {
                transform: translateX(30%);
                animation: none;
            }

            @keyframes attention {
                0% {
                    transform: translateX(0%);
                }

                50% {
                    transform: translateX(30%);
                }
            }

            .filter-form {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                padding: 10px;
                background-color: darkred;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);

            }

            .filter-form label {
                margin-right: 10px;
                font-weight: bold;
                font-family: 'Helvetica', sans-serif;
                color: #ffffff
            }

            .custom-select {
                display: inline-block;
                width: 160px;
                height: 40px;
                padding: 10px;
                font-size: 14px;
                font-family: 'Helvetica', sans-serif;
                color: #555;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
                appearance: none;
                background-color: #fff;
                background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"><path fill="#aaa" d="M2 0L0 2h4zm0 5L0 3h4z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 8px 12px;
            }

            .custom-select:focus {
                border-color: #aaa;
                outline: none;
            }

            .custom-select:hover {
                border-color: #888;
            }

        </style>
    </head>
    <body>
        <c:set var="member" value="${sessionScope.MEMBER}" />
        <nav>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/auctions">Auctions</a>
                <a href="${pageContext.request.contextPath}/valuation">Selling</a>
                <a href="${pageContext.request.contextPath}/my-upcoming-bids">My Bids</a>
                <a href="${pageContext.request.contextPath}/response">My Asset</a>
            </div>
            <div class="nav-logout">
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </nav>
        <div style="margin-top: 100px; background-color: #ffffff" class="container">
            <div style="font-family: 'Zapf-Chancery'; margin-right: 800px; font-size: 2em; margin-top: -20px">Auction Results</div>

            <!-- Filter Form -->
            <div class="filter-form" style="margin-bottom: 20px; margin-right: -800px">
                <label for="statusFilter">Filter by Status: </label>
                <select id="statusFilter" name="statusFilter" class="custom-select">
                    <option value="">All</option>
                    <option value="Placed">Placed</option>
                    <option value="Lost">Lost</option>
                    <option value="Pending Payment">Pending Payment</option>
                    <option value="Paid">Paid</option>
                    <option value="Delivery">Delivery</option>
                </select>
            </div>
            <div class="jewelry-list">
                <c:forEach var="jewelry" items="${requestScope.JEWELRYLIST}">
                    <div class="jewelry-item" data-status="${jewelry.statusBid}">
                        <div class="jewelry-id">ID ${jewelry.jewelryID}</div>
                        <div class="jewelry-photos">
                            <c:set var="photoArray" value="${fn:split(jewelry.photos, ';')}" />
                            <img src="${photoArray[0]}" alt="Jewelry Photo">
                        </div>
                        <div style="font-size: 20px; font-family: Helvetica">${jewelry.jewelryName}</div>
                        <div class="row">
                            <div class="col-lg-6">
                                <c:choose>
                                    <c:when test="${jewelry.statusBid != 'Pending Payment'}">
                                        <div class="jewelry-status">Status: ${jewelry.statusBid}</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="jewelry-status">Status: ${jewelry.statusBid}</div>
                                        <form action="${pageContext.request.contextPath}/pay" method="POST">
                                            <input type="hidden" name="memberID" value="${member.memberID}">
                                            <input type="hidden" name="jewelryID" value="${jewelry.jewelryID}">
                                            <input type="hidden" name="jewelryName" value="${jewelry.jewelryName}">
                                            <input type="hidden" name="photo" value="${photoArray}">
                                            <input type="hidden" name="bidAmount" value="${jewelry.currentBid}">
                                            <button type="submit" style="font-weight: bold; font-size: 18px; color: red" class="btn">
                                                Pay Now 
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" height="15px" width="15px" class="icon">
                                                <path stroke-linejoin="round" stroke-linecap="round" stroke-miterlimit="10" stroke-width="1.5" stroke="#292D32" d="M8.91016 19.9201L15.4302 13.4001C16.2002 12.6301 16.2002 11.3701 15.4302 10.6001L8.91016 4.08008"></path>
                                                </svg>
                                            </button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-lg-6">
                                <div class="jewelry-prebid">Your Bid: $${jewelry.currentBid}</div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <footer style="background-color: #000407; font-family: Helvetica; height: 30px; bottom: 0; width: 100%; text-align: center;">
            <span style="color: lightgrey; font-size: 14px;">&#169; F'RANKELLY AUCTION <script>document.write(new Date().getFullYear())</script></span>
        </footer>
    </body>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const statusFilter = document.getElementById('statusFilter');
            const jewelryItems = document.querySelectorAll('.jewelry-item');

            statusFilter.addEventListener('change', function () {
                const selectedStatus = this.value;

                jewelryItems.forEach(item => {
                    const itemStatus = item.getAttribute('data-status');

                    if (selectedStatus === '' || itemStatus === selectedStatus) {
                        item.style.display = '';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });
    </script>
</html>


