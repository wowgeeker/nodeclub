#!
# * nodeclub - wordpress_redirect
# *   handle wordpress http://xxx/blog/?p=$pid redirect to http://nodeclub/topic/xxxx
# * 
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 

###
Module dependencies.
###
PostToTopic = require("./model").PostToTopic
module.exports = wordpressRedirect = (options) ->
  options = options or {}
  root = options.root or "/topic/"
  root += "/"  if root[root.length - 1] isnt "/"
  URL_RE = options.match or /^\/blog\/?\?p=(\d+)/i
  (req, res, next) ->
    return next()  unless URL_RE.test(req.url)
    m = URL_RE.exec(req.url)
    postId = parseInt(m[1], 10)
    PostToTopic.findOne
      _id: postId
    , (err, o) ->
      return next(err)  if err
      return next()  unless o
      res.redirect root + o.topic_id, 301
      return

    return
