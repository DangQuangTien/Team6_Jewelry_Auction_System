var app = angular.module('valuationApp', []);
app.controller('validateCtrl', function ($scope, $http) {
    $scope.user = {};
    $scope.files = [];

    $scope.submitForm = function (isValid) {
        if (isValid) {
            var formData = new FormData();

            // Append user details to formData
            formData.append('name', $scope.user.name);
            formData.append('email', $scope.user.email);
            formData.append('phone', $scope.user.phone);
            formData.append('communication', $scope.user.communication);
            formData.append('description', $scope.user.description);

            // Append files to formData
            for (var i = 0; i < $scope.files.length; i++) {
                formData.append('files', $scope.files[i]);
            }

            // Send data to the servlet
            $http.post('${pageContext.request.contextPath}/ValuationRequestServlet', formData, {
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            }).then(function (response) {
                // Handle success response
                console.log('Success:', response.data);
                alert('Form submitted successfully!');

                // Clear form data
                $scope.user = {};
                $scope.files = [];
                $scope.valuationForm.$setPristine();
                $scope.valuationForm.$setUntouched();
            }, function (error) {
                // Handle error response
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
        element.value = ''; // Clear the input value to allow selecting the same file again
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