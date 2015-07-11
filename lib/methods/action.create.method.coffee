Meteor.methods
	'Action.create': (parameters) ->

		action = new Action(parameters)
		action['_id'] = Action.db.insert(action)

		effect = action.calculateEffect()

		target = Civilian.db.findOne(action['target_id'])
		target.adjustHappiness(effect)

		target_updates = _.pick(target, ['happiness'])
		Civilian.db.update(target['_id'], {$set: target_updates})

		return action['_id']
