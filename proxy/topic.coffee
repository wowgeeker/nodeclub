EventProxy = require("eventproxy")
models = require("../models")
Topic = models.Topic
TopicTag = models.TopicTag
User = require("./user")
Tag = require("./tag")
Reply = require("./reply")
Util = require("../libs/util")

###
根据主题ID获取主题
Callback:
- err, 数据库错误
- topic, 主题
- tags, 标签列表
- author, 作者
- lastReply, 最后回复
@param {String} id 主题ID
@param {Function} callback 回调函数
###
exports.getTopicById = (id, callback) ->
  proxy = new EventProxy()
  events = [
    "topic"
    "tags"
    "author"
    "last_reply"
  ]
  proxy.assign(events, (topic, tags, author, last_reply) ->
    callback null, topic, tags, author, last_reply
  ).fail callback
  Topic.findOne
    _id: id
  , proxy.done((topic) ->
    unless topic
      proxy.emit "topic", null
      proxy.emit "tags", []
      proxy.emit "author", null
      proxy.emit "last_reply", null
      return
    proxy.emit "topic", topic
    
    # TODO: 可以只查tag_id这个字段的吧？
    TopicTag.find
      topic_id: topic._id
    , proxy.done((topic_tags) ->
      tags_id = []
      i = 0

      while i < topic_tags.length
        tags_id.push topic_tags[i].tag_id
        i++
      Tag.getTagsByIds tags_id, proxy.done("tags")
      return
    )
    User.getUserById topic.author_id, proxy.done("author")
    if topic.last_reply
      Reply.getReplyById topic.last_reply, proxy.done((last_reply) ->
        proxy.emit "last_reply", last_reply or null
        return
      )
    else
      proxy.emit "last_reply", null
    return
  )
  return


###
获取关键词能搜索到的主题数量
Callback:
- err, 数据库错误
- count, 主题数量
@param {String} query 搜索关键词
@param {Function} callback 回调函数
###
exports.getCountByQuery = (query, callback) ->
  Topic.count query, callback
  return


###
根据关键词，获取主题列表
Callback:
- err, 数据库错误
- count, 主题列表
@param {String} query 搜索关键词
@param {Object} opt 搜索选项
@param {Function} callback 回调函数
###
exports.getTopicsByQuery = (query, opt, callback) ->
  Topic.find query, ["_id"], opt, (err, docs) ->
    return callback(err)  if err
    return callback(null, [])  if docs.length is 0
    topics_id = []
    i = 0

    while i < docs.length
      topics_id.push docs[i]._id
      i++
    proxy = new EventProxy()
    proxy.after "topic_ready", topics_id.length, (topics) ->
      
      # 过滤掉空值
      filtered = topics.filter((item) ->
        !!item
      )
      callback null, filtered

    proxy.fail callback
    topics_id.forEach (id, i) ->
      exports.getTopicById id, proxy.group("topic_ready", (topic, tags, author, last_reply) ->
        
        # 当id查询出来之后，进一步查询列表时，文章可能已经被删除了
        # 所以这里有可能是null
        if topic
          topic.tags = tags
          topic.author = author
          topic.reply = last_reply
          topic.friendly_create_at = Util.format_date(topic.create_at, true)
        topic
      )
      return

    return

  return


###
获取所有信息的主题
Callback:
- err, 数据库异常
- message, 消息
- topic, 主题
- tags, 主题的标签
- author, 主题作者
- replies, 主题的回复
@param {String} id 主题ID
@param {Function} callback 回调函数
###
exports.getFullTopic = (id, callback) ->
  proxy = new EventProxy()
  events = [
    "topic"
    "tags"
    "author"
    "replies"
  ]
  proxy.assign(events, (topic, tags, author, replies) ->
    callback null, "", topic, tags, author, replies
    return
  ).fail callback
  Topic.findOne
    _id: id
  , proxy.done((topic) ->
    unless topic
      proxy.unbind()
      return callback(null, "此话题不存在或已被删除。")
    proxy.emit "topic", topic
    TopicTag.find
      topic_id: topic._id
    , proxy.done((topic_tags) ->
      tags_ids = []
      i = 0

      while i < topic_tags.length
        tags_ids.push topic_tags[i].tag_id
        i++
      Tag.getTagsByIds tags_ids, proxy.done("tags")
      return
    )
    User.getUserById topic.author_id, proxy.done((author) ->
      unless author
        proxy.unbind()
        return callback(null, "话题的作者丢了。")
      proxy.emit "author", author
      return
    )
    Reply.getRepliesByTopicId topic._id, proxy.done("replies")
    return
  )
  return


###
更新主题的最后回复信息
@param {String} topicId 主题ID
@param {String} replyId 回复ID
@param {Function} callback 回调函数
###
exports.updateLastReply = (topicId, replyId, callback) ->
  Topic.findOne
    _id: topicId
  , (err, topic) ->
    return callback(err)  if err or not topic
    topic.last_reply = replyId
    topic.last_reply_at = new Date()
    topic.reply_count += 1
    topic.save callback
    return

  return


###
根据主题ID，查找一条主题
@param {String} id 主题ID
@param {Function} callback 回调函数
###
exports.getTopic = (id, callback) ->
  Topic.findOne
    _id: id
  , callback
  return


###
将当前主题的回复计数减1，删除回复时用到
@param {String} id 主题ID
@param {Function} callback 回调函数
###
exports.reduceCount = (id, callback) ->
  Topic.findOne
    _id: id
  , (err, topic) ->
    return callback(err)  if err
    return callback(new Error("该主题不存在"))  unless topic
    topic.reply_count -= 1
    topic.save callback
    return

  return

exports.newAndSave = (title, content, authorId, callback) ->
  topic = new Topic()
  topic.title = title
  topic.content = content
  topic.author_id = authorId
  topic.save callback
  return
