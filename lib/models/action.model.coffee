class @Action extends Base

	@db: new Mongo.Collection('actions',
		transform: (record) -> return new Action(record)
	)

	constructor: (properties) ->
		@source_id = null
		@target_id = null
		@time = 0
		@description_id = null
		@disposition = 0
		@effectiveness = 0

		super(properties)

	calculateEffect: ->
		return Math.floor((@disposition-50) * (@effectiveness/100))
