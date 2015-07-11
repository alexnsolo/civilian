angular.module('civilian').controller('TownsCtrl', ['$scope', '$meteor', '$state', ($scope, $meteor, $state) ->
	$scope.towns = $scope.$meteorCollection -> Town.db.find()

	$scope.createTown = ->
		name = Town.generateName()
		$meteor.call('Town.create', name)

	$scope.gotoTown = (town) ->
		$state.go('town', town_id: town['_id'])


])
