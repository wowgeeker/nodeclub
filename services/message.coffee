models = require("../models")
Message = models.Message
User = require("../proxy").User
messageProxy = require("../proxy/message")
mail = require("./mail")
exports.sendReplyMessage = (master_id, author_id, topic_id, reply_id) ->
  message = new Message()
  message.type = "reply"
  message.master_id = master_id
  message.author_id = author_id
  message.topic_id = topic_id
  message.reply_id = reply_id
  message.save (err) ->
    
    # TODO: 异常处理
    User.getUserById master_id, (err, master) ->
      
      # TODO: 异常处理
      if master and master.receive_reply_mail
        message.has_read = true
        message.save()
        messageProxy.getMessageById message._id, (err, msg) ->
          msg.reply_id = reply_id
          
          # TODO: 异常处理
          mail.sendReplyMail master.email, msg
          return

      return

    return

  return

exports.sendReply2Message = (master_id, author_id, topic_id, reply_id) ->
  message = new Message()
  message.type = "reply2"
  message.master_id = master_id
  message.author_id = author_id
  message.topic_id = topic_id
  message.reply_id = reply_id
  message.save (err) ->
    
    # TODO: 异常处理
    User.getUserById master_id, (err, master) ->
      
      # TODO: 异常处理
      if master and master.receive_reply_mail
        message.has_read = true
        message.save()
        messageProxy.getMessageById message._id, (err, msg) ->
          msg.reply_id = reply_id
          
          # TODO: 异常处理
          mail.sendReplyMail master.email, msg
          return

      return

    return

  return

exports.sendAtMessage = (master_id, author_id, topic_id, reply_id, callback) ->
  message = new Message()
  message.type = "at"
  message.master_id = master_id
  message.author_id = author_id
  message.topic_id = topic_id
  message.reply_id = reply_id
  message.save (err) ->
    
    # TODO: 异常处理
    User.getUserById master_id, (err, master) ->
      
      # TODO: 异常处理
      if master and master.receive_at_mail
        message.has_read = true
        message.save()
        messageProxy.getMessageById message._id, (err, msg) ->
          
          # TODO: 异常处理
          mail.sendAtMail master.email, msg
          return

      return

    callback err
    return

  return

exports.sendFollowMessage = (follow_id, author_id) ->
  message = new Message()
  message.type = "follow"
  message.master_id = follow_id
  message.author_id = author_id
  message.save()
  return
