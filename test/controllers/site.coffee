#!
# * nodeclub - site controller test
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 

###
Module dependencies.
###
should = require("should")
config = require("../../config").config
app = require("../../app")
describe "controllers/site.js", ->
  before (done) ->
    app.listen 0, done
    return

  after ->
    app.close()
    return

  it "should /index 200", (done) ->
    app.request().get("/").end (res) ->
      res.should.status 200
      done()
      return

    return

  it "should /?q=neverexistskeyword 200", (done) ->
    app.request().get("/?q=neverexistskeyword").end (res) ->
      res.should.status 200
      res.body.toString().should.include "无话题"
      done()
      return

    return

  it "should /?q=neverexistskeyword&q=foo2 200", (done) ->
    app.request().get("/?q=neverexistskeyword&q=foo2").end (res) ->
      res.should.status 200
      res.body.toString().should.include "无话题"
      done()
      return

    return

  return

