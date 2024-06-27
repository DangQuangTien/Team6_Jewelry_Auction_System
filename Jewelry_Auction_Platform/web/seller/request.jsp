<!DOCTYPE html>
<html lang="en" ng-app="valuationApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewelry Auctions Online</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f5eded;
        }

        .navbar {
                background: radial-gradient(circle, rgba(255, 239, 166, 1) 0%, rgba(218, 165, 32, 0.8) 50%, rgba(184, 134, 11, 0.8) 100%);
                background-size: 200% 200%;
                background-position: 50% 50%;
                transition: background 0.3s ease, box-shadow 0.3s ease, padding-top 0.3s ease, padding-bottom 0.3s ease;
                padding-top: 15px;
                padding-bottom: 15px;
                z-index: 1000;
                backdrop-filter: blur(15px);
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3), 0 0 20px rgba(0, 0, 0, 0.19);
            }

            .navbar:hover {
                background-position: 100% 100%;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.25);
            }

            .navbar-scrolled {
                background-color: black;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
                padding-top: 10px;
                padding-bottom: 10px;
            }

            .navbar-brand .brand-name {
                font-size: 2em;
                font-family: 'Zapf-Chancery';
                font-weight: 700;
                color: black;
            }

            .nav-link {
                color: black !important;
                transition: color 0.3s;
                font-family: Andale Mono;
                font-size: 1.25em;
            }

            .navbar-nav .nav-link {
                position: relative;
                transition: color 0.3s;
            }

            .navbar-nav .nav-link::after {
                content: '';
                position: absolute;
                bottom: -5px;
                left: 50%;
                width: 0;
                height: 2px;
                background-color: #ffc107;
                transition: width 0.3s, left 0.3s;
                visibility: hidden;
            }


            .dropdown-menu {
                background-color: #000;
                border: 1px solid rgba(255, 255, 255, 0.1);
                animation: fadeIn 0.5s;
            }

            .dropdown-item {
                color: #fff !important;
                transition: background-color 0.3s, color 0.3s;
                position: relative; /* Ensure pseudo-element positioning */
            }

            .dropdown-item::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: -2px;
                width: 0;
                height: 2px;
                background-color: transparent;
                transition: width 0.3s ease;
            }

            .dropdown-item:hover {
                background-color: rgba(255, 255, 255, 0.1) !important;
                color: #ffc107 !important;
            }

            .dropdown-item:hover::after {
                width: 100%;
                background-color: #ffc107
            }
            .nav-item dropdown:hover::after {
                width: 100%;
                background-color: #ffc107
            }

        .content {
            padding: 20px;
            flex-grow: 1;
        }

        .card-header {
            background-color: #343a40 !important;
        }

        .card-title, .card-subtitle {
            color: gold;
        }

        .btn-primary {
            background-color: #343a40 !important;
            border-color: #000407 !important;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #343a40;
            border-color: #004085;
        }

        .btn-primary span {
            color: gold;
        }

        .error-message {
            color: red;
            font-size: 0.9em;
        }

        .list-group-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer-decoration {
            position: relative;
        }

        .footer-lines {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, #ffc107, transparent);
            animation: slide 10s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.2);
            }
        }

        @keyframes slide {
            0% {
                left: -100%;
            }
            50% {
                left: 100%;

            }
            100% {
                left: -100%;
            }
        }

        .animated-button {
            animation: slideInFromLeft 2s ease-in-out;
        }

        .animated-button-right {
            animation: slideInFromRight 2s ease-in-out;
        }

        @keyframes slideInFromLeft {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }

        @keyframes slideInFromRight {
            from { transform: translateX(100%); }
            to { transform: translateX(0); }
        }

        main {
            flex-grow: 1;
        }

        footer {
            background-color: #000;
            color: #fff;
            padding: 1rem 0;
            text-align: center;
            position: relative;
            overflow: hidden;           
        }

        footer a {
            color: #ffc107;
            margin: 0 10px;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        .hover-shadow {
            transition: box-shadow 0.3s ease-in-out;
        }

        .hover-shadow:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        .input-group-text, .form-control {
            transition: box-shadow 0.3s ease-in-out, border-color 0.3s ease-in-out;
        }

        .input-group-text:hover, .form-control:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-color: #e4af11;
        }

        .input-group-text i, .form-control i {
            transition: transform 0.3s ease-in-out;
        }

        .input-group-text:hover i, .form-control:hover i {
            transform: scale(1.2);
        }
    </style>
</head>

<body ng-controller="validateCtrl" class="d-flex flex-column min-vh-100">

<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand"
    href="${pageContext.request.contextPath}/home">
     <span class="brand-name">F'RANKELLY</span>
 </a>
 <button class="navbar-toggler" type="button"
         data-toggle="collapse" data-target="#navbarNav"
         aria-controls="navbarNav" aria-expanded="false"
         aria-label="Toggle navigation">
     <span class="navbar-toggler-icon"></span>
 </button>
    <div class="collapse navbar-collapse" id="navbarNav">          
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Home <span class="sr-only">(current)</span></a>
            </li>                
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/auctions"><i class="fas fa-gavel"></i> Auction</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/valuation"><i class="fas fa-clipboard"></i> Request A Valuation</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/response"><i class="fas fa-reply"></i> Response</a>                                   
            </li>                
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/notification"><i class="fas fa-bell"></i> Notification</a>
            </li>
        </ul>
    </div>
