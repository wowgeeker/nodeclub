models = require("../models")
User = models.User

###
根据用户名列表查找用户列表
Callback:
- err, 数据库异常
- users, 用户列表
@param {Array} names 用户名列表
@param {Function} callback 回调函数
###
exports.getUsersByNames = (names, callback) ->
  return callback(null, [])  if names.length is 0
  User.find
    name:
      $in: names
  , callback
  return


###
根据登录名查找用户
Callback:
- err, 数据库异常
- user, 用户
@param {String} loginName 登录名
@param {Function} callback 回调函数
###
exports.getUserByLoginName = (loginName, callback) ->
  User.findOne
    loginname: loginName
  , callback
  return


###
根据用户ID，查找用户
Callback:
- err, 数据库异常
- user, 用户
@param {String} id 用户ID
@param {Function} callback 回调函数
###
exports.getUserById = (id, callback) ->
  User.findOne
    _id: id
  , callback
  return


###
根据用户名，查找用户
Callback:
- err, 数据库异常
- user, 用户
@param {String} name 用户名
@param {Function} callback 回调函数
###
exports.getUserByName = (name, callback) ->
  User.findOne
    name: name
  , callback
  return


###
根据邮箱，查找用户
Callback:
- err, 数据库异常
- user, 用户
@param {String} email 邮箱地址
@param {Function} callback 回调函数
###
exports.getUserByMail = (email, callback) ->
  User.findOne
    email: email
  , callback
  return


###
根据用户ID列表，获取一组用户
Callback:
- err, 数据库异常
- users, 用户列表
@param {Array} ids 用户ID列表
@param {Function} callback 回调函数
###
exports.getUsersByIds = (ids, callback) ->
  User.find
    _id:
      $in: ids
  , callback
  return


###
根据关键字，获取一组用户
Callback:
- err, 数据库异常
- users, 用户列表
@param {String} query 关键字
@param {Object} opt 选项
@param {Function} callback 回调函数
###
exports.getUsersByQuery = (query, opt, callback) ->
  User.find query, [], opt, callback
  return


###
根据查询条件，获取一个用户
Callback:
- err, 数据库异常
- user, 用户
@param {String} name 用户名
@param {String} key 激活码
@param {Function} callback 回调函数
###
exports.getUserByQuery = (name, key, callback) ->
  User.findOne
    name: name
    retrieve_key: key
  , callback
  return

exports.newAndSave = (name, loginname, pass, email, avatar_url, active, callback) ->
  user = new User()
  user.name = name
  user.loginname = loginname
  user.pass = pass
  user.email = email
  user.avatar = avatar_url
  user.active = false
  user.save callback
  return
