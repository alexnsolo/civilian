angular.module('civilian').controller('TownsCtrl', ['$scope', '$meteor', '$state', ($scope, $meteor, $state) ->
	$scope.towns = $scope.$meteorCollection -> Town.db.find()

	$scope.createTown = ->
		$meteor.call('Town.create')

	$scope.gotoTown = (town) ->
		$state.go('town', town_id: town['_id'])


])
