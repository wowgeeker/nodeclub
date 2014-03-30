#! jQuery v1.7.1 jquery.com | jquery.org/license 
((a, b) ->
  cy = (a) ->
    (if f.isWindow(a) then a else (if a.nodeType is 9 then a.defaultView or a.parentWindow else not 1))
  cv = (a) ->
    unless ck[a]
      b = c.body
      d = f("<" + a + ">").appendTo(b)
      e = d.css("display")
      d.remove()
      if e is "none" or e is ""
        cl or (cl = c.createElement("iframe")
        cl.frameBorder = cl.width = cl.height = 0
        )
        b.appendChild(cl)

        if not cm or not cl.createElement
          cm = (cl.contentWindow or cl.contentDocument).document
          cm.write(((if c.compatMode is "CSS1Compat" then "<!doctype html>" else "")) + "<html><body>")
          cm.close()
        d = cm.createElement(a)
        cm.body.appendChild(d)
        e = f.css(d, "display")
        b.removeChild(cl)
      ck[a] = e
    ck[a]
  cu = (a, b) ->
    c = {}
    f.each cq.concat.apply([], cq.slice(0, b)), ->
      c[this] = a
      return

    c
  ct = ->
    cr = b
    return
  cs = ->
    setTimeout ct, 0
    cr = f.now()
  cj = ->
    try
      return new a.ActiveXObject("Microsoft.XMLHTTP")
    return
  ci = ->
    try
      return new a.XMLHttpRequest
    return
  cc = (a, c) ->
    a.dataFilter and (c = a.dataFilter(c, a.dataType))
    d = a.dataTypes
    e = {}
    g = undefined
    h = undefined
    i = d.length
    j = undefined
    k = d[0]
    l = undefined
    m = undefined
    n = undefined
    o = undefined
    p = undefined
    g = 1
    while g < i
      if g is 1
        for h of a.converters
          continue
      l = k
      k = d[g]

      if k is "*"
        k = l
      else if l isnt "*" and l isnt k
        m = l + " " + k
        n = e[m] or e["* " + k]

        unless n
          p = b
          for o of e
            j = o.split(" ")
            if j[0] is l or j[0] is "*"
              p = e[j[1] + " " + k]
              if p
                o = e[o]
                (if o is not 0 then n = p else p is not 0 and (n = o))

                break
        not n and not p and f.error("No conversion from " + m.replace(" ", " to "))
        n isnt not 0 and (c = (if n then n(c) else p(o(c))))
      g++
    c
  cb = (a, c, d) ->
    e = a.contents
    f = a.dataTypes
    g = a.responseFields
    h = undefined
    i = undefined
    j = undefined
    k = undefined
    for i of g
      continue
    while f[0] is "*"
      f.shift()
      h is b and (h = a.mimeType or c.getResponseHeader("content-type"))
    if h
      for i of e
        continue
    if f[0] of d
      j = f[0]
    else
      for i of d
        if not f[0] or a.converters[i + " " + f[0]]
          j = i
          break
        k or (k = i)
      j = j or k
    if j
      j isnt f[0] and f.unshift(j)
      d[j]
  ca = (a, b, c, d) ->
    if f.isArray(b)
      f.each b, (b, e) ->
        (if c or bE.test(a) then d(a, e) else ca(a + "[" + ((if typeof e is "object" or f.isArray(e) then b else "")) + "]", e, c, d))
        return

    else if not c and b? and typeof b is "object"
      for e of b
        continue
    else
      d a, b
    return
  b_ = (a, c) ->
    d = undefined
    e = undefined
    g = f.ajaxSettings.flatOptions or {}
    for d of c
      continue
    e and f.extend(not 0, a, e)
    return
  b$ = (a, c, d, e, f, g) ->
    f = f or c.dataTypes[0]
    g = g or {}
    g[f] = not 0

    h = a[f]
    i = 0
    j = (if h then h.length else 0)
    k = a is bT
    l = undefined
    while i < j and (k or not l)
      l = h[i](c, d, e)
      typeof l is "string" and ((if not k or g[l] then l = b else (c.dataTypes.unshift(l)
      l = b$(a, c, d, e, l, g)
      )))
      i++
    (k or not l) and not g["*"] and (l = b$(a, c, d, e, "*", g))
    l
  bZ = (a) ->
    (b, c) ->
      typeof b isnt "string" and (c = b
      b = "*"
      )
      if f.isFunction(c)
        d = b.toLowerCase().split(bP)
        e = 0
        g = d.length
        h = undefined
        i = undefined
        j = undefined
        while e < g
          h = d[e]
          j = /^\+/.test(h)
          j and (h = h.substr(1) or "*")
          i = a[h] = a[h] or []
          i[(if j then "unshift" else "push")](c)
          e++
      return
  bC = (a, b, c) ->
    d = (if b is "width" then a.offsetWidth else a.offsetHeight)
    e = (if b is "width" then bx else by_)
    g = 0
    h = e.length
    if d > 0
      if c isnt "border"
        while g < h
          c or (d -= parseFloat(f.css(a, "padding" + e[g])) or 0)
          (if c is "margin" then d += parseFloat(f.css(a, c + e[g])) or 0 else d -= parseFloat(f.css(a, "border" + e[g] + "Width")) or 0)
          g++
      return d + "px"
    d = bz(a, b, b)
    d = a.style[b] or 0  if d < 0 or not d?
    d = parseFloat(d) or 0
    if c
      while g < h
        d += parseFloat(f.css(a, "padding" + e[g])) or 0
        c isnt "padding" and (d += parseFloat(f.css(a, "border" + e[g] + "Width")) or 0)
        c is "margin" and (d += parseFloat(f.css(a, c + e[g])) or 0)
        g++
    d + "px"
  bp = (a, b) ->
    (if b.src then f.ajax(
      url: b.src
      async: not 1
      dataType: "script"
    ) else f.globalEval((b.text or b.textContent or b.innerHTML or "").replace(bf, "/*$0*/")))
    b.parentNode and b.parentNode.removeChild(b)

    return
  bo = (a) ->
    b = c.createElement("div")
    bh.appendChild(b)
    b.innerHTML = a.outerHTML

    b.firstChild
  bn = (a) ->
    b = (a.nodeName or "").toLowerCase()
    (if b is "input" then bm(a) else b isnt "script" and typeof a.getElementsByTagName isnt "undefined" and f.grep(a.getElementsByTagName("input"), bm))
    return
  bm = (a) ->
    a.defaultChecked = a.checked  if a.type is "checkbox" or a.type is "radio"
    return
  bl = (a) ->
    (if typeof a.getElementsByTagName isnt "undefined" then a.getElementsByTagName("*") else (if typeof a.querySelectorAll isnt "undefined" then a.querySelectorAll("*") else []))
  bk = (a, b) ->
    c = undefined
    if b.nodeType is 1
      b.clearAttributes and b.clearAttributes()
      b.mergeAttributes and b.mergeAttributes(a)
      c = b.nodeName.toLowerCase()

      if c is "object"
        b.outerHTML = a.outerHTML
      else if c isnt "input" or a.type isnt "checkbox" and a.type isnt "radio"
        if c is "option"
          b.selected = a.defaultSelected
        else b.defaultValue = a.defaultValue  if c is "input" or c is "textarea"
      else
        a.checked and (b.defaultChecked = b.checked = a.checked)
        b.value isnt a.value and (b.value = a.value)
      b.removeAttribute f.expando
    return
  bj = (a, b) ->
    if b.nodeType is 1 and !!f.hasData(a)
      c = undefined
      d = undefined
      e = undefined
      g = f._data(a)
      h = f._data(b, g)
      i = g.events
      if i
        delete h.handle

        h.events = {}

        for c of i
          continue
      h.data and (h.data = f.extend({}, h.data))
    return
  bi = (a, b) ->
    (if f.nodeName(a, "table") then a.getElementsByTagName("tbody")[0] or a.appendChild(a.ownerDocument.createElement("tbody")) else a)
  U = (a) ->
    b = V.split("|")
    c = a.createDocumentFragment()
    c.createElement b.pop()  while b.length  if c.createElement
    c
  T = (a, b, c) ->
    b = b or 0
    if f.isFunction(b)
      return f.grep(a, (a, d) ->
        e = !!b.call(a, d, a)
        e is c
      )
    if b.nodeType
      return f.grep(a, (a, d) ->
        a is b is c
      )
    if typeof b is "string"
      d = f.grep(a, (a) ->
        a.nodeType is 1
      )
      return f.filter(b, d, not c)  if O.test(b)
      b = f.filter(b, d)
    f.grep a, (a, d) ->
      f.inArray(a, b) >= 0 is c

  S = (a) ->
    not a or not a.parentNode or a.parentNode.nodeType is 11
  K = ->
    not 0
  J = ->
    not 1
  n = (a, b, c) ->
    d = b + "defer"
    e = b + "queue"
    g = b + "mark"
    h = f._data(a, d)
    h and (c is "queue" or not f._data(a, e)) and (c is "mark" or not f._data(a, g)) and setTimeout(->
      not f._data(a, e) and not f._data(a, g) and (f.removeData(a, d, not 0)
      h.fire()
      )
      return
    , 0)
    return
  m = (a) ->
    for b of a
      continue  if b is "data" and f.isEmptyObject(a[b])
      return not 1  if b isnt "toJSON"
    not 0
  l = (a, c, d) ->
    if d is b and a.nodeType is 1
      e = "data-" + c.replace(k, "-$1").toLowerCase()
      d = a.getAttribute(e)
      if typeof d is "string"
        try
          d = (if d is "true" then not 0 else (if d is "false" then not 1 else (if d is "null" then null else (if f.isNumeric(d) then parseFloat(d) else (if j.test(d) then f.parseJSON(d) else d)))))
        f.data a, c, d
      else
        d = b
    d
  h = (a) ->
    b = g[a] = {}
    c = undefined
    d = undefined
    a = a.split(/\s+/)
    c = 0
    d = a.length

    while c < d
      b[a[c]] = not 0
      c++
    b
  c = a.document
  d = a.navigator
  e = a.location
  f = ->
    J = ->
      unless e.isReady
        try
          c.documentElement.doScroll "left"
        catch a
          setTimeout J, 1
          return
        e.ready()
      return
    e = (a, b) ->
      new e.fn.init(a, b, h)

    f = a.jQuery
    g = a.$
    h = undefined
    i = /^(?:[^#<]*(<[\w\W]+>)[^>]*$|#([\w\-]*)$)/
    j = /\S/
    k = /^\s+/
    l = /\s+$/
    m = /^<(\w+)\s*\/?>(?:<\/\1>)?$/
    n = /^[\],:{}\s]*$/
    o = /\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g
    p = /"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g
    q = /(?:^|:|,)(?:\s*\[)+/g
    r = /(webkit)[ \/]([\w.]+)/
    s = /(opera)(?:.*version)?[ \/]([\w.]+)/
    t = /(msie) ([\w.]+)/
    u = /(mozilla)(?:.*? rv:([\w.]+))?/
    v = /-([a-z]|[0-9])/g
    w = /^-ms-/
    x = (a, b) ->
      (b + "").toUpperCase()

    y = d.userAgent
    z = undefined
    A = undefined
    B = undefined
    C = Object::toString
    D = Object::hasOwnProperty
    E = Array::push
    F = Array::slice
    G = String::trim
    H = Array::indexOf
    I = {}
    e.fn = e:: =
      constructor: e
      init: (a, d, f) ->
        g = undefined
        h = undefined
        j = undefined
        k = undefined
        return this  unless a
        if a.nodeType
          @context = this[0] = a
          @length = 1

          return this
        if a is "body" and not d and c.body
          @context = c
          this[0] = c.body
          @selector = a
          @length = 1

          return this
        if typeof a is "string"
          (if a.charAt(0) isnt "<" or a.charAt(a.length - 1) isnt ">" or a.length < 3 then g = i.exec(a) else g = [
            null
            a
            null
          ])
          if g and (g[1] or not d)
            if g[1]
              d = (if d instanceof e then d[0] else d)
              k = (if d then d.ownerDocument or d else c)
              j = m.exec(a)
              (if j then (if e.isPlainObject(d) then (a = [c.createElement(j[1])]
              e.fn.attr.call(a, d, not 0)
              ) else a = [k.createElement(j[1])]) else (j = e.buildFragment([g[1]], [k])
              a = ((if j.cacheable then e.clone(j.fragment) else j.fragment)).childNodes
              ))

              return e.merge(this, a)
            h = c.getElementById(g[2])
            if h and h.parentNode
              return f.find(a)  if h.id isnt g[2]
              @length = 1
              this[0] = h
            @context = c
            @selector = a

            return this
          return (if not d or d.jquery then (d or f).find(a) else @constructor(d).find(a))
        return f.ready(a)  if e.isFunction(a)
        a.selector isnt b and (@selector = a.selector
        @context = a.context
        )
        e.makeArray a, this

      selector: ""
      jquery: "1.7.1"
      length: 0
      size: ->
        @length

      toArray: ->
        F.call this, 0

      get: (a) ->
        (if not a? then @toArray() else (if a < 0 then this[@length + a] else this[a]))

      pushStack: (a, b, c) ->
        d = @constructor()
        (if e.isArray(a) then E.apply(d, a) else e.merge(d, a))
        d.prevObject = this
        d.context = @context
        (if b is "find" then d.selector = @selector + ((if @selector then " " else "")) + c else b and (d.selector = @selector + "." + b + "(" + c + ")"))

        d

      each: (a, b) ->
        e.each this, a, b

      ready: (a) ->
        e.bindReady()
        A.add(a)

        this

      eq: (a) ->
        a = +a
        (if a is -1 then @slice(a) else @slice(a, a + 1))

      first: ->
        @eq 0

      last: ->
        @eq -1

      slice: ->
        @pushStack F.apply(this, arguments_), "slice", F.call(arguments_).join(",")

      map: (a) ->
        @pushStack e.map(this, (b, c) ->
          a.call b, c, b
        )

      end: ->
        @prevObject or @constructor(null)

      push: E
      sort: [].sort
      splice: [].splice

    e.fn.init:: = e.fn
    e.extend = e.fn.extend = ->
      a = undefined
      c = undefined
      d = undefined
      f = undefined
      g = undefined
      h = undefined
      i = arguments_[0] or {}
      j = 1
      k = arguments_.length
      l = not 1
      typeof i is "boolean" and (l = i
      i = arguments_[1] or {}
      j = 2
      )
      typeof i isnt "object" and not e.isFunction(i) and (i = {})
      k is j and (i = this
      --j
      )

      while j < k
        if (a = arguments_[j])?
          for c of a
            d = i[c]
            f = a[c]

            continue  if i is f
            (if l and f and (e.isPlainObject(f) or (g = e.isArray(f))) then ((if g then (g = not 1
            h = (if d and e.isArray(d) then d else [])
            ) else h = (if d and e.isPlainObject(d) then d else {}))
            i[c] = e.extend(l, h, f)
            ) else f isnt b and (i[c] = f))
        j++
      i

    e.extend(
      noConflict: (b) ->
        a.$ is e and (a.$ = g)
        b and a.jQuery is e and (a.jQuery = f)

        e

      isReady: not 1
      readyWait: 1
      holdReady: (a) ->
        (if a then e.readyWait++ else e.ready(not 0))
        return

      ready: (a) ->
        if a is not 0 and not --e.readyWait or a isnt not 0 and not e.isReady
          return setTimeout(e.ready, 1)  unless c.body
          e.isReady = not 0
          return  if a isnt not 0 and --e.readyWait > 0
          A.fireWith(c, [e])
          e.fn.trigger and e(c).trigger("ready").off("ready")
        return

      bindReady: ->
        unless A
          A = e.Callbacks("once memory")
          return setTimeout(e.ready, 1)  if c.readyState is "complete"
          if c.addEventListener
            c.addEventListener("DOMContentLoaded", B, not 1)
            a.addEventListener("load", e.ready, not 1)
          else if c.attachEvent
            c.attachEvent("onreadystatechange", B)
            a.attachEvent("onload", e.ready)

            b = not 1
            try
              b = not a.frameElement?
            c.documentElement.doScroll and b and J()
        return

      isFunction: (a) ->
        e.type(a) is "function"

      isArray: Array.isArray or (a) ->
        e.type(a) is "array"

      isWindow: (a) ->
        a and typeof a is "object" and "setInterval" of a

      isNumeric: (a) ->
        not isNaN(parseFloat(a)) and isFinite(a)

      type: (a) ->
        (if not a? then String(a) else I[C.call(a)] or "object")

      isPlainObject: (a) ->
        return not 1  if not a or e.type(a) isnt "object" or a.nodeType or e.isWindow(a)
        try
          return not 1  if a.constructor and not D.call(a, "constructor") and not D.call(a.constructor::, "isPrototypeOf")
        catch c
          return not 1
        d = undefined
        for d of a
          continue
        d is b or D.call(a, d)

      isEmptyObject: (a) ->
        for b of a
          continue
        not 0

      error: (a) ->
        throw new Error(a)return

      parseJSON: (b) ->
        return null  if typeof b isnt "string" or not b
        b = e.trim(b)
        return a.JSON.parse(b)  if a.JSON and a.JSON.parse
        return (new Function("return " + b))()  if n.test(b.replace(o, "@").replace(p, "]").replace(q, ""))
        e.error "Invalid JSON: " + b
        return

      parseXML: (c) ->
        d = undefined
        f = undefined
        try
          (if a.DOMParser then (f = new DOMParser
          d = f.parseFromString(c, "text/xml")
          ) else (d = new ActiveXObject("Microsoft.XMLDOM")
          d.async = "false"
          d.loadXML(c)
          ))
        catch g
          d = b
        (not d or not d.documentElement or d.getElementsByTagName("parsererror").length) and e.error("Invalid XML: " + c)
        d

      noop: ->

      globalEval: (b) ->
        b and j.test(b) and (a.execScript or (b) ->
          a.eval.call a, b
          return
        )(b)
        return

      camelCase: (a) ->
        a.replace(w, "ms-").replace v, x

      nodeName: (a, b) ->
        a.nodeName and a.nodeName.toUpperCase() is b.toUpperCase()

      each: (a, c, d) ->
        f = undefined
        g = 0
        h = a.length
        i = h is b or e.isFunction(a)
        if d
          if i
            for f of a
              continue
          else
            while g < h
              break  if c.apply(a[g++], d) is not 1
        else if i
          for f of a
            continue
        else
          while g < h
            break  if c.call(a[g], g, a[g++]) is not 1
        a

      trim: (if G then (a) ->
        (if not a? then "" else G.call(a))
       else (a) ->
        (if not a? then "" else (a + "").replace(k, "").replace(l, ""))
      )
      makeArray: (a, b) ->
        c = b or []
        if a?
          d = e.type(a)
          (if not a.length? or d is "string" or d is "function" or d is "regexp" or e.isWindow(a) then E.call(c, a) else e.merge(c, a))
        c

      inArray: (a, b, c) ->
        d = undefined
        if b
          return H.call(b, a, c)  if H
          d = b.length
          c = (if c then (if c < 0 then Math.max(0, d + c) else c) else 0)

          while c < d
            return c  if c of b and b[c] is a
            c++
        -1

      merge: (a, c) ->
        d = a.length
        e = 0
        if typeof c.length is "number"
          f = c.length

          while e < f
            a[d++] = c[e]
            e++
        else
          a[d++] = c[e++]  while c[e] isnt b
        a.length = d
        a

      grep: (a, b, c) ->
        d = []
        e = undefined
        c = !!c
        f = 0
        g = a.length

        while f < g
          e = !!b(a[f], f)
          c isnt e and d.push(a[f])
          f++
        d

      map: (a, c, d) ->
        f = undefined
        g = undefined
        h = []
        i = 0
        j = a.length
        k = a instanceof e or j isnt b and typeof j is "number" and (j > 0 and a[0] and a[j - 1] or j is 0 or e.isArray(a))
        if k
          while i < j
            f = c(a[i], i, d)
            f? and (h[h.length] = f)
            i++
        else
          for g of a
            continue
        h.concat.apply [], h

      guid: 1
      proxy: (a, c) ->
        if typeof c is "string"
          d = a[c]
          c = a
          a = d
        return b  unless e.isFunction(a)
        f = F.call(arguments_, 2)
        g = ->
          a.apply c, f.concat(F.call(arguments_))

        g.guid = a.guid = a.guid or g.guid or e.guid++
        g

      access: (a, c, d, f, g, h) ->
        i = a.length
        if typeof c is "object"
          for j of c
            continue
          return a
        if d isnt b
          f = not h and f and e.isFunction(d)
          k = 0

          while k < i
            g a[k], c, (if f then d.call(a[k], k, g(a[k], c)) else d), h
            k++
          return a
        (if i then g(a[0], c) else b)

      now: ->
        (new Date).getTime()

      uaMatch: (a) ->
        a = a.toLowerCase()
        b = r.exec(a) or s.exec(a) or t.exec(a) or a.indexOf("compatible") < 0 and u.exec(a) or []
        browser: b[1] or ""
        version: b[2] or "0"

      sub: ->
        a = (b, c) ->
          new a.fn.init(b, c)
        e.extend(not 0, a, this)
        a.superclass = this
        a.fn = a:: = this()
        a.fn.constructor = a
        a.sub = @sub
        a.fn.init = (d, f) ->
          f and f instanceof e and (f not instanceof a) and (f = a(f))
          e.fn.init.call this, d, f, b

        a.fn.init:: = a.fn

        b = a(c)
        a

      browser: {}
    )
    e.each("Boolean Number String Function Array Date RegExp Object".split(" "), (a, b) ->
      I["[object " + b + "]"] = b.toLowerCase()
      return
    )
    z = e.uaMatch(y)
    z.browser and (e.browser[z.browser] = not 0
    e.browser.version = z.version
    )
    e.browser.webkit and (e.browser.safari = not 0)
    j.test(" ") and (k = /^[\s\xA0]+/
    l = /[\s\xA0]+$/
    )
    h = e(c)
    (if c.addEventListener then B = ->
      c.removeEventListener("DOMContentLoaded", B, not 1)
      e.ready()

      return
     else c.attachEvent and (B = ->
      c.readyState is "complete" and (c.detachEvent("onreadystatechange", B)
      e.ready()
      )
      return
    ))

    e
  ()
  g = {}
  f.Callbacks = (a) ->
    a = (if a then g[a] or h(a) else {})
    c = []
    d = []
    e = undefined
    i = undefined
    j = undefined
    k = undefined
    l = undefined
    m = (b) ->
      d = undefined
      e = undefined
      g = undefined
      h = undefined
      i = undefined
      d = 0
      e = b.length

      while d < e
        g = b[d]
        h = f.type(g)
        (if h is "array" then m(g) else h is "function" and (not a.unique or not o.has(g)) and c.push(g))
        d++
      return

    n = (b, f) ->
      f = f or []
      e = not a.memory or [
        b
        f
      ]
      i = not 0
      l = j or 0
      j = 0
      k = c.length

      while c and l < k
        if c[l].apply(b, f) is not 1 and a.stopOnFalse
          e = not 0
          break
        l++
      i = not 1
      c and ((if a.once then (if e is not 0 then o.disable() else c = []) else d and d.length and (e = d.shift()
      o.fireWith(e[0], e[1])
      )))

      return

    o =
      add: ->
        if c
          a = c.length
          m(arguments_)
          (if i then k = c.length else e and e isnt not 0 and (j = a
          n(e[0], e[1])
          ))
        this

      remove: ->
        if c
          b = arguments_
          d = 0
          e = b.length
          while d < e
            f = 0

            while f < c.length
              if b[d] is c[f]
                i and f <= k and (k--
                f <= l and l--
                )
                c.splice(f--, 1)

                break  if a.unique
              f++
            d++
        this

      has: (a) ->
        if c
          b = 0
          d = c.length
          while b < d
            return not 0  if a is c[b]
            b++
        not 1

      empty: ->
        c = []
        this

      disable: ->
        c = d = e = b
        this

      disabled: ->
        not c

      lock: ->
        d = b
        (not e or e is not 0) and o.disable()

        this

      locked: ->
        not d

      fireWith: (b, c) ->
        d and ((if i then a.once or d.push([
          b
          c
        ]) else (not a.once or not e) and n(b, c)))
        this

      fire: ->
        o.fireWith this, arguments_
        this

      fired: ->
        !!e

    o

  i = [].slice
  f.extend(
    Deferred: (a) ->
      b = f.Callbacks("once memory")
      c = f.Callbacks("once memory")
      d = f.Callbacks("memory")
      e = "pending"
      g =
        resolve: b
        reject: c
        notify: d

      h =
        done: b.add
        fail: c.add
        progress: d.add
        state: ->
          e

        isResolved: b.fired
        isRejected: c.fired
        then: (a, b, c) ->
          i.done(a).fail(b).progress c
          this

        always: ->
          i.done.apply(i, arguments_).fail.apply i, arguments_
          this

        pipe: (a, b, c) ->
          f.Deferred((d) ->
            f.each
              done: [
                a
                "resolve"
              ]
              fail: [
                b
                "reject"
              ]
              progress: [
                c
                "notify"
              ]
            , (a, b) ->
              c = b[0]
              e = b[1]
              g = undefined
              (if f.isFunction(c) then i[a](->
                g = c.apply(this, arguments_)
                (if g and f.isFunction(g.promise) then g.promise().then(d.resolve, d.reject, d.notify) else d[e + "With"]((if this is i then d else this), [g]))

                return
              ) else i[a](d[e]))
              return

            return
          ).promise()

        promise: (a) ->
          unless a?
            a = h
          else
            for b of h
              continue
          a

      i = h.promise({})
      j = undefined
      for j of g
        continue
      i.done(->
        e = "resolved"
        return
      , c.disable, d.lock).fail(->
        e = "rejected"
        return
      , b.disable, d.lock)
      a and a.call(i, i)

      i

    when: (a) ->
      m = (a) ->
        (b) ->
          e[a] = (if arguments_.length > 1 then i.call(arguments_, 0) else b)
          j.notifyWith(k, e)

          return
      l = (a) ->
        (c) ->
          b[a] = (if arguments_.length > 1 then i.call(arguments_, 0) else c)
          --g or j.resolveWith(j, b)

          return
      b = i.call(arguments_, 0)
      c = 0
      d = b.length
      e = Array(d)
      g = d
      h = d
      j = (if d <= 1 and a and f.isFunction(a.promise) then a else f.Deferred())
      k = j.promise()
      if d > 1
        while c < d
          (if b[c] and b[c].promise and f.isFunction(b[c].promise) then b[c].promise().then(l(c), j.reject, m(c)) else --g)
          c++
        g or j.resolveWith(j, b)
      else
        j isnt a and j.resolveWith(j, (if d then [a] else []))
      k
  )
  f.support = ->
    b = undefined
    d = undefined
    e = undefined
    g = undefined
    h = undefined
    i = undefined
    j = undefined
    k = undefined
    l = undefined
    m = undefined
    n = undefined
    o = undefined
    p = undefined
    q = c.createElement("div")
    r = c.documentElement
    q.setAttribute("className", "t")
    q.innerHTML = "   <link/><table></table><a href='/a' style='top:1px;float:left;opacity:.55;'>a</a><input type='checkbox'/>"
    d = q.getElementsByTagName("*")
    e = q.getElementsByTagName("a")[0]

    return {}  if not d or not d.length or not e
    g = c.createElement("select")
    h = g.appendChild(c.createElement("option"))
    i = q.getElementsByTagName("input")[0]
    b =
      leadingWhitespace: q.firstChild.nodeType is 3
      tbody: not q.getElementsByTagName("tbody").length
      htmlSerialize: !!q.getElementsByTagName("link").length
      style: /top/.test(e.getAttribute("style"))
      hrefNormalized: e.getAttribute("href") is "/a"
      opacity: /^0.55/.test(e.style.opacity)
      cssFloat: !!e.style.cssFloat
      checkOn: i.value is "on"
      optSelected: h.selected
      getSetAttribute: q.className isnt "t"
      enctype: !!c.createElement("form").enctype
      html5Clone: c.createElement("nav").cloneNode(not 0).outerHTML isnt "<:nav></:nav>"
      submitBubbles: not 0
      changeBubbles: not 0
      focusinBubbles: not 1
      deleteExpando: not 0
      noCloneEvent: not 0
      inlineBlockNeedsLayout: not 1
      shrinkWrapBlocks: not 1
      reliableMarginRight: not 0

    i.checked = not 0
    b.noCloneChecked = i.cloneNode(not 0).checked
    g.disabled = not 0
    b.optDisabled = not h.disabled

    try
      delete q.test
    catch s
      b.deleteExpando = not 1
    not q.addEventListener and q.attachEvent and q.fireEvent and (q.attachEvent("onclick", ->
      b.noCloneEvent = not 1
      return
    )
    q.cloneNode(not 0).fireEvent("onclick")
    )
    i = c.createElement("input")
    i.value = "t"
    i.setAttribute("type", "radio")
    b.radioValue = i.value is "t"
    i.setAttribute("checked", "checked")
    q.appendChild(i)
    k = c.createDocumentFragment()
    k.appendChild(q.lastChild)
    b.checkClone = k.cloneNode(not 0).cloneNode(not 0).lastChild.checked
    b.appendChecked = i.checked
    k.removeChild(i)
    k.appendChild(q)
    q.innerHTML = ""
    a.getComputedStyle and (j = c.createElement("div")
    j.style.width = "0"
    j.style.marginRight = "0"
    q.style.width = "2px"
    q.appendChild(j)
    b.reliableMarginRight = (parseInt((a.getComputedStyle(j, null) or marginRight: 0).marginRight, 10) or 0) is 0
    )

    if q.attachEvent
      for o of
        submit: 1
        change: 1
        focusin: 1
        continue
    k.removeChild(q)
    k = g = h = j = q = i = null
    f(->
      a = undefined
      d = undefined
      e = undefined
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      m = undefined
      n = undefined
      o = undefined
      r = c.getElementsByTagName("body")[0]
      not r or (j = 1
      k = "position:absolute;top:0;left:0;width:1px;height:1px;margin:0;"
      m = "visibility:hidden;border:0;"
      n = "style='" + k + "border:5px solid #000;padding:0;'"
      o = "<div " + n + "><div></div></div>" + "<table " + n + " cellpadding='0' cellspacing='0'>" + "<tr><td></td></tr></table>"
      a = c.createElement("div")
      a.style.cssText = m + "width:0;height:0;position:static;top:0;margin-top:" + j + "px"
      r.insertBefore(a, r.firstChild)
      q = c.createElement("div")
      a.appendChild(q)
      q.innerHTML = "<table><tr><td style='padding:0;border:0;display:none'></td><td>t</td></tr></table>"
      l = q.getElementsByTagName("td")
      p = l[0].offsetHeight is 0
      l[0].style.display = ""
      l[1].style.display = "none"
      b.reliableHiddenOffsets = p and l[0].offsetHeight is 0
      q.innerHTML = ""
      q.style.width = q.style.paddingLeft = "1px"
      f.boxModel = b.boxModel = q.offsetWidth is 2
      typeof q.style.zoom isnt "undefined" and (q.style.display = "inline"
      q.style.zoom = 1
      b.inlineBlockNeedsLayout = q.offsetWidth is 2
      q.style.display = ""
      q.innerHTML = "<div style='width:4px;'></div>"
      b.shrinkWrapBlocks = q.offsetWidth isnt 2
      )
      q.style.cssText = k + m
      q.innerHTML = o
      d = q.firstChild
      e = d.firstChild
      h = d.nextSibling.firstChild.firstChild
      i =
        doesNotAddBorder: e.offsetTop isnt 5
        doesAddBorderForTableAndCells: h.offsetTop is 5

      e.style.position = "fixed"
      e.style.top = "20px"
      i.fixedPosition = e.offsetTop is 20 or e.offsetTop is 15
      e.style.position = e.style.top = ""
      d.style.overflow = "hidden"
      d.style.position = "relative"
      i.subtractsBorderForOverflowNotVisible = e.offsetTop is -5
      i.doesNotIncludeMarginInBodyOffset = r.offsetTop isnt j
      r.removeChild(a)
      q = a = null
      f.extend(b, i)
      )
      return
    )

    b
  ()

  j = /^(?:\{.*\}|\[.*\])$/
  k = /([A-Z])/g
  f.extend(
    cache: {}
    uuid: 0
    expando: "jQuery" + (f.fn.jquery + Math.random()).replace(/\D/g, "")
    noData:
      embed: not 0
      object: "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
      applet: not 0

    hasData: (a) ->
      a = (if a.nodeType then f.cache[a[f.expando]] else a[f.expando])
      !!a and not m(a)

    data: (a, c, d, e) ->
      unless not f.acceptData(a)
        g = undefined
        h = undefined
        i = undefined
        j = f.expando
        k = typeof c is "string"
        l = a.nodeType
        m = (if l then f.cache else a)
        n = (if l then a[j] else a[j] and j)
        o = c is "events"
        return  if (not n or not m[n] or not o and not e and not m[n].data) and k and d is b
        n or ((if l then a[j] = n = ++f.uuid else n = j))
        m[n] or (m[n] = {}
        l or (m[n].toJSON = f.noop)
        )

        (if e then m[n] = f.extend(m[n], c) else m[n].data = f.extend(m[n].data, c))  if typeof c is "object" or typeof c is "function"
        g = h = m[n]
        e or (h.data or (h.data = {})
        h = h.data
        )
        d isnt b and (h[f.camelCase(c)] = d)

        return g.events  if o and not h[c]
        (if k then (i = h[c]
        not i? and (i = h[f.camelCase(c)])
        ) else i = h)
        i

    removeData: (a, b, c) ->
      unless not f.acceptData(a)
        d = undefined
        e = undefined
        g = undefined
        h = f.expando
        i = a.nodeType
        j = (if i then f.cache else a)
        k = (if i then a[h] else h)
        return  unless j[k]
        if b
          d = (if c then j[k] else j[k].data)
          if d
            f.isArray(b) or ((if b of d then b = [b] else (b = f.camelCase(b)
            (if b of d then b = [b] else b = b.split(" "))
            )))
            e = 0
            g = b.length

            while e < g
              delete d[b[e]]
              e++
            return  unless ((if c then m else f.isEmptyObject))(d)
        unless c
          delete j[k].data

          return  unless m(j[k])
        (if f.support.deleteExpando or not j.setInterval then delete j[k]
         else j[k] = null)
        i and ((if f.support.deleteExpando then delete a[h]
         else (if a.removeAttribute then a.removeAttribute(h) else a[h] = null)))
      return

    _data: (a, b, c) ->
      f.data a, b, c, not 0

    acceptData: (a) ->
      if a.nodeName
        b = f.noData[a.nodeName.toLowerCase()]
        return b isnt not 0 and a.getAttribute("classid") is b  if b
      not 0
  )
  f.fn.extend(
    data: (a, c) ->
      d = undefined
      e = undefined
      g = undefined
      h = null
      if typeof a is "undefined"
        if @length
          h = f.data(this[0])
          if this[0].nodeType is 1 and not f._data(this[0], "parsedAttrs")
            e = this[0].attributes
            i = 0
            j = e.length

            while i < j
              g = e[i].name
              g.indexOf("data-") is 0 and (g = f.camelCase(g.substring(5))
              l(this[0], g, h[g])
              )
              i++
            f._data this[0], "parsedAttrs", not 0
        return h
      if typeof a is "object"
        return @each(->
          f.data this, a
          return
        )
      d = a.split(".")
      d[1] = (if d[1] then "." + d[1] else "")

      if c is b
        h = @triggerHandler("getData" + d[1] + "!", [d[0]])
        h is b and @length and (h = f.data(this[0], a)
        h = l(this[0], a, h)
        )

        return (if h is b and d[1] then @data(d[0]) else h)
      @each ->
        b = f(this)
        e = [
          d[0]
          c
        ]
        b.triggerHandler("setData" + d[1] + "!", e)
        f.data(this, a, c)
        b.triggerHandler("changeData" + d[1] + "!", e)

        return


    removeData: (a) ->
      @each ->
        f.removeData this, a
        return

  )
  f.extend(
    _mark: (a, b) ->
      a and (b = (b or "fx") + "mark"
      f._data(a, b, (f._data(a, b) or 0) + 1)
      )
      return

    _unmark: (a, b, c) ->
      a isnt not 0 and (c = b
      b = a
      a = not 1
      )
      if b
        c = c or "fx"
        d = c + "mark"
        e = (if a then 0 else (f._data(b, d) or 1) - 1)
        (if e then f._data(b, d, e) else (f.removeData(b, d, not 0)
        n(b, c, "mark")
        ))
      return

    queue: (a, b, c) ->
      d = undefined
      if a
        b = (b or "fx") + "queue"
        d = f._data(a, b)
        c and ((if not d or f.isArray(c) then d = f._data(a, b, f.makeArray(c)) else d.push(c)))

        d or []

    dequeue: (a, b) ->
      b = b or "fx"
      c = f.queue(a, b)
      d = c.shift()
      e = {}
      d is "inprogress" and (d = c.shift())
      d and (b is "fx" and c.unshift("inprogress")
      f._data(a, b + ".run", e)
      d.call(a, ->
        f.dequeue a, b
        return
      , e)
      )
      c.length or (f.removeData(a, b + "queue " + b + ".run", not 0)
      n(a, b, "queue")
      )

      return
  )
  f.fn.extend(
    queue: (a, c) ->
      typeof a isnt "string" and (c = a
      a = "fx"
      )
      return f.queue(this[0], a)  if c is b
      @each ->
        b = f.queue(this, a, c)
        a is "fx" and b[0] isnt "inprogress" and f.dequeue(this, a)
        return


    dequeue: (a) ->
      @each ->
        f.dequeue this, a
        return


    delay: (a, b) ->
      a = (if f.fx then f.fx.speeds[a] or a else a)
      b = b or "fx"

      @queue b, (b, c) ->
        d = setTimeout(b, a)
        c.stop = ->
          clearTimeout d
          return

        return


    clearQueue: (a) ->
      @queue a or "fx", []

    promise: (a, c) ->
      m = ->
        --h or d.resolveWith(e, [e])
        return
      typeof a isnt "string" and (c = a
      a = b
      )
      a = a or "fx"

      d = f.Deferred()
      e = this
      g = e.length
      h = 1
      i = a + "defer"
      j = a + "queue"
      k = a + "mark"
      l = undefined
      while g--
        if l = f.data(e[g], i, b, not 0) or (f.data(e[g], j, b, not 0) or f.data(e[g], k, b, not 0)) and f.data(e[g], i, f.Callbacks("once memory"), not 0)
          h++
          l.add(m)
      m()
      d.promise()
  )

  o = /[\n\t\r]/g
  p = /\s+/
  q = /\r/g
  r = /^(?:button|input)$/i
  s = /^(?:button|input|object|select|textarea)$/i
  t = /^a(?:rea)?$/i
  u = /^(?:autofocus|autoplay|async|checked|controls|defer|disabled|hidden|loop|multiple|open|readonly|required|scoped|selected)$/i
  v = f.support.getSetAttribute
  w = undefined
  x = undefined
  y = undefined
  f.fn.extend(
    attr: (a, b) ->
      f.access this, a, b, not 0, f.attr

    removeAttr: (a) ->
      @each ->
        f.removeAttr this, a
        return


    prop: (a, b) ->
      f.access this, a, b, not 0, f.prop

    removeProp: (a) ->
      a = f.propFix[a] or a
      @each ->
        try
          this[a] = b
          delete this[a]
        return


    addClass: (a) ->
      b = undefined
      c = undefined
      d = undefined
      e = undefined
      g = undefined
      h = undefined
      i = undefined
      if f.isFunction(a)
        return @each((b) ->
          f(this).addClass a.call(this, b, @className)
          return
        )
      if a and typeof a is "string"
        b = a.split(p)
        c = 0
        d = @length

        while c < d
          e = this[c]
          if e.nodeType is 1
            if not e.className and b.length is 1
              e.className = a
            else
              g = " " + e.className + " "
              h = 0
              i = b.length

              while h < i
                ~g.indexOf(" " + b[h] + " ") or (g += b[h] + " ")
                h++
              e.className = f.trim(g)
          c++
      this

    removeClass: (a) ->
      c = undefined
      d = undefined
      e = undefined
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      if f.isFunction(a)
        return @each((b) ->
          f(this).removeClass a.call(this, b, @className)
          return
        )
      if a and typeof a is "string" or a is b
        c = (a or "").split(p)
        d = 0
        e = @length

        while d < e
          g = this[d]
          if g.nodeType is 1 and g.className
            if a
              h = (" " + g.className + " ").replace(o, " ")
              i = 0
              j = c.length

              while i < j
                h = h.replace(" " + c[i] + " ", " ")
                i++
              g.className = f.trim(h)
            else
              g.className = ""
          d++
      this

    toggleClass: (a, b) ->
      c = typeof a
      d = typeof b is "boolean"
      if f.isFunction(a)
        return @each((c) ->
          f(this).toggleClass a.call(this, c, @className, b), b
          return
        )
      @each ->
        if c is "string"
          e = undefined
          g = 0
          h = f(this)
          i = b
          j = a.split(p)
          while e = j[g++]
            i = (if d then i else not h.hasClass(e))
            h[(if i then "addClass" else "removeClass")](e)
        else if c is "undefined" or c is "boolean"
          @className and f._data(this, "__className__", @className)
          @className = (if @className or a is not 1 then "" else f._data(this, "__className__") or "")
        return


    hasClass: (a) ->
      b = " " + a + " "
      c = 0
      d = @length
      while c < d
        return not 0  if this[c].nodeType is 1 and (" " + this[c].className + " ").replace(o, " ").indexOf(b) > -1
        c++
      not 1

    val: (a) ->
      c = undefined
      d = undefined
      e = undefined
      g = this[0]
      unless not arguments_.length
        e = f.isFunction(a)
        return @each((d) ->
          g = f(this)
          h = undefined
          if @nodeType is 1
            (if e then h = a.call(this, d, g.val()) else h = a)
            (if not h? then h = "" else (if typeof h is "number" then h += "" else f.isArray(h) and (h = f.map(h, (a) ->
              (if not a? then "" else a + "")
            ))))
            c = f.valHooks[@nodeName.toLowerCase()] or f.valHooks[@type]

            @value = h  if not c or ("set" of c) or c.set(this, h, "value") is b
          return
        )
      if g
        c = f.valHooks[g.nodeName.toLowerCase()] or f.valHooks[g.type]
        return d  if c and "get" of c and (d = c.get(g, "value")) isnt b
        d = g.value
        (if typeof d is "string" then d.replace(q, "") else (if not d? then "" else d))
  )
  f.extend(
    valHooks:
      option:
        get: (a) ->
          b = a.attributes.value
          (if not b or b.specified then a.value else a.text)

      select:
        get: (a) ->
          b = undefined
          c = undefined
          d = undefined
          e = undefined
          g = a.selectedIndex
          h = []
          i = a.options
          j = a.type is "select-one"
          return null  if g < 0
          c = (if j then g else 0)
          d = (if j then g + 1 else i.length)

          while c < d
            e = i[c]
            if e.selected and ((if f.support.optDisabled then not e.disabled else e.getAttribute("disabled") is null)) and (not e.parentNode.disabled or not f.nodeName(e.parentNode, "optgroup"))
              b = f(e).val()
              return b  if j
              h.push b
            c++
          return f(i[g]).val()  if j and not h.length and i.length
          h

        set: (a, b) ->
          c = f.makeArray(b)
          f(a).find("option").each(->
            @selected = f.inArray(f(this).val(), c) >= 0
            return
          )
          c.length or (a.selectedIndex = -1)

          c

    attrFn:
      val: not 0
      css: not 0
      html: not 0
      text: not 0
      data: not 0
      width: not 0
      height: not 0
      offset: not 0

    attr: (a, c, d, e) ->
      g = undefined
      h = undefined
      i = undefined
      j = a.nodeType
      if !!a and j isnt 3 and j isnt 8 and j isnt 2
        return f(a)[c](d)  if e and c of f.attrFn
        return f.prop(a, c, d)  if typeof a.getAttribute is "undefined"
        i = j isnt 1 or not f.isXMLDoc(a)
        i and (c = c.toLowerCase()
        h = f.attrHooks[c] or ((if u.test(c) then x else w))
        )

        if d isnt b
          if d is null
            f.removeAttr a, c
            return
          return g  if h and "set" of h and i and (g = h.set(a, d, c)) isnt b
          a.setAttribute c, "" + d
          return d
        return g  if h and "get" of h and i and (g = h.get(a, c)) isnt null
        g = a.getAttribute(c)
        (if g is null then b else g)

    removeAttr: (a, b) ->
      c = undefined
      d = undefined
      e = undefined
      g = undefined
      h = 0
      if b and a.nodeType is 1
        d = b.toLowerCase().split(p)
        g = d.length

        while h < g
          e = d[h]
          e and (c = f.propFix[e] or e
          f.attr(a, e, "")
          a.removeAttribute((if v then e else c))
          u.test(e) and c of a and (a[c] = not 1)
          )
          h++
      return

    attrHooks:
      type:
        set: (a, b) ->
          if r.test(a.nodeName) and a.parentNode
            f.error "type property can't be changed"
          else if not f.support.radioValue and b is "radio" and f.nodeName(a, "input")
            c = a.value
            a.setAttribute("type", b)
            c and (a.value = c)

            b
          return

      value:
        get: (a, b) ->
          return w.get(a, b)  if w and f.nodeName(a, "button")
          (if b of a then a.value else null)

        set: (a, b, c) ->
          return w.set(a, b, c)  if w and f.nodeName(a, "button")
          a.value = b
          return

    propFix:
      tabindex: "tabIndex"
      readonly: "readOnly"
      for: "htmlFor"
      class: "className"
      maxlength: "maxLength"
      cellspacing: "cellSpacing"
      cellpadding: "cellPadding"
      rowspan: "rowSpan"
      colspan: "colSpan"
      usemap: "useMap"
      frameborder: "frameBorder"
      contenteditable: "contentEditable"

    prop: (a, c, d) ->
      e = undefined
      g = undefined
      h = undefined
      i = a.nodeType
      if !!a and i isnt 3 and i isnt 8 and i isnt 2
        h = i isnt 1 or not f.isXMLDoc(a)
        h and (c = f.propFix[c] or c
        g = f.propHooks[c]
        )

        (if d isnt b then (if g and "set" of g and (e = g.set(a, d, c)) isnt b then e else a[c] = d) else (if g and "get" of g and (e = g.get(a, c)) isnt null then e else a[c]))

    propHooks:
      tabIndex:
        get: (a) ->
          c = a.getAttributeNode("tabindex")
          (if c and c.specified then parseInt(c.value, 10) else (if s.test(a.nodeName) or t.test(a.nodeName) and a.href then 0 else b))
  )
  f.attrHooks.tabindex = f.propHooks.tabIndex
  x =
    get: (a, c) ->
      d = undefined
      e = f.prop(a, c)
      (if e is not 0 or typeof e isnt "boolean" and (d = a.getAttributeNode(c)) and d.nodeValue isnt not 1 then c.toLowerCase() else b)

    set: (a, b, c) ->
      d = undefined
      (if b is not 1 then f.removeAttr(a, c) else (d = f.propFix[c] or c
      d of a and (a[d] = not 0)
      a.setAttribute(c, c.toLowerCase())
      ))
      c

  v or (y =
    name: not 0
    id: not 0

  w = f.valHooks.button =
    get: (a, c) ->
      d = undefined
      d = a.getAttributeNode(c)
      (if d and ((if y[c] then d.nodeValue isnt "" else d.specified)) then d.nodeValue else b)

    set: (a, b, d) ->
      e = a.getAttributeNode(d)
      e or (e = c.createAttribute(d)
      a.setAttributeNode(e)
      )
      e.nodeValue = b + ""

  f.attrHooks.tabindex.set = w.set
  f.each([
    "width"
    "height"
  ], (a, b) ->
    f.attrHooks[b] = f.extend(f.attrHooks[b],
      set: (a, c) ->
        if c is ""
          a.setAttribute b, "auto"
          c
    )
    return
  )
  f.attrHooks.contenteditable =
    get: w.get
    set: (a, b, c) ->
      b is "" and (b = "false")
      w.set(a, b, c)

      return

  )
  f.support.hrefNormalized or f.each([
    "href"
    "src"
    "width"
    "height"
  ], (a, c) ->
    f.attrHooks[c] = f.extend(f.attrHooks[c],
      get: (a) ->
        d = a.getAttribute(c, 2)
        (if d is null then b else d)
    )
    return
  )
  f.support.style or (f.attrHooks.style =
    get: (a) ->
      a.style.cssText.toLowerCase() or b

    set: (a, b) ->
      a.style.cssText = "" + b
  )
  f.support.optSelected or (f.propHooks.selected = f.extend(f.propHooks.selected,
    get: (a) ->
      b = a.parentNode
      b and (b.selectedIndex
      b.parentNode and b.parentNode.selectedIndex
      )
      null
  ))
  f.support.enctype or (f.propFix.enctype = "encoding")
  f.support.checkOn or f.each([
    "radio"
    "checkbox"
  ], ->
    f.valHooks[this] = get: (a) ->
      (if a.getAttribute("value") is null then "on" else a.value)

    return
  )
  f.each([
    "radio"
    "checkbox"
  ], ->
    f.valHooks[this] = f.extend(f.valHooks[this],
      set: (a, b) ->
        a.checked = f.inArray(f(a).val(), b) >= 0  if f.isArray(b)
    )
    return
  )

  z = /^(?:textarea|input|select)$/i
  A = /^([^\.]*)?(?:\.(.+))?$/
  B = /\bhover(\.\S+)?\b/
  C = /^key/
  D = /^(?:mouse|contextmenu)|click/
  E = /^(?:focusinfocus|focusoutblur)$/
  F = /^(\w*)(?:#([\w\-]+))?(?:\.([\w\-]+))?$/
  G = (a) ->
    b = F.exec(a)
    b and (b[1] = (b[1] or "").toLowerCase()
    b[3] = b[3] and new RegExp("(?:^|\\s)" + b[3] + "(?:\\s|$)")
    )
    b

  H = (a, b) ->
    c = a.attributes or {}
    (not b[1] or a.nodeName.toLowerCase() is b[1]) and (not b[2] or (c.id or {}).value is b[2]) and (not b[3] or b[3].test((c["class"] or {}).value))

  I = (a) ->
    (if f.event.special.hover then a else a.replace(B, "mouseenter$1 mouseleave$1"))

  f.event =
    add: (a, c, d, e, g) ->
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      n = undefined
      o = undefined
      p = undefined
      q = undefined
      r = undefined
      s = undefined
      unless a.nodeType is 3 or a.nodeType is 8 or not c or not d or not (h = f._data(a))
        d.handler and (p = d
        d = p.handler
        )
        d.guid or (d.guid = f.guid++)
        j = h.events
        j or (h.events = j = {})
        i = h.handle
        i or (h.handle = i = (a) ->
          (if typeof f isnt "undefined" and (not a or f.event.triggered isnt a.type) then f.event.dispatch.apply(i.elem, arguments_) else b)

        i.elem = a
        )
        c = f.trim(I(c)).split(" ")

        k = 0
        while k < c.length
          l = A.exec(c[k]) or []
          m = l[1]
          n = (l[2] or "").split(".").sort()
          s = f.event.special[m] or {}
          m = ((if g then s.delegateType else s.bindType)) or m
          s = f.event.special[m] or {}
          o = f.extend(
            type: m
            origType: l[1]
            data: e
            handler: d
            guid: d.guid
            selector: g
            quick: G(g)
            namespace: n.join(".")
          , p)
          r = j[m]

          unless r
            r = j[m] = []
            r.delegateCount = 0

            (if a.addEventListener then a.addEventListener(m, i, not 1) else a.attachEvent and a.attachEvent("on" + m, i))  if not s.setup or s.setup.call(a, e, n, i) is not 1
          s.add and (s.add.call(a, o)
          o.handler.guid or (o.handler.guid = d.guid)
          )
          (if g then r.splice(r.delegateCount++, 0, o) else r.push(o))
          f.event.global[m] = not 0
          k++
        a = null
      return

    global: {}
    remove: (a, b, c, d, e) ->
      g = f.hasData(a) and f._data(a)
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      n = undefined
      o = undefined
      p = undefined
      q = undefined
      r = undefined
      s = undefined
      if !!g and !!(o = g.events)
        b = f.trim(I(b or "")).split(" ")
        h = 0
        while h < b.length
          i = A.exec(b[h]) or []
          j = k = i[1]
          l = i[2]

          unless j
            for j of o
              continue
            continue
          p = f.event.special[j] or {}
          j = ((if d then p.delegateType else p.bindType)) or j
          r = o[j] or []
          m = r.length
          l = (if l then new RegExp("(^|\\.)" + l.split(".").sort().join("\\.(?:.*\\.)?") + "(\\.|$)") else null)

          n = 0
          while n < r.length
            s = r[n]
            (e or k is s.origType) and (not c or c.guid is s.guid) and (not l or l.test(s.namespace)) and (not d or d is s.selector or d is "**" and s.selector) and (r.splice(n--, 1)
            s.selector and r.delegateCount--
            p.remove and p.remove.call(a, s)
            )
            n++
          r.length is 0 and m isnt r.length and ((not p.teardown or p.teardown.call(a, l) is not 1) and f.removeEvent(a, j, g.handle)
          delete o[j]

          )
          h++
        f.isEmptyObject(o) and (q = g.handle
        q and (q.elem = null)
        f.removeData(a, [
          "events"
          "handle"
        ], not 0)
        )
      return

    customEvent:
      getData: not 0
      setData: not 0
      changeData: not 0

    trigger: (c, d, e, g) ->
      if not e or e.nodeType isnt 3 and e.nodeType isnt 8
        h = c.type or c
        i = []
        j = undefined
        k = undefined
        l = undefined
        m = undefined
        n = undefined
        o = undefined
        p = undefined
        q = undefined
        r = undefined
        s = undefined
        return  if E.test(h + f.event.triggered)
        h.indexOf("!") >= 0 and (h = h.slice(0, -1)
        k = not 0
        )
        h.indexOf(".") >= 0 and (i = h.split(".")
        h = i.shift()
        i.sort()
        )

        return  if (not e or f.event.customEvent[h]) and not f.event.global[h]
        c = (if typeof c is "object" then (if c[f.expando] then c else new f.Event(h, c)) else new f.Event(h))
        c.type = h
        c.isTrigger = not 0
        c.exclusive = k
        c.namespace = i.join(".")
        c.namespace_re = (if c.namespace then new RegExp("(^|\\.)" + i.join("\\.(?:.*\\.)?") + "(\\.|$)") else null)
        o = (if h.indexOf(":") < 0 then "on" + h else "")

        unless e
          j = f.cache
          for l of j
            continue
          return
        c.result = b
        c.target or (c.target = e)
        d = (if d? then f.makeArray(d) else [])
        d.unshift(c)
        p = f.event.special[h] or {}

        return  if p.trigger and p.trigger.apply(e, d) is not 1
        r = [[
          e
          p.bindType or h
        ]]
        if not g and not p.noBubble and not f.isWindow(e)
          s = p.delegateType or h
          m = (if E.test(s + h) then e else e.parentNode)
          n = null

          while m
            r.push([
              m
              s
            ])
            n = m
            m = m.parentNode
          n and n is e.ownerDocument and r.push([
            n.defaultView or n.parentWindow or a
            s
          ])
        l = 0
        while l < r.length and not c.isPropagationStopped()
          m = r[l][0]
          c.type = r[l][1]
          q = (f._data(m, "events") or {})[c.type] and f._data(m, "handle")
          q and q.apply(m, d)
          q = o and m[o]
          q and f.acceptData(m) and q.apply(m, d) is not 1 and c.preventDefault()
          l++
        c.type = h
        not g and not c.isDefaultPrevented() and (not p._default or p._default.apply(e.ownerDocument, d) is not 1) and (h isnt "click" or not f.nodeName(e, "a")) and f.acceptData(e) and o and e[h] and (h isnt "focus" and h isnt "blur" or c.target.offsetWidth isnt 0) and not f.isWindow(e) and (n = e[o]
        n and (e[o] = null)
        f.event.triggered = h
        e[h]()
        f.event.triggered = b
        n and (e[o] = n)
        )

        c.result

    dispatch: (c) ->
      c = f.event.fix(c or a.event)
      d = (f._data(this, "events") or {})[c.type] or []
      e = d.delegateCount
      g = [].slice.call(arguments_, 0)
      h = not c.exclusive and not c.namespace
      i = []
      j = undefined
      k = undefined
      l = undefined
      m = undefined
      n = undefined
      o = undefined
      p = undefined
      q = undefined
      r = undefined
      s = undefined
      t = undefined
      g[0] = c
      c.delegateTarget = this

      if e and not c.target.disabled and (not c.button or c.type isnt "click")
        m = f(this)
        m.context = @ownerDocument or this

        l = c.target
        while l isnt this
          o = {}
          q = []
          m[0] = l

          j = 0
          while j < e
            r = d[j]
            s = r.selector
            o[s] is b and (o[s] = (if r.quick then H(l, r.quick) else m.is(s)))
            o[s] and q.push(r)
            j++
          q.length and i.push(
            elem: l
            matches: q
          )
          l = l.parentNode or this
      d.length > e and i.push(
        elem: this
        matches: d.slice(e)
      )
      j = 0
      while j < i.length and not c.isPropagationStopped()
        p = i[j]
        c.currentTarget = p.elem

        k = 0
        while k < p.matches.length and not c.isImmediatePropagationStopped()
          r = p.matches[k]
          if h or not c.namespace and not r.namespace or c.namespace_re and c.namespace_re.test(r.namespace)
            c.data = r.data
            c.handleObj = r
            n = ((f.event.special[r.origType] or {}).handle or r.handler).apply(p.elem, g)
            n isnt b and (c.result = n
            n is not 1 and (c.preventDefault()
            c.stopPropagation()
            )
            )
          k++
        j++
      c.result

    props: "attrChange attrName relatedNode srcElement altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" ")
    fixHooks: {}
    keyHooks:
      props: "char charCode key keyCode".split(" ")
      filter: (a, b) ->
        not a.which? and (a.which = (if b.charCode? then b.charCode else b.keyCode))
        a

    mouseHooks:
      props: "button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" ")
      filter: (a, d) ->
        e = undefined
        f = undefined
        g = undefined
        h = d.button
        i = d.fromElement
        not a.pageX? and d.clientX? and (e = a.target.ownerDocument or c
        f = e.documentElement
        g = e.body
        a.pageX = d.clientX + (f and f.scrollLeft or g and g.scrollLeft or 0) - (f and f.clientLeft or g and g.clientLeft or 0)
        a.pageY = d.clientY + (f and f.scrollTop or g and g.scrollTop or 0) - (f and f.clientTop or g and g.clientTop or 0)
        )
        not a.relatedTarget and i and (a.relatedTarget = (if i is a.target then d.toElement else i))
        not a.which and h isnt b and (a.which = (if h & 1 then 1 else (if h & 2 then 3 else (if h & 4 then 2 else 0))))

        a

    fix: (a) ->
      return a  if a[f.expando]
      d = undefined
      e = undefined
      g = a
      h = f.event.fixHooks[a.type] or {}
      i = (if h.props then @props.concat(h.props) else @props)
      a = f.Event(g)
      d = i.length
      while d
        e = i[--d]
        a[e] = g[e]
      a.target or (a.target = g.srcElement or c)
      a.target.nodeType is 3 and (a.target = a.target.parentNode)
      a.metaKey is b and (a.metaKey = a.ctrlKey)

      (if h.filter then h.filter(a, g) else a)

    special:
      ready:
        setup: f.bindReady

      load:
        noBubble: not 0

      focus:
        delegateType: "focusin"

      blur:
        delegateType: "focusout"

      beforeunload:
        setup: (a, b, c) ->
          f.isWindow(this) and (@onbeforeunload = c)
          return

        teardown: (a, b) ->
          @onbeforeunload is b and (@onbeforeunload = null)
          return

    simulate: (a, b, c, d) ->
      e = f.extend(new f.Event, c,
        type: a
        isSimulated: not 0
        originalEvent: {}
      )
      (if d then f.event.trigger(e, null, b) else f.event.dispatch.call(b, e))
      e.isDefaultPrevented() and c.preventDefault()

      return

  f.event.handle = f.event.dispatch
  f.removeEvent = (if c.removeEventListener then (a, b, c) ->
    a.removeEventListener and a.removeEventListener(b, c, not 1)
    return
   else (a, b, c) ->
    a.detachEvent and a.detachEvent("on" + b, c)
    return
  )
  f.Event = (a, b) ->
    return new f.Event(a, b)  unless this instanceof f.Event
    (if a and a.type then (@originalEvent = a
    @type = a.type
    @isDefaultPrevented = (if a.defaultPrevented or a.returnValue is not 1 or a.getPreventDefault and a.getPreventDefault() then K else J)
    ) else @type = a)
    b and f.extend(this, b)
    @timeStamp = a and a.timeStamp or f.now()
    this[f.expando] = not 0

    return

  f.Event:: =
    preventDefault: ->
      @isDefaultPrevented = K
      a = @originalEvent
      not a or ((if a.preventDefault then a.preventDefault() else a.returnValue = not 1))
      return

    stopPropagation: ->
      @isPropagationStopped = K
      a = @originalEvent
      not a or (a.stopPropagation and a.stopPropagation()
      a.cancelBubble = not 0
      )
      return

    stopImmediatePropagation: ->
      @isImmediatePropagationStopped = K
      @stopPropagation()

      return

    isDefaultPrevented: J
    isPropagationStopped: J
    isImmediatePropagationStopped: J

  f.each(
    mouseenter: "mouseover"
    mouseleave: "mouseout"
  , (a, b) ->
    f.event.special[a] =
      delegateType: b
      bindType: b
      handle: (a) ->
        c = this
        d = a.relatedTarget
        e = a.handleObj
        g = e.selector
        h = undefined
        if not d or d isnt c and not f.contains(c, d)
          a.type = e.origType
          h = e.handler.apply(this, arguments_)
          a.type = b
        h

    return
  )
  f.support.submitBubbles or (f.event.special.submit =
    setup: ->
      return not 1  if f.nodeName(this, "form")
      f.event.add this, "click._submit keypress._submit", (a) ->
        c = a.target
        d = (if f.nodeName(c, "input") or f.nodeName(c, "button") then c.form else b)
        d and not d._submit_attached and (f.event.add(d, "submit._submit", (a) ->
          @parentNode and not a.isTrigger and f.event.simulate("submit", @parentNode, a, not 0)
          return
        )
        d._submit_attached = not 0
        )
        return

      return

    teardown: ->
      return not 1  if f.nodeName(this, "form")
      f.event.remove this, "._submit"
      return
  )
  f.support.changeBubbles or (f.event.special.change =
    setup: ->
      if z.test(@nodeName)
        if @type is "checkbox" or @type is "radio"
          f.event.add(this, "propertychange._change", (a) ->
            a.originalEvent.propertyName is "checked" and (@_just_changed = not 0)
            return
          )
          f.event.add(this, "click._change", (a) ->
            @_just_changed and not a.isTrigger and (@_just_changed = not 1
            f.event.simulate("change", this, a, not 0)
            )
            return
          )
        return not 1
      f.event.add this, "beforeactivate._change", (a) ->
        b = a.target
        z.test(b.nodeName) and not b._change_attached and (f.event.add(b, "change._change", (a) ->
          @parentNode and not a.isSimulated and not a.isTrigger and f.event.simulate("change", @parentNode, a, not 0)
          return
        )
        b._change_attached = not 0
        )
        return

      return

    handle: (a) ->
      b = a.target
      a.handleObj.handler.apply this, arguments_  if this isnt b or a.isSimulated or a.isTrigger or b.type isnt "radio" and b.type isnt "checkbox"

    teardown: ->
      f.event.remove this, "._change"
      z.test @nodeName
  )
  f.support.focusinBubbles or f.each(
    focus: "focusin"
    blur: "focusout"
  , (a, b) ->
    d = 0
    e = (a) ->
      f.event.simulate b, a.target, f.event.fix(a), not 0
      return

    f.event.special[b] =
      setup: ->
        d++ is 0 and c.addEventListener(a, e, not 0)
        return

      teardown: ->
        --d is 0 and c.removeEventListener(a, e, not 0)
        return

    return
  )
  f.fn.extend(
    on: (a, c, d, e, g) ->
      h = undefined
      i = undefined
      if typeof a is "object"
        typeof c isnt "string" and (d = c
        c = b
        )
        for i of a
          continue
        return this
      (if not d? and not e? then (e = c
      d = c = b
      ) else not e? and ((if typeof c is "string" then (e = d
      d = b
      ) else (e = d
      d = c
      c = b
      ))))
      if e is not 1
        e = J
      else return this  unless e
      g is 1 and (h = e
      e = (a) ->
        f().off a
        h.apply this, arguments_

      e.guid = h.guid or (h.guid = f.guid++)
      )
      @each ->
        f.event.add this, a, e, d, c
        return


    one: (a, b, c, d) ->
      @on.call this, a, b, c, d, 1

    off: (a, c, d) ->
      if a and a.preventDefault and a.handleObj
        e = a.handleObj
        f(a.delegateTarget).off (if e.namespace then e.type + "." + e.namespace else e.type), e.selector, e.handler
        return this
      if typeof a is "object"
        for g of a
          continue
        return this
      if c is not 1 or typeof c is "function"
        d = c
        c = b
      d is not 1 and (d = J)
      @each ->
        f.event.remove this, a, d, c
        return


    bind: (a, b, c) ->
      @on a, null, b, c

    unbind: (a, b) ->
      @off a, null, b

    live: (a, b, c) ->
      f(@context).on a, @selector, b, c
      this

    die: (a, b) ->
      f(@context).off a, @selector or "**", b
      this

    delegate: (a, b, c, d) ->
      @on b, a, c, d

    undelegate: (a, b, c) ->
      (if arguments_.length is 1 then @off(a, "**") else @off(b, a, c))

    trigger: (a, b) ->
      @each ->
        f.event.trigger a, b, this
        return


    triggerHandler: (a, b) ->
      f.event.trigger a, b, this[0], not 0  if this[0]

    toggle: (a) ->
      b = arguments_
      c = a.guid or f.guid++
      d = 0
      e = (c) ->
        e = (f._data(this, "lastToggle" + a.guid) or 0) % d
        f._data(this, "lastToggle" + a.guid, e + 1)
        c.preventDefault()

        b[e].apply(this, arguments_) or not 1

      e.guid = c
      b[d++].guid = c  while d < b.length
      @click e

    hover: (a, b) ->
      @mouseenter(a).mouseleave b or a
  )
  f.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "), (a, b) ->
    f.fn[b] = (a, c) ->
      not c? and (c = a
      a = null
      )
      (if arguments_.length > 0 then @on(b, null, a, c) else @trigger(b))

    f.attrFn and (f.attrFn[b] = not 0)
    C.test(b) and (f.event.fixHooks[b] = f.event.keyHooks)
    D.test(b) and (f.event.fixHooks[b] = f.event.mouseHooks)

    return
  )
  ->
    x = (a, b, c, e, f, g) ->
      h = 0
      i = e.length

      while h < i
        j = e[h]
        if j
          k = not 1
          j = j[a]
          while j
            if j[d] is c
              k = e[j.sizset]
              break
            if j.nodeType is 1
              g or (j[d] = c
              j.sizset = h
              )
              unless typeof b is "string"
                if j is b
                  k = not 0
                  break
              else if m.filter(b, [j]).length > 0
                k = j
                break
            j = j[a]
          e[h] = k
        h++
      return
    w = (a, b, c, e, f, g) ->
      h = 0
      i = e.length

      while h < i
        j = e[h]
        if j
          k = not 1
          j = j[a]
          while j
            if j[d] is c
              k = e[j.sizset]
              break
            j.nodeType is 1 and not g and (j[d] = c
            j.sizset = h
            )
            if j.nodeName.toLowerCase() is b
              k = j
              break
            j = j[a]
          e[h] = k
        h++
      return
    a = /((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^\[\]]*\]|['"][^'"]*['"]|[^\[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?((?:.|\r|\n)*)/g
    d = "sizcache" + (Math.random() + "").replace(".", "")
    e = 0
    g = Object::toString
    h = not 1
    i = not 0
    j = /\\/g
    k = /\r\n/g
    l = /\W/
    [
      0
      0
    ].sort ->
      i = not 1
      0

    m = (b, d, e, f) ->
      e = e or []
      d = d or c

      h = d
      return []  if d.nodeType isnt 1 and d.nodeType isnt 9
      return e  if not b or typeof b isnt "string"
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      n = undefined
      q = undefined
      r = undefined
      t = undefined
      u = not 0
      v = m.isXML(d)
      w = []
      x = b
      loop
        a.exec("")
        i = a.exec(x)

        if i
          x = i[3]
          w.push(i[1])

          if i[2]
            l = i[3]
            break
        break unless i
      if w.length > 1 and p.exec(b)
        if w.length is 2 and o.relative[w[0]]
          j = y(w[0] + w[1], d, f)
        else
          j = (if o.relative[w[0]] then [d] else m(w.shift(), d))
          while w.length
            b = w.shift()
            o.relative[b] and (b += w.shift())
            j = y(b, j, f)
      else
        not f and w.length > 1 and d.nodeType is 9 and not v and o.match.ID.test(w[0]) and not o.match.ID.test(w[w.length - 1]) and (n = m.find(w.shift(), d, v)
        d = (if n.expr then m.filter(n.expr, n.set)[0] else n.set[0])
        )
        if d
          n = (if f then
            expr: w.pop()
            set: s(f)
           else m.find(w.pop(), (if w.length is 1 and (w[0] is "~" or w[0] is "+") and d.parentNode then d.parentNode else d), v))
          j = (if n.expr then m.filter(n.expr, n.set) else n.set)
          (if w.length > 0 then k = s(j) else u = not 1)

          while w.length
            q = w.pop()
            r = q
            (if o.relative[q] then r = w.pop() else q = "")
            not r? and (r = d)
            o.relative[q](k, r, v)
        else
          k = w = []
      k or (k = j)
      k or m.error(q or b)

      if g.call(k) is "[object Array]"
        unless u
          e.push.apply e, k
        else if d and d.nodeType is 1
          t = 0
          while k[t]?
            k[t] and (k[t] is not 0 or k[t].nodeType is 1 and m.contains(d, k[t])) and e.push(j[t])
            t++
        else
          t = 0
          while k[t]?
            k[t] and k[t].nodeType is 1 and e.push(j[t])
            t++
      else
        s k, e
      l and (m(l, h, e, f)
      m.uniqueSort(e)
      )
      e

    m.uniqueSort = (a) ->
      if u
        h = i
        a.sort(u)

        if h
          b = 1

          while b < a.length
            a[b] is a[b - 1] and a.splice(b--, 1)
            b++
      a

    m.matches = (a, b) ->
      m a, null, null, b

    m.matchesSelector = (a, b) ->
      m(b, null, null, [a]).length > 0

    m.find = (a, b, c) ->
      d = undefined
      e = undefined
      f = undefined
      g = undefined
      h = undefined
      i = undefined
      return []  unless a
      e = 0
      f = o.order.length

      while e < f
        h = o.order[e]
        if g = o.leftMatch[h].exec(a)
          i = g[1]
          g.splice(1, 1)

          if i.substr(i.length - 1) isnt "\\"
            g[1] = (g[1] or "").replace(j, "")
            d = o.find[h](g, b, c)

            if d?
              a = a.replace(o.match[h], "")
              break
        e++
      d or (d = (if typeof b.getElementsByTagName isnt "undefined" then b.getElementsByTagName("*") else []))
      set: d
      expr: a

    m.filter = (a, c, d, e) ->
      f = undefined
      g = undefined
      h = undefined
      i = undefined
      j = undefined
      k = undefined
      l = undefined
      n = undefined
      p = undefined
      q = a
      r = []
      s = c
      t = c and c[0] and m.isXML(c[0])
      while a and c.length
        for h of o.filter
          continue
        if a is q
          unless g?
            m.error a
          else
            break
        q = a
      s

    m.error = (a) ->
      throw new Error("Syntax error, unrecognized expression: " + a)return


    n = m.getText = (a) ->
      b = undefined
      c = undefined
      d = a.nodeType
      e = ""
      if d
        if d is 1 or d is 9
          return a.textContent  if typeof a.textContent is "string"
          return a.innerText.replace(k, "")  if typeof a.innerText is "string"
          a = a.firstChild
          while a
            e += n(a)
            a = a.nextSibling
        else return a.nodeValue  if d is 3 or d is 4
      else
        b = 0
        while c = a[b]
          c.nodeType isnt 8 and (e += n(c))
          b++
      e

    o = m.selectors =
      order: [
        "ID"
        "NAME"
        "TAG"
      ]
      match:
        ID: /#((?:[\w\u00c0-\uFFFF\-]|\\.)+)/
        CLASS: /\.((?:[\w\u00c0-\uFFFF\-]|\\.)+)/
        NAME: /\[name=['"]*((?:[\w\u00c0-\uFFFF\-]|\\.)+)['"]*\]/
        ATTR: /\[\s*((?:[\w\u00c0-\uFFFF\-]|\\.)+)\s*(?:(\S?=)\s*(?:(['"])(.*?)\3|(#?(?:[\w\u00c0-\uFFFF\-]|\\.)*)|)|)\s*\]/
        TAG: /^((?:[\w\u00c0-\uFFFF\*\-]|\\.)+)/
        CHILD: /:(only|nth|last|first)-child(?:\(\s*(even|odd|(?:[+\-]?\d+|(?:[+\-]?\d*)?n\s*(?:[+\-]\s*\d+)?))\s*\))?/
        POS: /:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^\-]|$)/
        PSEUDO: /:((?:[\w\u00c0-\uFFFF\-]|\\.)+)(?:\((['"]?)((?:\([^\)]+\)|[^\(\)]*)+)\2\))?/

      leftMatch: {}
      attrMap:
        class: "className"
        for: "htmlFor"

      attrHandle:
        href: (a) ->
          a.getAttribute "href"

        type: (a) ->
          a.getAttribute "type"

      relative:
        "+": (a, b) ->
          c = typeof b is "string"
          d = c and not l.test(b)
          e = c and not d
          d and (b = b.toLowerCase())
          f = 0
          g = a.length
          h = undefined

          while f < g
            if h = a[f]
                while (h = h.previousSibling) and h.nodeType isnt 1
              a[f] = (if e or h and h.nodeName.toLowerCase() is b then h or not 1 else h is b)
            f++
          e and m.filter(b, a, not 0)
          return

        ">": (a, b) ->
          c = undefined
          d = typeof b is "string"
          e = 0
          f = a.length
          if d and not l.test(b)
            b = b.toLowerCase()
            while e < f
              c = a[e]
              if c
                g = c.parentNode
                a[e] = (if g.nodeName.toLowerCase() is b then g else not 1)
              e++
          else
            while e < f
              c = a[e]
              c and (a[e] = (if d then c.parentNode else c.parentNode is b))
              e++
            d and m.filter(b, a, not 0)
          return

        "": (a, b, c) ->
          d = undefined
          f = e++
          g = x
          typeof b is "string" and not l.test(b) and (b = b.toLowerCase()
          d = b
          g = w
          )
          g("parentNode", b, f, a, d, c)

          return

        "~": (a, b, c) ->
          d = undefined
          f = e++
          g = x
          typeof b is "string" and not l.test(b) and (b = b.toLowerCase()
          d = b
          g = w
          )
          g("previousSibling", b, f, a, d, c)

          return

      find:
        ID: (a, b, c) ->
          if typeof b.getElementById isnt "undefined" and not c
            d = b.getElementById(a[1])
            (if d and d.parentNode then [d] else [])

        NAME: (a, b) ->
          unless typeof b.getElementsByName is "undefined"
            c = []
            d = b.getElementsByName(a[1])
            e = 0
            f = d.length

            while e < f
              d[e].getAttribute("name") is a[1] and c.push(d[e])
              e++
            (if c.length is 0 then null else c)

        TAG: (a, b) ->
          b.getElementsByTagName a[1]  unless typeof b.getElementsByTagName is "undefined"

      preFilter:
        CLASS: (a, b, c, d, e, f) ->
          a = " " + a[1].replace(j, "") + " "
          return a  if f
          g = 0
          h = undefined

          while (h = b[g])?
            h and ((if e ^ (h.className and (" " + h.className + " ").replace(/[\t\n\r]/g, " ").indexOf(a) >= 0) then c or d.push(h) else c and (b[g] = not 1)))
            g++
          not 1

        ID: (a) ->
          a[1].replace j, ""

        TAG: (a, b) ->
          a[1].replace(j, "").toLowerCase()

        CHILD: (a) ->
          if a[1] is "nth"
            a[2] or m.error(a[0])
            a[2] = a[2].replace(/^\+|\s*/g, "")

            b = /(-?)(\d*)(?:n([+\-]?\d*))?/.exec(a[2] is "even" and "2n" or a[2] is "odd" and "2n+1" or not /\D/.test(a[2]) and "0n+" + a[2] or a[2])
            a[2] = b[1] + (b[2] or 1) - 0
            a[3] = b[3] - 0
          else
            a[2] and m.error(a[0])
          a[0] = e++
          a

        ATTR: (a, b, c, d, e, f) ->
          g = a[1] = a[1].replace(j, "")
          not f and o.attrMap[g] and (a[1] = o.attrMap[g])
          a[4] = (a[4] or a[5] or "").replace(j, "")
          a[2] is "~=" and (a[4] = " " + a[4] + " ")

          a

        PSEUDO: (b, c, d, e, f) ->
          if b[1] is "not"
            if (a.exec(b[3]) or "").length > 1 or /^\w/.test(b[3])
              b[3] = m(b[3], null, null, c)
            else
              g = m.filter(b[3], c, d, not 0 ^ f)
              d or e.push.apply(e, g)
              return not 1
          else return not 0  if o.match.POS.test(b[0]) or o.match.CHILD.test(b[0])
          b

        POS: (a) ->
          a.unshift not 0
          a

      filters:
        enabled: (a) ->
          a.disabled is not 1 and a.type isnt "hidden"

        disabled: (a) ->
          a.disabled is not 0

        checked: (a) ->
          a.checked is not 0

        selected: (a) ->
          a.parentNode and a.parentNode.selectedIndex
          a.selected is not 0

        parent: (a) ->
          !!a.firstChild

        empty: (a) ->
          not a.firstChild

        has: (a, b, c) ->
          !!m(c[3], a).length

        header: (a) ->
          /h\d/i.test a.nodeName

        text: (a) ->
          b = a.getAttribute("type")
          c = a.type
          a.nodeName.toLowerCase() is "input" and "text" is c and (b is c or b is null)

        radio: (a) ->
          a.nodeName.toLowerCase() is "input" and "radio" is a.type

        checkbox: (a) ->
          a.nodeName.toLowerCase() is "input" and "checkbox" is a.type

        file: (a) ->
          a.nodeName.toLowerCase() is "input" and "file" is a.type

        password: (a) ->
          a.nodeName.toLowerCase() is "input" and "password" is a.type

        submit: (a) ->
          b = a.nodeName.toLowerCase()
          (b is "input" or b is "button") and "submit" is a.type

        image: (a) ->
          a.nodeName.toLowerCase() is "input" and "image" is a.type

        reset: (a) ->
          b = a.nodeName.toLowerCase()
          (b is "input" or b is "button") and "reset" is a.type

        button: (a) ->
          b = a.nodeName.toLowerCase()
          b is "input" and "button" is a.type or b is "button"

        input: (a) ->
          /input|select|textarea|button/i.test a.nodeName

        focus: (a) ->
          a is a.ownerDocument.activeElement

      setFilters:
        first: (a, b) ->
          b is 0

        last: (a, b, c, d) ->
          b is d.length - 1

        even: (a, b) ->
          b % 2 is 0

        odd: (a, b) ->
          b % 2 is 1

        lt: (a, b, c) ->
          b < c[3] - 0

        gt: (a, b, c) ->
          b > c[3] - 0

        nth: (a, b, c) ->
          c[3] - 0 is b

        eq: (a, b, c) ->
          c[3] - 0 is b

      filter:
        PSEUDO: (a, b, c, d) ->
          e = b[1]
          f = o.filters[e]
          return f(a, c, b, d)  if f
          return (a.textContent or a.innerText or n([a]) or "").indexOf(b[3]) >= 0  if e is "contains"
          if e is "not"
            g = b[3]
            h = 0
            i = g.length

            while h < i
              return not 1  if g[h] is a
              h++
            return not 0
          m.error e
          return

        CHILD: (a, b) ->
          c = undefined
          e = undefined
          f = undefined
          g = undefined
          h = undefined
          i = undefined
          j = undefined
          k = b[1]
          l = a
          switch k
            when "only", "first"
              return not 1  if l.nodeType is 1  while l = l.previousSibling
              return not 0  if k is "first"
              l = a
            when "last"
              return not 1  if l.nodeType is 1  while l = l.nextSibling
              not 0
            when "nth"
              c = b[2]
              e = b[3]

              return not 0  if c is 1 and e is 0
              f = b[0]
              g = a.parentNode

              if g and (g[d] isnt f or not a.nodeIndex)
                i = 0
                l = g.firstChild
                while l
                  l.nodeType is 1 and (l.nodeIndex = ++i)
                  l = l.nextSibling
                g[d] = f
              j = a.nodeIndex - e
              (if c is 0 then j is 0 else j % c is 0 and j / c >= 0)
          return

        ID: (a, b) ->
          a.nodeType is 1 and a.getAttribute("id") is b

        TAG: (a, b) ->
          b is "*" and a.nodeType is 1 or !!a.nodeName and a.nodeName.toLowerCase() is b

        CLASS: (a, b) ->
          (" " + (a.className or a.getAttribute("class")) + " ").indexOf(b) > -1

        ATTR: (a, b) ->
          c = b[1]
          d = (if m.attr then m.attr(a, c) else (if o.attrHandle[c] then o.attrHandle[c](a) else (if a[c]? then a[c] else a.getAttribute(c))))
          e = d + ""
          f = b[2]
          g = b[4]
          (if not d? then f is "!=" else (if not f and m.attr then d? else (if f is "=" then e is g else (if f is "*=" then e.indexOf(g) >= 0 else (if f is "~=" then (" " + e + " ").indexOf(g) >= 0 else (if g then (if f is "!=" then e isnt g else (if f is "^=" then e.indexOf(g) is 0 else (if f is "$=" then e.substr(e.length - g.length) is g else (if f is "|=" then e is g or e.substr(0, g.length + 1) is g + "-" else not 1)))) else e and d isnt not 1))))))

        POS: (a, b, c, d) ->
          e = b[2]
          f = o.setFilters[e]
          f a, c, b, d  if f

    p = o.match.POS
    q = (a, b) ->
      "\\" + (b - 0 + 1)

    for r of o.match
      continue
    s = (a, b) ->
      a = Array::slice.call(a, 0)
      if b
        b.push.apply b, a
        return b
      a

    try
      Array::slice.call(c.documentElement.childNodes, 0)[0].nodeType
    catch t
      s = (a, b) ->
        c = 0
        d = b or []
        if g.call(a) is "[object Array]"
          Array::push.apply d, a
        else if typeof a.length is "number"
          e = a.length

          while c < e
            d.push a[c]
            c++
        else
          while a[c]
            d.push a[c]
            c++
        d
    u = undefined
    v = undefined
    (if c.documentElement.compareDocumentPosition then u = (a, b) ->
      if a is b
        h = not 0
        return 0
      return (if a.compareDocumentPosition then -1 else 1)  if not a.compareDocumentPosition or not b.compareDocumentPosition
      (if a.compareDocumentPosition(b) & 4 then -1 else 1)
     else (u = (a, b) ->
      if a is b
        h = not 0
        return 0
      return a.sourceIndex - b.sourceIndex  if a.sourceIndex and b.sourceIndex
      c = undefined
      d = undefined
      e = []
      f = []
      g = a.parentNode
      i = b.parentNode
      j = g
      return v(a, b)  if g is i
      return -1  unless g
      return 1  unless i
      while j
        e.unshift(j)
        j = j.parentNode
      j = i
      while j
        f.unshift(j)
        j = j.parentNode
      c = e.length
      d = f.length

      k = 0

      while k < c and k < d
        return v(e[k], f[k])  if e[k] isnt f[k]
        k++
      (if k is c then v(a, f[k], -1) else v(e[k], b, 1))

    v = (a, b, c) ->
      return c  if a is b
      d = a.nextSibling
      while d
        return -1  if d is b
        d = d.nextSibling
      1

    ))
    ->
      a = c.createElement("div")
      d = "script" + (new Date).getTime()
      e = c.documentElement
      a.innerHTML = "<a name='" + d + "'/>"
      e.insertBefore(a, e.firstChild)
      c.getElementById(d) and (o.find.ID = (a, c, d) ->
        if typeof c.getElementById isnt "undefined" and not d
          e = c.getElementById(a[1])
          (if e then (if e.id is a[1] or typeof e.getAttributeNode isnt "undefined" and e.getAttributeNode("id").nodeValue is a[1] then [e] else b) else [])

      o.filter.ID = (a, b) ->
        c = typeof a.getAttributeNode isnt "undefined" and a.getAttributeNode("id")
        a.nodeType is 1 and c and c.nodeValue is b

      )
      e.removeChild(a)
      e = a = null

      return
    ()
    ->
      a = c.createElement("div")
      a.appendChild(c.createComment(""))
      a.getElementsByTagName("*").length > 0 and (o.find.TAG = (a, b) ->
        c = b.getElementsByTagName(a[1])
        if a[1] is "*"
          d = []
          e = 0

          while c[e]
            c[e].nodeType is 1 and d.push(c[e])
            e++
          c = d
        c
      )
      a.innerHTML = "<a href='#'></a>"
      a.firstChild and typeof a.firstChild.getAttribute isnt "undefined" and a.firstChild.getAttribute("href") isnt "#" and (o.attrHandle.href = (a) ->
        a.getAttribute "href", 2
      )
      a = null

      return
    ()
    c.querySelectorAll and ->
      a = m
      b = c.createElement("div")
      d = "__sizzle__"
      b.innerHTML = "<p class='TEST'></p>"
      if not b.querySelectorAll or b.querySelectorAll(".TEST").length isnt 0
        m = (b, e, f, g) ->
          e = e or c
          if not g and not m.isXML(e)
            h = /^(\w+$)|^\.([\w\-]+$)|^#([\w\-]+$)/.exec(b)
            if h and (e.nodeType is 1 or e.nodeType is 9)
              return s(e.getElementsByTagName(b), f)  if h[1]
              return s(e.getElementsByClassName(h[2]), f)  if h[2] and o.find.CLASS and e.getElementsByClassName
            if e.nodeType is 9
              return s([e.body], f)  if b is "body" and e.body
              if h and h[3]
                i = e.getElementById(h[3])
                return s([], f)  if not i or not i.parentNode
                return s([i], f)  if i.id is h[3]
              try
                return s(e.querySelectorAll(b), f)
            else if e.nodeType is 1 and e.nodeName.toLowerCase() isnt "object"
              k = e
              l = e.getAttribute("id")
              n = l or d
              p = e.parentNode
              q = /^\s*[+~]/.test(b)
              (if l then n = n.replace(/'/g, "\\$&") else e.setAttribute("id", n))
              q and p and (e = e.parentNode)

              try
                return s(e.querySelectorAll("[id='" + n + "'] " + b), f)  if not q or p
              finally
                l or k.removeAttribute("id")
          a b, e, f, g

        for e of a
          continue
        b = null
      return
    ()
    ->
      a = c.documentElement
      b = a.matchesSelector or a.mozMatchesSelector or a.webkitMatchesSelector or a.msMatchesSelector
      if b
        d = not b.call(c.createElement("div"), "div")
        e = not 1
        try
          b.call c.documentElement, "[test!='']:sizzle"
        catch f
          e = not 0
        m.matchesSelector = (a, c) ->
          c = c.replace(/\=\s*([^'"\]]*)\s*\]/g, "='$1']")
          unless m.isXML(a)
            try
              if e or not o.match.PSEUDO.test(c) and not /!=/.test(c)
                f = b.call(a, c)
                return f  if f or not d or a.document and a.document.nodeType isnt 11
          m(c, null, null, [a]).length > 0
      return
    ()
    ->
      a = c.createElement("div")
      a.innerHTML = "<div class='test e'></div><div class='test'></div>"
      if !!a.getElementsByClassName and a.getElementsByClassName("e").length isnt 0
        a.lastChild.className = "e"
        return  if a.getElementsByClassName("e").length is 1
        o.order.splice(1, 0, "CLASS")
        o.find.CLASS = (a, b, c) ->
          b.getElementsByClassName a[1]  if typeof b.getElementsByClassName isnt "undefined" and not c

        a = null
      return
    ()
    (if c.documentElement.contains then m.contains = (a, b) ->
      a isnt b and ((if a.contains then a.contains(b) else not 0))
     else (if c.documentElement.compareDocumentPosition then m.contains = (a, b) ->
      !!(a.compareDocumentPosition(b) & 16)
     else m.contains = ->
      not 1
    ))
    m.isXML = (a) ->
      b = ((if a then a.ownerDocument or a else 0)).documentElement
      (if b then b.nodeName isnt "HTML" else not 1)


    y = (a, b, c) ->
      d = undefined
      e = []
      f = ""
      g = (if b.nodeType then [b] else b)
      while d = o.match.PSEUDO.exec(a)
        f += d[0]
        a = a.replace(o.match.PSEUDO, "")
      a = (if o.relative[a] then a + "*" else a)
      h = 0
      i = g.length

      while h < i
        m a, g[h], e, c
        h++
      m.filter f, e

    m.attr = f.attr
    m.selectors.attrMap = {}
    f.find = m
    f.expr = m.selectors
    f.expr[":"] = f.expr.filters
    f.unique = m.uniqueSort
    f.text = m.getText
    f.isXMLDoc = m.isXML
    f.contains = m.contains

    return
  ()

  L = /Until$/
  M = /^(?:parents|prevUntil|prevAll)/
  N = /,/
  O = /^.[^:#\[\.,]*$/
  P = Array::slice
  Q = f.expr.match.POS
  R =
    children: not 0
    contents: not 0
    next: not 0
    prev: not 0

  f.fn.extend(
    find: (a) ->
      b = this
      c = undefined
      d = undefined
      unless typeof a is "string"
        return f(a).filter(->
          c = 0
          d = b.length

          while c < d
            return not 0  if f.contains(b[c], this)
            c++
          return
        )
      e = @pushStack("", "find", a)
      g = undefined
      h = undefined
      i = undefined
      c = 0
      d = @length

      while c < d
        g = e.length
        f.find(a, this[c], e)

        if c > 0
          h = g
          while h < e.length
            i = 0
            while i < g
              if e[i] is e[h]
                e.splice h--, 1
                break
              i++
            h++
        c++
      e

    has: (a) ->
      b = f(a)
      @filter ->
        a = 0
        c = b.length

        while a < c
          return not 0  if f.contains(this, b[a])
          a++
        return


    not: (a) ->
      @pushStack T(this, a, not 1), "not", a

    filter: (a) ->
      @pushStack T(this, a, not 0), "filter", a

    is: (a) ->
      !!a and ((if typeof a is "string" then (if Q.test(a) then f(a, @context).index(this[0]) >= 0 else f.filter(a, this).length > 0) else @filter(a).length > 0))

    closest: (a, b) ->
      c = []
      d = undefined
      e = undefined
      g = this[0]
      if f.isArray(a)
        h = 1
        while g and g.ownerDocument and g isnt b
          d = 0
          while d < a.length
            f(g).is(a[d]) and c.push(
              selector: a[d]
              elem: g
              level: h
            )
            d++
          g = g.parentNode
          h++
        return c
      i = (if Q.test(a) or typeof a isnt "string" then f(a, b or @context) else 0)
      d = 0
      e = @length

      while d < e
        g = this[d]
        while g
          if (if i then i.index(g) > -1 else f.find.matchesSelector(g, a))
            c.push g
            break
          g = g.parentNode
          break  if not g or not g.ownerDocument or g is b or g.nodeType is 11
        d++
      c = (if c.length > 1 then f.unique(c) else c)
      @pushStack c, "closest", a

    index: (a) ->
      return (if this[0] and this[0].parentNode then @prevAll().length else -1)  unless a
      return f.inArray(this[0], f(a))  if typeof a is "string"
      f.inArray (if a.jquery then a[0] else a), this

    add: (a, b) ->
      c = (if typeof a is "string" then f(a, b) else f.makeArray((if a and a.nodeType then [a] else a)))
      d = f.merge(@get(), c)
      @pushStack (if S(c[0]) or S(d[0]) then d else f.unique(d))

    andSelf: ->
      @add @prevObject
  )
  f.each(
    parent: (a) ->
      b = a.parentNode
      (if b and b.nodeType isnt 11 then b else null)

    parents: (a) ->
      f.dir a, "parentNode"

    parentsUntil: (a, b, c) ->
      f.dir a, "parentNode", c

    next: (a) ->
      f.nth a, 2, "nextSibling"

    prev: (a) ->
      f.nth a, 2, "previousSibling"

    nextAll: (a) ->
      f.dir a, "nextSibling"

    prevAll: (a) ->
      f.dir a, "previousSibling"

    nextUntil: (a, b, c) ->
      f.dir a, "nextSibling", c

    prevUntil: (a, b, c) ->
      f.dir a, "previousSibling", c

    siblings: (a) ->
      f.sibling a.parentNode.firstChild, a

    children: (a) ->
      f.sibling a.firstChild

    contents: (a) ->
      (if f.nodeName(a, "iframe") then a.contentDocument or a.contentWindow.document else f.makeArray(a.childNodes))
  , (a, b) ->
    f.fn[a] = (c, d) ->
      e = f.map(this, b, c)
      L.test(a) or (d = c)
      d and typeof d is "string" and (e = f.filter(d, e))
      e = (if @length > 1 and not R[a] then f.unique(e) else e)
      (@length > 1 or N.test(d)) and M.test(a) and (e = e.reverse())

      @pushStack e, a, P.call(arguments_).join(",")

    return
  )
  f.extend(
    filter: (a, b, c) ->
      c and (a = ":not(" + a + ")")
      (if b.length is 1 then (if f.find.matchesSelector(b[0], a) then [b[0]] else []) else f.find.matches(a, b))

    dir: (a, c, d) ->
      e = []
      g = a[c]
      while g and g.nodeType isnt 9 and (d is b or g.nodeType isnt 1 or not f(g).is(d))
        g.nodeType is 1 and e.push(g)
        g = g[c]
      e

    nth: (a, b, c, d) ->
      b = b or 1
      e = 0
      while a
        break  if a.nodeType is 1 and ++e is b
        a = a[c]
      a

    sibling: (a, b) ->
      c = []
      while a
        a.nodeType is 1 and a isnt b and c.push(a)
        a = a.nextSibling
      c
  )

  V = "abbr|article|aside|audio|canvas|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video"
  W = RegExp(" jQuery\\d+=\"(?:\\d+|null)\"", "g")
  X = /^\s+/
  Y = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/g
  Z = /<([\w:]+)/
  $ = /<tbody/i
  _ = /<|&#?\w+;/
  ba = /<(?:script|style)/i
  bb = /<(?:script|object|embed|option|style)/i
  bc = new RegExp("<(?:" + V + ")", "i")
  bd = /checked\s*(?:[^=]|=\s*.checked.)/i
  be = /\/(java|ecma)script/i
  bf = /^\s*<!(?:\[CDATA\[|\-\-)/
  bg =
    option: [
      1
      "<select multiple='multiple'>"
      "</select>"
    ]
    legend: [
      1
      "<fieldset>"
      "</fieldset>"
    ]
    thead: [
      1
      "<table>"
      "</table>"
    ]
    tr: [
      2
      "<table><tbody>"
      "</tbody></table>"
    ]
    td: [
      3
      "<table><tbody><tr>"
      "</tr></tbody></table>"
    ]
    col: [
      2
      "<table><tbody></tbody><colgroup>"
      "</colgroup></table>"
    ]
    area: [
      1
      "<map>"
      "</map>"
    ]
    _default: [
      0
      ""
      ""
    ]

  bh = U(c)
  bg.optgroup = bg.option
  bg.tbody = bg.tfoot = bg.colgroup = bg.caption = bg.thead
  bg.th = bg.td
  f.support.htmlSerialize or (bg._default = [
    1
    "div<div>"
    "</div>"
  ])
  f.fn.extend(
    text: (a) ->
      if f.isFunction(a)
        return @each((b) ->
          c = f(this)
          c.text a.call(this, b, c.text())
          return
        )
      return @empty().append((this[0] and this[0].ownerDocument or c).createTextNode(a))  if typeof a isnt "object" and a isnt b
      f.text this

    wrapAll: (a) ->
      if f.isFunction(a)
        return @each((b) ->
          f(this).wrapAll a.call(this, b)
          return
        )
      if this[0]
        b = f(a, this[0].ownerDocument).eq(0).clone(not 0)
        this[0].parentNode and b.insertBefore(this[0])
        b.map(->
          a = this
          a = a.firstChild  while a.firstChild and a.firstChild.nodeType is 1
          a
        ).append(this)
      this

    wrapInner: (a) ->
      if f.isFunction(a)
        return @each((b) ->
          f(this).wrapInner a.call(this, b)
          return
        )
      @each ->
        b = f(this)
        c = b.contents()
        (if c.length then c.wrapAll(a) else b.append(a))
        return


    wrap: (a) ->
      b = f.isFunction(a)
      @each (c) ->
        f(this).wrapAll (if b then a.call(this, c) else a)
        return


    unwrap: ->
      @parent().each(->
        f.nodeName(this, "body") or f(this).replaceWith(@childNodes)
        return
      ).end()

    append: ->
      @domManip arguments_, not 0, (a) ->
        @nodeType is 1 and @appendChild(a)
        return


    prepend: ->
      @domManip arguments_, not 0, (a) ->
        @nodeType is 1 and @insertBefore(a, @firstChild)
        return


    before: ->
      if this[0] and this[0].parentNode
        return @domManip(arguments_, not 1, (a) ->
          @parentNode.insertBefore a, this
          return
        )
      if arguments_.length
        a = f.clean(arguments_)
        a.push.apply a, @toArray()
        @pushStack a, "before", arguments_

    after: ->
      if this[0] and this[0].parentNode
        return @domManip(arguments_, not 1, (a) ->
          @parentNode.insertBefore a, @nextSibling
          return
        )
      if arguments_.length
        a = @pushStack(this, "after", arguments_)
        a.push.apply a, f.clean(arguments_)
        a

    remove: (a, b) ->
      c = 0
      d = undefined

      while (d = this[c])?
        if not a or f.filter(a, [d]).length
          not b and d.nodeType is 1 and (f.cleanData(d.getElementsByTagName("*"))
          f.cleanData([d])
          )
          d.parentNode and d.parentNode.removeChild(d)
        c++
      this

    empty: ->
      a = 0
      b = undefined

      while (b = this[a])?
        b.nodeType is 1 and f.cleanData(b.getElementsByTagName("*"))
        b.removeChild b.firstChild  while b.firstChild
        a++
      this

    clone: (a, b) ->
      a = (if not a? then not 1 else a)
      b = (if not b? then a else b)

      @map ->
        f.clone this, a, b


    html: (a) ->
      return (if this[0] and this[0].nodeType is 1 then this[0].innerHTML.replace(W, "") else null)  if a is b
      if typeof a is "string" and not ba.test(a) and (f.support.leadingWhitespace or not X.test(a)) and not bg[(Z.exec(a) or [
        ""
        ""
      ])[1].toLowerCase()]
        a = a.replace(Y, "<$1></$2>")
        try
          c = 0
          d = @length

          while c < d
            this[c].nodeType is 1 and (f.cleanData(this[c].getElementsByTagName("*"))
            this[c].innerHTML = a
            )
            c++
        catch e
          @empty().append a
      else
        (if f.isFunction(a) then @each((b) ->
          c = f(this)
          c.html a.call(this, b, c.html())
          return
        ) else @empty().append(a))
      this

    replaceWith: (a) ->
      if this[0] and this[0].parentNode
        if f.isFunction(a)
          return @each((b) ->
            c = f(this)
            d = c.html()
            c.replaceWith a.call(this, b, d)
            return
          )
        typeof a isnt "string" and (a = f(a).detach())
        return @each(->
          b = @nextSibling
          c = @parentNode
          f(this).remove()
          (if b then f(b).before(a) else f(c).append(a))

          return
        )
      (if @length then @pushStack(f((if f.isFunction(a) then a() else a)), "replaceWith", a) else this)

    detach: (a) ->
      @remove a, not 0

    domManip: (a, c, d) ->
      e = undefined
      g = undefined
      h = undefined
      i = undefined
      j = a[0]
      k = []
      if not f.support.checkClone and arguments_.length is 3 and typeof j is "string" and bd.test(j)
        return @each(->
          f(this).domManip a, c, d, not 0
          return
        )
      if f.isFunction(j)
        return @each((e) ->
          g = f(this)
          a[0] = j.call(this, e, (if c then g.html() else b))
          g.domManip(a, c, d)

          return
        )
      if this[0]
        i = j and j.parentNode
        (if f.support.parentNode and i and i.nodeType is 11 and i.childNodes.length is @length then e = fragment: i else e = f.buildFragment(a, this, k))
        h = e.fragment
        (if h.childNodes.length is 1 then g = h = h.firstChild else g = h.firstChild)

        if g
          c = c and f.nodeName(g, "tr")
          l = 0
          m = @length
          n = m - 1

          while l < m
            d.call (if c then bi(this[l], g) else this[l]), (if e.cacheable or m > 1 and l < n then f.clone(h, not 0, not 0) else h)
            l++
        k.length and f.each(k, bp)
      this
  )
  f.buildFragment = (a, b, d) ->
    e = undefined
    g = undefined
    h = undefined
    i = undefined
    j = a[0]
    b and b[0] and (i = b[0].ownerDocument or b[0])
    i.createDocumentFragment or (i = c)
    a.length is 1 and typeof j is "string" and j.length < 512 and i is c and j.charAt(0) is "<" and not bb.test(j) and (f.support.checkClone or not bd.test(j)) and (f.support.html5Clone or not bc.test(j)) and (g = not 0
    h = f.fragments[j]
    h and h isnt 1 and (e = h)
    )
    e or (e = i.createDocumentFragment()
    f.clean(a, i, e, d)
    )
    g and (f.fragments[j] = (if h then e else 1))

    fragment: e
    cacheable: g

  f.fragments = {}
  f.each(
    appendTo: "append"
    prependTo: "prepend"
    insertBefore: "before"
    insertAfter: "after"
    replaceAll: "replaceWith"
  , (a, b) ->
    f.fn[a] = (c) ->
      d = []
      e = f(c)
      g = @length is 1 and this[0].parentNode
      if g and g.nodeType is 11 and g.childNodes.length is 1 and e.length is 1
        e[b] this[0]
        return this
      h = 0
      i = e.length

      while h < i
        j = ((if h > 0 then @clone(not 0) else this)).get()
        f(e[h])[b](j)
        d = d.concat(j)
        h++
      @pushStack d, a, e.selector

    return
  )
  f.extend(
    clone: (a, b, c) ->
      d = undefined
      e = undefined
      g = undefined
      h = (if f.support.html5Clone or not bc.test("<" + a.nodeName) then a.cloneNode(not 0) else bo(a))
      if (not f.support.noCloneEvent or not f.support.noCloneChecked) and (a.nodeType is 1 or a.nodeType is 11) and not f.isXMLDoc(a)
        bk(a, h)
        d = bl(a)
        e = bl(h)

        g = 0
        while d[g]
          e[g] and bk(d[g], e[g])
          ++g
      if b
        bj a, h
        if c
          d = bl(a)
          e = bl(h)

          g = 0
          while d[g]
            bj d[g], e[g]
            ++g
      d = e = null
      h

    clean: (a, b, d, e) ->
      g = undefined
      b = b or c
      typeof b.createElement is "undefined" and (b = b.ownerDocument or b[0] and b[0].ownerDocument or c)

      h = []
      i = undefined
      j = 0
      k = undefined

      while (k = a[j])?
        typeof k is "number" and (k += "")
        continue  unless k
        if typeof k is "string"
          unless _.test(k)
            k = b.createTextNode(k)
          else
            k = k.replace(Y, "<$1></$2>")
            l = (Z.exec(k) or [
              ""
              ""
            ])[1].toLowerCase()
            m = bg[l] or bg._default
            n = m[0]
            o = b.createElement("div")
            (if b is c then bh.appendChild(o) else U(b).appendChild(o))
            o.innerHTML = m[1] + k + m[2]

            o = o.lastChild  while n--
            unless f.support.tbody
              p = $.test(k)
              q = (if l is "table" and not p then o.firstChild and o.firstChild.childNodes else (if m[1] is "<table>" and not p then o.childNodes else []))
              i = q.length - 1
              while i >= 0
                f.nodeName(q[i], "tbody") and not q[i].childNodes.length and q[i].parentNode.removeChild(q[i])
                --i
            not f.support.leadingWhitespace and X.test(k) and o.insertBefore(b.createTextNode(X.exec(k)[0]), o.firstChild)
            k = o.childNodes
        r = undefined
        unless f.support.appendChecked
          if k[0] and typeof (r = k.length) is "number"
            i = 0
            while i < r
              bn k[i]
              i++
          else
            bn k
        (if k.nodeType then h.push(k) else h = f.merge(h, k))
        j++
      if d
        g = (a) ->
          not a.type or be.test(a.type)

        j = 0
        while h[j]
          if e and f.nodeName(h[j], "script") and (not h[j].type or h[j].type.toLowerCase() is "text/javascript")
            e.push (if h[j].parentNode then h[j].parentNode.removeChild(h[j]) else h[j])
          else
            if h[j].nodeType is 1
              s = f.grep(h[j].getElementsByTagName("script"), g)
              h.splice.apply h, [
                j + 1
                0
              ].concat(s)
            d.appendChild h[j]
          j++
      h

    cleanData: (a) ->
      b = undefined
      c = undefined
      d = f.cache
      e = f.event.special
      g = f.support.deleteExpando
      h = 0
      i = undefined

      while (i = a[h])?
        continue  if i.nodeName and f.noData[i.nodeName.toLowerCase()]
        c = i[f.expando]
        if c
          b = d[c]
          if b and b.events
            for j of b.events
              continue
            b.handle and (b.handle.elem = null)
          (if g then delete i[f.expando]
           else i.removeAttribute and i.removeAttribute(f.expando))
          delete d[c]
        h++
      return
  )

  bq = /alpha\([^)]*\)/i
  br = /opacity=([^)]*)/
  bs = /([A-Z]|^ms)/g
  bt = /^-?\d+(?:px)?$/i
  bu = /^-?\d/
  bv = /^([\-+])=([\-+.\de]+)/
  bw =
    position: "absolute"
    visibility: "hidden"
    display: "block"

  bx = [
    "Left"
    "Right"
  ]
  by_ = [
    "Top"
    "Bottom"
  ]
  bz = undefined
  bA = undefined
  bB = undefined
  f.fn.css = (a, c) ->
    return this  if arguments_.length is 2 and c is b
    f.access this, a, c, not 0, (a, c, d) ->
      (if d isnt b then f.style(a, c, d) else f.css(a, c))


  f.extend(
    cssHooks:
      opacity:
        get: (a, b) ->
          if b
            c = bz(a, "opacity", "opacity")
            return (if c is "" then "1" else c)
          a.style.opacity

    cssNumber:
      fillOpacity: not 0
      fontWeight: not 0
      lineHeight: not 0
      opacity: not 0
      orphans: not 0
      widows: not 0
      zIndex: not 0
      zoom: not 0

    cssProps:
      float: (if f.support.cssFloat then "cssFloat" else "styleFloat")

    style: (a, c, d, e) ->
      if !!a and a.nodeType isnt 3 and a.nodeType isnt 8 and !!a.style
        g = undefined
        h = undefined
        i = f.camelCase(c)
        j = a.style
        k = f.cssHooks[i]
        c = f.cssProps[i] or i
        if d is b
          return g  if k and "get" of k and (g = k.get(a, not 1, e)) isnt b
          return j[c]
        h = typeof d
        h is "string" and (g = bv.exec(d)) and (d = +(g[1] + 1) * +g[2] + parseFloat(f.css(a, c))
        h = "number"
        )

        return  if not d? or h is "number" and isNaN(d)
        h is "number" and not f.cssNumber[i] and (d += "px")
        if not k or ("set" of k) or (d = k.set(a, d)) isnt b
          try
            j[c] = d
      return

    css: (a, c, d) ->
      e = undefined
      g = undefined
      c = f.camelCase(c)
      g = f.cssHooks[c]
      c = f.cssProps[c] or c
      c is "cssFloat" and (c = "float")

      return e  if g and "get" of g and (e = g.get(a, not 0, d)) isnt b
      bz a, c  if bz

    swap: (a, b, c) ->
      d = {}
      for e of b
        continue
      c.call a
      for e of b
        continue
      return
  )
  f.curCSS = f.css
  f.each([
    "height"
    "width"
  ], (a, b) ->
    f.cssHooks[b] =
      get: (a, c, d) ->
        e = undefined
        if c
          return bC(a, b, d)  if a.offsetWidth isnt 0
          f.swap a, bw, ->
            e = bC(a, b, d)
            return

          e

      set: (a, b) ->
        return b  unless bt.test(b)
        b = parseFloat(b)
        b + "px"  if b >= 0

    return
  )
  f.support.opacity or (f.cssHooks.opacity =
    get: (a, b) ->
      (if br.test(((if b and a.currentStyle then a.currentStyle.filter else a.style.filter)) or "") then parseFloat(RegExp.$1) / 100 + "" else (if b then "1" else ""))

    set: (a, b) ->
      c = a.style
      d = a.currentStyle
      e = (if f.isNumeric(b) then "alpha(opacity=" + b * 100 + ")" else "")
      g = d and d.filter or c.filter or ""
      c.zoom = 1
      if b >= 1 and f.trim(g.replace(bq, "")) is ""
        c.removeAttribute "filter"
        return  if d and not d.filter
      c.filter = (if bq.test(g) then g.replace(bq, e) else g + " " + e)
      return
  )
  f(->
    f.support.reliableMarginRight or (f.cssHooks.marginRight = get: (a, b) ->
      c = undefined
      f.swap a,
        display: "inline-block"
      , ->
        (if b then c = bz(a, "margin-right", "marginRight") else c = a.style.marginRight)
        return

      c
    )
    return
  )
  c.defaultView and c.defaultView.getComputedStyle and (bA = (a, b) ->
    c = undefined
    d = undefined
    e = undefined
    b = b.replace(bs, "-$1").toLowerCase()
    (d = a.ownerDocument.defaultView) and (e = d.getComputedStyle(a, null)) and (c = e.getPropertyValue(b)
    c is "" and not f.contains(a.ownerDocument.documentElement, a) and (c = f.style(a, b))
    )

    c
  )
  c.documentElement.currentStyle and (bB = (a, b) ->
    c = undefined
    d = undefined
    e = undefined
    f = a.currentStyle and a.currentStyle[b]
    g = a.style
    f is null and g and (e = g[b]) and (f = e)
    not bt.test(f) and bu.test(f) and (c = g.left
    d = a.runtimeStyle and a.runtimeStyle.left
    d and (a.runtimeStyle.left = a.currentStyle.left)
    g.left = (if b is "fontSize" then "1em" else f or 0)
    f = g.pixelLeft + "px"
    g.left = c
    d and (a.runtimeStyle.left = d)
    )

    (if f is "" then "auto" else f)
  )
  bz = bA or bB
  f.expr and f.expr.filters and (f.expr.filters.hidden = (a) ->
    b = a.offsetWidth
    c = a.offsetHeight
    b is 0 and c is 0 or not f.support.reliableHiddenOffsets and (a.style and a.style.display or f.css(a, "display")) is "none"

  f.expr.filters.visible = (a) ->
    not f.expr.filters.hidden(a)

  )

  bD = /%20/g
  bE = /\[\]$/
  bF = /\r?\n/g
  bG = /#.*$/
  bH = /^(.*?):[ \t]*([^\r\n]*)\r?$/g
  bI = /^(?:color|date|datetime|datetime-local|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i
  bJ = /^(?:about|app|app\-storage|.+\-extension|file|res|widget):$/
  bK = /^(?:GET|HEAD)$/
  bL = /^\/\//
  bM = /\?/
  bN = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/g
  bO = /^(?:select|textarea)/i
  bP = /\s+/
  bQ = /([?&])_=[^&]*/
  bR = /^([\w\+\.\-]+:)(?:\/\/([^\/?#:]*)(?::(\d+))?)?/
  bS = f.fn.load
  bT = {}
  bU = {}
  bV = undefined
  bW = undefined
  bX = ["*/"] + ["*"]
  try
    bV = e.href
  catch bY
    bV = c.createElement("a")
    bV.href = ""
    bV = bV.href
  bW = bR.exec(bV.toLowerCase()) or []
  f.fn.extend(
    load: (a, c, d) ->
      return bS.apply(this, arguments_)  if typeof a isnt "string" and bS
      return this  unless @length
      e = a.indexOf(" ")
      if e >= 0
        g = a.slice(e, a.length)
        a = a.slice(0, e)
      h = "GET"
      c and ((if f.isFunction(c) then (d = c
      c = b
      ) else typeof c is "object" and (c = f.param(c, f.ajaxSettings.traditional)
      h = "POST"
      )))
      i = this
      f.ajax
        url: a
        type: h
        dataType: "html"
        data: c
        complete: (a, b, c) ->
          c = a.responseText
          a.isResolved() and (a.done((a) ->
            c = a
            return
          )
          i.html((if g then f("<div>").append(c.replace(bN, "")).find(g) else c))
          )
          d and i.each(d, [
            c
            b
            a
          ])

          return

      this

    serialize: ->
      f.param @serializeArray()

    serializeArray: ->
      @map(->
        (if @elements then f.makeArray(@elements) else this)
      ).filter(->
        @name and not @disabled and (@checked or bO.test(@nodeName) or bI.test(@type))
      ).map((a, b) ->
        c = f(this).val()
        (if not c? then null else (if f.isArray(c) then f.map(c, (a, c) ->
          name: b.name
          value: a.replace(bF, "\r\n")
        ) else
          name: b.name
          value: c.replace(bF, "\r\n")
        ))
      ).get()
  )
  f.each("ajaxStart ajaxStop ajaxComplete ajaxError ajaxSuccess ajaxSend".split(" "), (a, b) ->
    f.fn[b] = (a) ->
      @on b, a

    return
  )
  f.each([
    "get"
    "post"
  ], (a, c) ->
    f[c] = (a, d, e, g) ->
      f.isFunction(d) and (g = g or e
      e = d
      d = b
      )
      f.ajax
        type: c
        url: a
        data: d
        success: e
        dataType: g


    return
  )
  f.extend(
    getScript: (a, c) ->
      f.get a, b, c, "script"

    getJSON: (a, b, c) ->
      f.get a, b, c, "json"

    ajaxSetup: (a, b) ->
      (if b then b_(a, f.ajaxSettings) else (b = a
      a = f.ajaxSettings
      ))
      b_(a, b)

      a

    ajaxSettings:
      url: bV
      isLocal: bJ.test(bW[1])
      global: not 0
      type: "GET"
      contentType: "application/x-www-form-urlencoded"
      processData: not 0
      async: not 0
      accepts:
        xml: "application/xml, text/xml"
        html: "text/html"
        text: "text/plain"
        json: "application/json, text/javascript"
        "*": bX

      contents:
        xml: /xml/
        html: /html/
        json: /json/

      responseFields:
        xml: "responseXML"
        text: "responseText"

      converters:
        "* text": a.String
        "text html": not 0
        "text json": f.parseJSON
        "text xml": f.parseXML

      flatOptions:
        context: not 0
        url: not 0

    ajaxPrefilter: bZ(bT)
    ajaxTransport: bZ(bU)
    ajax: (a, c) ->
      w = (a, c, l, m) ->
        if s isnt 2
          s = 2
          q and clearTimeout(q)
          p = b
          n = m or ""
          v.readyState = (if a > 0 then 4 else 0)

          o = undefined
          r = undefined
          u = undefined
          w = c
          x = (if l then cb(d, v, l) else b)
          y = undefined
          z = undefined
          if a >= 200 and a < 300 or a is 304
            if d.ifModified
              f.lastModified[k] = y  if y = v.getResponseHeader("Last-Modified")
              f.etag[k] = z  if z = v.getResponseHeader("Etag")
            if a is 304
              w = "notmodified"
              o = not 0
            else
              try
                r = cc(d, x)
                w = "success"
                o = not 0
              catch A
                w = "parsererror"
                u = A
          else
            u = w
            if not w or a
              w = "error"
              a < 0 and (a = 0)
          v.status = a
          v.statusText = "" + (c or w)
          (if o then h.resolveWith(e, [
            r
            w
            v
          ]) else h.rejectWith(e, [
            v
            w
            u
          ]))
          v.statusCode(j)
          j = b
          t and g.trigger("ajax" + ((if o then "Success" else "Error")), [
            v
            d
            (if o then r else u)
          ])
          i.fireWith(e, [
            v
            w
          ])
          t and (g.trigger("ajaxComplete", [
            v
            d
          ])
          --f.active or f.event.trigger("ajaxStop")
          )
        return
      typeof a is "object" and (c = a
      a = b
      )
      c = c or {}

      d = f.ajaxSetup({}, c)
      e = d.context or d
      g = (if e isnt d and (e.nodeType or e instanceof f) then f(e) else f.event)
      h = f.Deferred()
      i = f.Callbacks("once memory")
      j = d.statusCode or {}
      k = undefined
      l = {}
      m = {}
      n = undefined
      o = undefined
      p = undefined
      q = undefined
      r = undefined
      s = 0
      t = undefined
      u = undefined
      v =
        readyState: 0
        setRequestHeader: (a, b) ->
          unless s
            c = a.toLowerCase()
            a = m[c] = m[c] or a
            l[a] = b
          this

        getAllResponseHeaders: ->
          (if s is 2 then n else null)

        getResponseHeader: (a) ->
          c = undefined
          if s is 2
            unless o
              o = {}
              o[c[1].toLowerCase()] = c[2]  while c = bH.exec(n)
            c = o[a.toLowerCase()]
          (if c is b then null else c)

        overrideMimeType: (a) ->
          s or (d.mimeType = a)
          this

        abort: (a) ->
          a = a or "abort"
          p and p.abort(a)
          w(0, a)

          this

      h.promise(v)
      v.success = v.done
      v.error = v.fail
      v.complete = i.add
      v.statusCode = (a) ->
        if a
          b = undefined
          if s < 2
            for b of a
              continue
          else
            b = a[v.status]
            v.then(b, b)
        this

      d.url = ((a or d.url) + "").replace(bG, "").replace(bL, bW[1] + "//")
      d.dataTypes = f.trim(d.dataType or "*").toLowerCase().split(bP)
      not d.crossDomain? and (r = bR.exec(d.url.toLowerCase())
      d.crossDomain = not (not r or r[1] is bW[1] and r[2] is bW[2] and (r[3] or ((if r[1] is "http:" then 80 else 443))) is (bW[3] or ((if bW[1] is "http:" then 80 else 443))))
      )
      d.data and d.processData and typeof d.data isnt "string" and (d.data = f.param(d.data, d.traditional))
      b$(bT, d, c, v)

      return not 1  if s is 2
      t = d.global
      d.type = d.type.toUpperCase()
      d.hasContent = not bK.test(d.type)
      t and f.active++ is 0 and f.event.trigger("ajaxStart")

      unless d.hasContent
        d.data and (d.url += ((if bM.test(d.url) then "&" else "?")) + d.data
        delete d.data

        )
        k = d.url

        if d.cache is not 1
          x = f.now()
          y = d.url.replace(bQ, "$1_=" + x)
          d.url = y + ((if y is d.url then ((if bM.test(d.url) then "&" else "?")) + "_=" + x else ""))
      (d.data and d.hasContent and d.contentType isnt not 1 or c.contentType) and v.setRequestHeader("Content-Type", d.contentType)
      d.ifModified and (k = k or d.url
      f.lastModified[k] and v.setRequestHeader("If-Modified-Since", f.lastModified[k])
      f.etag[k] and v.setRequestHeader("If-None-Match", f.etag[k])
      )
      v.setRequestHeader("Accept", (if d.dataTypes[0] and d.accepts[d.dataTypes[0]] then d.accepts[d.dataTypes[0]] + ((if d.dataTypes[0] isnt "*" then ", " + bX + "; q=0.01" else "")) else d.accepts["*"]))

      for u of d.headers
        continue
      if d.beforeSend and (d.beforeSend.call(e, v, d) is not 1 or s is 2)
        v.abort()
        return not 1
      for u of
        success: 1
        error: 1
        complete: 1
        continue
      p = b$(bU, d, c, v)
      unless p
        w -1, "No Transport"
      else
        v.readyState = 1
        t and g.trigger("ajaxSend", [
          v
          d
        ])
        d.async and d.timeout > 0 and (q = setTimeout(->
          v.abort "timeout"
          return
        , d.timeout))

        try
          s = 1
          p.send(l, w)
        catch z
          if s < 2
            w -1, z
          else
            throw z
      v

    param: (a, c) ->
      d = []
      e = (a, b) ->
        b = (if f.isFunction(b) then b() else b)
        d[d.length] = encodeURIComponent(a) + "=" + encodeURIComponent(b)

        return

      c is b and (c = f.ajaxSettings.traditional)
      if f.isArray(a) or a.jquery and not f.isPlainObject(a)
        f.each a, ->
          e @name, @value
          return

      else
        for g of a
          continue
      d.join("&").replace bD, "+"
  )
  f.extend(
    active: 0
    lastModified: {}
    etag: {}
  )

  cd = f.now()
  ce = /(\=)\?(&|$)|\?\?/i
  f.ajaxSetup(
    jsonp: "callback"
    jsonpCallback: ->
      f.expando + "_" + cd++
  )
  f.ajaxPrefilter("json jsonp", (b, c, d) ->
    e = b.contentType is "application/x-www-form-urlencoded" and typeof b.data is "string"
    if b.dataTypes[0] is "jsonp" or b.jsonp isnt not 1 and (ce.test(b.url) or e and ce.test(b.data))
      g = undefined
      h = b.jsonpCallback = (if f.isFunction(b.jsonpCallback) then b.jsonpCallback() else b.jsonpCallback)
      i = a[h]
      j = b.url
      k = b.data
      l = "$1" + h + "$2"
      b.jsonp isnt not 1 and (j = j.replace(ce, l)
      b.url is j and (e and (k = k.replace(ce, l))
      b.data is k and (j += ((if /\?/.test(j) then "&" else "?")) + b.jsonp + "=" + h)
      )
      )
      b.url = j
      b.data = k
      a[h] = (a) ->
        g = [a]
        return

      d.always(->
        a[h] = i
        g and f.isFunction(i) and a[h](g[0])

        return
      )
      b.converters["script json"] = ->
        g or f.error(h + " was not called")
        g[0]

      b.dataTypes[0] = "json"

      "script"
  )
  f.ajaxSetup(
    accepts:
      script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"

    contents:
      script: /javascript|ecmascript/

    converters:
      "text script": (a) ->
        f.globalEval a
        a
  )
  f.ajaxPrefilter("script", (a) ->
    a.cache is b and (a.cache = not 1)
    a.crossDomain and (a.type = "GET"
    a.global = not 1
    )

    return
  )
  f.ajaxTransport("script", (a) ->
    if a.crossDomain
      d = undefined
      e = c.head or c.getElementsByTagName("head")[0] or c.documentElement
      send: (f, g) ->
        d = c.createElement("script")
        d.async = "async"
        a.scriptCharset and (d.charset = a.scriptCharset)
        d.src = a.url
        d.onload = d.onreadystatechange = (a, c) ->
          if c or not d.readyState or /loaded|complete/.test(d.readyState)
            d.onload = d.onreadystatechange = null
            e and d.parentNode and e.removeChild(d)
            d = b
            c or g(200, "success")
          return

        e.insertBefore(d, e.firstChild)

        return

      abort: ->
        d and d.onload(0, 1)
        return
  )

  cf = (if a.ActiveXObject then ->
    for a of ch
      continue
    return
   else not 1)
  cg = 0
  ch = undefined
  f.ajaxSettings.xhr = (if a.ActiveXObject then ->
    not @isLocal and ci() or cj()
   else ci)
  (a) ->
    f.extend f.support,
      ajax: !!a
      cors: !!a and "withCredentials" of a

    return
  (f.ajaxSettings.xhr())
  f.support.ajax and f.ajaxTransport((c) ->
    if not c.crossDomain or f.support.cors
      d = undefined
      send: (e, g) ->
        h = c.xhr()
        i = undefined
        j = undefined
        (if c.username then h.open(c.type, c.url, c.async, c.username, c.password) else h.open(c.type, c.url, c.async))
        if c.xhrFields
          for j of c.xhrFields
            continue
        c.mimeType and h.overrideMimeType and h.overrideMimeType(c.mimeType)
        not c.crossDomain and not e["X-Requested-With"] and (e["X-Requested-With"] = "XMLHttpRequest")

        try
          for j of e
            continue
        h.send(c.hasContent and c.data or null)
        d = (a, e) ->
          j = undefined
          k = undefined
          l = undefined
          m = undefined
          n = undefined
          try
            if d and (e or h.readyState is 4)
              d = b
              i and (h.onreadystatechange = f.noop
              cf and delete ch[i]

              )

              if e
                h.readyState isnt 4 and h.abort()
              else
                j = h.status
                l = h.getAllResponseHeaders()
                m = {}
                n = h.responseXML
                n and n.documentElement and (m.xml = n)
                m.text = h.responseText

                try
                  k = h.statusText
                catch o
                  k = ""
                (if not j and c.isLocal and not c.crossDomain then j = (if m.text then 200 else 404) else j is 1223 and (j = 204))
          catch p
            e or g(-1, p)
          m and g(j, k, m, l)
          return

        (if not c.async or h.readyState is 4 then d() else (i = ++cg
        cf and (ch or (ch = {}
        f(a).unload(cf)
        )
        ch[i] = d
        )
        h.onreadystatechange = d
        ))

        return

      abort: ->
        d and d(0, 1)
        return
  )

  ck = {}
  cl = undefined
  cm = undefined
  cn = /^(?:toggle|show|hide)$/
  co = /^([+\-]=)?([\d+.\-]+)([a-z%]*)$/i
  cp = undefined
  cq = [
    [
      "height"
      "marginTop"
      "marginBottom"
      "paddingTop"
      "paddingBottom"
    ]
    [
      "width"
      "marginLeft"
      "marginRight"
      "paddingLeft"
      "paddingRight"
    ]
    ["opacity"]
  ]
  cr = undefined
  f.fn.extend(
    show: (a, b, c) ->
      d = undefined
      e = undefined
      return @animate(cu("show", 3), a, b, c)  if a or a is 0
      g = 0
      h = @length

      while g < h
        d = this[g]
        d.style and (e = d.style.display
        not f._data(d, "olddisplay") and e is "none" and (e = d.style.display = "")
        e is "" and f.css(d, "display") is "none" and f._data(d, "olddisplay", cv(d.nodeName))
        )
        g++
      g = 0
      while g < h
        d = this[g]
        if d.style
          e = d.style.display
          d.style.display = f._data(d, "olddisplay") or ""  if e is "" or e is "none"
        g++
      this

    hide: (a, b, c) ->
      return @animate(cu("hide", 3), a, b, c)  if a or a is 0
      d = undefined
      e = undefined
      g = 0
      h = @length
      while g < h
        d = this[g]
        d.style and (e = f.css(d, "display")
        e isnt "none" and not f._data(d, "olddisplay") and f._data(d, "olddisplay", e)
        )
        g++
      g = 0
      while g < h
        this[g].style and (this[g].style.display = "none")
        g++
      this

    _toggle: f.fn.toggle
    toggle: (a, b, c) ->
      d = typeof a is "boolean"
      (if f.isFunction(a) and f.isFunction(b) then @_toggle.apply(this, arguments_) else (if not a? or d then @each(->
        b = (if d then a else f(this).is(":hidden"))
        f(this)[(if b then "show" else "hide")]()
        return
      ) else @animate(cu("toggle", 3), a, b, c)))
      this

    fadeTo: (a, b, c, d) ->
      @filter(":hidden").css("opacity", 0).show().end().animate
        opacity: b
      , a, c, d

    animate: (a, b, c, d) ->
      g = ->
        e.queue is not 1 and f._mark(this)
        b = f.extend({}, e)
        c = @nodeType is 1
        d = c and f(this).is(":hidden")
        g = undefined
        h = undefined
        i = undefined
        j = undefined
        k = undefined
        l = undefined
        m = undefined
        n = undefined
        o = undefined
        b.animatedProperties = {}
        for i of a
          g = f.camelCase(i)
          i isnt g and (a[g] = a[i]
          delete a[i]

          )
          h = a[g]
          (if f.isArray(h) then (b.animatedProperties[g] = h[1]
          h = a[g] = h[0]
          ) else b.animatedProperties[g] = b.specialEasing and b.specialEasing[g] or b.easing or "swing")

          return b.complete.call(this)  if h is "hide" and d or h is "show" and not d
          c and (g is "height" or g is "width") and (b.overflow = [
            @style.overflow
            @style.overflowX
            @style.overflowY
          ]
          f.css(this, "display") is "inline" and f.css(this, "float") is "none" and ((if not f.support.inlineBlockNeedsLayout or cv(@nodeName) is "inline" then @style.display = "inline-block" else @style.zoom = 1))
          )
        b.overflow? and (@style.overflow = "hidden")
        for i of a
          continue
        not 0
      e = f.speed(b, c, d)
      return @each(e.complete, [not 1])  if f.isEmptyObject(a)
      a = f.extend({}, a)
      (if e.queue is not 1 then @each(g) else @queue(e.queue, g))

    stop: (a, c, d) ->
      typeof a isnt "string" and (d = c
      c = a
      a = b
      )
      c and a isnt not 1 and @queue(a or "fx", [])

      @each ->
        h = (a, b, c) ->
          e = b[c]
          f.removeData(a, c, not 0)
          e.stop(d)

          return
        b = undefined
        c = not 1
        e = f.timers
        g = f._data(this)
        d or f._unmark(not 0, this)
        unless a?
          for b of g
            continue
        else
          g[b = a + ".run"] and g[b].stop and h(this, g, b)
        b = e.length
        while b--
          e[b].elem is this and (not a? or e[b].queue is a) and ((if d then e[b](not 0) else e[b].saveState())
          c = not 0
          e.splice(b, 1)
          )
        (not d or not c) and f.dequeue(this, a)
        return

  )
  f.each(
    slideDown: cu("show", 1)
    slideUp: cu("hide", 1)
    slideToggle: cu("toggle", 1)
    fadeIn:
      opacity: "show"

    fadeOut:
      opacity: "hide"

    fadeToggle:
      opacity: "toggle"
  , (a, b) ->
    f.fn[a] = (a, c, d) ->
      @animate b, a, c, d

    return
  )
  f.extend(
    speed: (a, b, c) ->
      d = (if a and typeof a is "object" then f.extend({}, a) else
        complete: c or not c and b or f.isFunction(a) and a
        duration: a
        easing: c and b or b and not f.isFunction(b) and b
      )
      d.duration = (if f.fx.off then 0 else (if typeof d.duration is "number" then d.duration else (if d.duration of f.fx.speeds then f.fx.speeds[d.duration] else f.fx.speeds._default)))
      d.queue = "fx"  if not d.queue? or d.queue is not 0
      d.old = d.complete
      d.complete = (a) ->
        f.isFunction(d.old) and d.old.call(this)
        (if d.queue then f.dequeue(this, d.queue) else a isnt not 1 and f._unmark(this))

        return


      d

    easing:
      linear: (a, b, c, d) ->
        c + d * a

      swing: (a, b, c, d) ->
        (-Math.cos(a * Math.PI) / 2 + .5) * d + c

    timers: []
    fx: (a, b, c) ->
      @options = b
      @elem = a
      @prop = c
      b.orig = b.orig or {}

      return
  )
  f.fx:: =
    update: ->
      @options.step and @options.step.call(@elem, @now, this)
      (f.fx.step[@prop] or f.fx.step._default)(this)

      return

    cur: ->
      return @elem[@prop]  if @elem[@prop]? and (not @elem.style or not @elem.style[@prop]?)
      a = undefined
      b = f.css(@elem, @prop)
      (if isNaN(a = parseFloat(b)) then (if not b or b is "auto" then 0 else b) else a)

    custom: (a, c, d) ->
      h = (a) ->
        e.step a
      e = this
      g = f.fx
      @startTime = cr or cs()
      @end = c
      @now = @start = a
      @pos = @state = 0
      @unit = d or @unit or ((if f.cssNumber[@prop] then "" else "px"))
      h.queue = @options.queue
      h.elem = @elem
      h.saveState = ->
        e.options.hide and f._data(e.elem, "fxshow" + e.prop) is b and f._data(e.elem, "fxshow" + e.prop, e.start)
        return

      h() and f.timers.push(h) and not cp and (cp = setInterval(g.tick, g.interval))

      return

    show: ->
      a = f._data(@elem, "fxshow" + @prop)
      @options.orig[@prop] = a or f.style(@elem, @prop)
      @options.show = not 0
      (if a isnt b then @custom(@cur(), a) else @custom((if @prop is "width" or @prop is "height" then 1 else 0), @cur()))
      f(@elem).show()

      return

    hide: ->
      @options.orig[@prop] = f._data(@elem, "fxshow" + @prop) or f.style(@elem, @prop)
      @options.hide = not 0
      @custom(@cur(), 0)

      return

    step: (a) ->
      b = undefined
      c = undefined
      d = undefined
      e = cr or cs()
      g = not 0
      h = @elem
      i = @options
      if a or e >= i.duration + @startTime
        @now = @end
        @pos = @state = 1
        @update()
        i.animatedProperties[@prop] = not 0

        for b of i.animatedProperties
          continue
        if g
          i.overflow? and not f.support.shrinkWrapBlocks and f.each([
            ""
            "X"
            "Y"
          ], (a, b) ->
            h.style["overflow" + b] = i.overflow[a]
            return
          )
          i.hide and f(h).hide()

          if i.hide or i.show
            for b of i.animatedProperties
              continue
          d = i.complete
          d and (i.complete = not 1
          d.call(h)
          )
        return not 1
      (if i.duration is Infinity then @now = e else (c = e - @startTime
      @state = c / i.duration
      @pos = f.easing[i.animatedProperties[@prop]](@state, c, 0, 1, i.duration)
      @now = @start + (@end - @start) * @pos
      ))
      @update()

      not 0

  f.extend(f.fx,
    tick: ->
      a = undefined
      b = f.timers
      c = 0
      while c < b.length
        a = b[c]
        not a() and b[c] is a and b.splice(c--, 1)
        c++
      b.length or f.fx.stop()
      return

    interval: 13
    stop: ->
      clearInterval(cp)
      cp = null

      return

    speeds:
      slow: 600
      fast: 200
      _default: 400

    step:
      opacity: (a) ->
        f.style a.elem, "opacity", a.now
        return

      _default: (a) ->
        (if a.elem.style and a.elem.style[a.prop]? then a.elem.style[a.prop] = a.now + a.unit else a.elem[a.prop] = a.now)
        return
  )
  f.each([
    "width"
    "height"
  ], (a, b) ->
    f.fx.step[b] = (a) ->
      f.style a.elem, b, Math.max(0, a.now) + a.unit
      return

    return
  )
  f.expr and f.expr.filters and (f.expr.filters.animated = (a) ->
    f.grep(f.timers, (b) ->
      a is b.elem
    ).length
  )

  cw = /^t(?:able|d|h)$/i
  cx = /^(?:body|html)$/i
  (if "getBoundingClientRect" of c.documentElement then f.fn.offset = (a) ->
    b = this[0]
    c = undefined
    if a
      return @each((b) ->
        f.offset.setOffset this, a, b
        return
      )
    return null  if not b or not b.ownerDocument
    return f.offset.bodyOffset(b)  if b is b.ownerDocument.body
    try
      c = b.getBoundingClientRect()
    e = b.ownerDocument
    g = e.documentElement
    if not c or not f.contains(g, b)
      return (if c then
        top: c.top
        left: c.left
       else
        top: 0
        left: 0
      )
    h = e.body
    i = cy(e)
    j = g.clientTop or h.clientTop or 0
    k = g.clientLeft or h.clientLeft or 0
    l = i.pageYOffset or f.support.boxModel and g.scrollTop or h.scrollTop
    m = i.pageXOffset or f.support.boxModel and g.scrollLeft or h.scrollLeft
    n = c.top + l - j
    o = c.left + m - k
    top: n
    left: o
   else f.fn.offset = (a) ->
    b = this[0]
    if a
      return @each((b) ->
        f.offset.setOffset this, a, b
        return
      )
    return null  if not b or not b.ownerDocument
    return f.offset.bodyOffset(b)  if b is b.ownerDocument.body
    c = undefined
    d = b.offsetParent
    e = b
    g = b.ownerDocument
    h = g.documentElement
    i = g.body
    j = g.defaultView
    k = (if j then j.getComputedStyle(b, null) else b.currentStyle)
    l = b.offsetTop
    m = b.offsetLeft
    while (b = b.parentNode) and b isnt i and b isnt h
      break  if f.support.fixedPosition and k.position is "fixed"
      c = (if j then j.getComputedStyle(b, null) else b.currentStyle)
      l -= b.scrollTop
      m -= b.scrollLeft
      b is d and (l += b.offsetTop
      m += b.offsetLeft
      f.support.doesNotAddBorder and (not f.support.doesAddBorderForTableAndCells or not cw.test(b.nodeName)) and (l += parseFloat(c.borderTopWidth) or 0
      m += parseFloat(c.borderLeftWidth) or 0
      )
      e = d
      d = b.offsetParent
      )
      f.support.subtractsBorderForOverflowNotVisible and c.overflow isnt "visible" and (l += parseFloat(c.borderTopWidth) or 0
      m += parseFloat(c.borderLeftWidth) or 0
      )
      k = c
    if k.position is "relative" or k.position is "static"
      l += i.offsetTop
      m += i.offsetLeft
    f.support.fixedPosition and k.position is "fixed" and (l += Math.max(h.scrollTop, i.scrollTop)
    m += Math.max(h.scrollLeft, i.scrollLeft)
    )
    top: l
    left: m
  )
  f.offset =
    bodyOffset: (a) ->
      b = a.offsetTop
      c = a.offsetLeft
      f.support.doesNotIncludeMarginInBodyOffset and (b += parseFloat(f.css(a, "marginTop")) or 0
      c += parseFloat(f.css(a, "marginLeft")) or 0
      )
      top: b
      left: c

    setOffset: (a, b, c) ->
      d = f.css(a, "position")
      d is "static" and (a.style.position = "relative")
      e = f(a)
      g = e.offset()
      h = f.css(a, "top")
      i = f.css(a, "left")
      j = (d is "absolute" or d is "fixed") and f.inArray("auto", [
        h
        i
      ]) > -1
      k = {}
      l = {}
      m = undefined
      n = undefined
      (if j then (l = e.position()
      m = l.top
      n = l.left
      ) else (m = parseFloat(h) or 0
      n = parseFloat(i) or 0
      ))
      f.isFunction(b) and (b = b.call(a, c, g))
      b.top? and (k.top = b.top - g.top + m)
      b.left? and (k.left = b.left - g.left + n)
      (if "using" of b then b.using.call(a, k) else e.css(k))

      return

  f.fn.extend(
    position: ->
      return null  unless this[0]
      a = this[0]
      b = @offsetParent()
      c = @offset()
      d = (if cx.test(b[0].nodeName) then
        top: 0
        left: 0
       else b.offset())
      c.top -= parseFloat(f.css(a, "marginTop")) or 0
      c.left -= parseFloat(f.css(a, "marginLeft")) or 0
      d.top += parseFloat(f.css(b[0], "borderTopWidth")) or 0
      d.left += parseFloat(f.css(b[0], "borderLeftWidth")) or 0

      top: c.top - d.top
      left: c.left - d.left

    offsetParent: ->
      @map ->
        a = @offsetParent or c.body
        a = a.offsetParent  while a and not cx.test(a.nodeName) and f.css(a, "position") is "static"
        a

  )
  f.each([
    "Left"
    "Top"
  ], (a, c) ->
    d = "scroll" + c
    f.fn[d] = (c) ->
      e = undefined
      g = undefined
      if c is b
        e = this[0]
        return null  unless e
        g = cy(e)
        return (if g then (if "pageXOffset" of g then g[(if a then "pageYOffset" else "pageXOffset")] else f.support.boxModel and g.document.documentElement[d] or g.document.body[d]) else e[d])
      @each ->
        g = cy(this)
        (if g then g.scrollTo((if a then f(g).scrollLeft() else c), (if a then c else f(g).scrollTop())) else this[d] = c)

        return


    return
  )
  f.each([
    "Height"
    "Width"
  ], (a, c) ->
    d = c.toLowerCase()
    f.fn["inner" + c] = ->
      a = this[0]
      (if a then (if a.style then parseFloat(f.css(a, d, "padding")) else this[d]()) else null)

    f.fn["outer" + c] = (a) ->
      b = this[0]
      (if b then (if b.style then parseFloat(f.css(b, d, (if a then "margin" else "border"))) else this[d]()) else null)

    f.fn[d] = (a) ->
      e = this[0]
      return (if not a? then null else this)  unless e
      if f.isFunction(a)
        return @each((b) ->
          c = f(this)
          c[d] a.call(this, b, c[d]())
          return
        )
      if f.isWindow(e)
        g = e.document.documentElement["client" + c]
        h = e.document.body
        return e.document.compatMode is "CSS1Compat" and g or h and h["client" + c] or g
      return Math.max(e.documentElement["client" + c], e.body["scroll" + c], e.documentElement["scroll" + c], e.body["offset" + c], e.documentElement["offset" + c])  if e.nodeType is 9
      if a is b
        i = f.css(e, d)
        j = parseFloat(i)
        return (if f.isNumeric(j) then j else i)
      @css d, (if typeof a is "string" then a else a + "px")


    return
  )
  a.jQuery = a.$ = f
  typeof define is "function" and define.amd and define.amd.jQuery and define("jquery", [], ->
    f
  )

  return
) window
