User = require("../proxy").User
UserModel = require("../models").User
Tag = require("../proxy").Tag
Topic = require("../proxy").Topic
TopicModel = require("../models").Topic
Reply = require("../proxy").Reply
ReplyModel = require("../models").Reply
Relation = require("../proxy").Relation
TopicCollect = require("../proxy").TopicCollect
TagCollect = require("../proxy").TagCollect
utility = require("utility")
message = require("../services/message")
Util = require("../libs/util")
config = require("../config").config
EventProxy = require("eventproxy")
check = require("validator").check
sanitize = require("validator").sanitize
crypto = require("crypto")
exports.index = (req, res, next) ->
  user_name = req.params.name
  User.getUserByName user_name, (err, user) ->
    return next(err)  if err
    unless user
      res.render "notify/notify",
        error: "这个用户不存在。"

      return
    render = (recent_topics, recent_replies, relation) ->
      user.friendly_create_at = Util.format_date(user.create_at, true)
      
      # 如果用户没有激活，那么管理员可以帮忙激活
      token = ""
      token = utility.md5(user.email + config.session_secret)  if not user.active and req.session.user and req.session.user.is_admin
      res.render "user/index",
        user: user
        recent_topics: recent_topics
        recent_replies: recent_replies
        relation: relation
        token: token

      return

    proxy = new EventProxy()
    proxy.assign "recent_topics", "recent_replies", "relation", render
    proxy.fail next
    query = author_id: user._id
    opt =
      limit: 5
      sort: [[
        "create_at"
        "desc"
      ]]

    Topic.getTopicsByQuery query, opt, proxy.done("recent_topics")
    Reply.getRepliesByAuthorId user._id,
      limit: 20
      sort: [[
        "create_at"
        "desc"
      ]]
    , proxy.done((replies) ->
      topic_ids = []
      i = 0

      while i < replies.length
        topic_ids.push replies[i].topic_id.toString()  if topic_ids.indexOf(replies[i].topic_id.toString()) < 0
        i++
      query = _id:
        $in: topic_ids

      opt =
        limit: 5
        sort: [[
          "create_at"
          "desc"
        ]]

      Topic.getTopicsByQuery query, opt, proxy.done("recent_replies")
      return
    )
    unless req.session.user
      proxy.emit "relation", null
    else
      Relation.getRelation req.session.user._id, user._id, proxy.done("relation")
    return

  return

exports.show_stars = (req, res, next) ->
  User.getUsersByQuery
    is_star: true
  , {}, (err, stars) ->
    return next(err)  if err
    res.render "user/stars",
      stars: stars

    return

  return

exports.showSetting = (req, res, next) ->
  unless req.session.user
    res.redirect "home"
    return
  User.getUserById req.session.user._id, (err, user) ->
    return next(err)  if err
    user.success = "保存成功。"  if req.query.save is "success"
    user.error = null
    res.render "user/setting", user

  return

exports.setting = (req, res, next) ->
  
  # 显示出错或成功信息
  showMessage = (msg, data, isSuccess) ->
    data = data or req.body
    data2 =
      name: data.name
      email: data.email
      url: data.url
      profile_image_url: data.profile_image_url
      location: data.location
      signature: data.signature
      profile: data.profile
      weibo: data.weibo
      githubUsername: data.github or data.githubUsername
      receive_at_mail: data.receive_at_mail
      receive_reply_mail: data.receive_reply_mail

    if isSuccess
      data2.success = msg
    else
      data2.error = msg
    res.render "user/setting", data2
    return
  unless req.session.user
    res.redirect "home"
    return
  
  # post
  action = req.body.action
  if action is "change_setting"
    name = sanitize(req.body.name).trim()
    name = sanitize(name).xss()
    email = sanitize(req.body.email).trim()
    email = sanitize(email).xss()
    url = sanitize(req.body.url).trim()
    url = sanitize(url).xss()
    profile_image_url = null
    profile_image_url = sanitize(sanitize(req.body.profile_image_url).trim()).xss()  if typeof req.body.profile_image_url is "string"
    location = sanitize(req.body.location).trim()
    location = sanitize(location).xss()
    signature = sanitize(req.body.signature).trim()
    signature = sanitize(signature).xss()
    profile = sanitize(req.body.profile).trim()
    profile = sanitize(profile).xss()
    weibo = sanitize(req.body.weibo).trim()
    weibo = sanitize(weibo).xss()
    github = sanitize(req.body.github).trim()
    github = sanitize(github).xss()
    github = github.slice(1)  if github.indexOf("@") is 0
    receive_at_mail = req.body.receive_at_mail is "on"
    receive_reply_mail = req.body.receive_reply_mail is "on"
    if url isnt ""
      try
        url = "http://" + url  if (url.indexOf("http://") < 0) and (url.indexOf("https://") < 0)
        check(url, "不正确的个人网站。").isUrl()
      catch e
        return showMessage(e.message)
    if weibo
      try
        weibo = "http://" + weibo  if weibo.indexOf("http://") < 0
        check(weibo, "不正确的微博地址。").isUrl()
      catch e
        return showMessage(e.message)
    User.getUserById req.session.user._id, (err, user) ->
      return next(err)  if err
      user.url = url
      user.profile_image_url = profile_image_url  if typeof profile_image_url is "string"
      user.location = location
      user.signature = signature
      user.profile = profile
      user.weibo = weibo
      user.githubUsername = github
      user.receive_at_mail = receive_at_mail
      user.receive_reply_mail = receive_reply_mail
      user.save (err) ->
        return next(err)  if err
        res.redirect "/setting?save=success"

      return

  if action is "change_password"
    old_pass = sanitize(req.body.old_pass).trim()
    new_pass = sanitize(req.body.new_pass).trim()
    User.getUserById req.session.user._id, (err, user) ->
      return next(err)  if err
      md5sum = crypto.createHash("md5")
      md5sum.update old_pass
      old_pass = md5sum.digest("hex")
      return showMessage("当前密码不正确。", user)  if old_pass isnt user.pass
      md5sum = crypto.createHash("md5")
      md5sum.update new_pass
      new_pass = md5sum.digest("hex")
      user.pass = new_pass
      user.save (err) ->
        return next(err)  if err
        showMessage "密码已被修改。", user, true

      return

  return

