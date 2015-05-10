PhotoApp.module "AuthModule.Signin", (Signin, App, Backbone, Marionette, $, _) ->
	class Signin.Layout extends App.Views.LayoutView
		template: "{m}/auth/signin/signin_layout"

		containerRegionClass: "auth-layout"

	App.reqres.setHandler "get:auth:signin:layout", (options = {}) ->
		new Signin.Layout options