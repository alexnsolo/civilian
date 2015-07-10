class @Base
	constructor: (properties) ->
		return unless _.isObject(properties)
		@_id = properties['_id'] if properties['_id']
		_.assign(@, _.pick(properties, _.keys(@)))
	#END constructor
#END class
