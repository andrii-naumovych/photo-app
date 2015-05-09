#TODO: make building of index.html file according to deps.json file

module.exports = (grunt) ->
	gruntConf = require "./buildconfig/conf.json"

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