app = require("../../app")
describe "controllers/status.js", ->
  before (done) ->
    app.listen 0, done
    return

  after ->
    app.close()
    return

  it "should /status 200", (done) ->
    app.request().get("/status").end (res) ->
      res.should.status 200
      res.should.header "content-type", "application/json; charset=utf-8"
      json = undefined
      try
        json = JSON.parse(res.body.toString())
      catch e
        done e
      json.should.have.property "status", "success"
      json.should.have.property "now"
      done()
      return

    return

  return

