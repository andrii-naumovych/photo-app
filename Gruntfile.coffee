#TODO: make building of index.html file according to deps.json file

gruntConf	= require "./buildconfig/grunt_conf.json"
helpers		= require "./buildconfig/helpers.coffee"

module.exports = (grunt) ->
	helpers.replacer.replace ["./index_former.html"], { "STYLES": "styles_replaced","TITLE": "title_replaced" }
	grunt.initConfig gruntConf

	#Default tasks

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-newer"
	grunt.loadNpmTasks "grunt-reload"
	grunt.loadNpmTasks "grunt-contrib-copy"

	grunt.registerTask "copy-templates", "Copy hbs templates", ->
		grunt.task.run "copy:templates"

	grunt.registerTask "build", "Build frontend application", ->
		grunt.task.run "coffee"
		grunt.task.run "copy-templates"

	grunt.registerTask "default", "default task", ->
		console.log "hello from default task!"