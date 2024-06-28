<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Bids</title>
        <style>
            .navbar {
                background-color: #333;
                overflow: hidden;
                width: 100%;
            }
            .navbar a {
                float: left;
                display: block;
                color: white;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
                font-size: 17px;
            }
            .navbar a:hover {
                background-color: #ddd;
                color: black;
            }
            body, html {
                height: 100%;
                margin: 0;
                font-family: Arial, sans-serif;
            }
            .container {
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                background-color: #f0f0f0;
                padding: 20px;
                overflow: hidden; /* Ẩn thanh cuộn của trình duyệt */
            }
            .jewelry-list {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 30px; /* Khoảng cách giữa các mục */
                max-width: 1200px; /* Giới hạn chiều rộng của danh sách sản phẩm */
                width: 100%; /* Đảm bảo danh sách sản phẩm lấp đầy không gian container */
                overflow: auto; /* Cho phép cuộn nếu danh sách dài hơn màn hình */
                padding: 20px; /* Khoảng cách bố trí nội dung */
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
                text-align: right;
                color: #4CAF50;
                font-weight: bold;
            }
            .jewelry-status {
                text-align: left;
                margin-top: 10px;
                font-weight: bold;
                color: #337ab7;
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

        </style>
    </head>
    <body>
        <c:set var="member" value="${sessionScope.MEMBER}" />
            <div class="navbar">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/auctions">Auctions</a>
                <a href="${pageContext.request.contextPath}/profile">Profile</a>
                <a href="${pageContext.request.contextPath}/logout" style="float:right">Logout</a>
            </div>
            <div class="container">
                <h2>My Bids</h2>
                <div class="jewelry-list">
                    <c:forEach var="jewelry" items="${requestScope.JEWELRYLIST}">
                        <div class="jewelry-item">
                            <div class="jewelry-id">ID ${jewelry.jewelryID}</div>
                            <div class="jewelry-photos">
                                <c:set var="photoArray" value="${fn:split(jewelry.photos, ';')}" />
                                    <img src="${photoArray[0]}" alt="Jewelry Photo">
                            </div>
                                <font style="font-family: 'Zapf-Chancery'; font-size: 20px; font-weight: bold">${jewelry.jewelryName}</font><br>
                            <div class="jewelry-prebid">Your Bid: $${jewelry.preBid}</div>
                            <c:choose>
                                <c:when test="${jewelry.statusBid != 'Pending Payment'}">
                                    <div class="jewelry-status">Status: ${jewelry.statusBid}</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="jewelry-status">Status: ${jewelry.statusBid}</div>
                                    <form action="https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=1806000&vnp_Command=pay&vnp_CreateDate=20210801153333&vnp_CurrCode=VND&vnp_IpAddr=127.0.0.1&vnp_Locale=vn&vnp_OrderInfo=Thanh+toan+don+hang+%3A5&vnp_OrderType=other&vnp_ReturnUrl=https%3A%2F%2Fdomainmerchant.vn%2FReturnUrl&vnp_TmnCode=DEMOV210&vnp_TxnRef=5&vnp_Version=2.1.0&vnp_SecureHash=3e0d61a0c0534b2e36680b3f7277743e8784cc4e1d68fa7d276e79c23be7d6318d338b477910a27992f5057bb1582bd44bd82ae8009ffaf6d141219218625c42" method="GET">
                                        <input type="hidden" name="memberID" value="${member.memberID}">
                                        <input type="hidden" name="jewelryID" value="${jewelry.jewelryID}">
                                        <input type="hidden" name="jewelryName" value="${jewelry.jewelryName}">
                                        <input type="hidden" name="photo" value="${photoArray}}">
                                        <input type="hidden" name="bid" value="${jewelry.preBid}">
                                        <button type="submit" style="font-weight: bold" class="btn">
                                        Pay Now 
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" height="15px" width="15px" class="icon">
                                        <path stroke-linejoin="round" stroke-linecap="round" stroke-miterlimit="10" stroke-width="1.5" stroke="#292D32" d="M8.91016 19.9201L15.4302 13.4001C16.2002 12.6301 16.2002 11.3701 15.4302 10.6001L8.91016 4.08008"></path>
                                        </svg>
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </body>
    </html>


