Meteor.methods
	'Town.create': ->

		town = {}
		town['name'] = Town.generateName()
		town['_id'] = Town.db.insert(town)

		for x in [0..100]
			civilian = new Civilian()

			if _.sample([true, false])
				civilian['name'] = _.sample(PersonNames.male)
			else
				civilian['name'] = _.sample(PersonNames.female)

			civilian['town_id'] = town['_id']
			civilian['_id'] = Civilian.db.insert(civilian)


		return town
