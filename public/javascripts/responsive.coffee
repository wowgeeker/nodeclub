$(document).ready ->
  $responsiveBtn = $("#responsive-sidebar-trigger")
  $sidebarMask = $("#sidebar-mask")
  $sidebar = $("#sidebar")
  $main = $("#main")
  startX = 0
  swipeThreshold = 10
  toggleSideBar = ->
    isShow = $responsiveBtn.data("is-show")
    mainHeight = $main.height()
    sidebarHeight = $sidebar.outerHeight()
    $sidebar.css right: (if isShow then -300 else 0)
    $responsiveBtn.data "is-show", not isShow
    $main.height sidebarHeight  if not isShow and mainHeight < sidebarHeight
    $sidebarMask[(if isShow then "fadeOut" else "fadeIn")]().height $("body").height()
    return

  touchstart = (e) ->
    touchs = e.targetTouches
    startX = +touchs[0].pageX
    return

  touchmove = (e) ->
    touchs = e.changedTouches
    e.preventDefault()  if Math.abs(+touchs[0].pageX - startX) > swipeThreshold
    return

  touchend = (e) ->
    touchs = e.changedTouches
    x = +touchs[0].pageX
    winWidth = $(window).width()
    isShow = $responsiveBtn.data("is-show")
    $responsiveBtn.trigger "click"  if not isShow and (startX > winWidth * 3 / 4) and Math.abs(startX - x) > swipeThreshold
    $responsiveBtn.trigger "click"  if isShow and (startX < winWidth * 1 / 4) and Math.abs(startX - x) > swipeThreshold
    startX = 0
    return

  if ("ontouchstart" of window) or window.DocumentTouch and document instanceof DocumentTouch
    document.body.addEventListener "touchstart", touchstart
    document.body.addEventListener "touchmove", touchmove
    document.body.addEventListener "touchend", touchend
  $responsiveBtn.on "click", toggleSideBar
  $sidebarMask.on "click", ->
    $responsiveBtn.trigger "click"
    return

  return

