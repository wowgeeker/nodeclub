TagCollect = require("../../proxy/tag_collect")
support = require("../support/support")
should = require("should")
pedding = require("pedding")
describe "proxy/tag.js", ->
  user = undefined
  tag = undefined
  before (done) ->
    done = pedding(2, done)
    support.createUser (err, _user) ->
      should.not.exist err
      should.exist _user
      user = _user
      done()
      return

    support.createTag (err, _tag) ->
      should.not.exist err
      should.exist _tag
      tag = _tag
      done()
      return

    return

  describe "newAndSave", ->
    it "should ok", (done) ->
      TagCollect.newAndSave user._id, tag._id, (err, collect) ->
        should.not.exist err
        collect.should.have.property "user_id", user._id
        collect.should.have.property "tag_id", tag._id
        done()
        return

      return

    return

  describe "getTagCollect", ->
    it "should ok", (done) ->
      TagCollect.getTagCollect user._id, tag._id, (err, collect) ->
        should.not.exist err
        collect.user_id.should.be.eql user._id
        collect.tag_id.should.be.eql tag._id
        done()
        return

      return

    return

  describe "getTagCollectsByUserId", ->
    it "should ok", (done) ->
      TagCollect.getTagCollectsByUserId user._id, (err, list) ->
        should.not.exist err
        list.should.have.length 1
        collect = list[0]
        collect.user_id.should.be.eql user._id
        collect.tag_id.should.be.eql tag._id
        done()
        return

      return

    return

  describe "remove", ->
    it "should ok", (done) ->
      TagCollect.remove user._id, tag._id, (err, ok) ->
        should.not.exist err
        should.exist ok
        done()
        return

      return

    return

  describe "removeAllByTagId", ->
    user = undefined
    user2 = undefined
    tag = undefined
    before (done) ->
      next = pedding(3, ->
        next = pedding(2, done)
        TagCollect.newAndSave user._id, tag._id, (err, collect) ->
          should.not.exist err
          next()
          return

        TagCollect.newAndSave user2._id, tag._id, (err, collect) ->
          should.not.exist err
          next()
          return

        return
      )
      support.createUser (err, _user) ->
        should.not.exist err
        should.exist _user
        user = _user
        next()
        return

      support.createUser (err, _user) ->
        should.not.exist err
        should.exist _user
        user2 = _user
        next()
        return

      support.createTag (err, _tag2) ->
        should.not.exist err
        should.exist _tag2
        tag = _tag2
        next()
        return

      return

    it "should ok", (done) ->
      TagCollect.removeAllByTagId tag._id, (err, ok) ->
        should.not.exist err
        should.exist ok
        done()
        return

      return

    return

  return

