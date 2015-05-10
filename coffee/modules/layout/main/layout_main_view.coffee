PhotoApp.module "LayoutModule.Main", (Main, App, Backbone, Marionette, $, _) ->
	class Main.RootLayout extends App.Views.LayoutView
		template: false
		el: document.body

	class Main.AppLayout extends App.Views.LayoutView
		template: "{m}/layout/main/layout_main"
		containerRegionClass: "main-layout"
		regions:
			headerRegion	: "#header"
			sidebarRegion	: "#sidebar"
			contentRegion	: "#content"

	rootLayout = new Main.RootLayout
	rootLayout.addRegion "bodyRegion", el: document.body
	do rootLayout.render

	App.reqres.setHandler "get:layout:root", ->
		rootLayout

	App.reqres.setHandler "get:layout:app", (options) ->
		new Main.AppLayout options