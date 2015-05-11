PhotoApp.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
	class Controllers.Application extends Marionette.Controller
		constructor: (options = {}) ->
			@region = options.region or App.request("get:layout:view").contentRegion
			super options

			@_instance_id = _.uniqueId "controller"

			App.execute "register:instance", @, @_instance_id

		onBeforeDestroy: ->
			_.log "destroying", @
			App.execute "unregister:instance", @_instance_id

		show: (view, options = {}) ->
			_.defaults options,
				region	: @region
				loading	: false

			## allow us to pass in a controller instance instead of a view
			## if controller instance, set view to the mainView of the controller
			view = if view.getMainView then view.getMainView() else view

			throw new Error("getMainView() did not return a view instance or #{view?.constructor?.name} is not a view instance") if not view

			@setMainView view
			@_manageView view, options

		setMainView: (view) ->
			return if @_mainView

			@_mainView = view

			@listenTo view, "destroy", @destroy

		getMainView: ->
			@_mainView

		_manageView: (view, options) ->
			if options.loading
				## show the loading view
				App.execute "show:loading", view, options
			else
				options.region.show view