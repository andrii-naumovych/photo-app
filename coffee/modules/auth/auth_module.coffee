PhotoApp.module "AuthModule", (AuthModule, App, Backbone, Marionette, $, _) ->
	class AuthModule.Router extends Marionette.AppRouter
		appRoutes:
			"authenticate"	: "authenticate"
			"oauth"			: "oauth"
		queryRoutes:
			"oauth_token, oauth_verifier": "oauthCallback"
	API =
		oauth: ->
		authenticate: ->
			oauthModel = App.request "get:oauth"
			oauthModel.fetch().then (data) ->
				oauthModel.saveToLS()
				window.location = data.url

		oauthCallback: (allParams, changedParams) ->
			{ oauth_token, oauth_verifier } = allParams

			oauthModel = App.request "get:oauth"
			oauthModel.fetchFromLS()
			oauthModel.set
				oauth_token		: oauth_token
				oauth_verifier	: oauth_verifier

			oauthModel.fetch(data: $.param(oauthModel.attributes)).then ->
				oauthModel.saveToLS()
				Backbone.history.query.clear({trigger: false})



	AuthModule.on "start", ->
		_.log "Auth module start"
		new AuthModule.Router
			controller: API