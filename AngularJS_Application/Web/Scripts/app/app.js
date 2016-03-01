(function (window, angular, undefined) {
    'use strict';

    angular.module('app.filters', []);
    angular.module('app.services', []);
    angular.module('app.directives', []);
    angular.module('app.controllers', []);

    angular.module('app', ['ui.router', 'app.filters', 'app.services', 'app.directives', 'app.controllers', 'ezfb', 'hljs', 'ngResource', 'ui.bootstrap'])

        // Gets executed during the provider registrations and configuration phase. Only providers and constants can be
        // injected here. This is to prevent accidental instantiation of services before they have been fully configured.
        .config(['$stateProvider', '$locationProvider', 'ezfbProvider', function ($stateProvider, $locationProvider, ezfbProvider) {

            // UI States, URL Routing & Mapping. For more info see: https://github.com/angular-ui/ui-router
            // ------------------------------------------------------------------------------------------------------------

            $stateProvider
                .state('Forum', {
                    url: '/',
                    templateUrl: 'scripts/app/Forum/views/forum.html',
                    controller: 'ForumCtrl'

                })
                .state('login', {
                    url: '/login',
                    templateUrl: 'scripts/app/Login/views/login.html',
                    controller: 'LoginCtrl',
                })
                .state('otherwise', {
                    url: '*path',
                    templateUrl: 'scripts/app/Shared/views/404.html',
                    controller: 'Error404Ctrl'
                });

            $locationProvider.html5Mode(true);

            ezfbProvider.setInitParams({
                appId: '1616557875249814'
            });

        }])
        .run(function ($rootScope, $state, ezfb, loginService) {

            // register listener to watch route changes
            $rootScope.$on("$stateChangeStart", function (event, next, current) {

                var isLogin = next.name === "login";
                if (isLogin) {
                    $rootScope.loggedIn = false;
                    return; // no need to redirect 
                }

                loginService.setLoginStatus();
            });
            
            $rootScope.loginFacebook = function () { loginService.loginFacebook() };

            $rootScope.logoutFacebook = function () {
                ezfb.logout(function () {
                    $state.go('login');
                });
            };

            $rootScope.updateApiMe = function () {
                return ezfb.api('/me?fields=name,email', function (res) {
                    $rootScope.apiMe = res;
                });
            }
        });

})(window, angular);