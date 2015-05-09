gruntConf	= require "./buildconfig/grunt_conf.json"
conf		= require "./buildconfig/conf.json"
deps		= require "./buildconfig/deps.json"

helpers		= require("./buildconfig/helpers.coffee")({
	replacer:
		placeholderTPL: conf.placeholderTPL
})

module.exports = (grunt) ->
	grunt.initConfig gruntConf

	#Default tasks

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-newer"
	grunt.loadNpmTasks "grunt-reload"
	grunt.loadNpmTasks "grunt-contrib-copy"

	grunt.registerTask "copy-templates", "Copy hbs templates", ->
		grunt.task.run "copy:templates"

	grunt.registerTask "compose:tags", "Tags composing",->

	grunt.registerTask "replace:index:deps", "Replacing index dependencies", ->
		helpers.replacer.replace
			files		: ["index.html"]
			criterion	:
				TITLE		: "Photo Application"
				STYLES		: helpers.tagComposer.composeTags deps.styles
				SCRIPTS		: helpers.tagComposer.composeTags deps.scripts

	grunt.registerTask "build:index", "Build index.html", ->
		grunt.task.run "copy:index"
		grunt.task.run "replace:index:deps"

	grunt.registerTask "build:dev", "Build frontend application", ->
		grunt.task.run "build:index"
		grunt.task.run "coffee"
		grunt.task.run "copy:templates"

	grunt.registerTask "default", "default task", ->
		console.log "hello from default task!"