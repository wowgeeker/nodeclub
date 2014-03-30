# static page
# About
exports.about = (req, res, next) ->
  res.render "static/about"
  return


# FAQ
exports.faq = (req, res, next) ->
  res.render "static/faq"
  return
