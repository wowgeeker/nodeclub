$ ->
  if typeof __google_search_domain is "string" and __google_search_domain isnt ""
    siteHost = __google_search_domain
  else if [
    "127.0.0.1"
    "localhost"
  ].indexOf(location.hostname) isnt -1
    siteHost = "cnodejs.org"
  else
    siteHost = location.hostname
  id = -1
  start = ->
    id = setInterval(check, 1000)
    return

  old = ""
  check = ->
    q = $in.val().trim()
    return  if q is "" or old is q
    old = q
    url = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=site:" + siteHost + "+" + q + "&callback=?"
    $.getJSON url, (d) ->
      return  unless d.responseData and Array.isArray(d.responseData.results)
      list = d.responseData.results
      showList list
      return

    return

  stop = ->
    clearInterval id
    $list.slideUp 500
    return

  $in = $("input#q")
  $in.attr "autocomplete", "off"
  $in.focusin(start).focusout stop
  $in.after("<div id=\"__quick_search_list\" style=\"display:none; z-index:1000; position:fixed; padding:8px; background-color:white; opacity:0.95; color:black; font-size:14px; line-height:1.8em; border:1px solid #AAA; width:500px; box-shadow:2px 2px 4px #AAA;\"></div>").after "<style>.__quick_search_list_item { border-bottom:1px solid #EEE; padding:4px 0px; }\n.__quick_search_list_item:last-child { border-bottom:none; }\n.__quick_search_list_item:hover { background-color:#EEE; }\n.__quick_search_list_item span { font-size:10px ;margin-left:20px; color:#333; }\n.__quick_search_list_item b { color:#DD4B39; font-weight:normal; margin:2px; }</style>"
  $list = $("#__quick_search_list")
  showList = (list) ->
    html = ""
    list.forEach (line) ->
      html += "<div class=\"__quick_search_list_item\"><a href=\"" + line.url + "\">" + line.title + "</a>" + "<span style=\"font-size:12px;\">" + line.content + "</span></div>"
      return

    html = "暂时没有相关结果。"  unless html
    o1 = $in.offset()
    o2 =
      top: o1.top + $in.height() + 10
      left: o1.left

    $list.offset(o2).html(html).show()
    return

  return

