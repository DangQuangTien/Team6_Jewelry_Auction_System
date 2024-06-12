var app = angular.module('valuationApp', []);

        app.controller('validateCtrl', function($scope) {
            $scope.user = {};
            $scope.files = [];
            $scope.loading = false;

            $scope.submitForm = function(isValid) {
                if (isValid) {
                    $scope.loading = true;
                    // Simulate an HTTP request
                    setTimeout(function() {
                        alert('Form submitted successfully!');
                        $scope.loading = false;
                        $scope.$apply();
                    }, 2000);
                }
            };

            $scope.handleFileSelect = function(element) {
                $scope.$apply(function($scope) {
                    $scope.files = [];
                    for (var i = 0; i < element.files.length; i++) {
                        $scope.files.push(element.files[i]);
                    }
                });
            };

            $scope.removeFile = function(index) {
                $scope.files.splice(index, 1);
            };
        });

        app.directive('emailValidation', function() {
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
            return {
                require: 'ngModel',
                link: function(scope, elem, attrs, ctrl) {
                    ctrl.$validators.emailValidation = function(modelValue, viewValue) {
                        if (ctrl.$isEmpty(modelValue)) {
                            return true;
                        }
                        return emailRegex.test(viewValue);
                    };
                }
            };
        });

        app.directive('phoneValidation', function() {
            var phoneRegex = /^\d{10}$/;
            return {
                require: 'ngModel',
                link: function(scope, elem, attrs, ctrl) {
                    ctrl.$validators.phoneValidation = function(modelValue, viewValue) {
                        if (ctrl.$isEmpty(modelValue)) {
                            return true;
                        }
                        return phoneRegex.test(viewValue);
                    };
                }
            };
        });