PhotoApp.module "PhotoModule", (PhotoModule, App, Backbone, Marionette, $, _) ->
	class PhotoModule.Router extends Marionette.AppRouter
		appRoutes:
			"photos/show(/:query)": "showPhotos"

	collection = App.request "inst:photoCollection",
		models: [
			App.request "inst:photo", { url: "https://placekitten.com/g/70/70", id:"1", size: "100"}
			App.request "inst:photo", { url: "https://placekitten.com/g/70/70", id:"2", size: "200"}
			App.request "inst:photo", { url: "https://placekitten.com/g/70/70", id:"3", size: "300"}
			App.request "inst:photo", { url: "https://placekitten.com/g/70/70", id:"4", size: "500"}
			App.request "inst:photo", { url: "https://placekitten.com/g/70/70", id:"5", size: "600"}
		]


	API = _.extend {}, Backbone.Events,
		###
		# url query string, not as server side style,
    	# http query: /photos/show?page=3&offset=25 becomes
    	# ex. /photos/show/page:3+offset:25
		###
		_parseQueryString: (query) ->
			return {} unless query
			sp = query.split "+"
			res = {}

			sp.forEach (item) ->
				sp1 = item.split ":"
				if ~sp1[1].indexOf ","
					res[sp1[0]] = sp1[1].split ","
				else
					res[sp1[0]] = sp1[1] || true

			res

		showPhotos: (query) ->
			params = @_parseQueryString query

			collectionView = new PhotoModule.Show.PhotoItemsCollection
				collection: collection

			layout = App.request "get:layout:view"
			layout.contentRegion.show collectionView

			@listenTo collectionView, "photo:selected", (model) ->
				unless model.get "selected"
					model.set "selected", true
					selectedIds = collection.where("selected": true).map (model) -> model.get "id"
					Backbone.history.navigate "photos/show/select:" + selectedIds.sort().join()

			@listenTo collectionView, "photo:deselected", (model) ->
				if model.get "selected"
					model.set "selected", false
					selectedIds = collection.where("selected": true).map (model) -> model.get "id"
					if selectedIds.length
						Backbone.history.navigate "photos/show/select:" + selectedIds.sort().join()
					else
						Backbone.history.navigate "photos/show"

			collection.each (model) -> collectionView.triggerMethod "photo:deselect", model: model

			if params.select?
				selectedModels = []

				unless _.isArray params.select
					params.select = [params.select]

				selectedModels.push(collection.get(id)) for id in params.select

				_.log selectedModels

				selectedModels.forEach (selectedModel) ->
					collectionView.triggerMethod "photo:select", model: selectedModel




	PhotoModule.on "start", ->
		_.log "photo module started"
		new PhotoModule.Router
			controller: API