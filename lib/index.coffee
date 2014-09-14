_ = require 'lodash'
nobone = require 'nobone'

module.exports = _.defaults {

	conf: require './conf.default'

	nobone

	post: require './post'

}, nobone({
	service: {}
	db: {
		db_path: 'noblog.db'
	}
	renderer: {}
})