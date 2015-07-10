class @Town extends Base

	@db: new Mongo.Collection('towns',
		transform: (record) -> return new Town(record)
	)

	@generateName: ->
		part_one = _.sample([
			'Jason'
			'Nick'
			'Rick'
			'Josh'
			'Mitch'
			'Greg'
			'Jake'
			'Lyzzi'
		])
		part_two = _.sample([
			'ville'
			'town'
		])
		return "#{part_one}#{part_two}"


	constructor: (properties) ->
		@name = ''

		super(properties)
