{
	kit
	service
	db
	renderer
	conf
	posts
} = require './lib'

init = ->
	init_db().then ->
		init_main()
		init_service()
	.then ->
		init_assets()
		start()
	.done()

init_db = ->
	db.loaded.then ->
		kit.log 'DB loaded.'.green

init_main = ->
	service.get '/', (req, res) ->
		renderer.render 'views/index.html'
		.done (tpl) ->
			res.send tpl({ conf })

init_service = ->
	posts()

init_assets = ->
	service.use renderer.static('client')
	service.use '/assets', renderer.static('bower_components')

start = ->
	service.listen conf.port, ->
		kit.log "App: #{conf.name} v#{conf.version}".cyan
		kit.log "Listen port: #{conf.port}".yellow

init()
