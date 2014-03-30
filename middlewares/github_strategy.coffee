Models = require("../models")
User = Models.User
module.exports = (accessToken, refreshToken, profile, done) ->
  profile.accessToken = accessToken
  done null, profile
  return
