#!
# * nodeclub - One host only
# * 
# * Redirect `HTTP GET` for `club.cnodejs.org` and `www.cnodejs.org` to `cnodejs.org`.
# * 
# * Copyright(c) 2012 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 

###
Module dependencies.
###
module.exports = onehost = (options) ->
  options = options or {}
  host = options.host
  exclude = options.exclude or []
  exclude = [exclude]  unless Array.isArray(exclude)
  exclude.push host  if host
  (req, res, next) ->
    return next()  if not host or exclude.indexOf(req.headers.host) >= 0 or req.method isnt "GET"
    res.writeHead 301,
      Location: "http://" + host + req.url

    res.end()
    return
