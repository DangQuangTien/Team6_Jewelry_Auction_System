<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="entity.Auction.Auction"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.product.Category"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en" ng-app="bidApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewelry Auctions Online - Register & Place Your Bid</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../component/header.css">
    <link rel="stylesheet" type="text/css" href="../component/footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            font-family: 'Arial', sans-serif;
        }
        .item-details {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            background: #fff; 
            padding: 20px;
            border-radius: 8px; 
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
        }
        .item-image {
            max-width: 100%;
            margin-bottom: 20px;
        }
        .item-image img {
            width: 100%;
            border-radius: 8px;
            border: 1px solid #ddd;
        }
        .item-info {
            max-width: 100%;
            padding-left: 20px;
        }
        .item-info h3 {
            font-size: 24px;
            margin-bottom: 15px;
        }
        .item-info p {
            font-size: 16px;
            margin-bottom: 10px;
        }
        .register-btn {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 18px;
        }
        .modal-header {
            background-color: #007bff;
            color: #fff;
        }
        .modal-body {
            padding: 30px;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-control {
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
        }
        .form-control-file {
            font-size: 16px;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
        .btn-block {
            padding: 10px;
            font-size: 18px;
        }
    </style>
</head>
<body>
</head>
<body>
    <!-- START OF HEADER -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-light">
            <a class="navbar-brand" href="#">Jewelry Auctions</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Home<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="auctions/upcoming.jsp">Auction</a>
                    </li>
                    <c:if test="${role == 'Member' || role == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="seller/selling.html">Sell</a>
                        </li>
                    </c:if>
                    <c:choose>
                        <c:when test="${username == null}">
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="register.jsp">Register</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:set var="url">
                                <c:choose>
                                    <c:when test="${role == 'Member'}">bidder/profile.jsp</c:when>
                                    <c:when test="${role == 'Staff'}">staff/staff.jsp</c:when>
                                    <c:when test="${role == 'Manager'}">manager/manager.jsp</c:when>
                                    <c:otherwise>admin/admin.jsp</c:otherwise>
                                </c:choose>
                            </c:set>
                            <li class="nav-item">
                                <a class="nav-link" href="${url}">${username}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                    <li class="nav-item">
                        <a class="nav-link" href="notification.jsp" id="bell-icon"><i class="fas fa-bell"></i></a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search for anything" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
            </div>
        </nav>
    </header>
    <!-- END OF HEADER -->

    <main class="container mt-4" ng-controller="BidController">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <h1 class="mb-3">Register Bid</h1>
            </div>
        </div>
        <div class="row item-details mt-4">
            <div class="col-md-4 item-image">
                <!-- Bind image source to AngularJS scope -->
                <img ng-src="{{item.photos}}" alt="{{item.jewelryName}}">
            </div>
            <div class="col-md-8 item-info">
                <!-- Bind content to AngularJS scope -->
                <h3>{{item.jewelryName}}</h3>
                <p><strong>Category:</strong> {{item.category}}</p>
                <p><strong>Artist:</strong> {{item.artist}}</p>
                <p><strong>Material:</strong> {{item.material}}</p>
                <p><strong>Current Bid:</strong> ${{item.currentBid}}</p>
                <button class="btn btn-primary register-btn" data-toggle="modal" data-target="#registerModal">Register Bid</button>
            </div>
        </div>
    </main>

  <!--  <main class="container mt-4" ng-controller="BidController">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <h1 class="mb-3">Register to Place Your Bid</h1>
                <button class="btn btn-primary register-btn" data-toggle="modal" data-target="#registerModal">Register</button>
            </div>
        </div>
        <div class="row item-details mt-4">
            <div class="col-md-4 item-image">
                <img src="<%=request.getAttribute("itemPhoto")%>" alt="<%=request.getAttribute("itemJewelryName")%>">
            </div>
            <div class="col-md-8 item-info">
                <h3><%=request.getAttribute("itemJewelryName")%></h3>
                <p><strong>Category:</strong> <%=request.getAttribute("itemCategory")%></p>
                <p><strong>Artist:</strong> <%=request.getAttribute("itemArtist")%></p>
                <p><strong>Material:</strong> <%=request.getAttribute("itemMaterial")%></p>
                <p><strong>Current Bid:</strong> $<%=request.getAttribute("itemCurrentBid")%></p>
            </div>
        </div>
    </main>
-->
    <!-- Registration Modal -->
     
    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registerModalLabel">Register</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Dummy content for testing -->
                    <form id="registerForm" name="registerForm" method="post" action="registerBid" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                            <span class="error-message" ng-show="registerForm.firstName.$dirty && registerForm.firstName.$invalid">
                                <span ng-show="registerForm.firstName.$error.required">First name is required.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                            <span class="error-message" ng-show="registerForm.lastName.$dirty && registerForm.lastName.$invalid">
                                <span ng-show="registerForm.lastName.$error.required">Last name is required.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                            <span class="error-message" ng-show="registerForm.email.$dirty && registerForm.email.$invalid">
                                <span ng-show="registerForm.email.$error.required">Email is required.</span>
                                <span ng-show="registerForm.email.$error.email">Invalid email address.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="phoneNumber">Phone Number</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                            <span class="error-message" ng-show="registerForm.phoneNumber.$dirty && registerForm.phoneNumber.$invalid">
                                <span ng-show="registerForm.phoneNumber.$error.required">Phone number is required.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                            <span class="error-message" ng-show="registerForm.address.$dirty && registerForm.address.$invalid">
                                <span ng-show="registerForm.address.$error.required">Address is required.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="paymentMethod">Payment Method</label>
                            <select class="form-control" id="paymentMethod" name="paymentMethod" required>
                                <option value="">Select a payment method</option>
                                <option value="Credit Card">Credit Card</option>
                                <option value="PayPal">PayPal</option>
                                <option value="Bank Transfer">Bank Transfer</option>
                            </select>
                            <span class="error-message" ng-show="registerForm.paymentMethod.$dirty && registerForm.paymentMethod.$invalid">
                                <span ng-show="registerForm.paymentMethod.$error.required">Payment method is required.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="financialDocument">Financial Document</label>
                            <input type="file" class="form-control-file" id="financialDocument" name="financialDocument" required>
                            <span class="error-message" ng-show="registerForm.financialDocument.$dirty && registerForm.financialDocument.$invalid">
                                <span ng-show="registerForm.financialDocument.$error.required">Uploading a financial document is required.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="bidAmount">Bid Amount</label>
                            <input type="number" class="form-control" id="bidAmount" name="bidAmount" ng-model="user.bidAmount" required>
                            <span class="error-message" ng-show="registerForm.bidAmount.$dirty && registerForm.bidAmount.$invalid">
                                <span ng-show="registerForm.bidAmount.$error.required">Bid amount is required.</span>
                                <span ng-show="registerForm.bidAmount.$error.number">Invalid bid amount.</span>
                            </span>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block" ng-disabled="registerForm.$invalid">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
     <!-- START OF FOOTER -->
     <footer class="text-center py-3 mt-auto">
        <div>
            <h6>Jewelry Auction</h6>
            <a href="register.jsp">Register</a> |
            <a href="login.jsp">Login</a> |
            <a href="#">Help & FAQ</a> |
            <a href="#">Support</a> |
            <a href="#">Sitemap</a>
        </div>
    </footer>
    <!-- END OF FOOTER -->

    <!-- Include jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        var app = angular.module('bidApp', []);
        app.controller('BidController', function($scope) {

            // Dummy data for testing
            $scope.item = {
                jewelryName: 'Beautiful Diamond Ring',
                category: 'Rings',
                artist: 'John Doe',
                material: 'Gold',
                currentBid: 1000,
                photos: 'https://hips.hearstapps.com/hmg-prod/images/little-box-of-glitter-royalty-free-image-1687815428.jpg'
            };
   <!--       // $scope.item = {
        //        jewelryName: '<%=request.getAttribute("itemJewelryName")%>',
       //         artist: '<%=request.getAttribute("itemArtist")%>',
        //        material: '<%=request.getAttribute("itemMaterial")%>',
        //        currentBid: '<%=request.getAttribute("itemCurrentBid")%>',
        //        photos: '<%=request.getAttribute("itemPhoto")%>'
        //    }; -->
            $scope.user = {};
            $scope.submitRegister = function(isValid) {
                if (isValid) {
                    alert('Form submitted successfully!');
                }
            };
        });
    </script>
</body>
</html>
