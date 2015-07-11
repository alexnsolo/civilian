STARTING_TOWN_POPULATION = 100
MIN_STARTING_HAPPINESS = 20
MAX_STARTING_HAPPINESS = 80
MIN_STARTING_DISPOSITION = 20
MAX_STARTING_DISPOSITION = 80
MAX_RELATIONSHIPS = 7
MIN_INFLUENCE = 20
MAX_INFLUENCE = 80

Meteor.methods
	'Town.create': ->

		# Generate town
		town = {}
		town['name'] = Town.generateName()
		town['_id'] = Town.db.insert(town)

		# Generate civilians
		civilians = []
		_.times STARTING_TOWN_POPULATION, ->
			civilian = new Civilian()

			while _.contains(_.pluck(civilians, 'name'), civilian['name'])
				if _.sample([true, false])
					civilian['name'] = _.sample(PersonNames.male)
				else
					civilian['name'] = _.sample(PersonNames.female)

			civilian['happiness'] = _.random(MIN_STARTING_HAPPINESS, MAX_STARTING_HAPPINESS)
			civilian['disposition'] = _.random(MIN_STARTING_DISPOSITION, MAX_STARTING_DISPOSITION)
			civilian['town_id'] = town['_id']
			civilian['_id'] = Civilian.db.insert(civilian)

			civilians.push(civilian)

		# Generate relationships
		for civilian in civilians
			others = []
			num_relationships = _.random(0, MAX_RELATIONSHIPS)
			_.times num_relationships, ->
				target = null
				while target is null
					target = _.sample(civilians)
					target = null if target is civilian
					target = null if _.contains(others, target)

				others.push(target)

			for other in others
				relationship = {
					'other_id': other['_id']
					'influence': _.random(MIN_INFLUENCE, MAX_INFLUENCE)
				}
				civilian['relationships'].push(relationship)

			Civilian.db.update(civilian['_id'], ($set: {'relationships': civilian['relationships']}))

		return town
