#
# * FancyBox - jQuery Plugin
# * Simple and fancy lightbox alternative
# *
# * Examples and documentation at: http://fancybox.net
# * 
# * Copyright (c) 2008 - 2010 Janis Skarnelis
# * That said, it is hardly a one-person project. Many people have submitted bugs, code, and offered their advice freely. Their support is greatly appreciated.
# * 
# * Version: 1.3.4 (11/11/2010)
# * Requires: jQuery v1.3+
# *
# * Dual licensed under the MIT and GPL licenses:
# *   http://www.opensource.org/licenses/mit-license.php
# *   http://www.gnu.org/licenses/gpl.html
# 
((b) ->
  m = undefined
  t = undefined
  u = undefined
  f = undefined
  D = undefined
  j = undefined
  E = undefined
  n = undefined
  z = undefined
  A = undefined
  q = 0
  e = {}
  o = []
  p = 0
  d = {}
  l = []
  G = null
  v = new Image
  J = /\.(jpg|gif|png|bmp|jpeg)(.*)?$/i
  W = /[^\.]\.(swf)\s*$/i
  K = undefined
  L = 1
  y = 0
  s = ""
  r = undefined
  i = undefined
  h = false
  B = b.extend(b("<div/>")[0],
    prop: 0
  )
  M = b.browser.msie and b.browser.version < 7 and not window.XMLHttpRequest
  N = ->
    t.hide()
    v.onerror = v.onload = null
    G and G.abort()
    m.empty()
    return

  O = ->
    if false is e.onError(o, q, e)
      t.hide()
      h = false
    else
      e.titleShow = false
      e.width = "auto"
      e.height = "auto"
      m.html "<p id=\"fancybox-error\">The requested content cannot be loaded.<br />Please try again later.</p>"
      F()
    return

  I = ->
    a = o[q]
    c = undefined
    g = undefined
    k = undefined
    C = undefined
    P = undefined
    w = undefined
    N()
    e = b.extend({}, b.fn.fancybox.defaults, (if typeof b(a).data("fancybox") is "undefined" then e else b(a).data("fancybox")))
    w = e.onStart(o, q, e)
    if w is false
      h = false
    else
      e = b.extend(e, w)  if typeof w is "object"
      k = e.title or ((if a.nodeName then b(a).attr("title") else a.title)) or ""
      e.orig = (if b(a).children("img:first").length then b(a).children("img:first") else b(a))  if a.nodeName and not e.orig
      k = e.orig.attr("alt")  if k is "" and e.orig and e.titleFromAlt
      c = e.href or ((if a.nodeName then b(a).attr("href") else a.href)) or null
      c = null  if /^(?:javascript)/i.test(c) or c is "#"
      if e.type
        g = e.type
        c = e.content  unless c
      else if e.content
        g = "html"
      else g = (if c.match(J) then "image" else (if c.match(W) then "swf" else (if b(a).hasClass("iframe") then "iframe" else (if c.indexOf("#") is 0 then "inline" else "ajax"))))  if c
      if g
        if g is "inline"
          a = c.substr(c.indexOf("#"))
          g = (if b(a).length > 0 then "inline" else "ajax")
        e.type = g
        e.href = c
        e.title = k
        if e.autoDimensions
          if e.type is "html" or e.type is "inline" or e.type is "ajax"
            e.width = "auto"
            e.height = "auto"
          else
            e.autoDimensions = false
        if e.modal
          e.overlayShow = true
          e.hideOnOverlayClick = false
          e.hideOnContentClick = false
          e.enableEscapeButton = false
          e.showCloseButton = false
        e.padding = parseInt(e.padding, 10)
        e.margin = parseInt(e.margin, 10)
        m.css "padding", e.padding + e.margin
        b(".fancybox-inline-tmp").unbind("fancybox-cancel").bind "fancybox-change", ->
          b(this).replaceWith j.children()
          return

        switch g
          when "html"
            m.html e.content
            F()
          when "inline"
            if b(a).parent().is("#fancybox-content") is true
              h = false
              break
            b("<div class=\"fancybox-inline-tmp\" />").hide().insertBefore(b(a)).bind("fancybox-cleanup", ->
              b(this).replaceWith j.children()
              return
            ).bind "fancybox-cancel", ->
              b(this).replaceWith m.children()
              return

            b(a).appendTo m
            F()
          when "image"
            h = false
            b.fancybox.showActivity()
            v = new Image
            v.onerror = ->
              O()
              return

            v.onload = ->
              h = true
              v.onerror = v.onload = null
              e.width = v.width
              e.height = v.height
              b("<img />").attr(
                id: "fancybox-img"
                src: v.src
                alt: e.title
              ).appendTo m
              Q()
              return

            v.src = c
          when "swf"
            e.scrolling = "no"
            C = "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"" + e.width + "\" height=\"" + e.height + "\"><param name=\"movie\" value=\"" + c + "\"></param>"
            P = ""
            b.each e.swf, (x, H) ->
              C += "<param name=\"" + x + "\" value=\"" + H + "\"></param>"
              P += " " + x + "=\"" + H + "\""
              return

            C += "<embed src=\"" + c + "\" type=\"application/x-shockwave-flash\" width=\"" + e.width + "\" height=\"" + e.height + "\"" + P + "></embed></object>"
            m.html C
            F()
          when "ajax"
            h = false
            b.fancybox.showActivity()
            e.ajax.win = e.ajax.success
            G = b.ajax(b.extend({}, e.ajax,
              url: c
              data: e.ajax.data or {}
              error: (x) ->
                x.status > 0 and O()
                return

              success: (x, H, R) ->
                if ((if typeof R is "object" then R else G)).status is 200
                  if typeof e.ajax.win is "function"
                    w = e.ajax.win(c, x, H, R)
                    if w is false
                      t.hide()
                      return
                    else x = w  if typeof w is "string" or typeof w is "object"
                  m.html x
                  F()
                return
            ))
          when "iframe"
            Q()
      else
        O()
    return

  F = ->
    a = e.width
    c = e.height
    a = (if a.toString().indexOf("%") > -1 then parseInt((b(window).width() - e.margin * 2) * parseFloat(a) / 100, 10) + "px" else (if a is "auto" then "auto" else a + "px"))
    c = (if c.toString().indexOf("%") > -1 then parseInt((b(window).height() - e.margin * 2) * parseFloat(c) / 100, 10) + "px" else (if c is "auto" then "auto" else c + "px"))
    m.wrapInner "<div style=\"width:" + a + ";height:" + c + ";overflow: " + ((if e.scrolling is "auto" then "auto" else (if e.scrolling is "yes" then "scroll" else "hidden"))) + ";position:relative;\"></div>"
    e.width = m.width()
    e.height = m.height()
    Q()
    return

  Q = ->
    a = undefined
    c = undefined
    t.hide()
    if f.is(":visible") and false is d.onCleanup(l, p, d)
      b.event.trigger "fancybox-cancel"
      h = false
    else
      h = true
      b(j.add(u)).unbind()
      b(window).unbind "resize.fb scroll.fb"
      b(document).unbind "keydown.fb"
      f.is(":visible") and d.titlePosition isnt "outside" and f.css("height", f.height())
      l = o
      p = q
      d = e
      if d.overlayShow
        u.css
          "background-color": d.overlayColor
          opacity: d.overlayOpacity
          cursor: (if d.hideOnOverlayClick then "pointer" else "auto")
          height: b(document).height()

        unless u.is(":visible")
          M and b("select:not(#fancybox-tmp select)").filter(->
            @style.visibility isnt "hidden"
          ).css(visibility: "hidden").one("fancybox-cleanup", ->
            @style.visibility = "inherit"
            return
          )
          u.show()
      else
        u.hide()
      i = X()
      s = d.title or ""
      y = 0
      n.empty().removeAttr("style").removeClass()
      if d.titleShow isnt false
        if b.isFunction(d.titleFormat)
          a = d.titleFormat(s, l, p, d)
        else
          a = (if s and s.length then (if d.titlePosition is "float" then "<table id=\"fancybox-title-float-wrap\" cellpadding=\"0\" cellspacing=\"0\"><tr><td id=\"fancybox-title-float-left\"></td><td id=\"fancybox-title-float-main\">" + s + "</td><td id=\"fancybox-title-float-right\"></td></tr></table>" else "<div id=\"fancybox-title-" + d.titlePosition + "\">" + s + "</div>") else false)
        s = a
        unless not s or s is ""
          n.addClass("fancybox-title-" + d.titlePosition).html(s).appendTo("body").show()
          switch d.titlePosition
            when "inside"
              n.css
                width: i.width - d.padding * 2
                marginLeft: d.padding
                marginRight: d.padding

              y = n.outerHeight(true)
              n.appendTo D
              i.height += y
            when "over"
              n.css(
                marginLeft: d.padding
                width: i.width - d.padding * 2
                bottom: d.padding
              ).appendTo D
            when "float"
              n.css("left", parseInt((n.width() - i.width - 40) / 2, 10) * -1).appendTo f
            else
              n.css(
                width: i.width - d.padding * 2
                paddingLeft: d.padding
                paddingRight: d.padding
              ).appendTo f
      n.hide()
      if f.is(":visible")
        b(E.add(z).add(A)).hide()
        a = f.position()
        r =
          top: a.top
          left: a.left
          width: f.width()
          height: f.height()

        c = r.width is i.width and r.height is i.height
        j.fadeTo d.changeFade, 0.3, ->
          g = ->
            j.html(m.contents()).fadeTo d.changeFade, 1, S
            return

          b.event.trigger "fancybox-change"
          j.empty().removeAttr("filter").css
            "border-width": d.padding
            width: i.width - d.padding * 2
            height: (if e.autoDimensions then "auto" else i.height - y - d.padding * 2)

          if c
            g()
          else
            B.prop = 0
            b(B).animate
              prop: 1
            ,
              duration: d.changeSpeed
              easing: d.easingChange
              step: T
              complete: g

          return

      else
        f.removeAttr "style"
        j.css "border-width", d.padding
        if d.transitionIn is "elastic"
          r = V()
          j.html m.contents()
          f.show()
          i.opacity = 0  if d.opacity
          B.prop = 0
          b(B).animate
            prop: 1
          ,
            duration: d.speedIn
            easing: d.easingIn
            step: T
            complete: S

        else
          d.titlePosition is "inside" and y > 0 and n.show()
          j.css(
            width: i.width - d.padding * 2
            height: (if e.autoDimensions then "auto" else i.height - y - d.padding * 2)
          ).html m.contents()
          f.css(i).fadeIn (if d.transitionIn is "none" then 0 else d.speedIn), S
    return

  Y = ->
    if d.enableEscapeButton or d.enableKeyboardNav
      b(document).bind "keydown.fb", (a) ->
        if a.keyCode is 27 and d.enableEscapeButton
          a.preventDefault()
          b.fancybox.close()
        else if (a.keyCode is 37 or a.keyCode is 39) and d.enableKeyboardNav and a.target.tagName isnt "INPUT" and a.target.tagName isnt "TEXTAREA" and a.target.tagName isnt "SELECT"
          a.preventDefault()
          b.fancybox[(if a.keyCode is 37 then "prev" else "next")]()
        return

    if d.showNavArrows
      z.show()  if d.cyclic and l.length > 1 or p isnt 0
      A.show()  if d.cyclic and l.length > 1 or p isnt l.length - 1
    else
      z.hide()
      A.hide()
    return

  S = ->
    unless b.support.opacity
      j.get(0).style.removeAttribute "filter"
      f.get(0).style.removeAttribute "filter"
    e.autoDimensions and j.css("height", "auto")
    f.css "height", "auto"
    s and s.length and n.show()
    d.showCloseButton and E.show()
    Y()
    d.hideOnContentClick and j.bind("click", b.fancybox.close)
    d.hideOnOverlayClick and u.bind("click", b.fancybox.close)
    b(window).bind "resize.fb", b.fancybox.resize
    d.centerOnScroll and b(window).bind("scroll.fb", b.fancybox.center)
    b("<iframe id=\"fancybox-frame\" name=\"fancybox-frame" + (new Date).getTime() + "\" frameborder=\"0\" hspace=\"0\" " + ((if b.browser.msie then "allowtransparency=\"true\"\"" else "")) + " scrolling=\"" + e.scrolling + "\" src=\"" + d.href + "\"></iframe>").appendTo j  if d.type is "iframe"
    f.show()
    h = false
    b.fancybox.center()
    d.onComplete l, p, d
    a = undefined
    c = undefined
    if l.length - 1 > p
      a = l[p + 1].href
      if typeof a isnt "undefined" and a.match(J)
        c = new Image
        c.src = a
    if p > 0
      a = l[p - 1].href
      if typeof a isnt "undefined" and a.match(J)
        c = new Image
        c.src = a
    return

  T = (a) ->
    c =
      width: parseInt(r.width + (i.width - r.width) * a, 10)
      height: parseInt(r.height + (i.height - r.height) * a, 10)
      top: parseInt(r.top + (i.top - r.top) * a, 10)
      left: parseInt(r.left + (i.left - r.left) * a, 10)

    c.opacity = (if a < 0.5 then 0.5 else a)  if typeof i.opacity isnt "undefined"
    f.css c
    j.css
      width: c.width - d.padding * 2
      height: c.height - y * a - d.padding * 2

    return

  U = ->
    [
      b(window).width() - d.margin * 2
      b(window).height() - d.margin * 2
      b(document).scrollLeft() + d.margin
      b(document).scrollTop() + d.margin
    ]

  X = ->
    a = U()
    c = {}
    g = d.autoScale
    k = d.padding * 2
    c.width = (if d.width.toString().indexOf("%") > -1 then parseInt(a[0] * parseFloat(d.width) / 100, 10) else d.width + k)
    c.height = (if d.height.toString().indexOf("%") > -1 then parseInt(a[1] * parseFloat(d.height) / 100, 10) else d.height + k)
    if g and (c.width > a[0] or c.height > a[1])
      if e.type is "image" or e.type is "swf"
        g = d.width / d.height
        if c.width > a[0]
          c.width = a[0]
          c.height = parseInt((c.width - k) / g + k, 10)
        if c.height > a[1]
          c.height = a[1]
          c.width = parseInt((c.height - k) * g + k, 10)
      else
        c.width = Math.min(c.width, a[0])
        c.height = Math.min(c.height, a[1])
    c.top = parseInt(Math.max(a[3] - 20, a[3] + (a[1] - c.height - 40) * 0.5), 10)
    c.left = parseInt(Math.max(a[2] - 20, a[2] + (a[0] - c.width - 40) * 0.5), 10)
    c

  V = ->
    a = (if e.orig then b(e.orig) else false)
    c = {}
    if a and a.length
      c = a.offset()
      c.top += parseInt(a.css("paddingTop"), 10) or 0
      c.left += parseInt(a.css("paddingLeft"), 10) or 0
      c.top += parseInt(a.css("border-top-width"), 10) or 0
      c.left += parseInt(a.css("border-left-width"), 10) or 0
      c.width = a.width()
      c.height = a.height()
      c =
        width: c.width + d.padding * 2
        height: c.height + d.padding * 2
        top: c.top - d.padding - 20
        left: c.left - d.padding - 20
    else
      a = U()
      c =
        width: d.padding * 2
        height: d.padding * 2
        top: parseInt(a[3] + a[1] * 0.5, 10)
        left: parseInt(a[2] + a[0] * 0.5, 10)
    c

  Z = ->
    if t.is(":visible")
      b("div", t).css "top", L * -40 + "px"
      L = (L + 1) % 12
    else
      clearInterval K
    return

  b.fn.fancybox = (a) ->
    return this  unless b(this).length
    b(this).data("fancybox", b.extend({}, a, (if b.metadata then b(this).metadata() else {}))).unbind("click.fb").bind "click.fb", (c) ->
      c.preventDefault()
      unless h
        h = true
        b(this).blur()
        o = []
        q = 0
        c = b(this).attr("rel") or ""
        if not c or c is "" or c is "nofollow"
          o.push this
        else
          o = b("a[rel=" + c + "], area[rel=" + c + "]")
          q = o.index(this)
        I()
      return

    this

  b.fancybox = (a, c) ->
    g = undefined
    unless h
      h = true
      g = (if typeof c isnt "undefined" then c else {})
      o = []
      q = parseInt(g.index, 10) or 0
      if b.isArray(a)
        k = 0
        C = a.length

        while k < C
          if typeof a[k] is "object"
            b(a[k]).data "fancybox", b.extend({}, g, a[k])
          else
            a[k] = b({}).data("fancybox", b.extend(
              content: a[k]
            , g))
          k++
        o = jQuery.merge(o, a)
      else
        if typeof a is "object"
          b(a).data "fancybox", b.extend({}, g, a)
        else
          a = b({}).data("fancybox", b.extend(
            content: a
          , g))
        o.push a
      q = 0  if q > o.length or q < 0
      I()
    return

  b.fancybox.showActivity = ->
    clearInterval K
    t.show()
    K = setInterval(Z, 66)
    return

  b.fancybox.hideActivity = ->
    t.hide()
    return

  b.fancybox.next = ->
    b.fancybox.pos p + 1

  b.fancybox.prev = ->
    b.fancybox.pos p - 1

  b.fancybox.pos = (a) ->
    unless h
      a = parseInt(a)
      o = l
      if a > -1 and a < l.length
        q = a
        I()
      else if d.cyclic and l.length > 1
        q = (if a >= l.length then 0 else l.length - 1)
        I()
    return

  b.fancybox.cancel = ->
    unless h
      h = true
      b.event.trigger "fancybox-cancel"
      N()
      e.onCancel o, q, e
      h = false
    return

  b.fancybox.close = ->
    a = ->
      u.fadeOut "fast"
      n.empty().hide()
      f.hide()
      b.event.trigger "fancybox-cleanup"
      j.empty()
      d.onClosed l, p, d
      l = e = []
      p = q = 0
      d = e = {}
      h = false
      return
    unless h or f.is(":hidden")
      h = true
      if d and false is d.onCleanup(l, p, d)
        h = false
      else
        N()
        b(E.add(z).add(A)).hide()
        b(j.add(u)).unbind()
        b(window).unbind "resize.fb scroll.fb"
        b(document).unbind "keydown.fb"
        j.find("iframe").attr "src", (if M and /^https/i.test(window.location.href or "") then "javascript:void(false)" else "about:blank")
        d.titlePosition isnt "inside" and n.empty()
        f.stop()
        if d.transitionOut is "elastic"
          r = V()
          c = f.position()
          i =
            top: c.top
            left: c.left
            width: f.width()
            height: f.height()

          i.opacity = 1  if d.opacity
          n.empty().hide()
          B.prop = 1
          b(B).animate
            prop: 0
          ,
            duration: d.speedOut
            easing: d.easingOut
            step: T
            complete: a

        else
          f.fadeOut (if d.transitionOut is "none" then 0 else d.speedOut), a
    return

  b.fancybox.resize = ->
    u.is(":visible") and u.css("height", b(document).height())
    b.fancybox.center true
    return

  b.fancybox.center = (a) ->
    c = undefined
    g = undefined
    unless h
      g = (if a is true then 1 else 0)
      c = U()
      not g and (f.width() > c[0] or f.height() > c[1]) or f.stop().animate(
        top: parseInt(Math.max(c[3] - 20, c[3] + (c[1] - j.height() - 40) * 0.5 - d.padding))
        left: parseInt(Math.max(c[2] - 20, c[2] + (c[0] - j.width() - 40) * 0.5 - d.padding))
      , (if typeof a is "number" then a else 200))
    return

  b.fancybox.init = ->
    unless b("#fancybox-wrap").length
      b("body").append m = b("<div id=\"fancybox-tmp\"></div>"), t = b("<div id=\"fancybox-loading\"><div></div></div>"), u = b("<div id=\"fancybox-overlay\"></div>"), f = b("<div id=\"fancybox-wrap\"></div>")
      D = b("<div id=\"fancybox-outer\"></div>").append("<div class=\"fancybox-bg\" id=\"fancybox-bg-n\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-ne\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-e\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-se\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-s\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-sw\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-w\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-nw\"></div>").appendTo(f)
      D.append j = b("<div id=\"fancybox-content\"></div>"), E = b("<a id=\"fancybox-close\"></a>"), n = b("<div id=\"fancybox-title\"></div>"), z = b("<a href=\"javascript:;\" id=\"fancybox-left\"><span class=\"fancy-ico\" id=\"fancybox-left-ico\"></span></a>"), A = b("<a href=\"javascript:;\" id=\"fancybox-right\"><span class=\"fancy-ico\" id=\"fancybox-right-ico\"></span></a>")
      E.click b.fancybox.close
      t.click b.fancybox.cancel
      z.click (a) ->
        a.preventDefault()
        b.fancybox.prev()
        return

      A.click (a) ->
        a.preventDefault()
        b.fancybox.next()
        return

      b.fn.mousewheel and f.bind("mousewheel.fb", (a, c) ->
        if h
          a.preventDefault()
        else if b(a.target).get(0).clientHeight is 0 or b(a.target).get(0).scrollHeight is b(a.target).get(0).clientHeight
          a.preventDefault()
          b.fancybox[(if c > 0 then "prev" else "next")]()
        return
      )
      b.support.opacity or f.addClass("fancybox-ie")
      if M
        t.addClass "fancybox-ie6"
        f.addClass "fancybox-ie6"
        b("<iframe id=\"fancybox-hide-sel-frame\" src=\"" + ((if /^https/i.test(window.location.href or "") then "javascript:void(false)" else "about:blank")) + "\" scrolling=\"no\" border=\"0\" frameborder=\"0\" tabindex=\"-1\"></iframe>").prependTo D
    return

  b.fn.fancybox.defaults =
    padding: 10
    margin: 40
    opacity: false
    modal: false
    cyclic: false
    scrolling: "auto"
    width: 560
    height: 340
    autoScale: true
    autoDimensions: true
    centerOnScroll: false
    ajax: {}
    swf:
      wmode: "transparent"

    hideOnOverlayClick: true
    hideOnContentClick: false
    overlayShow: true
    overlayOpacity: 0.7
    overlayColor: "#777"
    titleShow: true
    titlePosition: "float"
    titleFormat: null
    titleFromAlt: false
    transitionIn: "fade"
    transitionOut: "fade"
    speedIn: 300
    speedOut: 300
    changeSpeed: 300
    changeFade: "fast"
    easingIn: "swing"
    easingOut: "swing"
    showCloseButton: true
    showNavArrows: true
    enableEscapeButton: true
    enableKeyboardNav: true
    onStart: ->

    onCancel: ->

    onComplete: ->

    onCleanup: ->

    onClosed: ->

    onError: ->

  b(document).ready ->
    b.fancybox.init()
    return

  return
) jQuery
