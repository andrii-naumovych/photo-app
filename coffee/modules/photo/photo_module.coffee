PhotoApp.module "PhotoModule", (PhotoModule, App, Backbone, Marionette, $, _) ->
	_controller = null

	controllers =
		show : PhotoModule.Show.Controller

	API =
		showPhotos: ->
			_.log "show photos"

			_controller = _controller instanceof controllers.show || new controllers.show

		selectPhotos: (params, changed) ->
			_.log "select photos"
			selectIds = [].concat params.select

			_controller.selectPhotos selectIds

	class PhotoModule.Router extends Marionette.AppRouter
		appRoutes:
			"photos/show": "showPhotos"

		queryRoutes:
			"select": "selectPhotos"

	PhotoModule.on "start", ->
		_.log "Photo Module start"
		new PhotoModule.Router
			controller: API