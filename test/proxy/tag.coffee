Tag = require("../../proxy/tag")
support = require("../support/support")
should = require("should")
describe "proxy/tag.js", ->
  describe "newAndSave", ->
    it "should ok", (done) ->
      Tag.newAndSave "name", "background", 1, "description", (err, tag) ->
        should.not.exist err
        tag.should.have.property "name", "name"
        tag.should.have.property "description", "description"
        tag.should.have.property "background", "background"
        tag.should.have.property "topic_count"
        tag.should.have.property "collect_count"
        tag.should.have.property "order"
        done()
        return

      return

    return

  describe "getTagByName", ->
    tag = undefined
    before (done) ->
      support.createTag (err, tag1) ->
        should.not.exist err
        tag = tag1
        done()
        return

      return

    it "should ok", (done) ->
      Tag.getTagByName tag.name, (err, tag1) ->
        should.not.exist err
        tag1.should.have.property "name", tag.name
        tag1.should.have.property "description", tag.description
        tag1.should.have.property "background", tag.background
        tag1.should.have.property "topic_count"
        tag1.should.have.property "collect_count"
        tag1.should.have.property "order"
        done()
        return

      return

    return

  describe "getTagsByIds", ->
    tag = undefined
    before (done) ->
      support.createTag (err, tag1) ->
        should.not.exist err
        tag = tag1
        done()
        return

      return

    it "should ok with empty", (done) ->
      Tag.getTagsByIds [], (err, tags) ->
        should.not.exist err
        tags.should.have.length 0
        done()
        return

      return

    it "should ok", (done) ->
      Tag.getTagsByIds [tag._id], (err, tags) ->
        should.not.exist err
        tags.should.have.length 1
        tag1 = tags[0]
        tag1.should.have.property "name", tag.name
        tag1.should.have.property "description", tag.description
        tag1.should.have.property "background", tag.background
        tag1.should.have.property "topic_count"
        tag1.should.have.property "collect_count"
        tag1.should.have.property "order"
        done()
        return

      return

    return

  describe "getAllTags", ->
    it "should ok", (done) ->
      Tag.getAllTags (err, list) ->
        should.not.exist err
        list.length.should.be.above 0
        done()
        return

      return

    return

  describe "getTagById", ->
    tag = undefined
    before (done) ->
      support.createTag (err, tag1) ->
        should.not.exist err
        tag = tag1
        done()
        return

      return

    it "should ok", (done) ->
      Tag.getTagById tag._id, (err, tag1) ->
        should.not.exist err
        tag1.should.have.property "name", tag.name
        tag1.should.have.property "description", tag.description
        tag1.should.have.property "background", tag.background
        tag1.should.have.property "topic_count"
        tag1.should.have.property "collect_count"
        tag1.should.have.property "order"
        done()
        return

      return

    return

  describe "update", ->
    tag = undefined
    before (done) ->
      support.createTag (err, tag1) ->
        should.not.exist err
        tag = tag1
        done()
        return

      return

    it "should ok", (done) ->
      Tag.update tag, "newname", "newbackground", 10, "newdescription", (err, tag1) ->
        should.not.exist err
        tag1.should.have.property "name", "newname"
        tag1.should.have.property "description", "newdescription"
        tag1.should.have.property "background", "newbackground"
        tag1.should.have.property "topic_count"
        tag1.should.have.property "collect_count"
        tag1.should.have.property "order"
        done()
        return

      return

    return

  return

