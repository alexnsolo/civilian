ACTION_BASE_EFFECTIVENESS = 100

Meteor.methods
	'Action.create': (action) ->

		action['_id'] = Action.db.insert(action)

		target = Civilian.db.findOne(action['target_id'])
		effect = Math.floor((action['disposition']-50) * (action['effectiveness']/100) * (ACTION_BASE_EFFECTIVENESS/100))
		target['happiness'] += effect
		target['happiness'] = Math.min(Math.max(target['happiness'], 0), 100)

		target_updates = _.pick(target, ['happiness'])
		Civilian.db.update(target['_id'], {$set: target_updates})

		return action['_id']
