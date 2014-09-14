require.config {
	paths: {
		'css': '/assets/require-css/css.min'

		'jquery': '/assets/jquery/dist/jquery.min'
		'editor': '/editor'
	}
}

require [
	# Styles
	'css!/style/default.css'

	'jquery'
], (nil, $) ->
	$new_post = $ '.new_post'
	$new_post.click ->
		require ['editor'], (editor) ->
			editor.init()
