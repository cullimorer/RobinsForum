var app = angular.module('app.controllers');

app.controller('LoginCtrl', ['$scope', '$location', '$window', 'loginService', 'ezfb', "$rootScope", function ($scope, $location, $window, loginService, ezfb, $rootScope) {
    $scope.$root.title = 'Robin\'s Forum | Sign In';

    $scope.loginFacebook = function () { loginService.loginFacebook() };
}]);