PhotoApp.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	class Entities.OAuth extends Entities.Model
		fetch: ->
			if not @get("oauth_token") and not @get("oauth_verifier")
				@url = App.API.auth.url
			else
				@url = App.API.auth.accessToken
			super
		fetchFromLS: ->
			attrs = window.localStorage.getItem "oauth"
			@set JSON.parse attrs
			@
		saveToLS: ->
			window.localStorage.setItem "oauth", JSON.stringify @attributes
			@

	oauthModel = new Entities.OAuth

	App.reqres.setHandler "get:oauth", -> oauthModel
