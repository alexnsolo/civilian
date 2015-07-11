angular.module('civilian').controller('TownCtrl', ['$scope', '$meteor', '$state', '$timeout', ($scope, $meteor, $state, $timeout) ->
	$scope.town = $scope.$meteorObject(Town.db, $state.params['town_id'])
	$scope.civilians = $scope.$meteorCollection -> Civilian.db.find(town_id: $state.params['town_id'])

	$scope.selectedCivilian = null
	$scope.highlightedCivilian = null
	$scope.selectedHistory = []

	$scope.dotDisplay = 'Happiness'

	$timeout ->
		jsPlumb.ready ->
			$scope.canvas = jsPlumb.getInstance(
				Container: "canvas"
				Connector: "StateMachine",
				PaintStyle: { lineWidth: 3, strokeStyle: "rgb(78, 78, 78)" },
				Endpoint: [ "Dot", { radius: 5 } ],
				EndpointStyle: { fillStyle: "rgb(78, 78, 78)" },
			)

	# $interval( ->
	# 	$scope.processTown()
	# , 100)

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
		$scope.selectedHistory = Action.db.find({$or: [{target_id: civilian['_id']}, {source_id: civilian['_id']}]}, {sort: {'time': -1}}).fetch()

		$scope.canvas.detachEveryConnection()
		influencee_ids = _.pluck(civilian['relationships'], 'other_id')
		for id in influencee_ids
			target = document.getElementById(id)
			source = document.getElementById(civilian['_id'])
			anchors = [
				["Perimeter", { shape: 'Circle'}]
				["Perimeter", { shape: 'Circle'}]
			]
			$scope.canvas.connect({target, source, anchors})

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

	$scope.highlightActionCivilian = (action) ->
		if action['target_id'] is $scope.selectedCivilian['_id']
			_id = action['source_id']
		else if action['source_id'] is $scope.selectedCivilian['_id']
			_id = action['target_id']

		civilian = _.findWhere($scope.civilians, {_id})
		$scope.highlightedCivilian = civilian

	$scope.dehighlightCivilian = ->
		$scope.highlightedCivilian = null

	$scope.getActionDescription = (action) ->
		description = _.findWhere(ActionDescriptions, id: action['description_id'])
		if action['source_id'] is $scope.selectedCivilian['_id']
			template = {
				source: $scope.selectedCivilian.name
				target: Civilian.db.findOne(action['target_id']).name
			}
			compile =  _.template(description['source_description'])
			return compile(template)
		else if action['target_id'] is $scope.selectedCivilian['_id']
			template = {
				source: Civilian.db.findOne(action['source_id']).name
				target: $scope.selectedCivilian.name
			}
			compile =  _.template(description['target_description'])
			return compile(template)

	$scope.civilianIsTarget = (action) ->
		return action['target_id'] is $scope.selectedCivilian['_id']

])
