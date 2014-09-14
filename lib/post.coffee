
module.exports = ->
	{ kit, service, db } = require './'

	service.post '/posts/add', (req, res) ->
		data = ''

		req.on 'data', (buf) ->
			data += buf

		req.on 'end', ->
			try
				data = JSON.parse data
			catch
				res.status(500).end()
				return

			db.exec data, (jdb, data) ->
				jdb.doc.posts.push data
				jdb.save()
			.done ->
				res.status(200).end()
