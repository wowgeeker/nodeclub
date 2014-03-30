TopicCollect = require("../models").TopicCollect
exports.getTopicCollect = (userId, topicId, callback) ->
  TopicCollect.findOne
    user_id: userId
    topic_id: topicId
  , callback
  return

exports.getTopicCollectsByUserId = (userId, callback) ->
  TopicCollect.find
    user_id: userId
  , callback
  return

exports.newAndSave = (userId, topicId, callback) ->
  topic_collect = new TopicCollect()
  topic_collect.user_id = userId
  topic_collect.topic_id = topicId
  topic_collect.save callback
  return

exports.remove = (userId, topicId, callback) ->
  TopicCollect.remove
    user_id: userId
    topic_id: topicId
  , callback
  return