</nav>

<main class="container mt-4 flex-grow-1">
    <div class="card hover-shadow">
        <div class="card-header bg-dark text-white text-center">
            <h1 class="card-title">Jewelry &amp; Valuation</h1>
            <p class="card-subtitle">Welcome to our quote / valuation request page</p>
        </div>
        <div class="card-body">
            <h3>Ready to submit your valuation request?</h3>
            <div class="row">
                <div class="col-md-6">
                    <form id="valuationForm" name="valuationForm" ng-submit="submitForm(valuationForm.$valid)" novalidate>
                        <div class="form-group">
                            <label for="name">Name</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" ng-model="user.name" required>
                            </div>
                            <span class="error-message" ng-show="valuationForm.name.$dirty && valuationForm.name.$invalid">
                                <span ng-show="valuationForm.name.$error.required">Name is required.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                </div>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email address" ng-model="user.email" email-validation required>
                            </div>
                            <span class="error-message" ng-show="valuationForm.email.$dirty && valuationForm.email.$invalid">
                                <span ng-show="valuationForm.email.$error.required">Email is required.</span>
                                <span ng-show="valuationForm.email.$error.emailValidation">Invalid email address.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="phone">Mobile Phone Number</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                </div>
                                <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter your mobile phone number" ng-model="user.phone" phone-validation required>
                            </div>
                            <span class="error-message" ng-show="valuationForm.phone.$dirty && valuationForm.phone.$invalid">
                                <span ng-show="valuationForm.phone.$error.required">Phone number is required.</span>
                                <span ng-show="valuationForm.phone.$error.phoneValidation">Invalid phone number format. It should be 10 digits.</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="communication">Communication preference</label><br>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="communication" id="emailComm" value="Email" ng-model="user.communication" required>
                                <label class="form-check-label" for="emailComm">Email</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="communication" id="textComm" value="Text Message" ng-model="user.communication">
                                <label class="form-check-label" for="textComm">Text Message</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="communication" id="phoneComm" value="Phone Call" ng-model="user.communication">
                                <label class="form-check-label" for="phoneComm">Phone Call</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="communication" id="anyComm" value="Any of the above" ng-model="user.communication">
                                <label class="form-check-label" for="anyComm">Any of the above</label>
                            </div>
                            <span class="error-message" ng-show="valuationForm.communication.$dirty && valuationForm.communication.$invalid">
                                <span ng-show="valuationForm.communication.$error.required">Communication preference is required.</span>
                            </span>
                            <small class="form-text text-muted">Please let us know how you wish to be contacted. We will try to contact you via your preferred method that you select here but may use other methods if we are unsuccessful.</small>
                        </div>
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" id="description" name="description" ng-model="user.description" placeholder="Please briefly describe your jewelry and/or watches in the field above."></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary" ng-disabled="valuationForm.$invalid">
                            <span ng-show="!loading">Submit Valuation Request</span>
                            <span ng-show="loading" class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                        </button>
                    </form>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="image">Photos</label>
                        <input type="file" class="form-control-file" id="image" name="image" multiple required accept="image/*" onchange="angular.element(this).scope().handleFileSelect(this)">
                        <small class="form-text text-muted">Please upload photos of your jewelry and/or watches in the field above. If you have photos that the form will not accept (too large or too many) please mention this in the description below and we will request the additional photos in our follow-up communication with you.</small>
                    </div>
                    <div class="form-group" ng-show="files.length > 0">
                        <label>Selected Photos:</label>
                        <ul class="list-group">
                            <li class="list-group-item" ng-repeat="file in files">
                                {{file.name}}
                                <button type="button" class="btn btn-danger btn-sm float-right" ng-click="removeFile($index)">Remove</button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<footer class="text-center py-4 mt-auto"
