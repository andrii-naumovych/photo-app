PhotoApp.module "PhotoModule.Show", (Show, App, Backbone, Marionette, $, _) ->
	class Show.Controller extends App.Controllers.Application
		initialize: ->
			@photosCollection	= App.request "get:photoCollection"
			@collectionView		= @getPhotosCollectionView @photosCollection

			@listenTo @collectionView, "photo:selected", (options) =>
				{ model, state } = options
				model.set "selected", state

				selectedIds = @photosCollection.where("selected": true).map (model) -> model.get "id"
				Backbone.history.query.set "select", selectedIds, trigger: false

			@show @collectionView

		getPhotosCollectionView: (collection) ->
			@photosCollectionView = new Show.PhotoItemsCollection
				collection: collection

		selectPhotos: (selectedIds) ->
			@photosCollection.each (model) =>
				@collectionView.triggerMethod "photo:select",
					model: model
					state: false

			selectedModels = []
			selectedModels.push(@photosCollection.get(id)) for id in selectedIds

			selectedModels.forEach (selectedModel) =>
				@collectionView.triggerMethod "photo:select",
					model: selectedModel