exports.follow = (req, res, next) ->
  follow_id = req.body.follow_id
  User.getUserById follow_id, (err, user) ->
    return next(err)  if err
    res.json status: "failed"  unless user
    proxy = EventProxy.create("relation_saved", "message_saved", ->
      res.json status: "success"
      return
    )
    proxy.fail next
    Relation.getRelation req.session.user._id, user._id, proxy.done((doc) ->
      return proxy.emit("relation_saved")  if doc
      
      # 新建关系并保存
      Relation.newAndSave req.session.user._id, user._id
      proxy.emit "relation_saved"
      User.getUserById req.session.user._id, proxy.done((me) ->
        me.following_count += 1
        me.save()
        return
      )
      user.follower_count += 1
      user.save()
      req.session.user.following_count += 1
      return
    )
    message.sendFollowMessage follow_id, req.session.user._id
    proxy.emit "message_saved"
    return

  return

exports.un_follow = (req, res, next) ->
  if not req.session or not req.session.user
    res.send "forbidden!"
    return
  follow_id = req.body.follow_id
  User.getUserById follow_id, (err, user) ->
    return next(err)  if err
    unless user
      res.json status: "failed"
      return
    
    # 删除关系
    Relation.remove req.session.user._id, user._id, (err) ->
      return next(err)  if err
      res.json status: "success"
      return

    User.getUserById req.session.user._id, (err, me) ->
      return next(err)  if err
      me.following_count -= 1
      me.following_count = 0  if me.following_count < 0
      me.save()
      return

    user.follower_count -= 1
    user.follower_count = 0  if user.follower_count < 0
    user.save()
    req.session.user.following_count -= 1
    req.session.user.following_count = 0  if req.session.user.following_count < 0
    return

  return

exports.toggle_star = (req, res, next) ->
  if not req.session.user or not req.session.user.is_admin
    res.send "forbidden!"
    return
  user_id = req.body.user_id
  User.getUserById user_id, (err, user) ->
    return next(err)  if err
    user.is_star = not user.is_star
    user.save (err) ->
      return next(err)  if err
      res.json status: "success"
      return

    return

  return

exports.get_collect_tags = (req, res, next) ->
  name = req.params.name
  User.getUserByName name, (err, user) ->
    return next(err)  if err or not user
    TagCollect.getTagCollectsByUserId user._id, (err, docs) ->
      return next(err)  if err
      ids = []
      i = 0

      while i < docs.length
        ids.push docs[i].tag_id
        i++
      Tag.getTagsByIds ids, (err, tags) ->
        return next(err)  if err
        res.render "user/collect_tags",
          tags: tags
          user: user

        return

      return

    return

  return

exports.get_collect_topics = (req, res, next) ->
  name = req.params.name
  User.getUserByName name, (err, user) ->
    return next(err)  if err or not user
    page = Number(req.query.page) or 1
    limit = config.list_topic_count
    render = (topics, pages) ->
      res.render "user/collect_topics",
        topics: topics
        current_page: page
        pages: pages
        user: user

      return

    proxy = EventProxy.create("topics", "pages", render)
    proxy.fail next
    TopicCollect.getTopicCollectsByUserId user._id, proxy.done((docs) ->
      ids = []
      i = 0

      while i < docs.length
        ids.push docs[i].topic_id
        i++
      query = _id:
        $in: ids

      opt =
        skip: (page - 1) * limit
        limit: limit
        sort: [[
          "create_at"
          "desc"
        ]]

      Topic.getTopicsByQuery query, opt, proxy.done("topics")
      Topic.getCountByQuery query, proxy.done((all_topics_count) ->
        pages = Math.ceil(all_topics_count / limit)
        proxy.emit "pages", pages
        return
      )
      return
    )
    return

  return

