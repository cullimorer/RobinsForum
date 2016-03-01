'use strict';

var app = angular.module('app.services');

app.service('sharedService', ['$resource', '$q', 'commonUtilities', function ($resource, $q, commonUtilities) {

    var base = 'http://localhost/API/';

    var res = $resource(base + ':url', null,
                {
                    'query': { method: 'GET', isArray: true },
                    'get': { method: 'GET' },
                    'update': { method: 'PUT' },
                    'save': { method: 'Post' },
                    'delete': { method: 'DELETE' }
                }
            );

    return {
        getListData: function (methodUrl, args) {
            var formattedUrl = commonUtilities.stringFormat(methodUrl, args);

            return res.query({
                url: formattedUrl
            }).$promise
                .then(function (data) {
                    return data;
                })
                .catch(function (reason) {
                    //commonUtilities.addAlert(reason.status + ' ' + reason.statusText + ': ' + reason.data.Message, 'danger');
                });
        },
        getData: function (methodUrl, args) {

            var formattedUrl = commonUtilities.stringFormat(methodUrl, args);

            return res.get({ url: formattedUrl }).$promise
                .then(function (data) {
                    return data;
                })
                .catch(function (reason) {
                    //commonUtilities.addAlert(reason.status + ' ' + reason.statusText + ': ' + reason.data.Message, 'danger');
                });
        },
        updateData: function (methodUrl, args, dto, msg) {

            var formattedUrl = commonUtilities.stringFormat(methodUrl, args);

            return res.update({ url: formattedUrl }, dto).$promise
                .then(function (data) {
                    return data;
                })
                .catch(function (reason) {
                    //commonUtilities.addAlert(reason.data.Message, 'danger');
                });
        },
        deleteData: function (methodUrl, args, dto, msg) {

            var formattedUrl = commonUtilities.stringFormat(methodUrl, args);

            return res.delete({ url: formattedUrl }, dto)
                .$promise
                .then(function (data) {
                    commonUtilities.addAlert(msg, 'success');
                    return data[0];
                })
                .catch(function (reason) {
                    //commonUtilities.addAlert(reason.status + ' ' + reason.statusText + ': ' + reason.data.Message, 'danger');
                });
        },
        addData: function (methodUrl, args, dto, msg) {

            var formattedUrl = commonUtilities.stringFormat(methodUrl, args);

            return res.save({ url: formattedUrl }, dto).$promise
                .then(function (data) {
                    if (msg.length > 5) {
                        commonUtilities.addAlert(msg, 'success');
                    };
                    return data;
                })
                .catch(function (reason) {
                    //commonUtilities.addAlert(reason.status + ' ' + reason.statusText + ': ' + reason.data.Message, 'danger');
                });
        }
    }
}]);