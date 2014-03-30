
#sign up

# md5 the pass

# create gavatar

# 发送激活邮件

###
Show user login page.

@param  {HttpRequest} req
@param  {HttpResponse} res
###

###
define some page when login just jump to the home page
@type {Array}
###
#active page
#reset password page, avoid to reset twice
#regist page
#serch pass page

###
Handle user login.

@param {HttpRequest} req
@param {HttpResponse} res
@param {Function} next
###

# 从新发送激活邮件

# store session cookie

#check at some page just jump to home page

# sign out

# 动态生成retrive_key和timestamp到users collection,之后重置密码进行验证

# 发送重置密码邮件

###
reset password
'get' to show the page, 'post' to reset password
after reset password, retrieve_key&time will be destroy
@param  {http.req}   req
@param  {http.res}   res
@param  {Function} next
###
# 用户激活
getAvatarURL = (user) ->
  return user.avatar_url  if user.avatar_url
  avatar_url = user.profile_image_url or user.avatar
  avatar_url = config.site_static_host + "/public/images/user_icon&48.png"  unless avatar_url
  avatar_url

# auth_user middleware

# private
gen_session = (user, res) ->
  auth_token = encrypt(user._id + "\t" + user.name + "\t" + user.pass + "\t" + user.email, config.session_secret)
  res.cookie config.auth_cookie_name, auth_token, #cookie 有效期30天
    path: "/"
    maxAge: 1000 * 60 * 60 * 24 * 30

  return
encrypt = (str, secret) ->
  cipher = crypto.createCipher("aes192", secret)
  enc = cipher.update(str, "utf8", "hex")
  enc += cipher.final("hex")
  enc
decrypt = (str, secret) ->
  decipher = crypto.createDecipher("aes192", secret)
  dec = decipher.update(str, "hex", "utf8")
  dec += decipher.final("utf8")
  dec
md5 = (str) ->
  md5sum = crypto.createHash("md5")
  md5sum.update str
  str = md5sum.digest("hex")
  str
randomString = (size) ->
  size = size or 6
  code_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  max_num = code_string.length + 1
  new_pass = ""
  while size > 0
    new_pass += code_string.charAt(Math.floor(Math.random() * max_num))
    size--
  new_pass
check = require("validator").check
sanitize = require("validator").sanitize
crypto = require("crypto")
config = require("../config").config
User = require("../proxy").User
Message = require("../proxy").Message
mail = require("../services/mail")
exports.showSignup = (req, res) ->
  res.render "sign/signup"
  return

exports.signup = (req, res, next) ->
  name = sanitize(req.body.name).trim()
  name = sanitize(name).xss()
  loginname = name.toLowerCase()
  pass = sanitize(req.body.pass).trim()
  pass = sanitize(pass).xss()
  email = sanitize(req.body.email).trim()
  email = email.toLowerCase()
  email = sanitize(email).xss()
  re_pass = sanitize(req.body.re_pass).trim()
  re_pass = sanitize(re_pass).xss()
  if name is "" or pass is "" or re_pass is "" or email is ""
    res.render "sign/signup",
      error: "信息不完整。"
      name: name
      email: email

    return
  if name.length < 5
    res.render "sign/signup",
      error: "用户名至少需要5个字符。"
      name: name
      email: email

    return
  try
    check(name, "用户名只能使用0-9，a-z，A-Z。").isAlphanumeric()
  catch e
    res.render "sign/signup",
      error: e.message
      name: name
      email: email

    return
  if pass isnt re_pass
    res.render "sign/signup",
      error: "两次密码输入不一致。"
      name: name
      email: email

    return
  try
    check(email, "不正确的电子邮箱。").isEmail()
  catch e
    res.render "sign/signup",
      error: e.message
      name: name
      email: email

    return
  User.getUsersByQuery
    $or: [
      {
        loginname: loginname
      }
      {
        email: email
      }
    ]
  , {}, (err, users) ->
    return next(err)  if err
    if users.length > 0
      res.render "sign/signup",
        error: "用户名或邮箱已被使用。"
        name: name
        email: email

      return
    pass = md5(pass)
    avatar_url = "http://www.gravatar.com/avatar/" + md5(email.toLowerCase()) + "?size=48"
    User.newAndSave name, loginname, pass, email, avatar_url, false, (err) ->
      return next(err)  if err
      mail.sendActiveMail email, md5(email + config.session_secret), name
      res.render "sign/signup",
        success: "欢迎加入 " + config.name + "！我们已给您的注册邮箱发送了一封邮件，请点击里面的链接来激活您的帐号。"

      return

    return

  return

exports.showLogin = (req, res) ->
  req.session._loginReferer = req.headers.referer
  res.render "sign/signin"
  return