style="background-color: #000; color: #fff; position: relative; overflow: hidden;">
<div class="container">
<div class="row">
    <div class="col-md-4">
        <h5>Jewelry Auction</h5>
        <p>Your premier destination for exquisite jewelry and
            gemstones. Discover the timeless beauty and elegance
            in our curated collections.</p>
    </div>
    <div class="col-md-4">
        <h5>Quick Links</h5>
        <ul class="list-unstyled">
            <li><a
                    href="${pageContext.request.contextPath}/register"
                    style="color: #ffc107;">Register</a></li>
            <li><a
                    href="${pageContext.request.contextPath}/login"
                    style="color: #ffc107;">Login</a></li>
            <li><a
                    href="${pageContext.request.contextPath}/auctions"
                    style="color: #ffc107;">Auctions</a></li>
            <li><a
                    href="${pageContext.request.contextPath}/selling"
                    style="color: #ffc107;">Selling</a></li>
        </ul>
    </div>
    <div class="col-md-4">
        <h5>Contact Us</h5>
        <p><i class="fas fa-phone-alt"></i> +849872539999</p>
        <p><i class="fas fa-envelope"></i>
            support@jewelryauction.com</p>
        <p><i class="fas fa-map-marker-alt"></i> 123 Jewelry
            Street, New York, NY</p>
        <div class="social-icons mt-3">
            <a href="#" class="mx-2"
               style="color: #ffc107; transition: transform 0.3s;"><i
                    class="fab fa-facebook-f"></i></a>
            <a href="#" class="mx-2"
               style="color: #ffc107; transition: transform 0.3s;"><i
                    class="fab fa-twitter"></i></a>
            <a href="#" class="mx-2"
               style="color: #ffc107; transition: transform 0.3s;"><i
                    class="fab fa-instagram"></i></a>
            <a href="#" class="mx-2"
               style="color: #ffc107; transition: transform 0.3s;"><i
                    class="fab fa-linkedin-in"></i></a>
        </div>
    </div>
</div>
<div class="mt-4">
    <p>&copy; 2024 Jewelry Auction. All rights reserved.</p>
</div>
</div>
</footer>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    var app = angular.module('valuationApp', []);
    app.controller('validateCtrl', function ($scope, $http) {
        $scope.user = {};
        $scope.files = [];

        $scope.submitForm = function (isValid) {
            if (isValid) {
                var formData = new FormData();

                formData.append('name', $scope.user.name);
                formData.append('email', $scope.user.email);
                formData.append('phone', $scope.user.phone);
                formData.append('communication', $scope.user.communication);
                formData.append('description', $scope.user.description);

                for (var i = 0; i < $scope.files.length; i++) {
                    formData.append('files', $scope.files[i]);
                }

                $http.post('${pageContext.request.contextPath}/process', formData, {
                    transformRequest: angular.identity,
                    headers: {'Content-Type': undefined}
                }).then(function (response) {

                    console.log('Success:', response.data);
                    alert('Form submitted successfully!');

                    $scope.user = {};
                    $scope.files = [];
                    $scope.valuationForm.$setPristine();
                    $scope.valuationForm.$setUntouched();
                }, function (error) {
                    console.log('Error:', error.data);
                    alert('An error occurred while submitting the form.');
                });
            }
        };

        $scope.handleFileSelect = function (element) {
            var files = element.files;
            for (var i = 0; i < files.length; i++) {
                $scope.files.push(files[i]);
            }
            $scope.$apply();
            element.value = '';
        };

        $scope.removeFile = function (index) {
            $scope.files.splice(index, 1);
        };
    });

    app.directive('phoneValidation', function () {
        return {
            require: 'ngModel',
            link: function (scope, element, attrs, ctrl) {
                ctrl.$validators.phoneValidation = function (modelValue, viewValue) {
                    if (ctrl.$isEmpty(modelValue)) {
                        return false;
                    }
                    var PHONE_REGEX = /^[0-9]{10}$/;
                    return PHONE_REGEX.test(viewValue);
                };
            }
        };
    });

    app.directive('emailValidation', function () {
        return {
            require: 'ngModel',
            link: function (scope, element, attrs, ctrl) {
                ctrl.$validators.emailValidation = function (modelValue, viewValue) {
                    if (ctrl.$isEmpty(modelValue)) {
                        return false;
                    }
                    var EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
                    return EMAIL_REGEX.test(viewValue);
                };
            }
        };
    });

    $(document).ready(function () {
        $("a").on('click', function (event) {
            if (this.hash !== "") {
                event.preventDefault();
                var hash = this.hash;
                $('html, body').animate({
                    scrollTop: $(hash).offset().top
                }, 800, function () {
                    window.location.hash = hash;
                });
            }
        });

        $(window).scroll(function () {
            if ($(this).scrollTop() > 50) {
                $('.navbar').addClass('navbar-scrolled');
            } else {
                $('.navbar').removeClass('navbar-scrolled');
            }
        });

        document.addEventListener("DOMContentLoaded", function () {
            window.addEventListener("scroll", function () {
                if (window.scrollY > 50) {
                    document.querySelector(".navbar").classList.add("navbar-scrolled");
                } else {
                    document.querySelector(".navbar").classList.remove("navbar-scrolled");
                }
            });
        });

        document.addEventListener("DOMContentLoaded", function () {
            var dropdowns = document.querySelectorAll('.nav-item.dropdown');

            dropdowns.forEach(function (dropdown) {
                dropdown.addEventListener('mouseenter', function () {
                    var dropdownMenu = dropdown.querySelector('.dropdown-menu');
                    if (dropdownMenu) {
                        dropdownMenu.classList.add('show');
                    }
                });
                dropdown.addEventListener('mouseleave', function () {
                    var dropdownMenu = dropdown.querySelector('.dropdown-menu');
                    if (dropdownMenu) {
                        dropdownMenu.classList.remove('show');
                    }
                });
            });
        });
    });
</script>

</body>
</html>