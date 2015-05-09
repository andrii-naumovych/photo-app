module.exports = (config) ->
	replacer	: require("./helpers/replacer.coffee")(config.replacer || {})
	tagComposer	: require("./helpers/tag_composer.coffee")