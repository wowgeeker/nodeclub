relation = require("../../proxy/relation")
support = require("../support/support")
should = require("should")
describe "proxy/relation.js", ->
  star = undefined
  fan = undefined
  before (done) ->
    support.createUser (err, user1) ->
      should.not.exist err
      support.createUser (err, user2) ->
        should.not.exist err
        relation.newAndSave user1._id, user2._id, (err) ->
          star = user1
          fan = user2
          done err
          return

        return

      return

    return

  describe "getRelation", ->
    it "should ok", (done) ->
      relation.getRelation star._id, fan._id, (err, rel) ->
        should.not.exist err
        rel.follow_id.toString().should.be.equal fan._id.toString()
        rel.user_id.toString().should.be.equal star._id.toString()
        done()
        return

      return

    return

  describe "getRelationsByUserId", ->
    it "should ok", (done) ->
      relation.getRelationsByUserId fan._id, (err, list) ->
        should.not.exist err
        list.should.have.length 1
        rel = list[0]
        rel.follow_id.toString().should.be.equal fan._id.toString()
        rel.user_id.toString().should.be.equal star._id.toString()
        done()
        return

      return

    return

  describe "getFollowings", ->
    it "should ok", (done) ->
      relation.getFollowings star._id, (err, list) ->
        should.not.exist err
        list.should.have.length 1
        rel = list[0]
        rel.follow_id.toString().should.be.equal fan._id.toString()
        rel.user_id.toString().should.be.equal star._id.toString()
        done()
        return

      return

    return

  describe "remove", ->
    it "should ok", (done) ->
      relation.remove star._id, fan._id, (err, ok) ->
        should.not.exist err
        should.exist ok
        done()
        return

      return

    return

  return

