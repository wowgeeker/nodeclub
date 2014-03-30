Message = require("../proxy").Message
EventProxy = require("eventproxy")
exports.index = (req, res, next) ->
  unless req.session.user
    res.redirect "home"
    return
  message_ids = []
  user_id = req.session.user._id
  Message.getMessagesByUserId user_id, (err, docs) ->
    return next(err)  if err
    i = 0

    while i < docs.length
      message_ids.push docs[i]._id
      i++
    messages = []
    if message_ids.length is 0
      res.render "message/index",
        has_read_messages: []
        hasnot_read_messages: []

      return
    proxy = new EventProxy()
    render = ->
      has_read_messages = []
      hasnot_read_messages = []
      i = 0

      while i < messages.length
        if messages[i].is_invalid
          messages[i].remove()
        else
          if messages[i].has_read
            has_read_messages.push messages[i]
          else
            hasnot_read_messages.push messages[i]
        i++
      res.render "message/index",
        has_read_messages: has_read_messages
        hasnot_read_messages: hasnot_read_messages

      return

    proxy.after "message_ready", message_ids.length, render
    message_ids.forEach (id, i) ->
      Message.getMessageById id, (err, message) ->
        return next(err)  if err
        messages[i] = message
        proxy.emit "message_ready"
        return

      return

    return

  return

exports.mark_read = (req, res, next) ->
  if not req.session or not req.session.user
    res.send "forbidden!"
    return
  message_id = req.body.message_id
  Message.getMessageById message_id, (err, message) ->
    return next(err)  if err
    unless message
      res.json status: "failed"
      return
    if message.master_id.toString() isnt req.session.user._id.toString()
      res.json status: "failed"
      return
    message.has_read = true
    message.save (err) ->
      return next(err)  if err
      res.json status: "success"
      return

    return

  return

exports.mark_all_read = (req, res, next) ->
  if not req.session or not req.session.user
    res.send "forbidden!"
    return
  
  # TODO: 直接做update，无需查找然后再逐个修改。
  Message.getUnreadMessageByUserId req.session.user._id, (err, messages) ->
    if messages.length is 0
      res.json status: "success"
      return
    proxy = new EventProxy()
    proxy.after "marked", messages.length, ->
      res.json status: "success"
      return

    proxy.fail next
    i = 0

    while i < messages.length
      message = messages[i]
      message.has_read = true
      message.save proxy.done("marked")
      i++
    return

  return
