PhotoApp.module "PhotoModule.Show", (Show, App, Backbone, Marionette, $, _) ->
	class Show.PhotoItem extends App.Views.ItemView
		template: "{m}/photo/show/photo_item"

		ui:
			img: ".js-img"

		events:
			"click": "onToggleSelection"

		onToggleSelection: ->
			if @model.get "selected"
				@triggerMethod "deselect"
			else
				@triggerMethod "select"

		onSelect: ->
			@$el.addClass "selected"

			@trigger "selected"
		onDeselect: ->
			@$el.removeClass "selected"

			@trigger "deselected"

		onShow: ->
			if @model.get "selected"
				@triggerMethod "select"

	class Show.PhotoItemsCollection extends App.Views.CollectionView
		childView: Show.PhotoItem

		onChildviewSelected: (childView) ->
			@trigger "photo:selected", childView.model
		onChildviewDeselected: (childView) ->
			@trigger "photo:deselected", childView.model

		onPhotoSelect: (options) ->
			{ model } = options

			photoView = @children.findByModel model
			photoView.triggerMethod "select"

		onPhotoDeselect: (options) ->
			{ model } = options

			photoView = @children.findByModel model
			photoView.triggerMethod "deselect"