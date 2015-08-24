'use strict'

###*
 # @ngdoc overview
 # @name tagatrekApp
 # @description
 # # tagatrekApp
 #
 # Main module of the application.
###
angular
  .module 'tagatrekApp', [
    'ngAnimate',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap-slider',
    'ui.bootstrap'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .otherwise
        redirectTo: '/'

