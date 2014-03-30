User = require("../../proxy/user")
Tag = require("../../proxy/tag")
Topic = require("../../proxy/topic")
exports.createUser = (callback) ->
  key = new Date().getTime() + "_" + Math.random()
  User.newAndSave "jackson" + key, "jackson" + key, "pass", "jackson" + key + "@domain.com", "", false, callback
  return

exports.createTopic = (authorId, callback) ->
  key = new Date().getTime() + "_" + Math.random()
  Topic.newAndSave "title" + key, "content" + key, authorId, callback
  return

exports.createTag = (callback) ->
  key = new Date().getTime() + "_" + Math.random()
  Tag.newAndSave "name" + key, "background" + key, 1, "description" + key, callback
  return
