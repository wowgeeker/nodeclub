#!
# * nodeclub - onehost plugins unit tests.
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 

###
Module dependencies.
###
onehost = require("../../plugins/onehost")
express = require("express")
should = require("should")
describe "plugins/onehost.js", ->
  bindHost = "test.localhost.onehost.com"
  app = express.createServer()
  app.use onehost(host: bindHost)
  app.use (req, res) ->
    res.send req.method + " " + req.url
    return

  before (done) ->
    app.listen 0, done
    return

  after ->
    app.close()
    return

  it "should 301 redirect all `GET` to " + bindHost, (done) ->
    app.request().get("/foo/bar").end (res) ->
      res.should.status 301
      res.headers.location.should.equal "http://" + bindHost + "/foo/bar"
      done()
      return

    return

  it "should 301 when GET request 127.0.0.1:port", (done) ->
    app.request(
      address: "127.0.0.1"
      port: app.address().port
    ).get("/foo/bar").end (res) ->
      res.should.status 301
      res.headers.location.should.equal "http://" + bindHost + "/foo/bar"
      done()
      return

    return

  [
    "post"
    "put"
    "delete"
    "head"
  ].forEach (method) ->
    it "should no redirect for `" + method + "`", (done) ->
      app.request()[method]("/foo/bar").end (res) ->
        res.should.status 200
        res.headers.should.not.have.property "location"
        if method is "head"
          res.body.should.length 0
        else
          res.body.toString().should.equal method.toUpperCase() + " /foo/bar"
        done()
        return

      return

    return

  describe "exclude options", ->
    app2 = express.createServer()
    app2.use onehost(
      host: bindHost
      exclude: "127.0.0.1:58964"
    )
    app2.use (req, res) ->
      res.send req.method + " " + req.url
      return

    before (done) ->
      app2.listen 58964, done
      return

    after ->
      app2.close()
      return

    it "should 301 redirect all `GET` to " + bindHost, (done) ->
      app.request().get("/foo/bar").end (res) ->
        res.should.status 301
        res.headers.location.should.equal "http://" + bindHost + "/foo/bar"
        done()
        return

      return

    it "should 200 when request GET exclude host", (done) ->
      app2.request(
        address: "127.0.0.1"
        port: 58964
      ).get("/foo/bar").end (res) ->
        res.should.status 200
        res.body.toString().should.equal "GET /foo/bar"
        done()
        return

      return

    return

  return

