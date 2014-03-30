#!
#* Bootstrap.js by @fat & @mdo
#* Copyright 2012 Twitter, Inc.
#* http://www.apache.org/licenses/LICENSE-2.0.txt
#
not (e) ->
  "use strict"
  e ->
    e.support.transition = ->
      e = ->
        e = document.createElement("bootstrap")
        t =
          WebkitTransition: "webkitTransitionEnd"
          MozTransition: "transitionend"
          OTransition: "oTransitionEnd otransitionend"
          transition: "transitionend"

        n = undefined
        for n of t
          continue
        return
      ()
      e and end: e
    ()
    return

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = "[data-dismiss=\"alert\"]"
  n = (n) ->
    e(n).on "click", t, @close
    return

  n::close = (t) ->
    s = ->
      i.trigger("closed").remove()
      return
    n = e(this)
    r = n.attr("data-target")
    i = undefined
    r or (r = n.attr("href")
    r = r and r.replace(/.*(?=#[^\s]*$)/, "")
    )
    i = e(r)
    t and t.preventDefault()
    i.length or (i = (if n.hasClass("alert") then n else n.parent()))
    i.trigger(t = e.Event("close"))

    return  if t.isDefaultPrevented()
    i.removeClass("in")
    (if e.support.transition and i.hasClass("fade") then i.on(e.support.transition.end, s) else s())

    return

  r = e.fn.alert
  e.fn.alert = (t) ->
    @each ->
      r = e(this)
      i = r.data("alert")
      i or r.data("alert", i = new n(this))
      typeof t is "string" and i[t].call(r)

      return


  e.fn.alert.Constructor = n
  e.fn.alert.noConflict = ->
    e.fn.alert = r
    this

  e(document).on("click.alert.data-api", t, n::close)

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (t, n) ->
    @$element = e(t)
    @options = e.extend({}, e.fn.button.defaults, n)

    return

  t::setState = (e) ->
    t = "disabled"
    n = @$element
    r = n.data()
    i = (if n.is("input") then "val" else "html")
    e += "Text"
    r.resetText or n.data("resetText", n[i]())
    n[i](r[e] or @options[e])
    setTimeout(->
      (if e is "loadingText" then n.addClass(t).attr(t, t) else n.removeClass(t).removeAttr(t))
      return
    , 0)

    return

  t::toggle = ->
    e = @$element.closest("[data-toggle=\"buttons-radio\"]")
    e and e.find(".active").removeClass("active")
    @$element.toggleClass("active")

    return


  n = e.fn.button
  e.fn.button = (n) ->
    @each ->
      r = e(this)
      i = r.data("button")
      s = typeof n is "object" and n
      i or r.data("button", i = new t(this, s))
      (if n is "toggle" then i.toggle() else n and i.setState(n))

      return


  e.fn.button.defaults = loadingText: "loading..."
  e.fn.button.Constructor = t
  e.fn.button.noConflict = ->
    e.fn.button = n
    this

  e(document).on("click.button.data-api", "[data-toggle^=button]", (t) ->
    n = e(t.target)
    n.hasClass("btn") or (n = n.closest(".btn"))
    n.button("toggle")

    return
  )

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (t, n) ->
    @$element = e(t)
    @$indicators = @$element.find(".carousel-indicators")
    @options = n
    @options.pause is "hover" and @$element.on("mouseenter", e.proxy(@pause, this)).on("mouseleave", e.proxy(@cycle, this))

    return

  t:: =
    cycle: (t) ->
      t or (@paused = not 1)
      @interval and clearInterval(@interval)
      @options.interval and not @paused and (@interval = setInterval(e.proxy(@next, this), @options.interval))
      this

    getActiveIndex: ->
      @$active = @$element.find(".item.active")
      @$items = @$active.parent().children()
      @$items.index(@$active)

    to: (t) ->
      n = @getActiveIndex()
      r = this
      return  if t > @$items.length - 1 or t < 0
      (if @sliding then @$element.one("slid", ->
        r.to t
        return
      ) else (if n is t then @pause().cycle() else @slide((if t > n then "next" else "prev"), e(@$items[t]))))

    pause: (t) ->
      t or (@paused = not 0)
      @$element.find(".next, .prev").length and e.support.transition.end and (@$element.trigger(e.support.transition.end)
      @cycle(not 0)
      )
      clearInterval(@interval)
      @interval = null
      this

    next: ->
      return  if @sliding
      @slide "next"

    prev: ->
      return  if @sliding
      @slide "prev"

    slide: (t, n) ->
      r = @$element.find(".item.active")
      i = n or r[t]()
      s = @interval
      o = (if t is "next" then "left" else "right")
      u = (if t is "next" then "first" else "last")
      a = this
      f = undefined
      @sliding = not 0
      s and @pause()
      i = (if i.length then i else @$element.find(".item")[u]())
      f = e.Event("slide",
        relatedTarget: i[0]
        direction: o
      )

      return  if i.hasClass("active")
      @$indicators.length and (@$indicators.find(".active").removeClass("active")
      @$element.one("slid", ->
        t = e(a.$indicators.children()[a.getActiveIndex()])
        t and t.addClass("active")
        return
      )
      )
      if e.support.transition and @$element.hasClass("slide")
        @$element.trigger f
        return  if f.isDefaultPrevented()
        i.addClass(t)
        i[0].offsetWidth
        r.addClass(o)
        i.addClass(o)
        @$element.one(e.support.transition.end, ->
          i.removeClass([
            t
            o
          ].join(" ")).addClass("active")
          r.removeClass([
            "active"
            o
          ].join(" "))
          a.sliding = not 1
          setTimeout(->
            a.$element.trigger "slid"
            return
          , 0)

          return
        )
      else
        @$element.trigger f
        return  if f.isDefaultPrevented()
        r.removeClass("active")
        i.addClass("active")
        @sliding = not 1
        @$element.trigger("slid")
      s and @cycle()
      this

  n = e.fn.carousel
  e.fn.carousel = (n) ->
    @each ->
      r = e(this)
      i = r.data("carousel")
      s = e.extend({}, e.fn.carousel.defaults, typeof n is "object" and n)
      o = (if typeof n is "string" then n else s.slide)
      i or r.data("carousel", i = new t(this, s))
      (if typeof n is "number" then i.to(n) else (if o then i[o]() else s.interval and i.pause().cycle()))

      return


  e.fn.carousel.defaults =
    interval: 5e3
    pause: "hover"

  e.fn.carousel.Constructor = t
  e.fn.carousel.noConflict = ->
    e.fn.carousel = n
    this

  e(document).on("click.carousel.data-api", "[data-slide], [data-slide-to]", (t) ->
    n = e(this)
    r = undefined
    i = e(n.attr("data-target") or (r = n.attr("href")) and r.replace(/.*(?=#[^\s]+$)/, ""))
    s = e.extend({}, i.data(), n.data())
    o = undefined
    i.carousel(s)
    (o = n.attr("data-slide-to")) and i.data("carousel").pause().to(o).cycle()
    t.preventDefault()

    return
  )

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (t, n) ->
    @$element = e(t)
    @options = e.extend({}, e.fn.collapse.defaults, n)
    @options.parent and (@$parent = e(@options.parent))
    @options.toggle and @toggle()

    return

  t:: =
    constructor: t
    dimension: ->
      e = @$element.hasClass("width")
      (if e then "width" else "height")

    show: ->
      t = undefined
      n = undefined
      r = undefined
      i = undefined
      return  if @transitioning or @$element.hasClass("in")
      t = @dimension()
      n = e.camelCase([
        "scroll"
        t
      ].join("-"))
      r = @$parent and @$parent.find("> .accordion-group > .in")

      if r and r.length
        i = r.data("collapse")
        return  if i and i.transitioning
        r.collapse("hide")
        i or r.data("collapse", null)
      @$element[t](0)
      @transition("addClass", e.Event("show"), "shown")
      e.support.transition and @$element[t](@$element[0][n])

      return

    hide: ->
      t = undefined
      return  if @transitioning or not @$element.hasClass("in")
      t = @dimension()
      @reset(@$element[t]())
      @transition("removeClass", e.Event("hide"), "hidden")
      @$element[t](0)

      return

    reset: (e) ->
      t = @dimension()
      @$element.removeClass("collapse")[t](e or "auto")[0].offsetWidth
      @$element[(if e isnt null then "addClass" else "removeClass")]("collapse")
      this

    transition: (t, n, r) ->
      i = this
      s = ->
        n.type is "show" and i.reset()
        i.transitioning = 0
        i.$element.trigger(r)

        return

      @$element.trigger n
      return  if n.isDefaultPrevented()
      @transitioning = 1
      @$element[t]("in")
      (if e.support.transition and @$element.hasClass("collapse") then @$element.one(e.support.transition.end, s) else s())

      return

    toggle: ->
      this[(if @$element.hasClass("in") then "hide" else "show")]()
      return

  n = e.fn.collapse
  e.fn.collapse = (n) ->
    @each ->
      r = e(this)
      i = r.data("collapse")
      s = e.extend({}, e.fn.collapse.defaults, r.data(), typeof n is "object" and n)
      i or r.data("collapse", i = new t(this, s))
      typeof n is "string" and i[n]()

      return


  e.fn.collapse.defaults = toggle: not 0
  e.fn.collapse.Constructor = t
  e.fn.collapse.noConflict = ->
    e.fn.collapse = n
    this

  e(document).on("click.collapse.data-api", "[data-toggle=collapse]", (t) ->
    n = e(this)
    r = undefined
    i = n.attr("data-target") or t.preventDefault() or (r = n.attr("href")) and r.replace(/.*(?=#[^\s]+$)/, "")
    s = (if e(i).data("collapse") then "toggle" else n.data())
    n[(if e(i).hasClass("in") then "addClass" else "removeClass")]("collapsed")
    e(i).collapse(s)

    return
  )

  return
(window.jQuery)
not (e) ->
  r = ->
    e(t).each ->
      i(e(this)).removeClass "open"
      return

    return
  i = (t) ->
    n = t.attr("data-target")
    r = undefined
    n or (n = t.attr("href")
    n = n and /#/.test(n) and n.replace(/.*(?=#[^\s]*$)/, "")
    )
    r = n and e(n)

    r = t.parent()  if not r or not r.length
    r
  "use strict"
  t = "[data-toggle=dropdown]"
  n = (t) ->
    n = e(t).on("click.dropdown.data-api", @toggle)
    e("html").on "click.dropdown.data-api", ->
      n.parent().removeClass "open"
      return

    return

  n:: =
    constructor: n
    toggle: (t) ->
      n = e(this)
      s = undefined
      o = undefined
      return  if n.is(".disabled, :disabled")
      s = i(n)
      o = s.hasClass("open")
      r()
      o or s.toggleClass("open")
      n.focus()
      not 1

    keydown: (n) ->
      r = undefined
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      f = undefined
      return  unless /(38|40|27)/.test(n.keyCode)
      r = e(this)
      n.preventDefault()
      n.stopPropagation()

      return  if r.is(".disabled, :disabled")
      u = i(r)
      a = u.hasClass("open")

      if not a or a and n.keyCode is 27
        return n.which is 27 and u.find(t).focus()
        r.click()
      s = e("[role=menu] li:not(.divider):visible a", u)
      return  unless s.length
      f = s.index(s.filter(":focus"))
      n.keyCode is 38 and f > 0 and f--
      n.keyCode is 40 and f < s.length - 1 and f++
      ~f or (f = 0)
      s.eq(f).focus()

      return

  s = e.fn.dropdown
  e.fn.dropdown = (t) ->
    @each ->
      r = e(this)
      i = r.data("dropdown")
      i or r.data("dropdown", i = new n(this))
      typeof t is "string" and i[t].call(r)

      return


  e.fn.dropdown.Constructor = n
  e.fn.dropdown.noConflict = ->
    e.fn.dropdown = s
    this

  e(document).on("click.dropdown.data-api", r).on("click.dropdown.data-api", ".dropdown form", (e) ->
    e.stopPropagation()
    return
  ).on("click.dropdown-menu", (e) ->
    e.stopPropagation()
    return
  ).on("click.dropdown.data-api", t, n::toggle).on("keydown.dropdown.data-api", t + ", [role=menu]", n::keydown)

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (t, n) ->
    @options = n
    @$element = e(t).delegate("[data-dismiss=\"modal\"]", "click.dismiss.modal", e.proxy(@hide, this))
    @options.remote and @$element.find(".modal-body").load(@options.remote)

    return

  t:: =
    constructor: t
    toggle: ->
      this[(if @isShown then "hide" else "show")]()

    show: ->
      t = this
      n = e.Event("show")
      @$element.trigger n
      return  if @isShown or n.isDefaultPrevented()
      @isShown = not 0
      @escape()
      @backdrop(->
        n = e.support.transition and t.$element.hasClass("fade")
        t.$element.parent().length or t.$element.appendTo(document.body)
        t.$element.show()
        n and t.$element[0].offsetWidth
        t.$element.addClass("in").attr("aria-hidden", not 1)
        t.enforceFocus()
        (if n then t.$element.one(e.support.transition.end, ->
          t.$element.focus().trigger "shown"
          return
        ) else t.$element.focus().trigger("shown"))

        return
      )

      return

    hide: (t) ->
      t and t.preventDefault()
      n = this
      t = e.Event("hide")
      @$element.trigger(t)

      return  if not @isShown or t.isDefaultPrevented()
      @isShown = not 1
      @escape()
      e(document).off("focusin.modal")
      @$element.removeClass("in").attr("aria-hidden", not 0)
      (if e.support.transition and @$element.hasClass("fade") then @hideWithTransition() else @hideModal())

      return

    enforceFocus: ->
      t = this
      e(document).on "focusin.modal", (e) ->
        t.$element[0] isnt e.target and not t.$element.has(e.target).length and t.$element.focus()
        return

      return

    escape: ->
      e = this
      (if @isShown and @options.keyboard then @$element.on("keyup.dismiss.modal", (t) ->
        t.which is 27 and e.hide()
        return
      ) else @isShown or @$element.off("keyup.dismiss.modal"))
      return

    hideWithTransition: ->
      t = this
      n = setTimeout(->
        t.$element.off(e.support.transition.end)
        t.hideModal()

        return
      , 500)
      @$element.one e.support.transition.end, ->
        clearTimeout(n)
        t.hideModal()

        return

      return

    hideModal: ->
      e = this
      @$element.hide()
      @backdrop(->
        e.removeBackdrop()
        e.$element.trigger("hidden")

        return
      )

      return

    removeBackdrop: ->
      @$backdrop and @$backdrop.remove()
      @$backdrop = null

      return

    backdrop: (t) ->
      n = this
      r = (if @$element.hasClass("fade") then "fade" else "")
      if @isShown and @options.backdrop
        i = e.support.transition and r
        @$backdrop = e("<div class=\"modal-backdrop " + r + "\" />").appendTo(document.body)
        @$backdrop.click((if @options.backdrop is "static" then e.proxy(@$element[0].focus, @$element[0]) else e.proxy(@hide, this)))
        i and @$backdrop[0].offsetWidth
        @$backdrop.addClass("in")

        return  unless t
        (if i then @$backdrop.one(e.support.transition.end, t) else t())
      else
        (if not @isShown and @$backdrop then (@$backdrop.removeClass("in")
        (if e.support.transition and @$element.hasClass("fade") then @$backdrop.one(e.support.transition.end, t) else t())
        ) else t and t())
      return

  n = e.fn.modal
  e.fn.modal = (n) ->
    @each ->
      r = e(this)
      i = r.data("modal")
      s = e.extend({}, e.fn.modal.defaults, r.data(), typeof n is "object" and n)
      i or r.data("modal", i = new t(this, s))
      (if typeof n is "string" then i[n]() else s.show and i.show())

      return


  e.fn.modal.defaults =
    backdrop: not 0
    keyboard: not 0
    show: not 0

  e.fn.modal.Constructor = t
  e.fn.modal.noConflict = ->
    e.fn.modal = n
    this

  e(document).on("click.modal.data-api", "[data-toggle=\"modal\"]", (t) ->
    n = e(this)
    r = n.attr("href")
    i = e(n.attr("data-target") or r and r.replace(/.*(?=#[^\s]+$)/, ""))
    s = (if i.data("modal") then "toggle" else e.extend(
      remote: not /#/.test(r) and r
    , i.data(), n.data()))
    t.preventDefault()
    i.modal(s).one("hide", ->
      n.focus()
      return
    )

    return
  )

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (e, t) ->
    @init "tooltip", e, t
    return

  t:: =
    constructor: t
    init: (t, n, r) ->
      i = undefined
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      @type = t
      @$element = e(n)
      @options = @getOptions(r)
      @enabled = not 0
      o = @options.trigger.split(" ")

      a = o.length
      while a--
        u = o[a]
        (if u is "click" then @$element.on("click." + @type, @options.selector, e.proxy(@toggle, this)) else u isnt "manual" and (i = (if u is "hover" then "mouseenter" else "focus")
        s = (if u is "hover" then "mouseleave" else "blur")
        @$element.on(i + "." + @type, @options.selector, e.proxy(@enter, this))
        @$element.on(s + "." + @type, @options.selector, e.proxy(@leave, this))
        ))
      (if @options.selector then @_options = e.extend({}, @options,
        trigger: "manual"
        selector: ""
      ) else @fixTitle())
      return

    getOptions: (t) ->
      t = e.extend({}, e.fn[@type].defaults, @$element.data(), t)
      t.delay and typeof t.delay is "number" and (t.delay =
        show: t.delay
        hide: t.delay
      )
      t

    enter: (t) ->
      n = e.fn[@type].defaults
      r = {}
      i = undefined
      @_options and e.each(@_options, (e, t) ->
        n[e] isnt t and (r[e] = t)
        return
      , this)
      i = e(t.currentTarget)[@type](r).data(@type)

      return i.show()  if not i.options.delay or not i.options.delay.show
      clearTimeout(@timeout)
      i.hoverState = "in"
      @timeout = setTimeout(->
        i.hoverState is "in" and i.show()
        return
      , i.options.delay.show)

      return

    leave: (t) ->
      n = e(t.currentTarget)[@type](@_options).data(@type)
      @timeout and clearTimeout(@timeout)
      return n.hide()  if not n.options.delay or not n.options.delay.hide
      n.hoverState = "out"
      @timeout = setTimeout(->
        n.hoverState is "out" and n.hide()
        return
      , n.options.delay.hide)

      return

    show: ->
      t = undefined
      n = undefined
      r = undefined
      i = undefined
      s = undefined
      o = undefined
      u = e.Event("show")
      if @hasContent() and @enabled
        @$element.trigger u
        return  if u.isDefaultPrevented()
        t = @tip()
        @setContent()
        @options.animation and t.addClass("fade")
        s = (if typeof @options.placement is "function" then @options.placement.call(this, t[0], @$element[0]) else @options.placement)
        t.detach().css(
          top: 0
          left: 0
          display: "block"
        )
        (if @options.container then t.appendTo(@options.container) else t.insertAfter(@$element))
        n = @getPosition()
        r = t[0].offsetWidth
        i = t[0].offsetHeight

        switch s
          when "bottom"
            o =
              top: n.top + n.height
              left: n.left + n.width / 2 - r / 2
          when "top"
            o =
              top: n.top - i
              left: n.left + n.width / 2 - r / 2
          when "left"
            o =
              top: n.top + n.height / 2 - i / 2
              left: n.left - r
          when "right"
            o =
              top: n.top + n.height / 2 - i / 2
              left: n.left + n.width
        @applyPlacement(o, s)
        @$element.trigger("shown")
      return

    applyPlacement: (e, t) ->
      n = @tip()
      r = n[0].offsetWidth
      i = n[0].offsetHeight
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      n.offset(e).addClass(t).addClass("in")
      s = n[0].offsetWidth
      o = n[0].offsetHeight
      t is "top" and o isnt i and (e.top = e.top + i - o
      a = not 0
      )
      (if t is "bottom" or t is "top" then (u = 0
      e.left < 0 and (u = e.left * -2
      e.left = 0
      n.offset(e)
      s = n[0].offsetWidth
      o = n[0].offsetHeight
      )
      @replaceArrow(u - r + s, s, "left")
      ) else @replaceArrow(o - i, o, "top"))
      a and n.offset(e)

      return

    replaceArrow: (e, t, n) ->
      @arrow().css n, (if e then 50 * (1 - e / t) + "%" else "")
      return

    setContent: ->
      e = @tip()
      t = @getTitle()
      e.find(".tooltip-inner")[(if @options.html then "html" else "text")](t)
      e.removeClass("fade in top bottom left right")

      return

    hide: ->
      i = ->
        t = setTimeout(->
          n.off(e.support.transition.end).detach()
          return
        , 500)
        n.one e.support.transition.end, ->
          clearTimeout(t)
          n.detach()

          return

        return
      t = this
      n = @tip()
      r = e.Event("hide")
      @$element.trigger r
      return  if r.isDefaultPrevented()
      n.removeClass("in")
      (if e.support.transition and @$tip.hasClass("fade") then i() else n.detach())
      @$element.trigger("hidden")
      this

    fixTitle: ->
      e = @$element
      (e.attr("title") or typeof e.attr("data-original-title") isnt "string") and e.attr("data-original-title", e.attr("title") or "").attr("title", "")
      return

    hasContent: ->
      @getTitle()

    getPosition: ->
      t = @$element[0]
      e.extend {}, (if typeof t.getBoundingClientRect is "function" then t.getBoundingClientRect() else
        width: t.offsetWidth
        height: t.offsetHeight
      ), @$element.offset()

    getTitle: ->
      e = undefined
      t = @$element
      n = @options
      e = t.attr("data-original-title") or ((if typeof n.title is "function" then n.title.call(t[0]) else n.title))
      e

    tip: ->
      @$tip = @$tip or e(@options.template)

    arrow: ->
      @$arrow = @$arrow or @tip().find(".tooltip-arrow")

    validate: ->
      @$element[0].parentNode or (@hide()
      @$element = null
      @options = null
      )
      return

    enable: ->
      @enabled = not 0
      return

    disable: ->
      @enabled = not 1
      return

    toggleEnabled: ->
      @enabled = not @enabled
      return

    toggle: (t) ->
      n = (if t then e(t.currentTarget)[@type](@_options).data(@type) else this)
      (if n.tip().hasClass("in") then n.hide() else n.show())
      return

    destroy: ->
      @hide().$element.off("." + @type).removeData @type
      return

  n = e.fn.tooltip
  e.fn.tooltip = (n) ->
    @each ->
      r = e(this)
      i = r.data("tooltip")
      s = typeof n is "object" and n
      i or r.data("tooltip", i = new t(this, s))
      typeof n is "string" and i[n]()

      return


  e.fn.tooltip.Constructor = t
  e.fn.tooltip.defaults =
    animation: not 0
    placement: "top"
    selector: not 1
    template: "<div class=\"tooltip\"><div class=\"tooltip-arrow\"></div><div class=\"tooltip-inner\"></div></div>"
    trigger: "hover focus"
    title: ""
    delay: 0
    html: not 1
    container: not 1

  e.fn.tooltip.noConflict = ->
    e.fn.tooltip = n
    this


  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (e, t) ->
    @init "popover", e, t
    return

  t:: = e.extend({}, e.fn.tooltip.Constructor::,
    constructor: t
    setContent: ->
      e = @tip()
      t = @getTitle()
      n = @getContent()
      e.find(".popover-title")[(if @options.html then "html" else "text")](t)
      e.find(".popover-content")[(if @options.html then "html" else "text")](n)
      e.removeClass("fade top bottom left right in")

      return

    hasContent: ->
      @getTitle() or @getContent()

    getContent: ->
      e = undefined
      t = @$element
      n = @options
      e = ((if typeof n.content is "function" then n.content.call(t[0]) else n.content)) or t.attr("data-content")
      e

    tip: ->
      @$tip or (@$tip = e(@options.template))
      @$tip

    destroy: ->
      @hide().$element.off("." + @type).removeData @type
      return
  )
  n = e.fn.popover
  e.fn.popover = (n) ->
    @each ->
      r = e(this)
      i = r.data("popover")
      s = typeof n is "object" and n
      i or r.data("popover", i = new t(this, s))
      typeof n is "string" and i[n]()

      return


  e.fn.popover.Constructor = t
  e.fn.popover.defaults = e.extend({}, e.fn.tooltip.defaults,
    placement: "right"
    trigger: "click"
    content: ""
    template: "<div class=\"popover\"><div class=\"arrow\"></div><h3 class=\"popover-title\"></h3><div class=\"popover-content\"></div></div>"
  )
  e.fn.popover.noConflict = ->
    e.fn.popover = n
    this


  return
(window.jQuery)
not (e) ->
  t = (t, n) ->
    r = e.proxy(@process, this)
    i = (if e(t).is("body") then e(window) else e(t))
    s = undefined
    @options = e.extend({}, e.fn.scrollspy.defaults, n)
    @$scrollElement = i.on("scroll.scroll-spy.data-api", r)
    @selector = (@options.target or (s = e(t).attr("href")) and s.replace(/.*(?=#[^\s]+$)/, "") or "") + " .nav li > a"
    @$body = e("body")
    @refresh()
    @process()

    return
  "use strict"
  t:: =
    constructor: t
    refresh: ->
      t = this
      n = undefined
      @offsets = e([])
      @targets = e([])
      n = @$body.find(@selector).map(->
        n = e(this)
        r = n.data("target") or n.attr("href")
        i = /^#\w/.test(r) and e(r)
        i and i.length and [[
          i.position().top + (not e.isWindow(t.$scrollElement.get(0)) and t.$scrollElement.scrollTop())
          r
        ]] or null
      ).sort((e, t) ->
        e[0] - t[0]
      ).each(->
        t.offsets.push(this[0])
        t.targets.push(this[1])

        return
      )

      return

    process: ->
      e = @$scrollElement.scrollTop() + @options.offset
      t = @$scrollElement[0].scrollHeight or @$body[0].scrollHeight
      n = t - @$scrollElement.height()
      r = @offsets
      i = @targets
      s = @activeTarget
      o = undefined
      return s isnt (o = i.last()[0]) and @activate(o)  if e >= n
      o = r.length
      while o--
        s isnt i[o] and e >= r[o] and (not r[o + 1] or e <= r[o + 1]) and @activate(i[o])
      return

    activate: (t) ->
      n = undefined
      r = undefined
      @activeTarget = t
      e(@selector).parent(".active").removeClass("active")
      r = @selector + "[data-target=\"" + t + "\"]," + @selector + "[href=\"" + t + "\"]"
      n = e(r).parent("li").addClass("active")
      n.parent(".dropdown-menu").length and (n = n.closest("li.dropdown").addClass("active"))
      n.trigger("activate")

      return

  n = e.fn.scrollspy
  e.fn.scrollspy = (n) ->
    @each ->
      r = e(this)
      i = r.data("scrollspy")
      s = typeof n is "object" and n
      i or r.data("scrollspy", i = new t(this, s))
      typeof n is "string" and i[n]()

      return


  e.fn.scrollspy.Constructor = t
  e.fn.scrollspy.defaults = offset: 10
  e.fn.scrollspy.noConflict = ->
    e.fn.scrollspy = n
    this

  e(window).on("load", ->
    e("[data-spy=\"scroll\"]").each ->
      t = e(this)
      t.scrollspy t.data()
      return

    return
  )

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (t) ->
    @element = e(t)
    return

  t:: =
    constructor: t
    show: ->
      t = @element
      n = t.closest("ul:not(.dropdown-menu)")
      r = t.attr("data-target")
      i = undefined
      s = undefined
      o = undefined
      r or (r = t.attr("href")
      r = r and r.replace(/.*(?=#[^\s]*$)/, "")
      )
      return  if t.parent("li").hasClass("active")
      i = n.find(".active:last a")[0]
      o = e.Event("show",
        relatedTarget: i
      )
      t.trigger(o)

      return  if o.isDefaultPrevented()
      s = e(r)
      @activate(t.parent("li"), n)
      @activate(s, s.parent(), ->
        t.trigger
          type: "shown"
          relatedTarget: i

        return
      )

      return

    activate: (t, n, r) ->
      o = ->
        i.removeClass("active").find("> .dropdown-menu > .active").removeClass("active")
        t.addClass("active")
        (if s then (t[0].offsetWidth
        t.addClass("in")
        ) else t.removeClass("fade"))
        t.parent(".dropdown-menu") and t.closest("li.dropdown").addClass("active")
        r and r()

        return
      i = n.find("> .active")
      s = r and e.support.transition and i.hasClass("fade")
      (if s then i.one(e.support.transition.end, o) else o())
      i.removeClass("in")

      return

  n = e.fn.tab
  e.fn.tab = (n) ->
    @each ->
      r = e(this)
      i = r.data("tab")
      i or r.data("tab", i = new t(this))
      typeof n is "string" and i[n]()

      return


  e.fn.tab.Constructor = t
  e.fn.tab.noConflict = ->
    e.fn.tab = n
    this

  e(document).on("click.tab.data-api", "[data-toggle=\"tab\"], [data-toggle=\"pill\"]", (t) ->
    t.preventDefault()
    e(this).tab("show")

    return
  )

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (t, n) ->
    @$element = e(t)
    @options = e.extend({}, e.fn.typeahead.defaults, n)
    @matcher = @options.matcher or @matcher
    @sorter = @options.sorter or @sorter
    @highlighter = @options.highlighter or @highlighter
    @updater = @options.updater or @updater
    @source = @options.source
    @$menu = e(@options.menu)
    @shown = not 1
    @listen()

    return

  t:: =
    constructor: t
    select: ->
      e = @$menu.find(".active").attr("data-value")
      @$element.val(@updater(e)).change()
      @hide()

    updater: (e) ->
      e

    show: ->
      t = e.extend({}, @$element.position(),
        height: @$element[0].offsetHeight
      )
      @$menu.insertAfter(@$element).css(
        top: t.top + t.height
        left: t.left
      ).show()
      @shown = not 0
      this

    hide: ->
      @$menu.hide()
      @shown = not 1
      this

    lookup: (t) ->
      n = undefined
      @query = @$element.val()
      (if not @query or @query.length < @options.minLength then (if @shown then @hide() else this) else (n = (if e.isFunction(@source) then @source(@query, e.proxy(@process, this)) else @source)
      (if n then @process(n) else this)
      ))

    process: (t) ->
      n = this
      t = e.grep(t, (e) ->
        n.matcher e
      )
      t = @sorter(t)
      (if t.length then @render(t.slice(0, @options.items)).show() else (if @shown then @hide() else this))

    matcher: (e) ->
      ~e.toLowerCase().indexOf(@query.toLowerCase())

    sorter: (e) ->
      t = []
      n = []
      r = []
      i = undefined
      (if i.toLowerCase().indexOf(@query.toLowerCase()) then (if ~i.indexOf(@query) then n.push(i) else r.push(i)) else t.push(i))  while i = e.shift()
      t.concat n, r

    highlighter: (e) ->
      t = @query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
      e.replace new RegExp("(" + t + ")", "ig"), (e, t) ->
        "<strong>" + t + "</strong>"


    render: (t) ->
      n = this
      t = e(t).map((t, r) ->
        t = e(n.options.item).attr("data-value", r)
        t.find("a").html(n.highlighter(r))
        t[0]
      )
      t.first().addClass("active")
      @$menu.html(t)
      this

    next: (t) ->
      n = @$menu.find(".active").removeClass("active")
      r = n.next()
      r.length or (r = e(@$menu.find("li")[0]))
      r.addClass("active")

      return

    prev: (e) ->
      t = @$menu.find(".active").removeClass("active")
      n = t.prev()
      n.length or (n = @$menu.find("li").last())
      n.addClass("active")

      return

    listen: ->
      @$element.on("focus", e.proxy(@focus, this)).on("blur", e.proxy(@blur, this)).on("keypress", e.proxy(@keypress, this)).on("keyup", e.proxy(@keyup, this))
      @eventSupported("keydown") and @$element.on("keydown", e.proxy(@keydown, this))
      @$menu.on("click", e.proxy(@click, this)).on("mouseenter", "li", e.proxy(@mouseenter, this)).on("mouseleave", "li", e.proxy(@mouseleave, this))

      return

    eventSupported: (e) ->
      t = e of @$element
      t or (@$element.setAttribute(e, "return;")
      t = typeof @$element[e] is "function"
      )
      t

    move: (e) ->
      return  unless @shown
      switch e.keyCode
        when 9, 13, 27
          e.preventDefault()
        when 38
          e.preventDefault()
          @prev()
        when 40
          e.preventDefault()
          @next()
      e.stopPropagation()
      return

    keydown: (t) ->
      @suppressKeyPressRepeat = ~e.inArray(t.keyCode, [
        40
        38
        9
        13
        27
      ])
      @move(t)

      return

    keypress: (e) ->
      return  if @suppressKeyPressRepeat
      @move e
      return

    keyup: (e) ->
      switch e.keyCode
        when 40, 38, 16, 17, 18, 9, 13
          return  unless @shown
          @select()
        when 27
          return  unless @shown
          @hide()
        else
          @lookup()
      e.stopPropagation()
      e.preventDefault()

      return

    focus: (e) ->
      @focused = not 0
      return

    blur: (e) ->
      @focused = not 1
      not @mousedover and @shown and @hide()

      return

    click: (e) ->
      e.stopPropagation()
      e.preventDefault()
      @select()
      @$element.focus()

      return

    mouseenter: (t) ->
      @mousedover = not 0
      @$menu.find(".active").removeClass("active")
      e(t.currentTarget).addClass("active")

      return

    mouseleave: (e) ->
      @mousedover = not 1
      not @focused and @shown and @hide()

      return

  n = e.fn.typeahead
  e.fn.typeahead = (n) ->
    @each ->
      r = e(this)
      i = r.data("typeahead")
      s = typeof n is "object" and n
      i or r.data("typeahead", i = new t(this, s))
      typeof n is "string" and i[n]()

      return


  e.fn.typeahead.defaults =
    source: []
    items: 8
    menu: "<ul class=\"typeahead dropdown-menu\"></ul>"
    item: "<li><a href=\"#\"></a></li>"
    minLength: 1

  e.fn.typeahead.Constructor = t
  e.fn.typeahead.noConflict = ->
    e.fn.typeahead = n
    this

  e(document).on("focus.typeahead.data-api", "[data-provide=\"typeahead\"]", (t) ->
    n = e(this)
    return  if n.data("typeahead")
    n.typeahead n.data()
    return
  )

  return
(window.jQuery)
not (e) ->
  "use strict"
  t = (t, n) ->
    @options = e.extend({}, e.fn.affix.defaults, n)
    @$window = e(window).on("scroll.affix.data-api", e.proxy(@checkPosition, this)).on("click.affix.data-api", e.proxy(->
      setTimeout e.proxy(@checkPosition, this), 1
      return
    , this))
    @$element = e(t)
    @checkPosition()

    return

  t::checkPosition = ->
    return  unless @$element.is(":visible")
    t = e(document).height()
    n = @$window.scrollTop()
    r = @$element.offset()
    i = @options.offset
    s = i.bottom
    o = i.top
    u = "affix affix-top affix-bottom"
    a = undefined
    typeof i isnt "object" and (s = o = i)
    typeof o is "function" and (o = i.top())
    typeof s is "function" and (s = i.bottom())
    a = (if @unpin? and n + @unpin <= r.top then not 1 else (if s? and r.top + @$element.height() >= t - s then "bottom" else (if o? and n <= o then "top" else not 1)))

    return  if @affixed is a
    @affixed = a
    @unpin = (if a is "bottom" then r.top - n else null)
    @$element.removeClass(u).addClass("affix" + ((if a then "-" + a else "")))

    return

  n = e.fn.affix
  e.fn.affix = (n) ->
    @each ->
      r = e(this)
      i = r.data("affix")
      s = typeof n is "object" and n
      i or r.data("affix", i = new t(this, s))
      typeof n is "string" and i[n]()

      return


  e.fn.affix.Constructor = t
  e.fn.affix.defaults = offset: 0
  e.fn.affix.noConflict = ->
    e.fn.affix = n
    this

  e(window).on("load", ->
    e("[data-spy=\"affix\"]").each ->
      t = e(this)
      n = t.data()
      n.offset = n.offset or {}
      n.offsetBottom and (n.offset.bottom = n.offsetBottom)
      n.offsetTop and (n.offset.top = n.offsetTop)
      t.affix(n)

      return

    return
  )

  return
(window.jQuery)
