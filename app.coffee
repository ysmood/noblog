{
	kit
	service
	db
	renderer
	conf
	post
} = require './lib'

init = ->
	init_db()
	init_main()
	init_service()
	init_assets()
	start()

init_db = ->
	db.loaded.then ->
		db.exec (jdb) ->
			jdb.doc.posts ?= []
			jdb.save()
	.done ->
		kit.log 'DB loaded.'.green

init_main = ->
	service.get '/', (req, res) ->
		renderer.render 'views/index.html'
		.done (tpl) ->
			res.send tpl({ conf })

init_service = ->
	post()

init_assets = ->
	service.use renderer.static('client')
	service.use '/assets', renderer.static('bower_components')

start = ->
	service.listen conf.port, ->
		kit.log "App: #{conf.name} v#{conf.version}".cyan
		kit.log "Listen port: #{conf.port}".yellow

init()
