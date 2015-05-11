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

###
# Override constructor in order to set "Controller's" method on Backbone.Router object
# In order to let "queryRoutes" to work
###
_.extend Marionette.AppRouter::,
	constructor: (options) ->
		@options = options || {}

		controller = @_getController()

		Backbone.Router.apply _.extend(@, controller), arguments

		appRoutes = @getOption "appRoutes"
		@processAppRoutes controller, appRoutes
		@on "route", @_processOnRoute, @