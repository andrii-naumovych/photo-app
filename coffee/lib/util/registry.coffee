PhotoApp.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

	API =
		register: (instance, id) ->
			App._registry ?= {}
			App._registry[id] = instance

			_.log "Controller registered ", id

		unregister: (id) ->
			delete App._registry[id]

		resetRegistry: ->
			oldCount = @getRegistrySize()

			for key, controller of App._registry
				do controller.region.reset
				@unregister key

			return {
				count	: @getRegistrySize()
				previous: oldCount
				msg		: "There were #{oldCount} controllers in the registry, there are now #{@getRegistrySize()}"
			}

		getRegistrySize: ->
			_.size(App._registry)

	App.commands.setHandler "register:instance", (instance, id) ->
		API.register instance, id

	App.commands.setHandler "unregister:instance", (id) ->
		API.unregister id

	App.reqres.setHandler "reset:registry", ->
		_.info API.resetRegistry()