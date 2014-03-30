models = require("../models")
TagCollect = models.TagCollect
exports.newAndSave = (userId, tagId, callback) ->
  tag_collect = new TagCollect()
  tag_collect.user_id = userId
  tag_collect.tag_id = tagId
  tag_collect.save callback
  return

exports.getTagCollect = (userId, tagId, callback) ->
  TagCollect.findOne
    user_id: userId
    tag_id: tagId
  , callback
  return

exports.getTagCollectsByUserId = (userId, callback) ->
  TagCollect.find
    user_id: userId
  , callback
  return

exports.remove = (userId, tagId, callback) ->
  TagCollect.remove
    user_id: userId
    tag_id: tagId
  , callback
  return

exports.removeAllByTagId = (tagId, callback) ->
  TagCollect.remove
    tag_id: tagId
  , callback
  return
