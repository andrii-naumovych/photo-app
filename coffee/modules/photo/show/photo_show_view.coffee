PhotoApp.module "PhotoModule.Show", (Show, App, Backbone, Marionette, $, _) ->
	class Show.PhotoItem extends App.Views.ItemView
		template: "{m}/photo/show/photo_item"

		ui:
			img: ".js-img"

		events:
			"click": "onToggleSelection"

		onToggleSelection: ->
			@triggerMethod "select", !@model.get "selected"

		onSelect: (state) ->
			@$el[["removeClass", "addClass"][+!!state]] "selected"

			@trigger "selected", state: state

		onShow: ->
			if @model.get "selected"
				@triggerMethod "select", true

	class Show.PhotoItemsCollection extends App.Views.CollectionView
		childView: Show.PhotoItem

		onChildviewSelected: (childView, options = {}) ->
			@trigger "photo:selected", _.extend options,
				model	: childView.model

		onPhotoSelect: (options) ->
			{ model, state } = options

			state ?= true

			photoView = @children.findByModel model
			photoView.triggerMethod "select", state