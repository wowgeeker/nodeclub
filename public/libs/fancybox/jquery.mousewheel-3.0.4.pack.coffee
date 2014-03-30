#! Copyright (c) 2010 Brandon Aaron (http://brandonaaron.net)
#* Licensed under the MIT License (LICENSE.txt).
#*
#* Thanks to: http://adomas.org/javascript-mouse-wheel/ for some pointers.
#* Thanks to: Mathias Bank(http://www.mathias-bank.de) for a scope bug fix.
#* Thanks to: Seamus Leahy for adding deltaX and deltaY
#*
#* Version: 3.0.4
#*
#* Requires: 1.2.2+
#
((d) ->
  g = (a) ->
    b = a or window.event
    i = [].slice.call(arguments_, 1)
    c = 0
    h = 0
    e = 0
    a = d.event.fix(b)
    a.type = "mousewheel"
    c = a.wheelDelta / 120  if a.wheelDelta
    c = -a.detail / 3  if a.detail
    e = c
    if b.axis isnt `undefined` and b.axis is b.HORIZONTAL_AXIS
      e = 0
      h = -1 * c
    e = b.wheelDeltaY / 120  if b.wheelDeltaY isnt `undefined`
    h = -1 * b.wheelDeltaX / 120  if b.wheelDeltaX isnt `undefined`
    i.unshift a, c, h, e
    d.event.handle.apply this, i
  f = [
    "DOMMouseScroll"
    "mousewheel"
  ]
  d.event.special.mousewheel =
    setup: ->
      if @addEventListener
        a = f.length

        while a
          @addEventListener f[--a], g, false
      else
        @onmousewheel = g
      return

    teardown: ->
      if @removeEventListener
        a = f.length

        while a
          @removeEventListener f[--a], g, false
      else
        @onmousewheel = null
      return

  d.fn.extend
    mousewheel: (a) ->
      (if a then @bind("mousewheel", a) else @trigger("mousewheel"))

    unmousewheel: (a) ->
      @unbind "mousewheel", a

  return
) jQuery
