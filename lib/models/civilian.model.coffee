class @Civilian extends Base

	@db: new Mongo.Collection('civilians',
		transform: (record) -> return new Civilian(record)
	)

	constructor: (properties) ->
		@name = ''
		@happiness = 0
		@disposition = 0
		@relationships = []
		@history = []
		@town_id = null

		super(properties)
