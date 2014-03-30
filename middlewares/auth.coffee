###
需要管理员权限
###
exports.adminRequired = (req, res, next) ->
  unless req.session.user
    return res.render("notify/notify",
      error: "你还没有登录。"
    )
  unless req.session.user.is_admin
    return res.render("notify/notify",
      error: "管理员才能编辑标签。"
    )
  next()
  return


###
需要登录
###
exports.userRequired = (req, res, next) ->
  return res.send(403, "forbidden!")  if not req.session or not req.session.user
  next()
  return


###
需要登录，响应错误页面
###
exports.signinRequired = (req, res, next) ->
  unless req.session.user
    res.render "notify/notify",
      error: "未登入用户不能发布话题。"

    return
  next()
  return

exports.blockUser = ->
  (req, res, next) ->
    return res.send("您被屏蔽了。")  if req.session.user and req.session.user.is_block
    next()
    return
