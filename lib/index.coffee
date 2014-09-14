_ = require 'lodash'
nobone = require 'nobone'

module.exports = _.defaults {

	conf: require './conf.default'

	nobone

	posts: require './posts'

}, nobone({
	service: {}
	db: {
		db_path: 'noblog.db'
	}
	renderer: {}
})