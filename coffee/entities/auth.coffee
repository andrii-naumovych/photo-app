PhotoApp.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	class Entities.OAuth extends Entities.Model
		url: "http://localhost:8080/oauth-get-access"

	oauthModel = new Entities.OAuth

	App.reqres.setHandler "get:oauth", -> oauthModel
