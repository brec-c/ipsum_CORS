#! /usr/bin/env NODE_PATH=$NODE_PATH:. ./node_modules/coffee-script/bin/coffee

express = require 'express'
http = require 'http'
request = require 'request'

app = express()
server = http.createServer app

app.use (req, res, next) ->
	res.header('Access-Control-Allow-Origin', '*')
	res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
	res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With')

	# intercept OPTIONS method
	if 'OPTIONS' == req.method
		res.send(200)
	else
		next()

app.use express.static 'static'

app.use (req, res, next) ->
	path = req.url
	console.log "requesting http://loripsum.net#{path}"
	request("http://loripsum.net#{path}").pipe(res)

port = process.env.PORT || 5000
server.listen port, -> console.log "Listening on #{port}"
