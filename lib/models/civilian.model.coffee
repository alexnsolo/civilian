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
		@was_deported = false
		@under_arrest = false

		super(properties)

	adjustHappiness: (effect) ->
		@happiness += effect
		@happiness = Math.min(Math.max(@happiness, 0), 100)
