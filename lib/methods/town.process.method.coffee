ANY_ACTION_CHANCE = 20
BAD_DISPOSITION_TRIGGER = 20
GOOD_DISPOSITION_TRIGGER = 60

Meteor.methods
	'Town.process': (town_id) ->

		# Increment time
		town = Town.db.findOne(town_id)
		town['time']++

		updates = _.pick(town, ['time'])
		Town.db.update(town['_id'], {$set: updates})

		# Make people take actions
		civilians = Civilian.db.find(town_id: town['_id']).fetch()

		for civilian in civilians
			relationship = _.sample(civilian['relationships'])
			take_any_action = _.random(0, 100) < ANY_ACTION_CHANCE
			take_bad_action = civilian['disposition'] <= BAD_DISPOSITION_TRIGGER
			take_good_action = civilian['disposition'] >= GOOD_DISPOSITION_TRIGGER

			if relationship and take_any_action and (take_bad_action or take_good_action)
				if civilian['disposition'] > 50
					description = _.sample(_.filter(ActionDescriptions, disposition: 'good'))
				else
					description = _.sample(_.filter(ActionDescriptions, disposition: 'bad'))

				action = {
					'source_id': civilian['_id']
					'target_id': relationship['other_id']
					'time': town['time']
					'description_id': description['id']
					'disposition': civilian['disposition']
					'effectiveness': relationship['influence']
				}

				Meteor.call('Action.create', action)

		return @
