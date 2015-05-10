PhotoApp.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	###
	# Main Photo item entity
	###
	class Entities.Photo extends App.Entities.Model
		defaults:
			name: ""
			url: ""
			size: ""

	###
	# Collection of photos
	###
	class Entities.PhotoCollection extends App.Entities.Collection
		model: Entities.Photo

	App.reqres.setHandler "inst:photoCollection", (options = {}) ->
		{ models } = options

		models = models || []

		new Entities.PhotoCollection models

	App.reqres.setHandler "inst:photo", (options = {}) ->
		new Entities.Photo options