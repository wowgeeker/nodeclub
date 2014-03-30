Message = require("../../proxy/message")
should = require("should")
describe "proxy/message.js", ->
  xdescribe "getMessagesCount", ->
    it "should ok", (done) ->
      Message.getMessagesCount "4fd5efe5dbf01e466c000002", (err, count) ->
        should.not.exist err
        count.should.be.above 0
        done()
        return

      return

    return

  xdescribe "getMessageById", ->
    it "should ok with at", (done) ->
      Message.getMessageById "5123c4a34cbcd5cc9300000d", (err, message) ->
        should.not.exist err
        message.type.should.be.equal "at"
        message.topic_id.toString().should.be.equal "4fb9db9c1dc2160000000005"
        message.author_id.toString().should.be.equal "4fcae41e1eb86c0000000003"
        done()
        return

      return

    it "should ok with follow", (done) ->
      
      # TODO: follow message
      # message.getMessageById('5123c4a34cbcd5cc9300000d', function (err, message) {
      #   should.not.exist(err);
      #   message.type.should.be.equal('');
      #   message.topic_id.toString().should.be.equal('4fb9db9c1dc2160000000005');
      #   message.author_id.toString().should.be.equal('4fcae41e1eb86c0000000003');
      done()
      return

    
    # });
    describe "mock User.getUserById", ->

    describe "mock Topic.getTopicById", ->

    return

  xdescribe "getMessagesByUserId", ->
    it "should ok", (done) ->
      Message.getMessagesByUserId "4fd5efe5dbf01e466c000002", (err, messages) ->
        should.not.exist err
        messages.length.should.be.above 10
        messages.forEach (message) ->
          message.should.have.property "topic_id"
          message.should.have.property "author_id"
          message.should.have.property "master_id"
          message.should.have.property "type"
          return

        done()
        return

      return

    return

  xdescribe "getUnreadMessageByUserId", ->
    it "should ok", (done) ->
      Message.getUnreadMessageByUserId "4fd5efe5dbf01e466c000002", (err, messages) ->
        should.not.exist err
        messages.length.should.be.above 10
        messages.forEach (message) ->
          message.should.have.property "topic_id"
          message.should.have.property "author_id"
          message.should.have.property "master_id"
          message.should.have.property "type"
          return

        done()
        return

      return

    return

  return

