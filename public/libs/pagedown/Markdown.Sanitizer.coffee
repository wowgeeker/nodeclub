(->
  # we're in a CommonJS (e.g. Node.js) module
  sanitizeHtml = (html) ->
    html.replace /<[^>]*>?/g, sanitizeTag
  
  # (tags that can be opened/closed) | (tags that stand alone)
  
  # <a href="url..." optional title>|</a>
  
  # <img src="url..." optional width  optional height  optional alt  optional title
  sanitizeTag = (tag) ->
    if tag.match(basic_tag_whitelist) or tag.match(a_white) or tag.match(img_white)
      tag
    else
      ""
  
  #/ <summary>
  #/ attempt to balance HTML tags in the html string
  #/ by removing any unmatched opening or closing tags
  #/ IMPORTANT: we *assume* HTML has *already* been 
  #/ sanitized and is safe/sane before balancing!
  #/ 
  #/ adapted from CODESNIPPET: A8591DBA-D1D3-11DE-947C-BA5556D89593
  #/ </summary>
  balanceTags = (html) ->
    return ""  if html is ""
    re = /<\/?\w+[^>]*(\s|$|>)/g
    
    # convert everything to lower case; this makes
    # our case insensitive comparisons easier
    tags = html.toLowerCase().match(re)
    
    # no HTML tags present? nothing to do; exit now
    tagcount = (tags or []).length
    return html  if tagcount is 0
    tagname = undefined
    tag = undefined
    ignoredtags = "<p><img><br><li><hr>"
    match = undefined
    tagpaired = []
    tagremove = []
    needsRemoval = false
    
    # loop through matched tags in forward order
    ctag = 0

    while ctag < tagcount
      tagname = tags[ctag].replace(/<\/?(\w+).*/, "$1")
      
      # skip any already paired tags
      # and skip tags in our ignore list; assume they're self-closed
      continue  if tagpaired[ctag] or ignoredtags.search("<" + tagname + ">") > -1
      tag = tags[ctag]
      match = -1
      unless /^<\//.test(tag)
        
        # this is an opening tag
        # search forwards (next tags), look for closing tags
        ntag = ctag + 1

        while ntag < tagcount
          if not tagpaired[ntag] and tags[ntag] is "</" + tagname + ">"
            match = ntag
            break
          ntag++
      if match is -1
        needsRemoval = tagremove[ctag] = true # mark for removal
      else # mark paired
        tagpaired[match] = true
      ctag++
    return html  unless needsRemoval
    
    # delete all orphaned tags from the string
    ctag = 0
    html = html.replace(re, (match) ->
      res = (if tagremove[ctag] then "" else match)
      ctag++
      res
    )
    html
  output = undefined
  Converter = undefined
  if typeof exports is "object" and typeof require is "function"
    output = exports
    Converter = require("./Markdown.Converter").Converter
  else
    output = window.Markdown
    Converter = output.Converter
  output.getSanitizingConverter = ->
    converter = new Converter()
    converter.hooks.chain "postConversion", sanitizeHtml
    converter.hooks.chain "postConversion", balanceTags
    converter

  basic_tag_whitelist = /^(<\/?(b|blockquote|code|del|dd|dl|dt|em|h1|h2|h3|i|kbd|li|ol|p|pre|s|sup|sub|strong|strike|ul)>|<(br|hr)\s?\/?>)$/i
  a_white = /^(<a\shref="((https?|ftp):\/\/|\/)[-A-Za-z0-9+&@#\/%?=~_|!:,.;\(\)]+"(\stitle="[^"<>]+")?\s?>|<\/a>)$/i
  img_white = /^(<img\ssrc="(https?:\/\/|\/)[-A-Za-z0-9+&@#\/%?=~_|!:,.;\(\)]+"(\swidth="\d{1,3}")?(\sheight="\d{1,3}")?(\salt="[^"<>]*")?(\stitle="[^"<>]*")?\s?\/?>)$/i
  return
)()
