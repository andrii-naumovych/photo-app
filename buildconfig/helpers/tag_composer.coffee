_private =
	replaceAll: (arr, tpl, placeholder) ->
		arr.map (item)->
			#TODO: take an ability to replace coffee to js in configuration
			item = item.replace(/^coffee/, "js").replace /\.coffee$/, ".js"
			return tpl.replace new RegExp(placeholder), item
API =
	composeTags: (config) ->
		result = []

		if Array.isArray config.files
			result = _private.replaceAll config.files, config.tpl, "SRC"
		else
			for i of config.files
				continue unless config.files.hasOwnProperty i
				result = result.concat _private.replaceAll config.files[i], config.tpl, "SRC"

		result.join "\n\t"

module.exports = API