exports.get_followings = (req, res, next) ->
  name = req.params.name
  User.getUserByName name, (err, user) ->
    return next(err)  if err or not user
    Relation.getFollowings user._id, (err, docs) ->
      return next(err)  if err
      ids = []
      i = 0

      while i < docs.length
        ids.push docs[i].follow_id
        i++
      User.getUsersByIds ids, (err, users) ->
        return next(err)  if err
        res.render "user/followings",
          users: users
          user: user

        return

      return

    return

  return

exports.get_followers = (req, res, next) ->
  name = req.params.name
  User.getUserByName name, (err, user) ->
    return next(err)  if err or not user
    proxy = new EventProxy()
    proxy.fail next
    Relation.getRelationsByUserId user._id, proxy.done((docs) ->
      ids = []
      i = 0

      while i < docs.length
        ids.push docs[i].user_id
        i++
      User.getUsersByIds ids, proxy.done((users) ->
        res.render "user/followers",
          users: users
          user: user

        return
      )
      return
    )
    return

  return

exports.top100 = (req, res, next) ->
  opt =
    limit: 100
    sort: [[
      "score"
      "desc"
    ]]

  User.getUsersByQuery
    $or: [
      {
        is_block:
          $exists: false
      }
      {
        is_block: false
      }
    ]
  , opt, (err, tops) ->
    return next(err)  if err
    res.render "user/top100",
      users: tops

    return

  return

exports.list_topics = (req, res, next) ->
  user_name = req.params.name
  page = Number(req.query.page) or 1
  limit = config.list_topic_count
  User.getUserByName user_name, (err, user) ->
    unless user
      res.render "notify/notify",
        error: "这个用户不存在。"

      return
    render = (topics, relation, pages) ->
      user.friendly_create_at = Util.format_date(user.create_at, true)
      res.render "user/topics",
        user: user
        topics: topics
        relation: relation
        current_page: page
        pages: pages

      return

    proxy = new EventProxy()
    proxy.assign "topics", "relation", "pages", render
    proxy.fail next
    query = author_id: user._id
    opt =
      skip: (page - 1) * limit
      limit: limit
      sort: [[
        "create_at"
        "desc"
      ]]

    Topic.getTopicsByQuery query, opt, proxy.done("topics")
    unless req.session.user
      proxy.emit "relation", null
    else
      Relation.getRelation req.session.user._id, user._id, proxy.done("relation")
    Topic.getCountByQuery query, proxy.done((all_topics_count) ->
      pages = Math.ceil(all_topics_count / limit)
      proxy.emit "pages", pages
      return
    )
    return

  return

exports.list_replies = (req, res, next) ->
  user_name = req.params.name
  page = Number(req.query.page) or 1
  limit = config.list_topic_count
  User.getUserByName user_name, (err, user) ->
    unless user
      res.render "notify/notify",
        error: "这个用户不存在。"

      return
    render = (topics, relation, pages) ->
      user.friendly_create_at = Util.format_date(user.create_at, true)
      res.render "user/replies",
        user: user
        topics: topics
        relation: relation
        current_page: page
        pages: pages

      return

    proxy = new EventProxy()
    proxy.assign "topics", "relation", "pages", render
    proxy.fail next
    Reply.getRepliesByAuthorId user._id, proxy.done((replies) ->
      
      # 获取所有有评论的主题
      topic_ids = []
      i = 0

      while i < replies.length
        topic_ids.push replies[i].topic_id  if topic_ids.indexOf(replies[i].topic_id.toString()) < 0
        i++
      query = _id:
        $in: topic_ids

      opt =
        skip: (page - 1) * limit
        limit: limit
        sort: [[
          "create_at"
          "desc"
        ]]

      Topic.getTopicsByQuery query, opt, proxy.done("topics")
      Topic.getCountByQuery query, proxy.done((all_topics_count) ->
        pages = Math.ceil(all_topics_count / limit)
        proxy.emit "pages", pages
        return
      )
      return
    )
    unless req.session.user
      proxy.emit "relation", null
    else
      Relation.getRelation req.session.user._id, user._id, proxy.done("relation")
    return

  return

exports.block = (req, res, next) ->
  userName = req.params.name
  User.getUserByName userName, (err, user) ->
    return next(err)  if err
    if req.body.action is "set_block"
      ep = EventProxy.create()
      ep.fail next
      ep.all "block_user", "del_topics", "del_replys", (user, topics, replys) ->
        res.json status: "success"
        return

      user.is_block = true
      user.save ep.done("block_user")
      
      # TopicModel.remove({author_id: user._id}, ep.done('del_topics'));
      # ReplyModel.remove({author_id: user._id}, ep.done('del_replys'));
      ep.emit "del_topics"
      ep.emit "del_replys"
    else if req.body.action is "cancel_block"
      user.is_block = false
      user.save (err) ->
        return next(err)  if err
        res.json status: "success"
        return

    return

  return
