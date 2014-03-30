User = require("../../proxy/user")
should = require("should")
support = require("../support/support")
describe "proxy/user.js", ->
  describe "getUserByLoginName", ->
    it "should ok", (done) ->
      User.getUserByLoginName "jacksontian", (err, user) ->
        should.not.exist err
        
        # TODO: check user
        done()
        return

      return

    return

  describe "getUserByMail", ->
    it "should ok", (done) ->
      User.getUserByMail "shyvo1987@gmail.com", (err, user) ->
        should.not.exist err
        
        # TODO: check user
        done()
        return

      return

    return

  describe "getUsersByIds", ->
    user = undefined
    before (done) ->
      support.createUser (err, user1) ->
        should.not.exist err
        user = user1
        done()
        return

      return

    it "should ok with empty list", (done) ->
      User.getUsersByIds [], (err, list) ->
        should.not.exist err
        list.should.have.length 0
        done()
        return

      return

    it "should ok", (done) ->
      User.getUsersByIds [user._id], (err, list) ->
        should.not.exist err
        list.should.have.length 1
        user1 = list[0]
        user1.name.should.be.equal user.name
        done()
        return

      return

    return

  describe "getUserByQuery", ->
    user = undefined
    before (done) ->
      support.createUser (err, user1) ->
        should.not.exist err
        user = user1
        done()
        return

      return

    it "should not exist", (done) ->
      User.getUserByQuery "name", "key", (err, user) ->
        should.not.exist err
        should.not.exist user
        done()
        return

      return

    it "should exist", (done) ->
      User.getUserByQuery user.name, null, (err, user1) ->
        should.not.exist err
        should.exist user1
        user1.name.should.be.equal user.name
        done()
        return

      return

    return

  return

