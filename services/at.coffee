#!
# * nodeclub - topic mention user controller.
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * Copyright(c) 2012 muyuan
# * MIT Licensed
# 

###
Module dependencies.
###
User = require("../proxy").User
Message = require("./message")
EventProxy = require("eventproxy")

###
从文本中提取出@username 标记的用户名数组
@param {String} text 文本内容
@return {Array} 用户名数组
###
fetchUsers = (text) ->
  results = text.match(/@[a-zA-Z0-9\-_]+/g)
  names = []
  if results
    i = 0
    l = results.length

    while i < l
      s = results[i]
      
      #remove char @
      s = s.slice(1)
      names.push s
      i++
  names


###
根据文本内容中读取用户，并发送消息给提到的用户
Callback:
- err, 数据库异常
@param {String} text 文本内容
@param {String} topicId 主题ID
@param {String} authorId 作者ID
@param {Function} callback 回调函数
###
exports.sendMessageToMentionUsers = (text, topicId, authorId, reply_id, callback) ->
  if typeof reply_id is "function"
    callback = reply_id
    reply_id = null
  callback = callback or ->

  User.getUsersByNames fetchUsers(text), (err, users) ->
    return callback(err)  if err or not users
    ep = new EventProxy()
    ep.after("sent", users.length, ->
      callback()
      return
    ).fail callback
    users.forEach (user) ->
      Message.sendAtMessage user._id, authorId, topicId, reply_id, ep.done("sent")
      return

    return

  return


###
根据文本内容，替换为数据库中的数据
Callback:
- err, 数据库异常
- text, 替换后的文本内容
@param {String} text 文本内容
@param {Function} callback 回调函数
###
exports.linkUsers = (text, callback) ->
  User.getUsersByNames fetchUsers(text), (err, users) ->
    return callback(err)  if err
    i = 0
    l = users.length

    while i < l
      name = users[i].name
      text = text.replace(new RegExp("@" + name, "gmi"), "[@" + name + "](/user/" + name + ")")
      i++
    callback null, text

  return
