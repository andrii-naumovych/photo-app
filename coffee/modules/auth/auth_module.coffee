PhotoApp.module "AuthModule", (AuthModule, App, Backbone, Marionette, $, _) ->
	class AuthModule.Router extends Marionette.AppRouter
		queryRoutes:
			"oauth_token, oauth_verifier": "oauth"
	API =
		index: ->
			_.log "INDEX PAGE"
		oauth: (allParams, changedParams) ->
			{ oauth_token, oauth_verifier } = allParams

			oauthModel = App.request "get:oauth"
			oauthModel.set
				oauth_token		: oauth_token
				oauth_verifier	: oauth_verifier

			oauthModel.fetch().then ->
				_.log "Fetched", arguments



	AuthModule.on "start", ->
		_.log "Auth module start"
		new AuthModule.Router
			controller: API