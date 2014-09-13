class Noblog then constructor: ->
	self = @

	init = ->
		document.querySelector 'h1'
		.classList.add 'noblog'

	init()

noblog = new Noblog
