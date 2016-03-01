'use strict';

var app = angular.module('app.services');

app.service("forumService", ['$http', '$q', 'sharedService', function ($http, $q, sharedService) {

    // Return public API.
    return ({
        getPosts: function (threadId) {
            return sharedService.getListData('threads/{0}/posts', [threadId]);
        },
        addPost: function (threadId, data) {
            return sharedService.addData('threads/{0}/posts', [threadId], data, 'Thread added!');
        },
        getThreads: function () {
            return sharedService.getListData('threads', null);
        },
        addThread: function (data) {
            return sharedService.addData('threads', null, data, 'Thread added!');
        },
        getCategories: function () {
            return sharedService.getListData('categories', null);
        }
    });
}]);