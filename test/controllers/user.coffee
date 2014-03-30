#!
# * nodeclub - user controller test
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 

###
Module dependencies.
###
should = require("should")
app = require("../../app")
describe "controllers/user.js", ->
  before (done) ->
    app.listen 0, done
    return

  after ->
    app.close()
    return

  it "/user/testuser1 should 200", (done) ->
    app.request().get("/user/testuser1").end (res) ->
      res.should.status 200
      done()
      return

    return

  it "/stars should 200", (done) ->
    app.request().get("/stars").end (res) ->
      res.should.status 200
      done()
      return

    return

  it "/users/top100 should 200", (done) ->
    app.request().get("/users/top100").end (res) ->
      res.should.status 200
      done()
      return

    return

  it "/setting should 302 when not login", (done) ->
    app.request().get("/setting").end (res) ->
      res.should.status 302
      done()
      return

    return

  return

