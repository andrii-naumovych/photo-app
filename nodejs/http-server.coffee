oauth = require "./oauth.coffee"
http = require "http"
dispatcher = require "httpdispatcher"
fs = require "fs"

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

	oauth.requestForAuthURL().then (authUrl) ->
		resp.end JSON.stringify authUrl: authUrl


dispatcher.onGet "/oauth-get-access", (req, resp) ->
	fs.writeFile "code.json", JSON.stringify req
	resp.writeHead 200,
		"Content-Type": "application/json"
		"Access-Control-Allow-Origin": "http://photoapp.local"

	oauth.requestForAccessToken().then (tokenData) ->
		resp.end JSON.stringify tokenData
server = http.createServer handleRequest

server.listen PORT, ->
	console.log "Server listen #{PORT} port"