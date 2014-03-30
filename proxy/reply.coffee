models = require("../models")
Reply = models.Reply
EventProxy = require("eventproxy")
Util = require("../libs/util")
Showdown = require("../public/libs/showdown")
User = require("./user")
at = require("../services/at")

###
获取一条回复信息
@param {String} id 回复ID
@param {Function} callback 回调函数
###
exports.getReply = (id, callback) ->
  Reply.findOne
    _id: id
  , callback
  return


###
根据回复ID，获取回复
Callback:
- err, 数据库异常
- reply, 回复内容
@param {String} id 回复ID
@param {Function} callback 回调函数
###
exports.getReplyById = (id, callback) ->
  Reply.findOne
    _id: id
  , (err, reply) ->
    return callback(err)  if err
    return callback(err, null)  unless reply
    author_id = reply.author_id
    User.getUserById author_id, (err, author) ->
      return callback(err)  if err
      reply.author = author
      reply.friendly_create_at = Util.format_date(reply.create_at, true)
      
      # TODO: 添加更新方法，有些旧帖子可以转换为markdown格式的内容
      return callback(null, reply)  if reply.content_is_html
      at.linkUsers reply.content, (err, str) ->
        return callback(err)  if err
        reply.content = str
        callback err, reply

      return

    return

  return


###
根据主题ID，获取回复列表
Callback:
- err, 数据库异常
- replies, 回复列表
@param {String} id 主题ID
@param {Function} callback 回调函数
###
exports.getRepliesByTopicId = (id, cb) ->
  Reply.find
    topic_id: id
  , [],
    sort: [[
      "create_at"
      "asc"
    ]]
  , (err, replies) ->
    return cb(err)  if err
    return cb(err, [])  if replies.length is 0
    proxy = new EventProxy()
    done = ->
      replies2 = []
      i = replies.length - 1

      while i >= 0
        if replies[i].reply_id
          replies2.push replies[i]
          replies.splice i, 1
        i--
      j = 0

      while j < replies.length
        replies[j].replies = []
        k = 0

        while k < replies2.length
          id1 = replies[j]._id
          id2 = replies2[k].reply_id
          replies[j].replies.push replies2[k]  if id1.toString() is id2.toString()
          k++
        replies[j].replies.reverse()
        j++
      cb err, replies

    proxy.after "reply_find", replies.length, done
    j = 0

    while j < replies.length
      ((i) ->
        author_id = replies[i].author_id
        User.getUserById author_id, (err, author) ->
          return cb(err)  if err
          replies[i].author = author or _id: ""
          replies[i].friendly_create_at = Util.format_date(replies[i].create_at, true)
          return proxy.emit("reply_find")  if replies[i].content_is_html
          at.linkUsers replies[i].content, (err, str) ->
            return cb(err)  if err
            replies[i].content = str
            proxy.emit "reply_find"
            return

          return

        return
      ) j
      j++
    return

  return


###
创建并保存一条回复信息
@param {String} content 回复内容
@param {String} topicId 主题ID
@param {String} authorId 回复作者
@param {String} [replyId] 回复ID，当二级回复时设定该值
@param {Function} callback 回调函数
###
exports.newAndSave = (content, topicId, authorId, replyId, callback) ->
  if typeof replyId is "function"
    callback = replyId
    replyId = null
  reply = new Reply()
  reply.content = content
  reply.topic_id = topicId
  reply.author_id = authorId
  reply.reply_id = replyId  if replyId
  reply.save (err) ->
    callback err, reply
    return

  return

exports.getRepliesByAuthorId = (authorId, opt, callback) ->
  unless callback
    callback = opt
    opt = null
  Reply.find
    author_id: authorId
  , {}, opt, callback
  return
