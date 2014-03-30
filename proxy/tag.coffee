models = require("../models")
Tag = models.Tag
exports.getTagByName = (name, callback) ->
  Tag.findOne
    name: name
  , callback
  return


###
根据标签ID列表，获取一组标签
Callback:
- err, 数据库异常
- tags, 标签列表
@param {Array} ids 标签ID列表
@param {Function} callback 回调函数
###
exports.getTagsByIds = (ids, callback) ->
  Tag.find
    _id:
      $in: ids
  , callback
  return


###
获取所有标签
Callback:
- err, 数据库异常
- tags, 标签列表
@param {Function} callback 回调函数
###
exports.getAllTags = (callback) ->
  Tag.find {}, [],
    sort: [[
      "order"
      "asc"
    ]]
  , callback
  return


###
根据标签ID获取标签
Callback:
- err, 数据库异常
- tag, 标签
@param {String} id 标签ID
@param {Function} callback 回调函数
###
exports.getTagById = (id, callback) ->
  Tag.findOne
    _id: id
  , callback
  return

exports.update = (tag, name, background, order, description, callback) ->
  tag.name = name
  tag.order = order
  tag.background = background
  tag.description = description
  tag.save callback
  return

exports.newAndSave = (name, background, order, description, callback) ->
  tag = new Tag()
  tag.name = name
  tag.background = background
  tag.order = order
  tag.description = description
  tag.save callback
  return
