config = require("../config").config
convert = require("data2xml")()
markdown = require("node-markdown").Markdown
Topic = require("../proxy").Topic
exports.index = (req, res, next) ->
  unless config.rss
    res.statusCode = 404
    return res.send("Please set `rss` in config.js")
  opt =
    limit: config.rss.max_rss_items
    sort: [[
      "create_at"
      "desc"
    ]]

  Topic.getTopicsByQuery {}, opt, (err, topics) ->
    return next(err)  if err
    rss_obj =
      _attr:
        version: "2.0"

      channel:
        title: config.rss.title
        link: config.rss.link
        language: config.rss.language
        description: config.rss.description
        item: []

    topics.forEach (topic) ->
      rss_obj.channel.item.push
        title: topic.title
        link: config.rss.link + "/topic/" + topic._id
        guid: config.rss.link + "/topic/" + topic._id
        description: markdown(topic.content, true)
        author: topic.author.name
        pubDate: topic.create_at.toUTCString()

      return

    rss_content = convert("rss", rss_obj)
    res.contentType "application/xml"
    res.send rss_content
    return

  return
