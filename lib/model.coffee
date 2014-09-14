
{ kit, service, db } = require './'
{ _ } = kit

self = {}

self.create_list = (mod_name) ->

	init_service_add = ->
		service.post "/#{mod_name}/add", (req, res) ->
			data = ''

			req.on 'data', (buf) ->
				data += buf

			req.on 'end', ->
				try
					data = JSON.parse data
				catch
					res.status(500).end()
					return

				db.exec { data, mod_name }, (jdb, { data, mod_name }) ->
					jdb.doc[mod_name][jdb.doc[mod_name + '_id_ptr']++] = data
					jdb.save()
				.done ->
					res.status(200).end()

	init_service_put = ->
		service.post "/#{mod_name}/put/:id", (req, res) ->
			data = ''

			req.on 'data', (buf) ->
				data += buf

			req.on 'end', ->
				try
					data = JSON.parse data
				catch
					res.status(500).end()
					return

				db.exec { mod_name, data, id: req.params.id }, (jdb, { mod_name, data, id }) ->
					jdb.doc[mod_name][id] = data
					jdb.save()
				.done ->
					res.status(200).end()

	init_service_get = ->
		service.get "/#{mod_name}/get/:id", (req, res) ->
			db.exec (jdb) ->
				jdb.send(
					jdb.doc[mod_name][req.params.id]
				)
			.done (item) ->
				res.send JSON.stringify(item)

	init_service_del = ->
		service.get "/#{mod_name}/del/:id", (req, res) ->
			db.exec { mod_name, id: req.params.id }, (jdb, { mod_name, id }) ->
				delete jdb.doc[mod_name][id]
				jdb.save()
			.done ->
				res.status(200).end()

	init_service_list = ->
		service.get "/#{mod_name}/list/:start/:limit", (req, res) ->
			limit = +req.params.limit
			start = +req.params.start
			end = start + limit

			db.exec req.params, (jdb) ->
				list = {}
				i = 1
				for k, v of jdb.doc[mod_name]
					if start < i++ < end
						list[k] = v
				jdb.send { list, all: i - 1 }
			.done (data) ->
				res.send data

	db.exec mod_name, (jdb, mod_name) ->
		jdb.doc[mod_name] ?= {}
		jdb.doc[mod_name + '_id_ptr'] ?= 0
		jdb.save()
	.then ->
		init_service_add()
		init_service_put()
		init_service_get()
		init_service_del()
		init_service_list()
	.then ->
		kit.log "Model loaded: ".cyan + mod_name

module.exports = self
