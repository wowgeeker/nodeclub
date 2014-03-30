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
(($) ->
  tmp = undefined
  loading = undefined
  overlay = undefined
  wrap = undefined
  outer = undefined
  content = undefined
  close = undefined
  title = undefined
  nav_left = undefined
  nav_right = undefined
  selectedIndex = 0
  selectedOpts = {}
  selectedArray = []
  currentIndex = 0
  currentOpts = {}
  currentArray = []
  ajaxLoader = null
  imgPreloader = new Image()
  imgRegExp = /\.(jpg|gif|png|bmp|jpeg)(.*)?$/i
  swfRegExp = /[^\.]\.(swf)\s*$/i
  loadingTimer = undefined
  loadingFrame = 1
  titleHeight = 0
  titleStr = ""
  start_pos = undefined
  final_pos = undefined
  busy = false
  fx = $.extend($("<div/>")[0],
    prop: 0
  )
  isIE6 = $.browser.msie and $.browser.version < 7 and not window.XMLHttpRequest
  
  #
  #		 * Private methods 
  #		 
  _abort = ->
    loading.hide()
    imgPreloader.onerror = imgPreloader.onload = null
    ajaxLoader.abort()  if ajaxLoader
    tmp.empty()
    return

  _error = ->
    if false is selectedOpts.onError(selectedArray, selectedIndex, selectedOpts)
      loading.hide()
      busy = false
      return
    selectedOpts.titleShow = false
    selectedOpts.width = "auto"
    selectedOpts.height = "auto"
    tmp.html "<p id=\"fancybox-error\">The requested content cannot be loaded.<br />Please try again later.</p>"
    _process_inline()
    return

  _start = ->
    obj = selectedArray[selectedIndex]
    href = undefined
    type = undefined
    title = undefined
    str = undefined
    emb = undefined
    ret = undefined
    _abort()
    selectedOpts = $.extend({}, $.fn.fancybox.defaults, ((if typeof $(obj).data("fancybox") is "undefined" then selectedOpts else $(obj).data("fancybox"))))
    ret = selectedOpts.onStart(selectedArray, selectedIndex, selectedOpts)
    if ret is false
      busy = false
      return
    else selectedOpts = $.extend(selectedOpts, ret)  if typeof ret is "object"
    title = selectedOpts.title or ((if obj.nodeName then $(obj).attr("title") else obj.title)) or ""
    selectedOpts.orig = (if $(obj).children("img:first").length then $(obj).children("img:first") else $(obj))  if obj.nodeName and not selectedOpts.orig
    title = selectedOpts.orig.attr("alt")  if title is "" and selectedOpts.orig and selectedOpts.titleFromAlt
    href = selectedOpts.href or ((if obj.nodeName then $(obj).attr("href") else obj.href)) or null
    href = null  if (/^(?:javascript)/i).test(href) or href is "#"
    if selectedOpts.type
      type = selectedOpts.type
      href = selectedOpts.content  unless href
    else if selectedOpts.content
      type = "html"
    else if href
      if href.match(imgRegExp)
        type = "image"
      else if href.match(swfRegExp)
        type = "swf"
      else if $(obj).hasClass("iframe")
        type = "iframe"
      else if href.indexOf("#") is 0
        type = "inline"
      else
        type = "ajax"
    unless type
      _error()
      return
    if type is "inline"
      obj = href.substr(href.indexOf("#"))
      type = (if $(obj).length > 0 then "inline" else "ajax")
    selectedOpts.type = type
    selectedOpts.href = href
    selectedOpts.title = title
    if selectedOpts.autoDimensions
      if selectedOpts.type is "html" or selectedOpts.type is "inline" or selectedOpts.type is "ajax"
        selectedOpts.width = "auto"
        selectedOpts.height = "auto"
      else
        selectedOpts.autoDimensions = false
    if selectedOpts.modal
      selectedOpts.overlayShow = true
      selectedOpts.hideOnOverlayClick = false
      selectedOpts.hideOnContentClick = false
      selectedOpts.enableEscapeButton = false
      selectedOpts.showCloseButton = false
    selectedOpts.padding = parseInt(selectedOpts.padding, 10)
    selectedOpts.margin = parseInt(selectedOpts.margin, 10)
    tmp.css "padding", (selectedOpts.padding + selectedOpts.margin)
    $(".fancybox-inline-tmp").unbind("fancybox-cancel").bind "fancybox-change", ->
      $(this).replaceWith content.children()
      return

    switch type
      when "html"
        tmp.html selectedOpts.content
        _process_inline()
      when "inline"
        if $(obj).parent().is("#fancybox-content") is true
          busy = false
          return
        $("<div class=\"fancybox-inline-tmp\" />").hide().insertBefore($(obj)).bind("fancybox-cleanup", ->
          $(this).replaceWith content.children()
          return
        ).bind "fancybox-cancel", ->
          $(this).replaceWith tmp.children()
          return

        $(obj).appendTo tmp
        _process_inline()
      when "image"
        busy = false
        $.fancybox.showActivity()
        imgPreloader = new Image()
        imgPreloader.onerror = ->
          _error()
          return

        imgPreloader.onload = ->
          busy = true
          imgPreloader.onerror = imgPreloader.onload = null
          _process_image()
          return

        imgPreloader.src = href
      when "swf"
        selectedOpts.scrolling = "no"
        str = "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"" + selectedOpts.width + "\" height=\"" + selectedOpts.height + "\"><param name=\"movie\" value=\"" + href + "\"></param>"
        emb = ""
        $.each selectedOpts.swf, (name, val) ->
          str += "<param name=\"" + name + "\" value=\"" + val + "\"></param>"
          emb += " " + name + "=\"" + val + "\""
          return

        str += "<embed src=\"" + href + "\" type=\"application/x-shockwave-flash\" width=\"" + selectedOpts.width + "\" height=\"" + selectedOpts.height + "\"" + emb + "></embed></object>"
        tmp.html str
        _process_inline()
      when "ajax"
        busy = false
        $.fancybox.showActivity()
        selectedOpts.ajax.win = selectedOpts.ajax.success
        ajaxLoader = $.ajax($.extend({}, selectedOpts.ajax,
          url: href
          data: selectedOpts.ajax.data or {}
          error: (XMLHttpRequest, textStatus, errorThrown) ->
            _error()  if XMLHttpRequest.status > 0
            return

          success: (data, textStatus, XMLHttpRequest) ->
            o = (if typeof XMLHttpRequest is "object" then XMLHttpRequest else ajaxLoader)
            if o.status is 200
              if typeof selectedOpts.ajax.win is "function"
                ret = selectedOpts.ajax.win(href, data, textStatus, XMLHttpRequest)
                if ret is false
                  loading.hide()
                  return
                else data = ret  if typeof ret is "string" or typeof ret is "object"
              tmp.html data
              _process_inline()
            return
        ))
      when "iframe"
        _show()

  _process_inline = ->
    w = selectedOpts.width
    h = selectedOpts.height
    if w.toString().indexOf("%") > -1
      w = parseInt(($(window).width() - (selectedOpts.margin * 2)) * parseFloat(w) / 100, 10) + "px"
    else
      w = (if w is "auto" then "auto" else w + "px")
    if h.toString().indexOf("%") > -1
      h = parseInt(($(window).height() - (selectedOpts.margin * 2)) * parseFloat(h) / 100, 10) + "px"
    else
      h = (if h is "auto" then "auto" else h + "px")
    tmp.wrapInner "<div style=\"width:" + w + ";height:" + h + ";overflow: " + ((if selectedOpts.scrolling is "auto" then "auto" else ((if selectedOpts.scrolling is "yes" then "scroll" else "hidden")))) + ";position:relative;\"></div>"
    selectedOpts.width = tmp.width()
    selectedOpts.height = tmp.height()
    _show()
    return

  _process_image = ->
    selectedOpts.width = imgPreloader.width
    selectedOpts.height = imgPreloader.height
    $("<img />").attr(
      id: "fancybox-img"
      src: imgPreloader.src
      alt: selectedOpts.title
    ).appendTo tmp
    _show()
    return

  _show = ->
    pos = undefined
    equal = undefined
    loading.hide()
    if wrap.is(":visible") and false is currentOpts.onCleanup(currentArray, currentIndex, currentOpts)
      $.event.trigger "fancybox-cancel"
      busy = false
      return
    busy = true
    $(content.add(overlay)).unbind()
    $(window).unbind "resize.fb scroll.fb"
    $(document).unbind "keydown.fb"
    wrap.css "height", wrap.height()  if wrap.is(":visible") and currentOpts.titlePosition isnt "outside"
    currentArray = selectedArray
    currentIndex = selectedIndex
    currentOpts = selectedOpts
    if currentOpts.overlayShow
      overlay.css
        "background-color": currentOpts.overlayColor
        opacity: currentOpts.overlayOpacity
        cursor: (if currentOpts.hideOnOverlayClick then "pointer" else "auto")
        height: $(document).height()

      unless overlay.is(":visible")
        if isIE6
          $("select:not(#fancybox-tmp select)").filter(->
            @style.visibility isnt "hidden"
          ).css(visibility: "hidden").one "fancybox-cleanup", ->
            @style.visibility = "inherit"
            return

        overlay.show()
    else
      overlay.hide()
    final_pos = _get_zoom_to()
    _process_title()
    if wrap.is(":visible")
      $(close.add(nav_left).add(nav_right)).hide()
      pos = wrap.position()
      start_pos =
        top: pos.top
        left: pos.left
        width: wrap.width()
        height: wrap.height()


      equal = (start_pos.width is final_pos.width and start_pos.height is final_pos.height)
      content.fadeTo currentOpts.changeFade, 0.3, ->
        finish_resizing = ->
          content.html(tmp.contents()).fadeTo currentOpts.changeFade, 1, _finish
          return

        $.event.trigger "fancybox-change"
        content.empty().removeAttr("filter").css
          "border-width": currentOpts.padding
          width: final_pos.width - currentOpts.padding * 2
          height: (if selectedOpts.autoDimensions then "auto" else final_pos.height - titleHeight - currentOpts.padding * 2)

        if equal
          finish_resizing()
        else
          fx.prop = 0
          $(fx).animate
            prop: 1
          ,
            duration: currentOpts.changeSpeed
            easing: currentOpts.easingChange
            step: _draw
            complete: finish_resizing

        return

      return
    wrap.removeAttr "style"
    content.css "border-width", currentOpts.padding
    if currentOpts.transitionIn is "elastic"
      start_pos = _get_zoom_from()
      content.html tmp.contents()
      wrap.show()
      final_pos.opacity = 0  if currentOpts.opacity
      fx.prop = 0
      $(fx).animate
        prop: 1
      ,
        duration: currentOpts.speedIn
        easing: currentOpts.easingIn
        step: _draw
        complete: _finish

      return
    title.show()  if currentOpts.titlePosition is "inside" and titleHeight > 0
    content.css(
      width: final_pos.width - currentOpts.padding * 2
      height: (if selectedOpts.autoDimensions then "auto" else final_pos.height - titleHeight - currentOpts.padding * 2)
    ).html tmp.contents()
    wrap.css(final_pos).fadeIn (if currentOpts.transitionIn is "none" then 0 else currentOpts.speedIn), _finish
    return

  _format_title = (title) ->
    if title and title.length
      return "<table id=\"fancybox-title-float-wrap\" cellpadding=\"0\" cellspacing=\"0\"><tr><td id=\"fancybox-title-float-left\"></td><td id=\"fancybox-title-float-main\">" + title + "</td><td id=\"fancybox-title-float-right\"></td></tr></table>"  if currentOpts.titlePosition is "float"
      return "<div id=\"fancybox-title-" + currentOpts.titlePosition + "\">" + title + "</div>"
    false

  _process_title = ->
    titleStr = currentOpts.title or ""
    titleHeight = 0
    title.empty().removeAttr("style").removeClass()
    if currentOpts.titleShow is false
      title.hide()
      return
    titleStr = (if $.isFunction(currentOpts.titleFormat) then currentOpts.titleFormat(titleStr, currentArray, currentIndex, currentOpts) else _format_title(titleStr))
    if not titleStr or titleStr is ""
      title.hide()
      return
    title.addClass("fancybox-title-" + currentOpts.titlePosition).html(titleStr).appendTo("body").show()
    switch currentOpts.titlePosition
      when "inside"
        title.css
          width: final_pos.width - (currentOpts.padding * 2)
          marginLeft: currentOpts.padding
          marginRight: currentOpts.padding

        titleHeight = title.outerHeight(true)
        title.appendTo outer
        final_pos.height += titleHeight
      when "over"
        title.css(
          marginLeft: currentOpts.padding
          width: final_pos.width - (currentOpts.padding * 2)
          bottom: currentOpts.padding
        ).appendTo outer
      when "float"
        title.css("left", parseInt((title.width() - final_pos.width - 40) / 2, 10) * -1).appendTo wrap
      else
        title.css(
          width: final_pos.width - (currentOpts.padding * 2)
          paddingLeft: currentOpts.padding
          paddingRight: currentOpts.padding
        ).appendTo wrap
    title.hide()
    return

  _set_navigation = ->
    if currentOpts.enableEscapeButton or currentOpts.enableKeyboardNav
      $(document).bind "keydown.fb", (e) ->
        if e.keyCode is 27 and currentOpts.enableEscapeButton
          e.preventDefault()
          $.fancybox.close()
        else if (e.keyCode is 37 or e.keyCode is 39) and currentOpts.enableKeyboardNav and e.target.tagName isnt "INPUT" and e.target.tagName isnt "TEXTAREA" and e.target.tagName isnt "SELECT"
          e.preventDefault()
          $.fancybox[(if e.keyCode is 37 then "prev" else "next")]()
        return

    unless currentOpts.showNavArrows
      nav_left.hide()
      nav_right.hide()
      return
    nav_left.show()  if (currentOpts.cyclic and currentArray.length > 1) or currentIndex isnt 0
    nav_right.show()  if (currentOpts.cyclic and currentArray.length > 1) or currentIndex isnt (currentArray.length - 1)
    return

  _finish = ->
    unless $.support.opacity
      content.get(0).style.removeAttribute "filter"
      wrap.get(0).style.removeAttribute "filter"
    content.css "height", "auto"  if selectedOpts.autoDimensions
    wrap.css "height", "auto"
    title.show()  if titleStr and titleStr.length
    close.show()  if currentOpts.showCloseButton
    _set_navigation()
    content.bind "click", $.fancybox.close  if currentOpts.hideOnContentClick
    overlay.bind "click", $.fancybox.close  if currentOpts.hideOnOverlayClick
    $(window).bind "resize.fb", $.fancybox.resize
    $(window).bind "scroll.fb", $.fancybox.center  if currentOpts.centerOnScroll
    $("<iframe id=\"fancybox-frame\" name=\"fancybox-frame" + new Date().getTime() + "\" frameborder=\"0\" hspace=\"0\" " + ((if $.browser.msie then "allowtransparency=\"true\"\"" else "")) + " scrolling=\"" + selectedOpts.scrolling + "\" src=\"" + currentOpts.href + "\"></iframe>").appendTo content  if currentOpts.type is "iframe"
    wrap.show()
    busy = false
    $.fancybox.center()
    currentOpts.onComplete currentArray, currentIndex, currentOpts
    _preload_images()
    return

  _preload_images = ->
    href = undefined
    objNext = undefined
    if (currentArray.length - 1) > currentIndex
      href = currentArray[currentIndex + 1].href
      if typeof href isnt "undefined" and href.match(imgRegExp)
        objNext = new Image()
        objNext.src = href
    if currentIndex > 0
      href = currentArray[currentIndex - 1].href
      if typeof href isnt "undefined" and href.match(imgRegExp)
        objNext = new Image()
        objNext.src = href
    return

  _draw = (pos) ->
    dim =
      width: parseInt(start_pos.width + (final_pos.width - start_pos.width) * pos, 10)
      height: parseInt(start_pos.height + (final_pos.height - start_pos.height) * pos, 10)
      top: parseInt(start_pos.top + (final_pos.top - start_pos.top) * pos, 10)
      left: parseInt(start_pos.left + (final_pos.left - start_pos.left) * pos, 10)

    dim.opacity = (if pos < 0.5 then 0.5 else pos)  if typeof final_pos.opacity isnt "undefined"
    wrap.css dim
    content.css
      width: dim.width - currentOpts.padding * 2
      height: dim.height - (titleHeight * pos) - currentOpts.padding * 2

    return

  _get_viewport = ->
    [
      $(window).width() - (currentOpts.margin * 2)
      $(window).height() - (currentOpts.margin * 2)
      $(document).scrollLeft() + currentOpts.margin
      $(document).scrollTop() + currentOpts.margin
    ]

  _get_zoom_to = ->
    view = _get_viewport()
    to = {}
    resize = currentOpts.autoScale
    double_padding = currentOpts.padding * 2
    ratio = undefined
    if currentOpts.width.toString().indexOf("%") > -1
      to.width = parseInt((view[0] * parseFloat(currentOpts.width)) / 100, 10)
    else
      to.width = currentOpts.width + double_padding
    if currentOpts.height.toString().indexOf("%") > -1
      to.height = parseInt((view[1] * parseFloat(currentOpts.height)) / 100, 10)
    else
      to.height = currentOpts.height + double_padding
    if resize and (to.width > view[0] or to.height > view[1])
      if selectedOpts.type is "image" or selectedOpts.type is "swf"
        ratio = (currentOpts.width) / (currentOpts.height)
        if (to.width) > view[0]
          to.width = view[0]
          to.height = parseInt(((to.width - double_padding) / ratio) + double_padding, 10)
        if (to.height) > view[1]
          to.height = view[1]
          to.width = parseInt(((to.height - double_padding) * ratio) + double_padding, 10)
      else
        to.width = Math.min(to.width, view[0])
        to.height = Math.min(to.height, view[1])
    to.top = parseInt(Math.max(view[3] - 20, view[3] + ((view[1] - to.height - 40) * 0.5)), 10)
    to.left = parseInt(Math.max(view[2] - 20, view[2] + ((view[0] - to.width - 40) * 0.5)), 10)
    to

  _get_obj_pos = (obj) ->
    pos = obj.offset()
    pos.top += parseInt(obj.css("paddingTop"), 10) or 0
    pos.left += parseInt(obj.css("paddingLeft"), 10) or 0
    pos.top += parseInt(obj.css("border-top-width"), 10) or 0
    pos.left += parseInt(obj.css("border-left-width"), 10) or 0
    pos.width = obj.width()
    pos.height = obj.height()
    pos

  _get_zoom_from = ->
    orig = (if selectedOpts.orig then $(selectedOpts.orig) else false)
    from = {}
    pos = undefined
    view = undefined
    if orig and orig.length
      pos = _get_obj_pos(orig)
      from =
        width: pos.width + (currentOpts.padding * 2)
        height: pos.height + (currentOpts.padding * 2)
        top: pos.top - currentOpts.padding - 20
        left: pos.left - currentOpts.padding - 20
    else
      view = _get_viewport()
      from =
        width: currentOpts.padding * 2
        height: currentOpts.padding * 2
        top: parseInt(view[3] + view[1] * 0.5, 10)
        left: parseInt(view[2] + view[0] * 0.5, 10)
    from

  _animate_loading = ->
    unless loading.is(":visible")
      clearInterval loadingTimer
      return
    $("div", loading).css "top", (loadingFrame * -40) + "px"
    loadingFrame = (loadingFrame + 1) % 12
    return

  
  #
  #	 * Public methods 
  #	 
  $.fn.fancybox = (options) ->
    return this  unless $(this).length
    $(this).data("fancybox", $.extend({}, options, ((if $.metadata then $(this).metadata() else {})))).unbind("click.fb").bind "click.fb", (e) ->
      e.preventDefault()
      return  if busy
      busy = true
      $(this).blur()
      selectedArray = []
      selectedIndex = 0
      rel = $(this).attr("rel") or ""
      if not rel or rel is "" or rel is "nofollow"
        selectedArray.push this
      else
        selectedArray = $("a[rel=" + rel + "], area[rel=" + rel + "]")
        selectedIndex = selectedArray.index(this)
      _start()
      return

    this

  $.fancybox = (obj) ->
    opts = undefined
    return  if busy
    busy = true
    opts = (if typeof arguments_[1] isnt "undefined" then arguments_[1] else {})
    selectedArray = []
    selectedIndex = parseInt(opts.index, 10) or 0
    if $.isArray(obj)
      i = 0
      j = obj.length

      while i < j
        if typeof obj[i] is "object"
          $(obj[i]).data "fancybox", $.extend({}, opts, obj[i])
        else
          obj[i] = $({}).data("fancybox", $.extend(
            content: obj[i]
          , opts))
        i++
      selectedArray = jQuery.merge(selectedArray, obj)
    else
      if typeof obj is "object"
        $(obj).data "fancybox", $.extend({}, opts, obj)
      else
        obj = $({}).data("fancybox", $.extend(
          content: obj
        , opts))
      selectedArray.push obj
    selectedIndex = 0  if selectedIndex > selectedArray.length or selectedIndex < 0
    _start()
    return

  $.fancybox.showActivity = ->
    clearInterval loadingTimer
    loading.show()
    loadingTimer = setInterval(_animate_loading, 66)
    return

  $.fancybox.hideActivity = ->
    loading.hide()
    return

  $.fancybox.next = ->
    $.fancybox.pos currentIndex + 1

  $.fancybox.prev = ->
    $.fancybox.pos currentIndex - 1

  $.fancybox.pos = (pos) ->
    return  if busy
    pos = parseInt(pos)
    selectedArray = currentArray
    if pos > -1 and pos < currentArray.length
      selectedIndex = pos
      _start()
    else if currentOpts.cyclic and currentArray.length > 1
      selectedIndex = (if pos >= currentArray.length then 0 else currentArray.length - 1)
      _start()
    return

  $.fancybox.cancel = ->
    return  if busy
    busy = true
    $.event.trigger "fancybox-cancel"
    _abort()
    selectedOpts.onCancel selectedArray, selectedIndex, selectedOpts
    busy = false
    return

  
  # Note: within an iframe use - parent.$.fancybox.close();
  $.fancybox.close = ->
    _cleanup = ->
      overlay.fadeOut "fast"
      title.empty().hide()
      wrap.hide()
      $.event.trigger "fancybox-cleanup"
      content.empty()
      currentOpts.onClosed currentArray, currentIndex, currentOpts
      currentArray = selectedOpts = []
      currentIndex = selectedIndex = 0
      currentOpts = selectedOpts = {}
      busy = false
      return
    return  if busy or wrap.is(":hidden")
    busy = true
    if currentOpts and false is currentOpts.onCleanup(currentArray, currentIndex, currentOpts)
      busy = false
      return
    _abort()
    $(close.add(nav_left).add(nav_right)).hide()
    $(content.add(overlay)).unbind()
    $(window).unbind "resize.fb scroll.fb"
    $(document).unbind "keydown.fb"
    content.find("iframe").attr "src", (if isIE6 and /^https/i.test(window.location.href or "") then "javascript:void(false)" else "about:blank")
    title.empty()  if currentOpts.titlePosition isnt "inside"
    wrap.stop()
    if currentOpts.transitionOut is "elastic"
      start_pos = _get_zoom_from()
      pos = wrap.position()
      final_pos =
        top: pos.top
        left: pos.left
        width: wrap.width()
        height: wrap.height()

      final_pos.opacity = 1  if currentOpts.opacity
      title.empty().hide()
      fx.prop = 1
      $(fx).animate
        prop: 0
      ,
        duration: currentOpts.speedOut
        easing: currentOpts.easingOut
        step: _draw
        complete: _cleanup

    else
      wrap.fadeOut (if currentOpts.transitionOut is "none" then 0 else currentOpts.speedOut), _cleanup
    return

  $.fancybox.resize = ->
    overlay.css "height", $(document).height()  if overlay.is(":visible")
    $.fancybox.center true
    return

  $.fancybox.center = ->
    view = undefined
    align = undefined
    return  if busy
    align = (if arguments_[0] is true then 1 else 0)
    view = _get_viewport()
    return  if not align and (wrap.width() > view[0] or wrap.height() > view[1])
    wrap.stop().animate
      top: parseInt(Math.max(view[3] - 20, view[3] + ((view[1] - content.height() - 40) * 0.5) - currentOpts.padding))
      left: parseInt(Math.max(view[2] - 20, view[2] + ((view[0] - content.width() - 40) * 0.5) - currentOpts.padding))
    , (if typeof arguments_[0] is "number" then arguments_[0] else 200)
    return

  $.fancybox.init = ->
    return  if $("#fancybox-wrap").length
    $("body").append tmp = $("<div id=\"fancybox-tmp\"></div>"), loading = $("<div id=\"fancybox-loading\"><div></div></div>"), overlay = $("<div id=\"fancybox-overlay\"></div>"), wrap = $("<div id=\"fancybox-wrap\"></div>")
    outer = $("<div id=\"fancybox-outer\"></div>").append("<div class=\"fancybox-bg\" id=\"fancybox-bg-n\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-ne\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-e\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-se\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-s\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-sw\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-w\"></div><div class=\"fancybox-bg\" id=\"fancybox-bg-nw\"></div>").appendTo(wrap)
    outer.append content = $("<div id=\"fancybox-content\"></div>"), close = $("<a id=\"fancybox-close\"></a>"), title = $("<div id=\"fancybox-title\"></div>"), nav_left = $("<a href=\"javascript:;\" id=\"fancybox-left\"><span class=\"fancy-ico\" id=\"fancybox-left-ico\"></span></a>"), nav_right = $("<a href=\"javascript:;\" id=\"fancybox-right\"><span class=\"fancy-ico\" id=\"fancybox-right-ico\"></span></a>")
    close.click $.fancybox.close
    loading.click $.fancybox.cancel
    nav_left.click (e) ->
      e.preventDefault()
      $.fancybox.prev()
      return

    nav_right.click (e) ->
      e.preventDefault()
      $.fancybox.next()
      return

    if $.fn.mousewheel
      wrap.bind "mousewheel.fb", (e, delta) ->
        if busy
          e.preventDefault()
        else if $(e.target).get(0).clientHeight is 0 or $(e.target).get(0).scrollHeight is $(e.target).get(0).clientHeight
          e.preventDefault()
          $.fancybox[(if delta > 0 then "prev" else "next")]()
        return

    wrap.addClass "fancybox-ie"  unless $.support.opacity
    if isIE6
      loading.addClass "fancybox-ie6"
      wrap.addClass "fancybox-ie6"
      $("<iframe id=\"fancybox-hide-sel-frame\" src=\"" + ((if /^https/i.test(window.location.href or "") then "javascript:void(false)" else "about:blank")) + "\" scrolling=\"no\" border=\"0\" frameborder=\"0\" tabindex=\"-1\"></iframe>").prependTo outer
    return

  $.fn.fancybox.defaults =
    padding: 10
    margin: 40
    opacity: false
    modal: false
    cyclic: false
    scrolling: "auto" # 'auto', 'yes' or 'no'
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
    titlePosition: "float" # 'float', 'outside', 'inside' or 'over'
    titleFormat: null
    titleFromAlt: false
    transitionIn: "fade" # 'elastic', 'fade' or 'none'
    transitionOut: "fade" # 'elastic', 'fade' or 'none'
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

  $(document).ready ->
    $.fancybox.init()
    return

  return
) jQuery
