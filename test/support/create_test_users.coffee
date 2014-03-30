#!
# * nodeclub - Create test users for unit tests.
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 

###
Module dependencies.
###
User = require("../../models").User
exports.createUsers = (callback) ->
  names = [
    "testuser1"
    "testuser2"
    "testuser3"
  ]
  count = 0
  names.forEach (name) ->
    User.findOne
      loginname: name
    , (err, user) ->
      unless user
        user = new User(
          loginname: name
          name: name
          pass: name + "123"
          email: name + "@localhost.cnodejs.org"
        )
        user.save ->
          
          # console.log(arguments);
          count++
          callback()  if count is names.length
          return

      else
        count++
        callback()  if count is names.length
      return

    return

  return
