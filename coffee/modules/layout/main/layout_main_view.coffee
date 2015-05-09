PhotoApp.module "LayoutModule.Main", (Main, App, Backbone, Marionette, $, _) ->
	class Main.RootLayout extends App.Views.LayoutView
		template: false
		el: document.body

	class Main.AppLayout extends App.Views.LayoutView
		template: "{m}/layout/main/layout_main"
		regions:
			sidebarRegion: "#sidebar"
			contentRegion: "#content"

	rootLayout = new Main.RootLayout
	rootLayout.addRegion "bodyRegion", el: document.body
	rootLayout.render()

	App.reqres.setHandler "get:rootLayout", ->
		rootLayout

	App.reqres.setHandler "get:appLayout", (options) ->
		new Main.AppLayout options