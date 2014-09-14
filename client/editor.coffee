define [
	'jquery'
], ($) ->
	self = {}
	ego = {}

	self.init = ->
		init_editor_dom()
		show()
		init_submit()

	init_editor_dom = ->
		ego.$dom = $("""
			<div>
				<textarea cols="30" rows="10"></textarea>
				<input type="button" value='Submit'>
			</div>
		""")

		ego.$editor = ego.$dom.find 'textarea'
		ego.$submit_btn = ego.$dom.find 'input'

	init_submit = ->
		ego.$submit_btn.click ->
			data = {
				body: ego.$editor.val()
			}
			$.post '/post/add', JSON.stringify(data)

			hide()

	show = ->
		$('body').append ego.$dom
		ego.$dom.show()

	hide = ->
		ego.$dom.hide()

	self