<!DOCTYPE html>
<html lang="en" ng-app="valuationApp">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewelry Auctions Blog</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="component/footer.css">
    <link rel="stylesheet" type="text/css" href="component/NavBar.css">  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
         
</head>
<style>
    .navbar {
    position: sticky;
    top: 0;
    z-index: 1000;
    background-color: #343a40;
    border-bottom: 3px solid #e4af11;
}

.navbar-brand, .nav-link, .navbar-toggler-icon {
    color: #ffc107 !important;
}

.navbar-brand:hover, .nav-link:hover {
    color: #0a0800 !important;
}

.content {
    flex: 1;
    padding: 20px;
}
</style>
<body>
  
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#"><i class="fas fa-gem"></i> Jewelry Auctions</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-home"></i> Home<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="auctions/upcoming.jsp"><i class="fas fa-gavel"></i> Auction</a>
                </li>
                <c:if test="${role == 'Member' || role == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="seller/selling.html"><i class="fas fa-dollar-sign"></i> Sell</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
    

    <!-- END OF HEADER -->
    <main class="container mt-4" ng-controller="ValuationController">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <h1 class="mb-3">Jewelry & Watch Valuation</h1>
                <p class="lead">Welcome to our quote / valuation request page</p>
                <h3 class="mt-4 mb-3">Ready to submit your valuation request?</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="image">Photos</label>
                    <input type="file" class="form-control-file" id="image" name="image" multiple required accept="image/*" onchange="angular.element(this).scope().handleFileSelect(this)">
                    <small class="form-text text-muted">Please upload photos of your jewelry and/or watches in the field above. If you have photos that the form will not accept (too large or too many) please mention this in the description below and we will request the additional photos in our follow-up communication with you.</small>
                </div>
                <div class="form-group" ng-show="files.length > 0">
                    <label>Selected Photos:</label>
                    <div class="selected-photos">
                        <div class="photo-item" ng-repeat="file in files">
                            <img ng-src="{{file.url}}" alt="{{file.name}}" class="img-thumbnail">
                            <div>{{file.name}}</div>
                            <button type="button" class="btn btn-danger btn-sm mt-2" ng-click="removeFile($index)">Remove</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <form id="valuationForm" name="valuationForm" ng-submit="submitForm(valuationForm.$valid)" novalidate>
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" ng-model="user.name" required>
                        <span class="error-message" ng-show="valuationForm.name.$dirty && valuationForm.name.$invalid">
                            <span ng-show="valuationForm.name.$error.required">Name is required.</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email address" ng-model="user.email" email-validation required>
                        <span class="error-message" ng-show="valuationForm.email.$dirty && valuationForm.email.$invalid">
                            <span ng-show="valuationForm.email.$error.required">Email is required.</span>
                        <span ng-show="valuationForm.email.$error.emailValidation">Invalid email address.</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label for="phone">Mobile Phone Number</label>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter your mobile phone number" ng-model="user.phone" phone-validation required>
                        <span class="error-message" ng-show="valuationForm.phone.$dirty && valuationForm.phone.$invalid">
                            <span ng-show="valuationForm.phone.$error.required">Phone number is required.</span>
                        <span ng-show="valuationForm.phone.$error.phoneValidation">Invalid phone number format. It should be 10 digits.</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label>Communication preference</label><br>
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
                        <textarea class="form-control" id="description" name="description" ng-model="user.description"></textarea>
                        <small class="form-text text-muted">Please briefly describe your jewelry and/or watches in the field above.</small>
                    </div>
                    <button type="submit" class="btn btn-primary" ng-disabled="valuationForm.$invalid">Submit Valuation Request</button>
                </form>
            </div>
        </div>
    </main>

    <!-- START OF FOOTER -->
    <footer class="bg-light text-center py-3 mt-auto">
        <div>
            <h6>Jewelry Auction</h6>
            <a href="register.jsp">Register</a> |
            <a href="login.jsp">Login</a> |
            <a href="#">Help & FAQ</a> |
            <a href="#">Support</a> |
            <a href="#">Sitemap</a>
        </div>
    </footer>

    <!-- Include jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>  
    <script>
        angular.module('valuationApp', [])
            .controller('ValuationController', ['$scope', function($scope) {
                $scope.user = {};
                $scope.files = [];

                $scope.handleFileSelect = function(element) {
                    $scope.$apply(function() {
                        for (var i = 0; i < element.files.length; i++) {
                            let file = element.files[i];
                            let reader = new FileReader();

                            reader.onload = (function(file) {
                                return function(e) {
                                    $scope.$apply(function() {
                                        $scope.files.push({
                                            name: file.name,
                                            url: e.target.result
                                        });
                                    });
                                };
                            })(file);

                            reader.readAsDataURL(file);
                        }
                    });
                };

                $scope.removeFile = function(index) {
                    $scope.files.splice(index, 1);
                };

                $scope.submitForm = function(isValid) {
                    if (isValid) {
                        // Handle form submission
                    }
                };
            }]);
    </script>

</body>
</html>
