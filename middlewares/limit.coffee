config = require("../config").config

# 发帖时间间隔，为毫秒
POST_INTERVAL = config.post_interval
POST_INTERVAL = 0  unless POST_INTERVAL > 0
DISABLE_POST_INTERVAL = (if POST_INTERVAL > 0 then false else true)

###
发帖/评论时间间隔限制
###
exports.postInterval = (req, res, next) ->
  return next()  if DISABLE_POST_INTERVAL
  if isNaN(req.session.lastPostTimestamp)
    req.session.lastPostTimestamp = Date.now()
    return next()
  if Date.now() - req.session.lastPostTimestamp < POST_INTERVAL
    ERROR_MSG = "请刷新页面检查是否已提交成功！"
    if req.accepts("json")
      res.json error: ERROR_MSG
    else
      res.render "notify/notify",
        error: ERROR_MSG

    return
  req.session.lastPostTimestamp = Date.now()
  next()
  return
