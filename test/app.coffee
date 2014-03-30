app = require("../app")
describe "app.js", ->
  before (done) ->
    app.listen 0, done
    return

  after ->
    app.close()
    return

  it "should / status 200", (done) ->
    app.request().get("/").end (res) ->
      res.should.status 200
      done()
      return

    return

  return

