models = require("../models")
Relation = models.Relation

###
查找关注关系
@param {ID} userId 被关注人的id
@param {ID} followId 关注人的id
###
exports.getRelation = (userId, followId, callback) ->
  Relation.findOne
    user_id: userId
    follow_id: followId
  , callback
  return


###
根据用户查找用户的偶像们
@param {ID} followId 关注人的id
###
exports.getRelationsByUserId = (followId, callback) ->
  Relation.find
    follow_id: followId
  , callback
  return


###
根据用户查找粉丝们
@param {ID} userId 被关注人的id
###
exports.getFollowings = (userId, callback) ->
  Relation.find
    user_id: userId
  , callback
  return


###
创建新的关注关系
@param {ID} userId 被关注人的id
@param {ID} followId 关注人的id
###
exports.newAndSave = (userId, followId, callback) ->
  relation = new Relation()
  relation.user_id = userId
  relation.follow_id = followId
  relation.save callback
  return


###
删除的关注关系
@param {ID} userId 被关注人的id
@param {ID} followId 关注人的id
###
exports.remove = (userId, followId, callback) ->
  Relation.remove
    user_id: userId
    follow_id: followId
  , callback
  return
