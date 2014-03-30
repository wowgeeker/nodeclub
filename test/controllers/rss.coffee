#!
# * nodeclub - rss controller test
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 

###
Module dependencies.
###
should = require("should")
app = require("../../app")
config = require("../../config").config
describe "controllers/rss.js", ->
  before (done) ->
    app.listen 0, done
    return

  after ->
    app.close()
    return

  describe "/rss", ->
    it "should return `application/xml` Content-Type", (done) ->
      app.request().get("/rss").end (res) ->
        res.should.status 200
        res.should.header "content-type", "application/xml"
        body = res.body.toString()
        body.indexOf("<?xml version=\"1.0\" encoding=\"utf-8\"?>").should.equal 0
        body.should.include "<rss version=\"2.0\">"
        body.should.include "<channel><title>" + config.rss.title + "</title>"
        done()
        return

      return

    describe "mock `config.rss` not set", ->
      rss = config.rss
      before ->
        config.rss = null
        return

      after ->
        config.rss = rss
        return

      it "should return waring message", (done) ->
        app.request().get("/rss").end (res) ->
          res.should.status 404
          res.body.toString().should.equal "Please set `rss` in config.js"
          done()
          return

        return

      return

    describe "mock `topic.getTopicsByQuery()` error", ->
      topic = require("../../proxy").Topic
      getTopicsByQuery = topic.getTopicsByQuery
      before ->
        topic.getTopicsByQuery = ->
          callback = arguments_[arguments_.length - 1]
          process.nextTick ->
            callback new Error("mock getTopicsByQuery() error")
            return

          return

        return

      after ->
        topic.getTopicsByQuery = getTopicsByQuery
        return

      it "should return error", (done) ->
        app.request().get("/rss").end (res) ->
          res.should.status 500
          res.body.toString().should.include "mock getTopicsByQuery() error"
          done()
          return

        return

      return

    return

  return

