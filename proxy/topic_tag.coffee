TopicTag = require("../models").TopicTag
exports.getTopicTagByTagId = (tagId, callback) ->
  TopicTag.find
    tag_id: tagId
  , callback
  return

exports.getTopicTagByTopicId = (topicId, callback) ->
  TopicTag.find
    topic_id: topicId
  , callback
  return

exports.removeByTagId = (tagId, callback) ->
  TopicTag.remove
    tag_id: tagId
  , callback
  return

exports.newAndSave = (topicId, tagId, callback) ->
  topic_tag = new TopicTag()
  topic_tag.topic_id = topicId
  topic_tag.tag_id = tagId
  topic_tag.save callback
  return
