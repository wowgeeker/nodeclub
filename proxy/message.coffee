EventProxy = require("eventproxy")
Message = require("../models").Message
User = require("./user")
Topic = require("./topic")
Reply = require("./reply")

###
根据用户ID，获取未读消息的数量
Callback:
回调函数参数列表：
- err, 数据库错误
- count, 未读消息数量
@param {String} id 用户ID
@param {Function} callback 获取消息数量
###
exports.getMessagesCount = (id, callback) ->
  Message.count
    master_id: id
    has_read: false
  , callback
  return


###
根据消息Id获取消息
Callback:
- err, 数据库错误
- message, 消息对象
@param {String} id 消息ID
@param {Function} callback 回调函数
###
exports.getMessageById = (id, callback) ->
  Message.findOne
    _id: id
  , (err, message) ->
    return callback(err)  if err
    if message.type is "reply" or message.type is "reply2" or message.type is "at"
      proxy = new EventProxy()
      proxy.assign("author_found", "topic_found", "reply_found", (author, topic, reply) -> # 接收异常
        message.author = author
        message.topic = topic
        message.reply = reply
        message.is_invalid = true  if not author or not topic
        callback null, message
      ).fail callback
      User.getUserById message.author_id, proxy.done("author_found")
      Topic.getTopicById message.topic_id, proxy.done("topic_found")
      Reply.getReplyById message.reply_id, proxy.done("reply_found")
    if message.type is "follow"
      User.getUserById message.author_id, (err, author) ->
        return callback(err)  if err
        message.author = author
        message.is_invalid = true  unless author
        callback null, message

    return

  return


###
根据用户ID，获取消息列表
Callback:
- err, 数据库异常
- messages, 消息列表
@param {String} userId 用户ID
@param {Function} callback 回调函数
###
exports.getMessagesByUserId = (userId, callback) ->
  Message.find
    master_id: userId
  , [],
    sort: [[
      "create_at"
      "desc"
    ]]
    limit: 20
  , callback
  return


###
根据用户ID，获取未读消息列表
Callback:
- err, 数据库异常
- messages, 未读消息列表
@param {String} userId 用户ID
@param {Function} callback 回调函数
###
exports.getUnreadMessageByUserId = (userId, callback) ->
  Message.find
    master_id: userId
    has_read: false
  , callback
  return
