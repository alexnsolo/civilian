class @Civilian extends Base

	@db: new Mongo.Collection('civilians',
		transform: (record) -> return new Civilian(record)
	)

	constructor: (properties) ->
		@name = ''
		@town_id = null

		super(properties)
