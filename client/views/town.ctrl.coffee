angular.module('civilian').controller('TownCtrl', ['$scope', '$meteor', '$state', ($scope, $meteor, $state) ->
	$scope.town = Town.db.findOne(_id: $state.params['town_id'])
	$scope.civilians = $scope.$meteorCollection -> Civilian.db.find(town_id: $state.params['town_id'])
])
