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

	collection = new Entities.PhotoCollection [
			{ url: "https://placekitten.com/g/70/70", id:"1", size: "100"}
			{ url: "https://placekitten.com/g/70/70", id:"2", size: "200"}
			{ url: "https://placekitten.com/g/70/70", id:"3", size: "300"}
			{ url: "https://placekitten.com/g/70/70", id:"4", size: "500"}
			{ url: "https://placekitten.com/g/70/70", id:"5", size: "600"}
		]

	App.reqres.setHandler "get:photoCollection", ->
		collection

	App.reqres.setHandler "inst:photoCollection", (options = {}) ->
		{ models } = options

		models = models || []

		new Entities.PhotoCollection models

	App.reqres.setHandler "inst:photo", (options = {}) ->
		new Entities.Photo options