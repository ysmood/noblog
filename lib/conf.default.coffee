_ = require 'lodash'
app_info = require '../package'

conf = _.defaults {

	port: 8293

	blog_title: 'noblog'

}, app_info

_.defaults require('../conf'), conf

module.exports = conf
