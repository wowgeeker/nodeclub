#!
# * nodeclub - common/render_helpers.js
# * Copyright(c) 2013 fengmk2 <fengmk2@gmail.com>
# * MIT Licensed
# 
"use strict"

###
Module dependencies.
###
marked = require("marked-prettyprint")
utils = require("../libs/util")

# Set default options
marked.setOptions
  gfm: true
  tables: true
  breaks: true
  pedantic: false
  sanitize: false
  smartLists: true
  codeClass: "prettyprint"
  langPrefix: "language-"

exports.markdown = ->
  (text) ->
    "<div class=\"markdown-text\">" + utils.xss(marked(text or "")) + "</div>"

exports.csrf = (req, res) ->
  (if req.session then req.session._csrf else "")
