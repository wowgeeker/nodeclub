xss = require("xss")
exports.format_date = (date, friendly) ->
  year = date.getFullYear()
  month = date.getMonth() + 1
  day = date.getDate()
  hour = date.getHours()
  minute = date.getMinutes()
  second = date.getSeconds()
  if friendly
    now = new Date()
    mseconds = -(date.getTime() - now.getTime())
    time_std = [
      1000
      60 * 1000
      60 * 60 * 1000
      24 * 60 * 60 * 1000
    ]
    if mseconds < time_std[3]
      return Math.floor(mseconds / time_std[0]).toString() + " 秒前"  if mseconds > 0 and mseconds < time_std[1]
      return Math.floor(mseconds / time_std[1]).toString() + " 分钟前"  if mseconds > time_std[1] and mseconds < time_std[2]
      return Math.floor(mseconds / time_std[2]).toString() + " 小时前"  if mseconds > time_std[2]
  
  #month = ((month < 10) ? '0' : '') + month;
  #day = ((day < 10) ? '0' : '') + day;
  hour = ((if (hour < 10) then "0" else "")) + hour
  minute = ((if (minute < 10) then "0" else "")) + minute
  second = ((if (second < 10) then "0" else "")) + second
  thisYear = new Date().getFullYear()
  year = (if (thisYear is year) then "" else (year + "-"))
  year + month + "-" + day + " " + hour + ":" + minute


###
Escape the given string of `html`.

@param {String} html
@return {String}
@api private
###
exports.escape = (html) ->
  codeSpan = /(^|[^\\])(`+)([^\r]*?[^`])\2(?!`)/g
  codeBlock = /(?:\n\n|^)((?:(?:[ ]{4}|\t).*\n+)+)(\n*[ ]{0,3}[^ \t\n]|(?=~0))/g
  spans = []
  blocks = []
  text = String(html).replace(/\r\n/g, "\n").replace("/\r/g", "\n")
  text = "\n\n" + text + "\n\n"
  text = text.replace(codeSpan, (code) ->
    spans.push code
    "`span`"
  )
  text += "~0"
  text.replace(codeBlock, (whole, code, nextChar) ->
    blocks.push code
    "\n\tblock" + nextChar
  ).replace(/&(?!\w+;)/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/`span`/g, ->
    spans.shift()
  ).replace(/\n\tblock/g, ->
    blocks.shift()
  ).replace(/~0$/, "").replace(/^\n\n/, "").replace /\n\n$/, ""


###
XSS模块配置
###
xssOptions = whiteList:
  h1: []
  h2: []
  h3: []
  h4: []
  h5: []
  h6: []
  hr: []
  span: []
  strong: []
  b: []
  i: []
  br: []
  p: []
  pre: ["class"]
  code: []
  a: [
    "target"
    "href"
    "title"
  ]
  img: [
    "src"
    "alt"
    "title"
  ]
  div: []
  table: [
    "width"
    "border"
  ]
  tr: []
  td: [
    "width"
    "colspan"
  ]
  th: [
    "width"
    "colspan"
  ]
  tbody: []
  thead: []
  ul: []
  li: []
  ol: []
  dl: []
  dt: []
  em: []
  cite: []
  section: []
  header: []
  footer: []
  blockquote: []
  audio: [
    "autoplay"
    "controls"
    "loop"
    "preload"
    "src"
  ]
  video: [
    "autoplay"
    "controls"
    "loop"
    "preload"
    "src"
    "height"
    "width"
  ]


###
过滤XSS攻击代码

@param {string} html
@return {string}
###
exports.xss = (html) ->
  xss html, xssOptions
