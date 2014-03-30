###
EpicEditor - An Embeddable JavaScript Markdown Editor (https://github.com/OscarGodson/EpicEditor)
Copyright (c) 2011-2012, Oscar Godson. (MIT Licensed)
###
((e, t) ->
  n = (e, t) ->
    for n of t
      continue
    return
  r = (e, t) ->
    for n of t
      continue
    return
  i = (t, n) ->
    r = t
    i = null
    (if e.getComputedStyle then i = document.defaultView.getComputedStyle(r, null).getPropertyValue(n) else r.currentStyle and (i = r.currentStyle[n]))
    i
  s = (e, t, n) ->
    s = {}
    o = undefined
    if t is "save"
      for o of n
        continue
      r e, n
    else
      t is "apply" and r(e, n)
    s
  o = (e) ->
    t = parseInt(i(e, "border-left-width"), 10) + parseInt(i(e, "border-right-width"), 10)
    n = parseInt(i(e, "padding-left"), 10) + parseInt(i(e, "padding-right"), 10)
    r = e.offsetWidth
    s = undefined
    isNaN(t) and (t = 0)
    s = t + n + r
    s
  u = (e) ->
    t = parseInt(i(e, "border-top-width"), 10) + parseInt(i(e, "border-bottom-width"), 10)
    n = parseInt(i(e, "padding-top"), 10) + parseInt(i(e, "padding-bottom"), 10)
    r = parseInt(i(e, "height"), 10)
    s = undefined
    isNaN(t) and (t = 0)
    s = t + n + r
    s
  a = (e, t, r) ->
    r = r or ""
    i = t.getElementsByTagName("head")[0]
    s = t.createElement("link")
    n(s,
      type: "text/css"
      id: r
      rel: "stylesheet"
      href: e
      name: e
      media: "screen"
    )
    i.appendChild(s)

    return
  f = (e, t, n) ->
    e.className = e.className.replace(t, n)
    return
  l = (e) ->
    e.contentDocument or e.contentWindow.document
  c = (e) ->
    t = undefined
    (if typeof document.body.innerText is "string" then t = e.innerText else (t = e.innerHTML.replace(/<br>/g, "\n")
    t = t.replace(/<(?:.|\n)*?>/g, "")
    t = t.replace(/&lt;/g, "<")
    t = t.replace(/&gt;/g, ">")
    ))
    t
  h = (e, t) ->
    t = t.replace(/</g, "&lt;")
    t = t.replace(/>/g, "&gt;")
    t = t.replace(/\n/g, "<br>")
    t = t.replace(/<br>\s/g, "<br>&nbsp;")
    t = t.replace(/\s\s\s/g, "&nbsp; &nbsp;")
    t = t.replace(/\s\s/g, "&nbsp; ")
    t = t.replace(/^ /, "&nbsp;")
    e.innerHTML = t
    not 0
  p = (e) ->
    e.replace(/\u00a0/g, " ").replace /&nbsp;/g, " "
  d = ->
    e = -1
    t = navigator.userAgent
    n = undefined
    navigator.appName is "Microsoft Internet Explorer" and (n = /MSIE ([0-9]{1,}[\.0-9]{0,})/
    n.exec(t)? and (e = parseFloat(RegExp.$1, 10))
    )
    e
  v = ->
    t = e.navigator
    t.userAgent.indexOf("Safari") > -1 and t.userAgent.indexOf("Chrome") is -1
  m = ->
    t = e.navigator
    t.userAgent.indexOf("Firefox") > -1 and t.userAgent.indexOf("Seamonkey") is -1
  g = (e) ->
    t = {}
    e and t.toString.call(e) is "[object Function]"
  y = ->
    e = arguments_[0] or {}
    n = 1
    r = arguments_.length
    i = not 1
    s = undefined
    o = undefined
    u = undefined
    a = undefined
    typeof e is "boolean" and (i = e
    e = arguments_[1] or {}
    n = 2
    )
    typeof e isnt "object" and not g(e) and (e = {})
    r is n and (e = this
    --n
    )

    while n < r
      if (s = arguments_[n])?
        for o of s
          continue
      n++
    e
  b = (e) ->
    n = this
    r = e or {}
    i = undefined
    s = undefined
    o =
      container: "epiceditor"
      basePath: "epiceditor"
      textarea: t
      clientSideStorage: not 0
      localStorageName: "epiceditor"
      useNativeFullscreen: not 0
      file:
        name: null
        defaultContent: ""
        autoSave: 100

      theme:
        base: "/themes/base/epiceditor.css"
        preview: "/themes/preview/github.css"
        editor: "/themes/editor/epic-dark.css"

      focusOnLoad: not 1
      shortcut:
        modifier: 18
        fullscreen: 70
        preview: 80

      string:
        togglePreview: "Toggle Preview Mode"
        toggleEdit: "Toggle Edit Mode"
        toggleFullscreen: "Enter Fullscreen"

      parser: (if typeof marked is "function" then marked else null)
      autogrow: not 1
      button:
        fullscreen: not 0
        preview: not 0
        bar: "auto"

    u = undefined
    a =
      minHeight: 80
      maxHeight: not 1
      scroll: not 0

    n.settings = y(not 0, o, r)
    f = n.settings.button
    n._fullscreenEnabled = (if typeof f is "object" then typeof f.fullscreen is "undefined" or f.fullscreen else f is not 0)
    n._editEnabled = (if typeof f is "object" then typeof f.edit is "undefined" or f.edit else f is not 0)
    n._previewEnabled = (if typeof f is "object" then typeof f.preview is "undefined" or f.preview else f is not 0)

    if typeof n.settings.parser isnt "function" or typeof n.settings.parser("TEST") isnt "string"
      n.settings.parser = (e) ->
        e
    n.settings.autogrow and ((if n.settings.autogrow is not 0 then n.settings.autogrow = a else n.settings.autogrow = y(not 0, a, n.settings.autogrow))
    n._oldHeight = -1
    )
    n.settings.theme.preview.match(/^https?:\/\//) or (n.settings.theme.preview = n.settings.basePath + n.settings.theme.preview)
    n.settings.theme.editor.match(/^https?:\/\//) or (n.settings.theme.editor = n.settings.basePath + n.settings.theme.editor)
    n.settings.theme.base.match(/^https?:\/\//) or (n.settings.theme.base = n.settings.basePath + n.settings.theme.base)
    (if typeof n.settings.container is "string" then n.element = document.getElementById(n.settings.container) else typeof n.settings.container is "object" and (n.element = n.settings.container))
    n.settings.file.name or ((if typeof n.settings.container is "string" then n.settings.file.name = n.settings.container else typeof n.settings.container is "object" and ((if n.element.id then n.settings.file.name = n.element.id else (b._data.unnamedEditors or (b._data.unnamedEditors = [])
    b._data.unnamedEditors.push(n)
    n.settings.file.name = "__epiceditor-untitled-" + b._data.unnamedEditors.length
    )))))
    n.settings.button.bar is "show" and (n.settings.button.bar = not 0)
    n.settings.button.bar is "hide" and (n.settings.button.bar = not 1)
    n._instanceId = "epiceditor-" + Math.round(Math.random() * 1e5)
    n._storage = {}
    n._canSave = not 0
    n._defaultFileSchema = ->
      content: n.settings.file.defaultContent
      created: new Date
      modified: new Date

    localStorage and n.settings.clientSideStorage and (@_storage = localStorage
    @_storage[n.settings.localStorageName] and n.getFiles(n.settings.file.name) is t and (s = n._defaultFileSchema()
    s.content = n.settings.file.defaultContent
    )
    )
    @_storage[n.settings.localStorageName] or (u = {}
    u[n.settings.file.name] = n._defaultFileSchema()
    u = JSON.stringify(u)
    @_storage[n.settings.localStorageName] = u
    )
    n._previewDraftLocation = "__draft-"
    n._storage[n._previewDraftLocation + n.settings.localStorageName] = n._storage[n.settings.localStorageName]
    n._eeState =
      fullscreen: not 1
      preview: not 1
      edit: not 1
      loaded: not 1
      unloaded: not 1

    n.events or (n.events = {})
    this
  b::load = (t) ->
    O = (t) ->
      return  if n.settings.button.bar isnt "auto"
      if Math.abs(g.y - t.pageY) >= 5 or Math.abs(g.x - t.pageX) >= 5
        h.style.display = "block"
        p and clearTimeout(p)
        p = e.setTimeout(->
          h.style.display = "none"
          return
        , 1e3)
      g =
        y: t.pageY
        x: t.pageX

      return
    M = (e) ->
      e.keyCode is n.settings.shortcut.modifier and (N = not 0)
      e.keyCode is 17 and (C = not 0)
      N is not 0 and e.keyCode is n.settings.shortcut.preview and not n.is("fullscreen") and (e.preventDefault()
      (if n.is("edit") and n._previewEnabled then n.preview() else n._editEnabled and n.edit())
      )
      N is not 0 and e.keyCode is n.settings.shortcut.fullscreen and n._fullscreenEnabled and (e.preventDefault()
      n._goFullscreen(T)
      )
      N is not 0 and e.keyCode isnt n.settings.shortcut.modifier and (N = not 1)
      e.keyCode is 27 and n.is("fullscreen") and n._exitFullscreen(T)
      C is not 0 and e.keyCode is 83 and (n.save()
      e.preventDefault()
      C = not 1
      )
      e.metaKey and e.keyCode is 83 and (n.save()
      e.preventDefault()
      )

      return
    _ = (e) ->
      e.keyCode is n.settings.shortcut.modifier and (N = not 1)
      e.keyCode is 17 and (C = not 1)

      return
    D = (t) ->
      r = undefined
      (if t.clipboardData then (t.preventDefault()
      r = t.clipboardData.getData("text/plain")
      n.editorIframeDocument.execCommand("insertText", not 1, r)
      ) else e.clipboardData and (t.preventDefault()
      r = e.clipboardData.getData("Text")
      r = r.replace(/</g, "&lt;")
      r = r.replace(/>/g, "&gt;")
      r = r.replace(/\n/g, "<br>")
      r = r.replace(/\r/g, "")
      r = r.replace(/<br>\s/g, "<br>&nbsp;")
      r = r.replace(/\s\s\s/g, "&nbsp; &nbsp;")
      r = r.replace(/\s\s/g, "&nbsp; ")
      n.editorIframeDocument.selection.createRange().pasteHTML(r)
      ))
      return
    return this  if @is("loaded")
    n = this
    o = undefined
    u = undefined
    f = undefined
    c = undefined
    h = undefined
    p = undefined
    m = undefined
    g =
      y: -1
      x: -1

    y = undefined
    b = undefined
    w = not 1
    E = not 1
    S = not 1
    x = not 1
    T = undefined
    N = not 1
    C = not 1
    k = undefined
    L = undefined
    A = undefined
    n._eeState.startup = not 0
    n.settings.useNativeFullscreen and (E = (if document.body.webkitRequestFullScreen then not 0 else not 1)
    S = (if document.body.mozRequestFullScreen then not 0 else not 1)
    x = (if document.body.requestFullscreen then not 0 else not 1)
    w = E or S or x
    )
    v() and (w = not 1
    E = not 1
    )
    not n.is("edit") and not n.is("preview") and (n._eeState.edit = not 0)
    t = t or ->

    o =
      chrome: "<div id=\"epiceditor-wrapper\" class=\"epiceditor-edit-mode\"><iframe frameborder=\"0\" id=\"epiceditor-editor-frame\"></iframe><iframe frameborder=\"0\" id=\"epiceditor-previewer-frame\"></iframe><div id=\"epiceditor-utilbar\">" + ((if n._previewEnabled then "<button title=\"" + @settings.string.togglePreview + "\" class=\"epiceditor-toggle-btn epiceditor-toggle-preview-btn\"></button> " else "")) + ((if n._editEnabled then "<button title=\"" + @settings.string.toggleEdit + "\" class=\"epiceditor-toggle-btn epiceditor-toggle-edit-btn\"></button> " else "")) + ((if n._fullscreenEnabled then "<button title=\"" + @settings.string.toggleFullscreen + "\" class=\"epiceditor-fullscreen-btn\"></button>" else "")) + "</div>" + "</div>"
      previewer: "<div id=\"epiceditor-preview\"></div>"
      editor: "<!doctype HTML>"

    n.element.innerHTML = "<iframe scrolling=\"no\" frameborder=\"0\" id= \"" + n._instanceId + "\"></iframe>"
    n.element.style.height = n.element.offsetHeight + "px"
    u = document.getElementById(n._instanceId)
    n.iframeElement = u
    n.iframe = l(u)
    n.iframe.open()
    n.iframe.write(o.chrome)
    n.editorIframe = n.iframe.getElementById("epiceditor-editor-frame")
    n.previewerIframe = n.iframe.getElementById("epiceditor-previewer-frame")
    n.editorIframeDocument = l(n.editorIframe)
    n.editorIframeDocument.open()
    n.editorIframeDocument.write(o.editor)
    n.editorIframeDocument.close()
    n.previewerIframeDocument = l(n.previewerIframe)
    n.previewerIframeDocument.open()
    n.previewerIframeDocument.write(o.previewer)
    f = n.previewerIframeDocument.createElement("base")
    f.target = "_blank"
    n.previewerIframeDocument.getElementsByTagName("head")[0].appendChild(f)
    n.previewerIframeDocument.close()
    n.reflow()
    a(n.settings.theme.base, n.iframe, "theme")
    a(n.settings.theme.editor, n.editorIframeDocument, "theme")
    a(n.settings.theme.preview, n.previewerIframeDocument, "theme")
    n.iframe.getElementById("epiceditor-wrapper").style.position = "relative"
    n.editorIframe.style.position = "absolute"
    n.previewerIframe.style.position = "absolute"
    n.editor = n.editorIframeDocument.body
    n.previewer = n.previewerIframeDocument.getElementById("epiceditor-preview")
    n.editor.contentEditable = not 0
    n.iframe.body.style.height = @element.offsetHeight + "px"
    n.previewerIframe.style.left = "-999999px"
    @editorIframeDocument.body.style.wordWrap = "break-word"
    d() > -1 and (@previewer.style.height = parseInt(i(@previewer, "height"), 10) + 2)
    @open(n.settings.file.name)
    n.settings.focusOnLoad and n.iframe.addEventListener("readystatechange", ->
      n.iframe.readyState is "complete" and n.focus()
      return
    )
    n.previewerIframeDocument.addEventListener("click", (t) ->
      r = t.target
      i = n.previewerIframeDocument.body
      r.nodeName is "A" and r.hash and r.hostname is e.location.hostname and (t.preventDefault()
      r.target = "_self"
      i.querySelector(r.hash) and (i.scrollTop = i.querySelector(r.hash).offsetTop)
      )
      return
    )
    c = n.iframe.getElementById("epiceditor-utilbar")
    y = {}
    n._goFullscreen = (t) ->
      @_fixScrollbars "auto"
      if n.is("fullscreen")
        n._exitFullscreen t
        return
      w and ((if E then t.webkitRequestFullScreen() else (if S then t.mozRequestFullScreen() else x and t.requestFullscreen())))
      b = n.is("edit")
      n._eeState.fullscreen = not 0
      n._eeState.edit = not 0
      n._eeState.preview = not 0

      r = e.innerWidth
      o = e.innerHeight
      u = e.outerWidth
      a = e.outerHeight
      w or (a = e.innerHeight)
      y.editorIframe = s(n.editorIframe, "save",
        width: u / 2 + "px"
        height: a + "px"
        float: "left"
        cssFloat: "left"
        styleFloat: "left"
        display: "block"
        position: "static"
        left: ""
      )
      y.previewerIframe = s(n.previewerIframe, "save",
        width: u / 2 + "px"
        height: a + "px"
        float: "right"
        cssFloat: "right"
        styleFloat: "right"
        display: "block"
        position: "static"
        left: ""
      )
      y.element = s(n.element, "save",
        position: "fixed"
        top: "0"
        left: "0"
        width: "100%"
        "z-index": "9999"
        zIndex: "9999"
        border: "none"
        margin: "0"
        background: i(n.editor, "background-color")
        height: o + "px"
      )
      y.iframeElement = s(n.iframeElement, "save",
        width: u + "px"
        height: o + "px"
      )
      c.style.visibility = "hidden"
      w or (document.body.style.overflow = "hidden")
      n.preview()
      n.focus()
      n.emit("fullscreenenter")

      return

    n._exitFullscreen = (e) ->
      @_fixScrollbars()
      s(n.element, "apply", y.element)
      s(n.iframeElement, "apply", y.iframeElement)
      s(n.editorIframe, "apply", y.editorIframe)
      s(n.previewerIframe, "apply", y.previewerIframe)
      n.element.style.width = (if n._eeState.reflowWidth then n._eeState.reflowWidth else "")
      n.element.style.height = (if n._eeState.reflowHeight then n._eeState.reflowHeight else "")
      c.style.visibility = "visible"
      n._eeState.fullscreen = not 1
      (if w then (if E then document.webkitCancelFullScreen() else (if S then document.mozCancelFullScreen() else x and document.exitFullscreen())) else document.body.style.overflow = "auto")
      (if b then n.edit() else n.preview())
      n.reflow()
      n.emit("fullscreenexit")

      return

    n.editor.addEventListener("keyup", ->
      m and e.clearTimeout(m)
      m = e.setTimeout(->
        n.is("fullscreen") and n.preview()
        return
      , 250)

      return
    )
    T = n.iframeElement
    c.addEventListener("click", (e) ->
      t = e.target.className
      (if t.indexOf("epiceditor-toggle-preview-btn") > -1 then n.preview() else (if t.indexOf("epiceditor-toggle-edit-btn") > -1 then n.edit() else t.indexOf("epiceditor-fullscreen-btn") > -1 and n._goFullscreen(T)))
      return
    )
    (if E then document.addEventListener("webkitfullscreenchange", ->
      not document.webkitIsFullScreen and n._eeState.fullscreen and n._exitFullscreen(T)
      return
    , not 1) else (if S then document.addEventListener("mozfullscreenchange", ->
      not document.mozFullScreen and n._eeState.fullscreen and n._exitFullscreen(T)
      return
    , not 1) else x and document.addEventListener("fullscreenchange", ->
      not document.fullscreenElement? and n._eeState.fullscreen and n._exitFullscreen(T)
      return
    , not 1)))
    h = n.iframe.getElementById("epiceditor-utilbar")
    n.settings.button.bar isnt not 0 and (h.style.display = "none")
    h.addEventListener("mouseover", ->
      p and clearTimeout(p)
      return
    )
    k = [
      n.previewerIframeDocument
      n.editorIframeDocument
    ]

    L = 0
    while L < k.length
      k[L].addEventListener("mousemove", (e) ->
        O e
        return
      )
      k[L].addEventListener("scroll", (e) ->
        O e
        return
      )
      k[L].addEventListener("keyup", (e) ->
        _ e
        return
      )
      k[L].addEventListener("keydown", (e) ->
        M e
        return
      )
      k[L].addEventListener("paste", (e) ->
        D e
        return
      )
      L++
    n.settings.file.autoSave and (n._saveIntervalTimer = e.setInterval(->
      return  unless n._canSave
      n.save not 1, not 0
      return
    , n.settings.file.autoSave))
    n.settings.textarea and n._setupTextareaSync()
    e.addEventListener("resize", ->
      (if n.is("fullscreen") then (r(n.iframeElement,
        width: e.outerWidth + "px"
        height: e.innerHeight + "px"
      )
      r(n.element,
        height: e.innerHeight + "px"
      )
      r(n.previewerIframe,
        width: e.outerWidth / 2 + "px"
        height: e.innerHeight + "px"
      )
      r(n.editorIframe,
        width: e.outerWidth / 2 + "px"
        height: e.innerHeight + "px"
      )
      ) else n.is("fullscreen") or n.reflow())
      return
    )
    n._eeState.loaded = not 0
    n._eeState.unloaded = not 1
    (if n.is("preview") then n.preview() else n.edit())
    n.iframe.close()
    n._eeState.startup = not 1
    n.settings.autogrow and (n._fixScrollbars()
    A = ->
      setTimeout (->
        n._autogrow()
        return
      ), 1
      return

    [
      "keydown"
      "keyup"
      "paste"
      "cut"
    ].forEach((e) ->
      n.getElement("editor").addEventListener e, A
      return
    )
    n.on("__update", A)
    n.on("edit", ->
      setTimeout A, 50
      return
    )
    n.on("preview", ->
      setTimeout A, 50
      return
    )
    setTimeout(A, 50)
    A()
    )
    t.call(this)
    @emit("load")
    this

  b::_setupTextareaSync = ->
    t = this
    n = t.settings.file.name
    r = undefined
    t._textareaSaveTimer = e.setInterval(->
      return  unless t._canSave
      t.save not 0
      return
    , 100)
    r = ->
      t._textareaElement.value = t.exportFile(n, "text", not 0) or t.settings.file.defaultContent
      return

    (if typeof t.settings.textarea is "string" then t._textareaElement = document.getElementById(t.settings.textarea) else typeof t.settings.textarea is "object" and (t._textareaElement = t.settings.textarea))
    t._textareaElement.value isnt "" and (t.importFile(n, t._textareaElement.value)
    t.save(not 0)
    )
    r()
    t.on("__update", r)

    return

  b::_focusExceptOnLoad = ->
    e = this
    (e._eeState.startup and e.settings.focusOnLoad or not e._eeState.startup) and e.focus()
    return

  b::unload = (t) ->
    throw new Error("Editor isn't loaded")  if @is("unloaded")
    n = this
    r = e.parent.document.getElementById(n._instanceId)
    r.parentNode.removeChild(r)
    n._eeState.loaded = not 1
    n._eeState.unloaded = not 0
    t = t or ->

    n.settings.textarea and (n._textareaElement.value = ""
    n.removeListener("__update")
    )
    n._saveIntervalTimer and e.clearInterval(n._saveIntervalTimer)
    n._textareaSaveTimer and e.clearInterval(n._textareaSaveTimer)
    t.call(this)
    n.emit("unload")
    n

  b::reflow = (e, t) ->
    n = this
    r = o(n.element) - n.element.offsetWidth
    i = u(n.element) - n.element.offsetHeight
    s = [
      n.iframeElement
      n.editorIframe
      n.previewerIframe
    ]
    a = {}
    f = undefined
    l = undefined
    typeof e is "function" and (t = e
    e = null
    )
    t or (t = ->
    )

    c = 0

    while c < s.length
      if not e or e is "width"
        f = n.element.offsetWidth - r + "px"
        s[c].style.width = f
        n._eeState.reflowWidth = f
        a.width = f
      if not e or e is "height"
        l = n.element.offsetHeight - i + "px"
        s[c].style.height = l
        n._eeState.reflowHeight = l
        a.height = l
      c++
    n.emit("reflow", a)
    t.call(this, a)
    n

  b::preview = ->
    e = this
    t = undefined
    n = e.settings.theme.preview
    r = undefined
    f(e.getElement("wrapper"), "epiceditor-edit-mode", "epiceditor-preview-mode")
    (if e.previewerIframeDocument.getElementById("theme") then e.previewerIframeDocument.getElementById("theme").name isnt n and (e.previewerIframeDocument.getElementById("theme").href = n) else a(n, e.previewerIframeDocument, "theme"))
    e.save(not 0)
    e.previewer.innerHTML = e.exportFile(null, "html", not 0)
    e.is("fullscreen") or (e.editorIframe.style.left = "-999999px"
    e.previewerIframe.style.left = ""
    e._eeState.preview = not 0
    e._eeState.edit = not 1
    e._focusExceptOnLoad()
    )
    e.emit("preview")
    e

  b::focus = (e) ->
    t = this
    n = t.is("preview")
    r = (if n then t.previewerIframeDocument.body else t.editorIframeDocument.body)
    m() and n and (r = t.previewerIframe)
    r.focus()
    this

  b::enterFullscreen = ->
    (if @is("fullscreen") then this else (@_goFullscreen(@iframeElement)
    this
    ))

  b::exitFullscreen = ->
    (if @is("fullscreen") then (@_exitFullscreen(@iframeElement)
    this
    ) else this)

  b::edit = ->
    e = this
    f(e.getElement("wrapper"), "epiceditor-preview-mode", "epiceditor-edit-mode")
    e._eeState.preview = not 1
    e._eeState.edit = not 0
    e.editorIframe.style.left = ""
    e.previewerIframe.style.left = "-999999px"
    e._focusExceptOnLoad()
    e.emit("edit")
    this

  b::getElement = (e) ->
    t =
      container: @element
      wrapper: @iframe.getElementById("epiceditor-wrapper")
      wrapperIframe: @iframeElement
      editor: @editorIframeDocument
      editorIframe: @editorIframe
      previewer: @previewerIframeDocument
      previewerIframe: @previewerIframe

    (if not t[e] or @is("unloaded") then null else t[e])

  b::is = (e) ->
    t = this
    switch e
      when "loaded"
        t._eeState.loaded
      when "unloaded"
        t._eeState.unloaded
      when "preview"
        t._eeState.preview
      when "edit"
        t._eeState.edit
      when "fullscreen"
        t._eeState.fullscreen
      else
        not 1

  b::open = (e) ->
    n = this
    r = n.settings.file.defaultContent
    i = undefined
    e = e or n.settings.file.name
    n.settings.file.name = e
    @_storage[n.settings.localStorageName] and (i = n.exportFile(e)
    (if i isnt t then (h(n.editor, i)
    n.emit("read")
    ) else (h(n.editor, r)
    n.save()
    n.emit("create")
    ))
    n.previewer.innerHTML = n.exportFile(null, "html")
    n.emit("open")
    )
    this

  b::save = (e, n) ->
    r = this
    i = undefined
    s = not 1
    o = r.settings.file.name
    u = ""
    a = @_storage[u + r.settings.localStorageName]
    f = c(@editor)
    e and (u = r._previewDraftLocation)
    @_canSave = not 0

    if a
      i = JSON.parse(@_storage[u + r.settings.localStorageName])
      if i[o] is t
        i[o] = r._defaultFileSchema()
      else if f isnt i[o].content
        i[o].modified = new Date
        s = not 0
      else return  if n
      i[o].content = f
      @_storage[u + r.settings.localStorageName] = JSON.stringify(i)
      s and (r.emit("update")
      r.emit("__update")
      )
      (if n then @emit("autosave") else e or @emit("save"))
    this

  b::remove = (e) ->
    t = this
    n = undefined
    e = e or t.settings.file.name
    e is t.settings.file.name and (t._canSave = not 1)
    n = JSON.parse(@_storage[t.settings.localStorageName])
    delete n[e]

    @_storage[t.settings.localStorageName] = JSON.stringify(n)
    @emit("remove")
    this

  b::rename = (e, t) ->
    n = this
    r = JSON.parse(@_storage[n.settings.localStorageName])
    r[t] = r[e]
    delete r[e]

    @_storage[n.settings.localStorageName] = JSON.stringify(r)
    n.open(t)
    this

  b::importFile = (e, n, r, i) ->
    s = this
    o = not 1
    e = e or s.settings.file.name
    n = n or ""
    r = r or "md"
    i = i or {}
    JSON.parse(@_storage[s.settings.localStorageName])[e] is t and (o = not 0)
    s.settings.file.name = e
    h(s.editor, n)
    o and s.emit("create")
    s.save()
    s.is("fullscreen") and s.preview()
    s.settings.autogrow and setTimeout(->
      s._autogrow()
      return
    , 50)
    this

  b::_getFileStore = (e, t) ->
    n = ""
    r = undefined
    t and (n = @_previewDraftLocation)
    r = JSON.parse(@_storage[n + @settings.localStorageName])
    (if e then r[e] else r)

  b::exportFile = (e, n, r) ->
    i = this
    s = undefined
    o = undefined
    e = e or i.settings.file.name
    n = n or "text"
    s = i._getFileStore(e, r)

    return  if s is t
    o = s.content
    switch n
      when "html"
        o = p(o)
        i.settings.parser(o)
      when "text"
        p o
      when "json"
        s.content = p(s.content)
        JSON.stringify(s)
      when "raw"
        o
      else
        o

  b::getFiles = (e, n) ->
    r = undefined
    i = @_getFileStore(e)
    if e
      return i isnt t and ((if n then delete i.content
       else i.content = p(i.content)))
      i
    for r of i
      continue
    i

  b::on = (e, t) ->
    n = this
    @events[e] or (@events[e] = [])
    @events[e].push(t)
    n

  b::emit = (e, t) ->
    i = (e) ->
      e.call n, t
      return
    n = this
    r = undefined
    t = t or n.getFiles(n.settings.file.name)
    return  unless @events[e]
    r = 0
    while r < n.events[e].length
      i n.events[e][r]
      r++
    n

  b::removeListener = (e, t) ->
    n = this
    (if t then (if @events[e] then (@events[e].splice(@events[e].indexOf(t), 1)
    n
    ) else n) else (@events[e] = []
    n
    ))

  b::_autogrow = ->
    t = undefined
    n = undefined
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    a = not 1
    @is("fullscreen") or ((if @is("edit") then s = @getElement("editor").documentElement else s = @getElement("previewer").documentElement)
    t = u(s)
    n = t
    r = @settings.autogrow.minHeight
    typeof r is "function" and (r = r(this))
    r and n < r and (n = r)
    i = @settings.autogrow.maxHeight
    typeof i is "function" and (i = i(this))
    i and n > i and (n = i
    a = not 0
    )
    (if a then @_fixScrollbars("auto") else @_fixScrollbars("hidden"))
    n isnt @oldHeight and (@getElement("container").style.height = n + "px"
    @reflow()
    @settings.autogrow.scroll and e.scrollBy(0, n - @oldHeight)
    @oldHeight = n
    )
    )
    return

  b::_fixScrollbars = (e) ->
    t = undefined
    (if @settings.autogrow then t = "hidden" else t = "auto")
    t = e or t
    @getElement("editor").documentElement.style.overflow = t
    @getElement("previewer").documentElement.style.overflow = t

    return

  b.version = "0.2.2"
  b._data = {}
  e.EpicEditor = b

  return
)(window)
(->
  t = (t) ->
    @tokens = []
    @tokens.links = {}
    @options = t or f.defaults
    @rules = e.normal
    @options.gfm and ((if @options.tables then @rules = e.tables else @rules = e.gfm))

    return
  r = (e, t) ->
    @options = t or f.defaults
    @links = e
    @rules = n.normal

    throw new Error("Tokens array requires a `links` property.")  unless @links
    (if @options.gfm then (if @options.breaks then @rules = n.breaks else @rules = n.gfm) else @options.pedantic and (@rules = n.pedantic))
    return
  i = (e) ->
    @tokens = []
    @token = null
    @options = e or f.defaults

    return
  s = (e, t) ->
    e.replace((if t then /&/g else /&(?!#?\w+;)/g), "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace /'/g, "&#39;"
  o = (e, t) ->
    e = e.source
    t = t or ""
    n = (r, i) ->
      (if r then (i = i.source or i
      i = i.replace(/(^|[^\[])\^/g, "$1")
      e = e.replace(r, i)
      n
      ) else new RegExp(e, t))
  u = ->
  a = (e) ->
    t = 1
    n = undefined
    r = undefined
    while t < arguments_.length
      n = arguments_[t]
      for r of n
        continue
      t++
    e
  f = (e, n) ->
    try
      return i.parse(t.lex(e, n), n)
    catch r
      r.message += "\nPlease report this to https://github.com/chjj/marked."
      return "An error occured:\n" + r.message  if (n or f.defaults).silent
      throw r
    return
  e =
    newline: /^\n+/
    code: /^( {4}[^\n]+\n*)+/
    fences: u
    hr: /^( *[-*_]){3,} *(?:\n+|$)/
    heading: /^ *(#{1,6}) *([^\n]+?) *#* *(?:\n+|$)/
    nptable: u
    lheading: /^([^\n]+)\n *(=|-){3,} *\n*/
    blockquote: /^( *>[^\n]+(\n[^\n]+)*\n*)+/
    list: /^( *)(bull) [\s\S]+?(?:hr|\n{2,}(?! )(?!\1bull )\n*|\s*$)/
    html: /^ *(?:comment|closed|closing) *(?:\n{2,}|\s*$)/
    def: /^ *\[([^\]]+)\]: *([^\s]+)(?: +["(]([^\n]+)[")])? *(?:\n+|$)/
    table: u
    paragraph: /^([^\n]+\n?(?!hr|heading|lheading|blockquote|tag|def))+\n*/
    text: /^[^\n]+/

  e.bullet = /(?:[*+-]|\d+\.)/
  e.item = /^( *)(bull) [^\n]*(?:\n(?!\1bull )[^\n]*)*/
  e.item = o(e.item, "gm")(/bull/g, e.bullet)()
  e.list = o(e.list)(/bull/g, e.bullet)("hr", /\n+(?=(?: *[-*_]){3,} *(?:\n+|$))/)()
  e._tag = "(?!(?:a|em|strong|small|s|cite|q|dfn|abbr|data|time|code|var|samp|kbd|sub|sup|i|b|u|mark|ruby|rt|rp|bdi|bdo|span|br|wbr|ins|del|img)\\b)\\w+(?!:/|@)\\b"
  e.html = o(e.html)("comment", /<!--[\s\S]*?-->/)("closed", /<(tag)[\s\S]+?<\/\1>/)("closing", /<tag(?:"[^"]*"|'[^']*'|[^'">])*?>/)(/tag/g, e._tag)()
  e.paragraph = o(e.paragraph)("hr", e.hr)("heading", e.heading)("lheading", e.lheading)("blockquote", e.blockquote)("tag", "<" + e._tag)("def", e.def)()
  e.normal = a({}, e)
  e.gfm = a({}, e.normal,
    fences: /^ *(`{3,}|~{3,}) *(\w+)? *\n([\s\S]+?)\s*\1 *(?:\n+|$)/
    paragraph: /^/
  )
  e.gfm.paragraph = o(e.paragraph)("(?!", "(?!" + e.gfm.fences.source.replace("\\1", "\\2") + "|")()
  e.tables = a({}, e.gfm,
    nptable: /^ *(\S.*\|.*)\n *([-:]+ *\|[-| :]*)\n((?:.*\|.*(?:\n|$))*)\n*/
    table: /^ *\|(.+)\n *\|( *[-:]+[-| :]*)\n((?: *\|.*(?:\n|$))*)\n*/
  )
  t.rules = e
  t.lex = (e, n) ->
    r = new t(n)
    r.lex e

  t::lex = (e) ->
    e = e.replace(/\r\n|\r/g, "\n").replace(/\t/g, "    ").replace(/\u00a0/g, " ").replace(/\u2424/g, "\n")
    @token(e, not 0)

  t::token = (e, t) ->
    e = e.replace(/^ +$/g, "")
    n = undefined
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    u = undefined
    a = undefined
    while e
      if i = @rules.newline.exec(e)
        e = e.substring(i[0].length)
        i[0].length > 1 and @tokens.push(type: "space")
      if i = @rules.code.exec(e)
        e = e.substring(i[0].length)
        i = i[0].replace(/^ {4}/g, "")
        @tokens.push(
          type: "code"
          text: (if @options.pedantic then i else i.replace(/\n+$/, ""))
        )

        continue
      if i = @rules.fences.exec(e)
        e = e.substring(i[0].length)
        @tokens.push(
          type: "code"
          lang: i[2]
          text: i[3]
        )

        continue
      if i = @rules.heading.exec(e)
        e = e.substring(i[0].length)
        @tokens.push(
          type: "heading"
          depth: i[1].length
          text: i[2]
        )

        continue
      if t and (i = @rules.nptable.exec(e))
        e = e.substring(i[0].length)
        s =
          type: "table"
          header: i[1].replace(/^ *| *\| *$/g, "").split(RegExp(" *\\| *"))
          align: i[2].replace(/^ *|\| *$/g, "").split(RegExp(" *\\| *"))
          cells: i[3].replace(/\n$/, "").split("\n")


        u = 0
        while u < s.align.length
          (if /^ *-+: *$/.test(s.align[u]) then s.align[u] = "right" else (if /^ *:-+: *$/.test(s.align[u]) then s.align[u] = "center" else (if /^ *:-+ *$/.test(s.align[u]) then s.align[u] = "left" else s.align[u] = null)))
          u++
        u = 0
        while u < s.cells.length
          s.cells[u] = s.cells[u].split(RegExp(" *\\| *"))
          u++
        @tokens.push s
        continue
      if i = @rules.lheading.exec(e)
        e = e.substring(i[0].length)
        @tokens.push(
          type: "heading"
          depth: (if i[2] is "=" then 1 else 2)
          text: i[1]
        )

        continue
      if i = @rules.hr.exec(e)
        e = e.substring(i[0].length)
        @tokens.push(type: "hr")

        continue
      if i = @rules.blockquote.exec(e)
        e = e.substring(i[0].length)
        @tokens.push(type: "blockquote_start")
        i = i[0].replace(/^ *> ?/g, "")
        @token(i, t)
        @tokens.push(type: "blockquote_end")

        continue
      if i = @rules.list.exec(e)
        e = e.substring(i[0].length)
        @tokens.push(
          type: "list_start"
          ordered: isFinite(i[2])
        )
        i = i[0].match(@rules.item)
        n = not 1
        a = i.length
        u = 0

        while u < a
          s = i[u]
          o = s.length
          s = s.replace(/^ *([*+-]|\d+\.) +/, "")
          ~s.indexOf("\n ") and (o -= s.length
          s = (if @options.pedantic then s.replace(/^ {1,4}/g, "") else s.replace(new RegExp("^ {1," + o + "}", "gm"), ""))
          )
          r = n or /\n\n(?!\s*$)/.test(s)
          u isnt a - 1 and (n = s[s.length - 1] is "\n"
          r or (r = n)
          )
          @tokens.push(type: (if r then "loose_item_start" else "list_item_start"))
          @token(s, not 1)
          @tokens.push(type: "list_item_end")
          u++
        @tokens.push type: "list_end"
        continue
      if i = @rules.html.exec(e)
        e = e.substring(i[0].length)
        @tokens.push(
          type: (if @options.sanitize then "paragraph" else "html")
          pre: i[1] is "pre"
          text: i[0]
        )

        continue
      if t and (i = @rules.def.exec(e))
        e = e.substring(i[0].length)
        @tokens.links[i[1].toLowerCase()] =
          href: i[2]
          title: i[3]


        continue
      if t and (i = @rules.table.exec(e))
        e = e.substring(i[0].length)
        s =
          type: "table"
          header: i[1].replace(/^ *| *\| *$/g, "").split(RegExp(" *\\| *"))
          align: i[2].replace(/^ *|\| *$/g, "").split(RegExp(" *\\| *"))
          cells: i[3].replace(/(?: *\| *)?\n$/, "").split("\n")


        u = 0
        while u < s.align.length
          (if /^ *-+: *$/.test(s.align[u]) then s.align[u] = "right" else (if /^ *:-+: *$/.test(s.align[u]) then s.align[u] = "center" else (if /^ *:-+ *$/.test(s.align[u]) then s.align[u] = "left" else s.align[u] = null)))
          u++
        u = 0
        while u < s.cells.length
          s.cells[u] = s.cells[u].replace(/^ *\| *| *\| *$/g, "").split(RegExp(" *\\| *"))
          u++
        @tokens.push s
        continue
      if t and (i = @rules.paragraph.exec(e))
        e = e.substring(i[0].length)
        @tokens.push(
          type: "paragraph"
          text: i[0]
        )

        continue
      if i = @rules.text.exec(e)
        e = e.substring(i[0].length)
        @tokens.push(
          type: "text"
          text: i[0]
        )

        continue
      throw new Error("Infinite loop on byte: " + e.charCodeAt(0))  if e
    @tokens


  n =
    escape: /^\\([\\`*{}\[\]()#+\-.!_>|])/
    autolink: /^<([^ >]+(@|:\/)[^ >]+)>/
    url: u
    tag: /^<!--[\s\S]*?-->|^<\/?\w+(?:"[^"]*"|'[^']*'|[^'">])*?>/
    link: /^!?\[(inside)\]\(href\)/
    reflink: /^!?\[(inside)\]\s*\[([^\]]*)\]/
    nolink: /^!?\[((?:\[[^\]]*\]|[^\[\]])*)\]/
    strong: /^__([\s\S]+?)__(?!_)|^\*\*([\s\S]+?)\*\*(?!\*)/
    em: /^\b_((?:__|[\s\S])+?)_\b|^\*((?:\*\*|[\s\S])+?)\*(?!\*)/
    code: /^(`+)([\s\S]*?[^`])\1(?!`)/
    br: /^ {2,}\n(?!\s*$)/
    del: u
    text: /^[\s\S]+?(?=[\\<!\[_*`]| {2,}\n|$)/

  n._inside = /(?:\[[^\]]*\]|[^\]]|\](?=[^\[]*\]))*/
  n._href = /\s*<?([^\s]*?)>?(?:\s+['"]([\s\S]*?)['"])?\s*/
  n.link = o(n.link)("inside", n._inside)("href", n._href)()
  n.reflink = o(n.reflink)("inside", n._inside)()
  n.normal = a({}, n)
  n.pedantic = a({}, n.normal,
    strong: /^__(?=\S)([\s\S]*?\S)__(?!_)|^\*\*(?=\S)([\s\S]*?\S)\*\*(?!\*)/
    em: /^_(?=\S)([\s\S]*?\S)_(?!_)|^\*(?=\S)([\s\S]*?\S)\*(?!\*)/
  )
  n.gfm = a({}, n.normal,
    escape: o(n.escape)("])", "~])")()
    url: /^(https?:\/\/[^\s]+[^.,:;"')\]\s])/
    del: /^~{2,}([\s\S]+?)~{2,}/
    text: o(n.text)("]|", "~]|")("|", "|https?://|")()
  )
  n.breaks = a({}, n.gfm,
    br: o(n.br)("{2,}", "*")()
    text: o(n.gfm.text)("{2,}", "*")()
  )
  r.rules = n
  r.output = (e, t, n) ->
    i = new r(t, n)
    i.output e

  r::output = (e) ->
    t = ""
    n = undefined
    r = undefined
    i = undefined
    o = undefined
    while e
      if o = @rules.escape.exec(e)
        e = e.substring(o[0].length)
        t += o[1]

        continue
      if o = @rules.autolink.exec(e)
        e = e.substring(o[0].length)
        (if o[2] is "@" then (r = (if o[1][6] is ":" then @mangle(o[1].substring(7)) else @mangle(o[1]))
        i = @mangle("mailto:") + r
        ) else (r = s(o[1])
        i = r
        ))
        t += "<a href=\"" + i + "\">" + r + "</a>"

        continue
      if o = @rules.url.exec(e)
        e = e.substring(o[0].length)
        r = s(o[1])
        i = r
        t += "<a href=\"" + i + "\">" + r + "</a>"

        continue
      if o = @rules.tag.exec(e)
        e = e.substring(o[0].length)
        t += (if @options.sanitize then s(o[0]) else o[0])

        continue
      if o = @rules.link.exec(e)
        e = e.substring(o[0].length)
        t += @outputLink(o,
          href: o[2]
          title: o[3]
        )

        continue
      if (o = @rules.reflink.exec(e)) or (o = @rules.nolink.exec(e))
        e = e.substring(o[0].length)
        n = (o[2] or o[1]).replace(/\s+/g, " ")
        n = @links[n.toLowerCase()]

        if not n or not n.href
          t += o[0][0]
          e = o[0].substring(1) + e

          continue
        t += @outputLink(o, n)
        continue
      if o = @rules.strong.exec(e)
        e = e.substring(o[0].length)
        t += "<strong>" + @output(o[2] or o[1]) + "</strong>"

        continue
      if o = @rules.em.exec(e)
        e = e.substring(o[0].length)
        t += "<em>" + @output(o[2] or o[1]) + "</em>"

        continue
      if o = @rules.code.exec(e)
        e = e.substring(o[0].length)
        t += "<code>" + s(o[2], not 0) + "</code>"

        continue
      if o = @rules.br.exec(e)
        e = e.substring(o[0].length)
        t += "<br>"

        continue
      if o = @rules.del.exec(e)
        e = e.substring(o[0].length)
        t += "<del>" + @output(o[1]) + "</del>"

        continue
      if o = @rules.text.exec(e)
        e = e.substring(o[0].length)
        t += s(o[0])

        continue
      throw new Error("Infinite loop on byte: " + e.charCodeAt(0))  if e
    t

  r::outputLink = (e, t) ->
    (if e[0][0] isnt "!" then "<a href=\"" + s(t.href) + "\"" + ((if t.title then " title=\"" + s(t.title) + "\"" else "")) + ">" + @output(e[1]) + "</a>" else "<img src=\"" + s(t.href) + "\" alt=\"" + s(e[1]) + "\"" + ((if t.title then " title=\"" + s(t.title) + "\"" else "")) + ">")

  r::mangle = (e) ->
    t = ""
    n = e.length
    r = 0
    i = undefined
    while r < n
      i = e.charCodeAt(r)
      Math.random() > .5 and (i = "x" + i.toString(16))
      t += "&#" + i + ";"
      r++
    t

  i.parse = (e, t) ->
    n = new i(t)
    n.parse e

  i::parse = (e) ->
    @inline = new r(e.links, @options)
    @tokens = e.reverse()

    t = ""
    t += @tok()  while @next()
    t

  i::next = ->
    @token = @tokens.pop()

  i::peek = ->
    @tokens[@tokens.length - 1] or 0

  i::parseText = ->
    e = @token.text
    e += "\n" + @next().text  while @peek().type is "text"
    @inline.output e

  i::tok = ->
    switch @token.type
      when "space"
        ""
      when "hr"
        "<hr>\n"
      when "heading"
        "<h" + @token.depth + ">" + @inline.output(@token.text) + "</h" + @token.depth + ">\n"
      when "code"
        if @options.highlight
          e = @options.highlight(@token.text, @token.lang)
          e? and e isnt @token.text and (@token.escaped = not 0
          @token.text = e
          )
        @token.escaped or (@token.text = s(@token.text, not 0))
        "<pre><code" + ((if @token.lang then " class=\"lang-" + @token.lang + "\"" else "")) + ">" + @token.text + "</code></pre>\n"
      when "table"
        t = ""
        n = undefined
        r = undefined
        i = undefined
        o = undefined
        u = undefined
        t += "<thead>\n<tr>\n"
        r = 0
        while r < @token.header.length
          n = @inline.output(@token.header[r])
          t += (if @token.align[r] then "<th align=\"" + @token.align[r] + "\">" + n + "</th>\n" else "<th>" + n + "</th>\n")
          r++
        t += "</tr>\n</thead>\n"
        t += "<tbody>\n"

        r = 0
        while r < @token.cells.length
          i = @token.cells[r]
          t += "<tr>\n"

          u = 0
          while u < i.length
            o = @inline.output(i[u])
            t += (if @token.align[u] then "<td align=\"" + @token.align[u] + "\">" + o + "</td>\n" else "<td>" + o + "</td>\n")
            u++
          t += "</tr>\n"
          r++
        t += "</tbody>\n"
        "<table>\n" + t + "</table>\n"
      when "blockquote_start"
        t = ""
        t += @tok()  while @next().type isnt "blockquote_end"
        "<blockquote>\n" + t + "</blockquote>\n"
      when "list_start"
        a = (if @token.ordered then "ol" else "ul")
        t = ""
        t += @tok()  while @next().type isnt "list_end"
        "<" + a + ">\n" + t + "</" + a + ">\n"
      when "list_item_start"
        t = ""
        t += (if @token.type is "text" then @parseText() else @tok())  while @next().type isnt "list_item_end"
        "<li>" + t + "</li>\n"
      when "loose_item_start"
        t = ""
        t += @tok()  while @next().type isnt "list_item_end"
        "<li>" + t + "</li>\n"
      when "html"
        (if not @token.pre and not @options.pedantic then @inline.output(@token.text) else @token.text)
      when "paragraph"
        "<p>" + @inline.output(@token.text) + "</p>\n"
      when "text"
        "<p>" + @parseText() + "</p>\n"

  u.exec = u
  f.options = f.setOptions = (e) ->
    f.defaults = e
    f

  f.defaults =
    gfm: not 0
    tables: not 0
    breaks: not 1
    pedantic: not 1
    sanitize: not 1
    silent: not 1
    highlight: null

  f.Parser = i
  f.parser = i.parse
  f.Lexer = t
  f.lexer = t.lex
  f.InlineLexer = r
  f.inlineLexer = r.output
  f.parse = f
  (if typeof module isnt "undefined" then module.exports = f else (if typeof define is "function" and define.amd then define(->
    f
  ) else @marked = f))

  return
).call(->
  this or ((if typeof window isnt "undefined" then window else global))
())
