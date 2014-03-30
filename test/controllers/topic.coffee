#!
# * nodeclub - test/controllers/topic.js
# * Copyright(c) 2013 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 
"use strict"

###
Module dependencies.
###
should = require("should")
request = require("supertest")
app = require("../../app")
describe "controllers/topic.js", ->
  before (done) ->
    app.listen 0, done
    return

  after ->
    app.close()
    return

  describe "/topic", ->
    it "should ok", (done) ->
      request(app).get("/topic/inexist").expect(200).expect /此话题不存在或已被删除/, done
      return

    return

  describe "/user/$name/replies", ->
    it "should GET /user/lzghades/replies?page=1 %27%27%29%29%28%27%27%29%27%28 status 200", (done) ->
      request(app).get("/user/lzghades/replies?page=1 %27%27%29%29%28%27%27%29%27%28 ").expect 200, done
      return

    return

  return

