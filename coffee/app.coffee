PhotoApp = new Marionette.Application

PhotoApp.on "start", ->


	root = PhotoApp.request "get:layout:root"
	main = PhotoApp.request "inst:layout:app"

	root.bodyRegion.show main

	###
	# Get current main layout, it can be main-layout, auth-layout or something else
	###
	PhotoApp.reqres.setHandler "get:layout:view", (options) ->
		main

	Backbone.history.start()