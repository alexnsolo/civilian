angular.module('civilian').config(['$urlRouterProvider', '$stateProvider', '$locationProvider', ($urlRouterProvider, $stateProvider, $locationProvider) ->

	$locationProvider.html5Mode(true)
	$urlRouterProvider.otherwise('/towns')

	$stateProvider

		.state 'towns',
			url: '/towns'
			controller: 'TownsCtrl'
			templateUrl: 'client/views/towns.template.html'

		.state 'town',
			url: '/town/:town_id'
			controller: 'TownCtrl'
			templateUrl: 'client/views/town.template.html'

])
