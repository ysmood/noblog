require.config {
	paths: {
		'css': '/assets/require-css/css.min'

		'lodash': '/assets/lodash/dist/lodash.min'
		'jquery': '/assets/jquery/dist/jquery.min'
		'editor': '/editor'
	}
}

require [
	# Styles
	'css!/style/default.css'

	'lodash'
	'jquery'
], (nil, _, $) ->
	$new_post = $ '.new_post'
	$new_post.click ->
		require ['editor'], (editor) ->
			editor.init()

	$.get '/posts/list/0/10'
	.done (data) ->
		_.map data.list, (post, id) ->
			$post = $("""
				<div>
					<hr>
					<h4>id - #{id}</h4>
					<div>#{post.body}</div>
				</div>
			""")

			$btn_del = $("<button>delete</button>").click ->
				$.get "/posts/del/#{id}"
				$post.remove()
			$post.append $btn_del

			$('#main').append $post

