
module.exports = ->
	{ kit, service, db } = require './'
	model = require './model'

	model.create_list 'posts'
