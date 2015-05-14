oauth = require "./oauth.coffee"
http = require "http"
dispatcher = require "httpdispatcher"
fs = require "fs"
util = require "util"

PORT = 8080

handleRequest = (req, resp) ->
	try
		dispatcher.dispatch req, resp
	catch ex
		console.log ex

dispatcher.onGet "/oauth-url", (req, resp) ->
	resp.writeHead 200,
		"Content-Type": "application/json"
		"Access-Control-Allow-Origin": "http://photoapp.local"

	oauth.requestForAuthURL().then (data) ->
		resp.end JSON.stringify data


dispatcher.onGet "/oauth-get-access", (req, resp) ->
	resp.writeHead 200,
		"Content-Type": "application/json"
		"Access-Control-Allow-Origin": "http://photoapp.local"

	oauth.requestForAccessToken(req.params).then (tokenData) ->
		resp.end JSON.stringify tokenData
server = http.createServer handleRequest

server.listen PORT, ->
	console.log "Server listen #{PORT} port"