angular.module('civilian').controller('TownCtrl', ['$scope', '$meteor', '$state', ($scope, $meteor, $state) ->
	$scope.town = $scope.$meteorObject(Town.db, $state.params['town_id'])
	$scope.civilians = $scope.$meteorCollection -> Civilian.db.find(town_id: $state.params['town_id'])

	$scope.selectedCivilian = null
	$scope.highlightedCivilian = null

	$scope.dotDisplay = 'Happiness'

	$scope.processTown = ->
		$meteor.call('Town.process', $scope.town['_id'])

	$scope.getCivilianStyle = (civilian) ->
		if $scope.dotDisplay is 'Happiness'
			hue = 120 * (civilian.happiness/100)
		else if $scope.dotDisplay is 'Disposition'
			hue = 120 * (civilian.disposition/100)
			
		style = {}
		style['background-color'] = "hsl(#{hue}, 50%, 45%)"
		return style

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
