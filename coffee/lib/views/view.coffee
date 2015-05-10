PhotoApp.module "Views", (Views, App, Backbone, Marionette, $, _) ->
	_.extend Marionette.View::,
		onShow: (view, region) ->
			#toggle region class if needed
			if @containerRegionClass?
				@containerRegion = region
				@containerRegion.$el.addClass @containerRegionClass

		onDestroy: ->
			if @containerRegionClass? and @containerRegion?
				@containerRegion.$el.removeClass @containerRegionClass
				@containerRegion = null