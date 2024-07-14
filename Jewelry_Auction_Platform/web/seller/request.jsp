
<%-- 
    Document   : valuation
    Created on : May 19, 2024, 2:08:38 AM
    Author     : User
--%>

<!DOCTYPE html>
<html lang="en" ng-app="valuationApp">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>F'RANKELLY? - Get A Jewelry and/or Watch Valuation Before Selling</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
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
                padding-top: 1px;
                padding-bottom: 1px;
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
                background-color: rgba(27, 27, 27, 0.75);
                border: 1px solid rgba(255, 255, 255, 0.1);
                animation: fadeIn 0.5s;
                margin-top: -10px
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
            .card-header {
                background-color: #343a40 !important;
            }

            .card-title, .card-subtitle {
                color: gold;
            }

            main {
                flex-grow: 1;
            }

            footer {
                background-color: #343a40;
                color: #fff;
                padding: 1rem;
                text-align: center;
            }

            footer a {
                color: #ffc107;
                margin: 0 10px;
            }

            footer a:hover {
                color: #a98585;
            }
            .error-message {
                color: red;
                font-size: 0.9em;
            }

            .btn-primary span {
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

            .list-group-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .btn {
                width: 250px;
                height: 50px;
                background-color: #c82333;
                margin-top: 50px;
                color: white;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
                font-family: Helvetica;
            }

            .btn:hover {
                background-color: #a71d2a;
                color: #e9ecef;
                transform: scale(1.05);
            }

        </style>
    </head>
    <body ng-controller="validateCtrl" class="d-flex flex-column min-vh-100">
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
            <div class="container">
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
                            <a class="nav-link" href="home"> HOME</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#"
                               id="auctionDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">
                                AUCTIONS <i class="fas fa-caret-down"></i>
                            </a>
                            <div class="dropdown-menu"
                                 aria-labelledby="auctionDropdown">
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="auctions">UPCOMING
                                    AUCTIONS</a>
                                <a style="font-family:Andale Mono" class="dropdown-item" href="pastauction">PAST
                                    AUCTION</a>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#"
                               id="sellingDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">
                                SELLING <i class="fas fa-caret-down"></i>
                            </a>
                            <div class="dropdown-menu"
                                 aria-labelledby="sellingDropdown">
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="selling">ABOUT SELLING
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="response">APPRAISED ASSET
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="notification">SHIPMENT REQUEST
                                </a>
                                <a style="font-family:Andale Mono" class="dropdown-item"
                                   href="valuation">VALUATION REQUEST
                                </a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about"> ABOUT</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about"> CONTACT</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div style="margin-top: 150px" class="container">
            <div style="font-family: Brush Script MT;color: #333;">
                <h1 style=" font-size: 80px">Jewelry & Watch Valuation</h1>
            </div><br>
            <p style="font-family: Helvetica; color: #333; text-align: left; font-size: 18px">Welcome to our quote / valuation request page. If you haven't yet read about what makes F'RANKELLY the leading boutique jewelry and watch auction house and would like to, or, if you would like to learn more about the process of selling at F'RANKELLY, click the button below.
                Otherwise, if you're ready to submit your quote / valuation request, please continue to scroll down to the form below.
            </p><br>
            <div style="font-family: Helvetica; color: #333; font-size: 2em">Ready to submit your valuation request?</div><br>
            <p style="font-family: Helvetica; color: #333; text-align: left; font-size: 18px">Kindly fill out the form below, hit the "Submit Valuation Request" button at the bottom of the form, and wait for the form to successfully submit. A member of Team F'RANKELLY will be in contact shortly thereafter.</p>
            <br>
        </div>
        <main style="margin-bottom: 100px" class="container">
            <div style="background-color: #f5f3f3" class="card-body">
                <form id="valuationForm" name="valuationForm" ng-submit="submitForm(valuationForm.$valid)" novalidate>
                    <div class="form-group">
                        <label for="name">Name</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                            </div>
                            <input type="text" class="form-control" id="name" name="name" ng-model="user.name" required>
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
                            <input type="email" class="form-control" id="email" name="email" ng-model="user.email" email-validation required>
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
                            <input type="tel" class="form-control" id="phone" name="phone"  ng-model="user.phone" phone-validation required>
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
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" ng-model="user.description" ></textarea>
                    </div>
                    <small class="form-text text-muted"> Please briefly describe your jewelry and/or watches in the field above.</small>
                    <button type="submit" class="btn" ng-disabled="valuationForm.$invalid">
                        <span ng-show="!loading">Submit Valuation Request</span>
                        <span ng-show="loading" class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                    </button>
                </form>
            </div>
        </div>
    </div>
</main>
<footer style="background-color: #000407; font-family: Helvetica; height: 60px">
    <span style="color: lightgrey; font-size: 14px">&copy; F'RANKELLY AUCTION <script>document.write(new Date().getFullYear())</script></span>
</footer>
</body>
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
                        Swal.fire({
                            title: 'Success!',
                            text: 'Form submitted successfully!',
                            icon: 'success',
                            confirmButtonText: 'OK'
                        });

                        $scope.user = {};
                        $scope.files = [];
                        $scope.valuationForm.$setPristine();
                        $scope.valuationForm.$setUntouched();
                    }, function (error) {
                        Swal.fire({
                            title: 'Error!',
                            text: 'An error occurred while submitting the form.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
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
</script>
<script>
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

    $(document).ready(function () {
        $("a.nav-link").on('click', function (event) {
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
</script>
</html>
