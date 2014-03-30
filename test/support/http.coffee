###
`connect` or `express` http request test helper.

Source codes come from https://github.com/senchalabs/connect/blob/master/test/support/http.js.

Modified by @fengmk2
###

###
Module dependencies.
###

# need to change > 0.3.x

# not support < 0.2.0
# connect.proto.request = function(){
#   return request(this);
# };
Request = (app, address) ->
  @data = []
  @header = {}
  @app = app
  @server = app
  @addr = address or @server.address()
  return
EventEmitter = require("events").EventEmitter
methods = [
  "get"
  "post"
  "put"
  "delete"
  "head"
]
express = require("express")
connect = null
try
  connect = require("connect")
http = require("http")
querystring = require("querystring")
express.HTTPServer::request = (address) ->
  new Request(this, address)

connect.HTTPServer::request = express.HTTPServer::request  if connect and connect.HTTPServer

###
Inherit from `EventEmitter.prototype`.
###
Request::__proto__ = EventEmitter::
methods.forEach (method) ->
  Request::[method] = (path) ->
    @request method, path

  return

Request::set = (field, val) ->
  @header[field] = val
  this

Request::setBody = (body) ->
  @set "Content-Type", "application/x-www-form-urlencoded"
  @write querystring.stringify(body)
  this

Request::write = (data) ->
  @data.push data
  this

Request::request = (method, path) ->
  @method = method
  @path = path
  this

Request::expect = (body, fn) ->
  args = arguments_
  @end (res) ->
    if args.length is 3
      res.headers.should.have.property body.toLowerCase(), args[1]
      args[2]()
    else
      if "number" is typeof body
        res.statusCode.should.equal body
      else
        res.body.toString().should.equal body
      fn()
    return

  return

Request::end = (fn) ->
  self = this
  req = http.request(
    method: @method
    port: @addr.port
    host: @addr.address
    path: @path
    headers: @header
  )
  @data.forEach (chunk) ->
    req.write chunk
    return

  req.on "response", (res) ->
    chunks = []
    size = 0
    res.on "data", (chunk) ->
      chunks.push chunk
      size += chunk.length
      return

    res.on "end", ->
      buf = null
      switch chunks.length
        when 0
          buf = new Buffer(0)
        when 1
          buf = chunks[0]
        else
          buf = new Buffer(size)
          pos = 0
          i = 0
          l = chunks.length

          while i < l
            chunk = chunks[i]
            chunk.copy buf, pos
            pos += chunk.length
            i++
      res.body = buf
      res.bodyJSON = ->
        JSON.parse res.body

      res.shouldRedirect = (status, url) ->
        res.should.status status
        addr = self.app.address()
        res.headers.location.should.equal "http://" + addr.address + ":" + addr.port + url
        return

      fn res
      return

    return

  req.end()
  this
