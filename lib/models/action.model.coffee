class @Action extends Base

	@db: new Mongo.Collection('actions',
		transform: (record) -> return new Action(record)
	)

	constructor: (properties) ->
		@source_id = null
		@target_id = null
		@time = 0
		@disposition = 0
		@effectiveness = 0

		super(properties)
