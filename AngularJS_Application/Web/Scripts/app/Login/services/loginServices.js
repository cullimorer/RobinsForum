'use strict';

// Demonstrate how to register services
// In this case it is a simple value service.
var app = angular.module('app.services');

app.service("loginService", ['sharedService', 'ezfb', '$rootScope', '$state', function (sharedService, ezfb, $rootScope, $state) {

    var addOauthFacebookUser = function (data) {
        data.OauthProviderId = 2;
        data.OauthId = data.id;
        data.Username = data.name;

        sharedService.addData('OauthUsers', null, data, 'Facebook account added!');
    };

    var getOauthUserByOauthId = function (id) {
        return sharedService.getData('OauthUsers/{0}', [id], null);
    };

    // Return public API.
    return ({
        setLoginStatus: function () {
            ezfb.getLoginStatus(function (res) {
                $rootScope.loggedIn = false;

                if (res.status != 'connected') {
                    event.preventDefault(); // stop current execution
                    $rootScope.loggedIn = false;
                    $rootScope.authenticatedUser = {};
                    $state.go('login'); // go to login
                } else {
                    $rootScope.loggedIn = true;
                    getOauthUserByOauthId(res.authResponse.userID).then(function (data) {
                        $rootScope.authenticatedUser = data;
                    });
                }
            });
        },
        loginFacebook: function () {
            ezfb.login(function (res) { }, { scope: 'email,user_likes,user_status' })
                .then(function (res) {
                    if (res.status == "connected") {
                        $rootScope.updateApiMe()
                        .then(function (apiRes) {
                            addOauthFacebookUser(apiRes);
                            $rootScope.loggedIn = true;
                            $state.go('Forum');

                            getOauthUserByOauthId(res.authResponse.userID).then(function (data) {
                                $rootScope.authenticatedUser = data;
                            });
                        });
                    }
                });
        }
    });
}]);