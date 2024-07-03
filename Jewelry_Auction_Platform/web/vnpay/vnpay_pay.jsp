<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Pending Payment</title>
        <link href="assets/bootstrap.min.css" rel="stylesheet"/>
        <link href="assets/jumbotron-narrow.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                color: #343a40;
            }
            .container {
                margin-top: 20px;
                background-color: #fff;
                padding: 30px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .header h3 {
                font-size: 24px;
                font-weight: bold;
            }
            .jewelry-photo {
                margin-bottom: 20px;
                text-align: center;
            }
            .jewelry-photo img {
                width: 100%;
                max-width: 500px;
                height: auto;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
            }
            .thumbnail-container {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 15px;
            }
            .thumbnail-img {
                width: 80px;
                height: 80px;
                cursor: pointer;
                transition: transform 0.2s ease-in-out;
            }
            .thumbnail-img:hover {
                transform: scale(1.1);
            }
            .jewelry-details {
                margin-top: 20px;
            }
            .jewelry-details h4 {
                font-size: 22px;
                font-weight: bold;
                margin-bottom: 15px;
            }
            .jewelry-details p {
                font-size: 16px;
                margin-bottom: 10px;
            }
            .form-group small {
                font-size: 14px;
                color: #555;
            }
            .form-check-label {
                font-size: 16px;
                margin-left: 10px;
            }
            .btn {
                background-color: #007bff; /* A professional blue color */
                color: white;
                padding: 16px 24px; /* Increased padding for better touch target */
                margin: 12px 0;
                border: none;
                width: 100%;
                border-radius: 5px; /* Slightly increased border radius */
                cursor: pointer;
                font-size: 18px;
                font-family: Arial, Helvetica, sans-serif; /* Professional font family */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .btn:hover {
                background-color: #0056b3; /* Darker blue for hover */
                transform: translateY(-1px);
                color: lightgrey
            }

            .btn:focus {
                outline: none;
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.4);
            }

            .btn:active {
                background-color: #004085; /* Even darker blue for active state */
                transform: translateY(1px);
            }

            .btn:disabled {
                background-color: #d6d6d6; /* Light gray for disabled state */
                cursor: not-allowed;
                box-shadow: none;
                color: #666666;
            }

            .footer {
                margin-top: 20px;
                text-align: center;
                font-size: 14px;
                color: #777;
            }
        </style>
        <script src="../assets/jquery-1.11.3.min.js"></script>
        <script>
            function changeMainImage(newSrc) {
                document.getElementById("mainImage").src = newSrc;
            }
        </script>
    </head>
    <body>
        <c:set var="jewelry" value="${requestScope.JEWELRY}" />
        <a  style="margin-left: 100px; text-decoration: none; font-size: 20px" href="${pageContext.request.contextPath}/my-upcoming-bids">< Back</a>
        <div class="container">
            <div class="header clearfix">
                <h3 class="text-muted">F'RENKELLY WITH THE COOPERATION OF VNPAY</h3>
            </div>
            <div class="row">
                <!-- Jewelry Photo Column -->
                <div class="col-md-6">
                    <div class="jewelry-photo">
                        <img id="mainImage" src="${pageContext.request.contextPath}/${fn:split(jewelry.photos, ';')[0]}" class="img-responsive">
                    </div>
                    <div class="thumbnail-container">
                        <c:forEach var="photo" items="${fn:split(jewelry.photos, ';')}" varStatus="loop">
                            <img class="thumbnail-img" src="${pageContext.request.contextPath}/${photo}" onclick="changeMainImage('${pageContext.request.contextPath}/${photo}')">
                        </c:forEach>
                    </div>
                </div>
                <!-- Jewelry Details Column -->
                <div class="col-md-6">
                    <div class="jewelry-details">
                        <h4>Product Information</h4>
                        <p><strong>Product ID: </strong>${jewelry.jewelryID}</p>
                        <p><strong>Product Name: </strong>${jewelry.jewelryName}</p>
                        <p><strong>Category: </strong>${jewelry.categoryName}</p>
                        <p><strong>Est. </strong>$${jewelry.minPrice} - $${jewelry.maxPrice}</p>
                    </div>
                </div>
                <!-- Payment Form Column -->
                <c:set var="bidAmount" value="${Double.parseDouble(param.bidAmount)}"/>
                <div class="col-md-6">
                    <hr>
                    <div class="table-responsive">
                        <form action="${pageContext.request.contextPath}/vnpayajax" id="frmCreateOrder" method="post">        
                            <div class="form-group">
                                <table class="table table-bordered">
                                    <thead>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Total Price</td>
                                            <td>$${bidAmount}</td>
                                        </tr>
                                        <tr>
                                            <c:choose>
                                                <c:when test="${bidAmount <= 300000}">
                                                    <c:set var="biddingFee" value="${bidAmount * 0.25}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${bidAmount > 300000 and bidAmount <= 3000000}">
                                                            <c:set var="biddingFee" value="${bidAmount * 0.20}" />
                                                        </c:when>
                                                        <c:when test="${bidAmount > 3000000}">
                                                            <c:set var="biddingFee" value="${bidAmount * 0.125}" />
                                                        </c:when>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                            <!-- Output the bidding fee -->
                                            <td>Fee</td>
                                            <td>$${biddingFee}</td>
                                        </tr>
                                        <tr>
                                            <td>Becoming Money</td>
                                            <c:set var="total" value="${biddingFee + bidAmount}"/>
                                            <td>$${total}</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <small class="form-text text-muted">
                                    Bidding Fee Auction:
                                    <ul>
                                        <li>25% on the first $300,000</li>
                                        <li>20% from $300,001 to $3,000,000</li>
                                        <li>12.5% on the excess over $3,000,000</li>
                                    </ul>
                                </small>
                            </div>
                            <!-- Total money member has to pay -->
                            <div class="form-group">
                                <label for="amount">TOTAL (VND)</label>
                                <c:set var="totalMoney" value="${Math.round(total * 24000.0)}"/>
                                <fmt:formatNumber value="${totalMoney}" pattern="#,##0"/>
                                <input class="form-control" 
                                       id="amount" 
                                       name="amount" 
                                       type="number" 
                                       step="1"
                                       readonly 
                                       value="${totalMoney}" 
                                       data-val="true" 
                                       data-val-range-min="5000"
                                       data-val-range-max="999999999"
                                       data-val-number="The field Amount must be a number." 
                                       data-val-required="The Amount field is required."/>
                            </div>
                            <!-- Hidden fields to send jewelry data -->
                            <input type="hidden" name="jewelryID" value="${jewelry.jewelryID}"/>
                            <input type="hidden" name="memberID" value="${param.memberID}"/>
                            <h4>Select Payment Method</h4>
                            <div class="form-group">
                                <h5>Option 1: Redirect to VNPAY Gateway to select payment method</h5>
                                <input type="radio" checked="true" id="bankCode" name="bankCode" value="">
                                <label for="bankCode">VNPAYQR Payment Gateway</label><br>

                                <h5>Option 2: Separate methods at the connection unit's site</h5>
                                <input type="radio" id="bankCode" name="bankCode" value="VNPAYQR">
                                <label for="bankCode">Payment via VNPAYQR supporting application</label><br>

                                <input type="radio" id="bankCode" name="bankCode" value="VNBANK">
                                <label for="bankCode">Payment via ATM card/Domestic account</label><br>

                                <input type="radio" id="bankCode" name="bankCode" value="INTCARD">
                                <label for="bankCode">Payment via International card</label><br>
                            </div>
                            <div class="form-group">
                                <h5>Select Payment Interface Language:</h5>
                                <input type="radio" id="language" checked="true" name="language" value="vn">
                                <label for="language">Vietnamese</label><br>
                                <input type="radio" id="language" name="language" value="en">
                                <label for="language">English</label><br>
                            </div>
                            <button type="submit" class="btn btn-default" href>Continue to checkout</button>
                        </form>
                    </div>
                </div>
            </div>
            <footer class="footer">
                <p>&copy; VNPAY 2024</p>
            </footer>
        </div>
        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script>
                                document.getElementById("frmCreateOrder").addEventListener("submit", function (event) {
                                    event.preventDefault(); // Prevent the default form submission
                                    var xhr = new XMLHttpRequest();
                                    xhr.open("POST", this.action, true);
                                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                    xhr.onload = function () {
                                        if (xhr.status === 200) {
                                            var response = JSON.parse(xhr.responseText);
                                            if (response.code === "00") {
                                                window.location.href = response.data;
                                            } else {
                                                alert("Payment initiation failed: " + response.message);
                                            }
                                        } else {
                                            alert("An error occurred while initiating payment.");
                                        }
                                    };
                                    xhr.send(new URLSearchParams(new FormData(this)).toString());
                                });
        </script>
    </body>
</html>
