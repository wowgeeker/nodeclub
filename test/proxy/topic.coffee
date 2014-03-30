Topic = require("../../proxy/topic")
support = require("../support/support")
should = require("should")
describe "proxy/topic.js", ->
  user = undefined
  topic = undefined
  before (done) ->
    support.createUser (err, _user) ->
      should.not.exist err
      user = _user
      support.createTopic _user._id, (err, _topic) ->
        should.not.exist err
        topic = _topic
        done()
        return

      return

    return

  describe "updateLastReply()", ->
    it "should update a topic reply count success when topic not exists", (done) ->
      Topic.updateLastReply "aaaaaaaaaaaaaaaaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaa", (err, result) ->
        should.not.exist err
        should.not.exist result
        done()
        return

      return

    return

  describe "newAndSave", ->
    it "should ok", (done) ->
      Topic.newAndSave "title", "content", user._id, (err, topic) ->
        should.not.exist err
        topic.title.should.equal "title"
        topic.content.should.equal "content"
        done()
        return

      return

    return

  describe "getTopicById", ->
    it "should empty", (done) ->
      Topic.getTopicById null, (err, topic, tags, author, lastReply) ->
        should.not.exist err
        should.not.exist topic
        tags.should.have.length 0
        should.not.exist author
        should.not.exist lastReply
        done()
        return

      return

    it "should ok", (done) ->
      Topic.getTopicById topic._id, (err, topic, tags, author, lastReply) ->
        should.not.exist err
        should.exist topic
        tags.should.have.length 0
        author.loginname.should.equal user.loginname
        should.not.exist lastReply
        done()
        return

      return

    return

  describe "getFullTopic", ->
    it "should empty", (done) ->
      Topic.getFullTopic null, (err, message, topic, tags, author, replies) ->
        should.not.exist err
        message.should.be.equal "此话题不存在或已被删除。"
        done()
        return

      return

    it "should ok", (done) ->
      Topic.getFullTopic topic._id, (err, message, topic, tags, author, replies) ->
        should.not.exist err
        message.should.be.equal ""
        topic.author_id.should.eql user._id
        tags.should.have.length 0
        author.loginname.should.be.equal user.loginname
        replies.should.have.length 0
        done()
        return

      return

    return

  describe "getTopic", ->
    it "should empty", (done) ->
      Topic.getTopic null, (err, topic) ->
        should.not.exist err
        should.not.exist topic
        done()
        return

      return

    it "should ok", (done) ->
      Topic.getTopic topic._id, (err, topic) ->
        should.not.exist err
        topic.author_id.should.eql user._id
        done()
        return

      return

    return

  describe "reduceCount", ->
    it "should empty", (done) ->
      Topic.reduceCount null, (err, topic) ->
        should.exist err
        err.should.have.property "message", "该主题不存在"
        should.not.exist topic
        done()
        return

      return

    it "should ok", (done) ->
      count = topic.reply_count
      Topic.reduceCount topic._id, (err, topic) ->
        should.not.exist err
        topic.reply_count.should.equal count - 1
        done()
        return

      return

    return

  return

