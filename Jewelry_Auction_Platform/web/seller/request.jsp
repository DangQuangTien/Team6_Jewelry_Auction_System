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
    <title>Jewelry Auctions Online</title>
    <!-- Include Bootstrap CSS and FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="asset/request.css">

</head>

<body ng-controller="validateCtrl" class="d-flex flex-column min-vh-100">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#"><i class="fas fa-gem"></i> Jewelry Auctions</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">          
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home.jsp"><i class="fas fa-home"></i> Home <span class="sr-only">(current)</span></a>
                </li>                
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/auctions/upcoming.jsp"><i class="fas fa-gavel"></i> Auction</a>
                </li>
            </ul>
        </div>
    </nav>

    <main class="container mt-4 flex-grow-1">
        <div class="card">
            <div class="card-header bg-primary text-white">
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

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="../component/form.js"></script>
    <script src="asset/request.js"></script>
</body>
</html>
