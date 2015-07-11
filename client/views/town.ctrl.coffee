angular.module('civilian').controller('TownCtrl', ['$scope', '$meteor', '$state', ($scope, $meteor, $state) ->
	$scope.town = $scope.$meteorObject(Town.db, $state.params['town_id'])
	$scope.civilians = $scope.$meteorCollection -> Civilian.db.find(town_id: $state.params['town_id'])

	$scope.selectedCivilian = null
	$scope.highlightedCivilian = null

	$scope.selectCivilian = (civilian) ->
		$scope.selectedCivilian = civilian

	$scope.isCivilianSelected = (civilian) ->
		return $scope.selectedCivilian is civilian

	$scope.isCivilianHighlighted = (civilian) ->
		return $scope.highlightedCivilian is civilian

	$scope.getCivilianName = (id) ->
		civilian = Civilian.db.findOne(id)
		return civilian?.name

	$scope.highlightCivilian = (_id) ->
		civilian = _.findWhere($scope.civilians, {_id})
		$scope.highlightedCivilian = civilian

	$scope.dehighlightCivilian = ->
		$scope.highlightedCivilian = null

])
