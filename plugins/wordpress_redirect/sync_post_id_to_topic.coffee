#!
# * Sync post id to topic by title.
# * 
# * Usage: node sync_post_id_to_topic.js wordpress.json
# * 
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 

###
Module dependencies.
###
sync = (post, callback) ->
  title = post.post_title
  return callback()  if not title or post.post_type isnt "post"
  Topic.findOne
    title: title
  , (err, topic) ->
    return callback(err)  if err
    
    # console.log('%s %s not found', post.id, title);
    return callback()  unless topic
    r = new PostToTopic()
    r._id = post.id
    r.topic_id = topic._id
    r.save()
    console.log "%s %s founed %s", post.id, title, topic._id
    callback()
    return

  return
next = (i) ->
  post = posts[i]
  process.exit 0  unless post
  sync post, (err) ->
    throw err  if err
    next --i
    return

  return
PostToTopic = require("./model").PostToTopic
Topic = require("../../models").Topic
path = require("path")
posts = require(path.join(process.cwd(), process.argv[2]))
next posts.length - 1
