should = require("should")
app = require("../../app")
describe "controllers/message.js", ->
  before (done) ->
    app.listen 0, done
    return

  after ->
    app.close()
    return

  describe "index", ->
    it "should 302 without session", (done) ->
      app.request().get("/my/messages").end (res) ->
        res.statusCode.should.equal 302
        res.headers.should.have.property "content-type", "text/html"
        res.headers.should.have.property "location"
        done()
        return

      return

    return

  return

