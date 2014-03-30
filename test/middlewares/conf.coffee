conf = require("../../middlewares/conf")
config = require("../../config")
describe "middlewares/conf.js", ->
  it "should alert no github oauth", (done) ->
    _clientID = config.GITHUB_OAUTH.clientID
    config.GITHUB_OAUTH.clientID = "your GITHUB_CLIENT_ID"
    conf.github {},
      send: (str) ->
        str.should.equal "call the admin to set github oauth."
        config.GITHUB_OAUTH.clientID = _clientID
        done()
        return

    return

  return

