config = require("../config").config
exports.github = (req, res, next) ->
  return res.send("call the admin to set github oauth.")  if config.GITHUB_OAUTH.clientID is "your GITHUB_CLIENT_ID"
  next()
  return