notJump = [
  "/active_account"
  "/reset_pass"
  "/signup"
  "/search_pass"
]
exports.login = (req, res, next) ->
  loginname = sanitize(req.body.name).trim().toLowerCase()
  pass = sanitize(req.body.pass).trim()
  if not loginname or not pass
    return res.render("sign/signin",
      error: "信息不完整。"
    )
  User.getUserByLoginName loginname, (err, user) ->
    return next(err)  if err
    unless user
      return res.render("sign/signin",
        error: "这个用户不存在。"
      )
    pass = md5(pass)
    if pass isnt user.pass
      return res.render("sign/signin",
        error: "密码错误。"
      )
    unless user.active
      mail.sendActiveMail user.email, md5(user.email + config.session_secret), user.name
      return res.render("sign/signin",
        error: "此帐号还没有被激活，激活链接已发送到 " + user.email + " 邮箱，请查收。"
      )
    gen_session user, res
    refer = req.session._loginReferer or "home"
    i = 0
    len = notJump.length

    while i isnt len
      if refer.indexOf(notJump[i]) >= 0
        refer = "home"
        break
      ++i
    res.redirect refer
    return

  return

exports.signout = (req, res, next) ->
  req.session.destroy()
  res.clearCookie config.auth_cookie_name,
    path: "/"

  res.redirect req.headers.referer or "home"
  return

exports.active_account = (req, res, next) ->
  key = req.query.key
  name = req.query.name
  User.getUserByName name, (err, user) ->
    return next(err)  if err
    if not user or md5(user.email + config.session_secret) isnt key
      return res.render("notify/notify",
        error: "信息有误，帐号无法被激活。"
      )
    if user.active
      return res.render("notify/notify",
        error: "帐号已经是激活状态。"
      )
    user.active = true
    user.save (err) ->
      return next(err)  if err
      res.render "notify/notify",
        success: "帐号已被激活，请登录"

      return

    return

  return

exports.showSearchPass = (req, res) ->
  res.render "sign/search_pass"
  return

exports.updateSearchPass = (req, res, next) ->
  email = req.body.email
  email = email.toLowerCase()
  try
    check(email, "不正确的电子邮箱。").isEmail()
  catch e
    res.render "sign/search_pass",
      error: e.message
      email: email

    return
  retrieveKey = randomString(15)
  retrieveTime = new Date().getTime()
  User.getUserByMail email, (err, user) ->
    unless user
      res.render "sign/search_pass",
        error: "没有这个电子邮箱。"
        email: email

      return
    user.retrieve_key = retrieveKey
    user.retrieve_time = retrieveTime
    user.save (err) ->
      return next(err)  if err
      mail.sendResetPassMail email, retrieveKey, user.name
      res.render "notify/notify",
        success: "我们已给您填写的电子邮箱发送了一封邮件，请在24小时内点击里面的链接来重置密码。"

      return

    return

  return

exports.reset_pass = (req, res, next) ->
  key = req.query.key
  name = req.query.name
  User.getUserByQuery name, key, (err, user) ->
    unless user
      return res.render("notify/notify",
        error: "信息有误，密码无法重置。"
      )
    now = new Date().getTime()
    oneDay = 1000 * 60 * 60 * 24
    if not user.retrieve_time or now - user.retrieve_time > oneDay
      return res.render("notify/notify",
        error: "该链接已过期，请重新申请。"
      )
    res.render "sign/reset",
      name: name
      key: key


  return

exports.update_pass = (req, res, next) ->
  psw = req.body.psw or ""
  repsw = req.body.repsw or ""
  key = req.body.key or ""
  name = req.body.name or ""
  if psw isnt repsw
    return res.render("sign/reset",
      name: name
      key: key
      error: "两次密码输入不一致。"
    )
  User.getUserByQuery name, key, (err, user) ->
    return next(err)  if err
    unless user
      return res.render("notify/notify",
        error: "错误的激活链接"
      )
    user.pass = md5(psw)
    user.retrieve_key = null
    user.retrieve_time = null
    user.active = true
    user.save (err) ->
      return next(err)  if err
      res.render "notify/notify",
        success: "你的密码已重置。"


    return

  return

exports.auth_user = (req, res, next) ->
  if req.session.user
    req.session.user.is_admin = true  if config.admins.hasOwnProperty(req.session.user.name)
    Message.getMessagesCount req.session.user._id, (err, count) ->
      return next(err)  if err
      req.session.user.messages_count = count
      req.session.user.avatar_url = getAvatarURL(req.session.user)  unless req.session.user.avatar_url
      res.local "current_user", req.session.user
      next()

  else
    cookie = req.cookies[config.auth_cookie_name]
    return next()  unless cookie
    auth_token = decrypt(cookie, config.session_secret)
    auth = auth_token.split("\t")
    user_id = auth[0]
    User.getUserById user_id, (err, user) ->
      return next(err)  if err
      if user
        user.is_admin = true  if config.admins.hasOwnProperty(user.name)
        Message.getMessagesCount user._id, (err, count) ->
          return next(err)  if err
          user.messages_count = count
          req.session.user = user
          res.local "current_user", req.session.user
          next()

      else
        next()
      return

  return

exports.gen_session = gen_session
