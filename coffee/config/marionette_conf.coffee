#TODO: implement below stuff for prod & dev envs
_.extend Marionette.TemplateCache.prototype,
	shortcuts: PhotoApp.Config.tplShortcuts

	normalizeTemplatePath: (templateId) ->
		for i of @shortcuts
			templateId = templateId.replace new RegExp("^{#{i}}"), @shortcuts[i]

		"js/" + templateId.replace /(\w+)$/, "tpl/tpl_$1.hbs"

	loadTemplate: (templateId, options) ->
		tplPath = @normalizeTemplatePath templateId

		result = $.ajax
			url		: tplPath
			type	: "GET"
			async	: false

		result.responseText

	compileTemplate: (rawTemplate, options) ->
		return Handlebars.compile(rawTemplate);
