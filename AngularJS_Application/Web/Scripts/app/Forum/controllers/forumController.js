var app = angular.module('app.controllers');

app.controller('ForumCtrl', ['$scope', '$rootScope', '$location', '$window', '$http', 'forumService', 'loginService',
    function ($scope, $rootScope, $location, $window, $http, forumService, loginService) {

        loginService.setLoginStatus();

        $scope.getThreads = function () {
            forumService.getThreads().then(function (data) {
                $scope.threads = data;

                $scope.getPosts(1);
            });
        };
        $scope.getThreads();

        $scope.getPosts = function (threadId) {
            $scope.currentThreadId = threadId;
            forumService.getPosts(threadId).then(function (data) {
                $scope.posts = data;
            });
        };

        $scope.getCategories = function () {
            forumService.getCategories().then(function (data) {
                $scope.categories = data;
            });
        };
        $scope.getCategories();

        $scope.createNewThread = function (newThread) {
            newThread.CreatedOn = new Date();
            newThread.CreatedBy = 'Administrator';
            newThread.IsEnabled = 1;
            forumService.addThread(newThread).then(function (data) {
                if (data != undefined) {
                    $scope.threads.push(data);
                }
            });
        };

        $scope.sendPost = function (data) {
            data.CreatedOn = new Date();
            data.CreatedBy = 'Administrator';
            data.ThreadId = $scope.currentThreadId;
            data.OauthUserId = $rootScope.authenticatedUser.Id;
            data.IsEnabled = 1;

            forumService.addPost(data.ThreadId, data).then(function (data) {
                $scope.posts.push(data);
            });
        };
    }]);