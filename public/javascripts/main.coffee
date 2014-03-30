$(document).ready ->
  
  #e.preventDefault();
  search = ->
    q = document.getElementById("q")
    if q.value
      
      #
      #      var hostname = window.location.hostname;
      #      var url = 'http://www.google.com/search?q=site:' + hostname + '%20';
      #      window.open(url + q.value, '_blank');
      #      
      true
    else
      false
  moveBacktotop = ->
    $backtotop.css
      top: top
      right: 0

    return
  $("#search_form").submit (e) ->
    search()
    return

  $wrapper = $("#wrapper")
  $backtotop = $("#backtotop")
  $sidebar = $("#sidebar")
  top = $(window).height() - $backtotop.height() - 200
  $backtotop.click ->
    $("html,body").animate scrollTop: 0
    false

  $(window).scroll ->
    windowHeight = $(window).scrollTop()
    if windowHeight > 200
      $backtotop.fadeIn()
    else
      $backtotop.fadeOut()
    return

  moveBacktotop()
  $(window).resize moveBacktotop
  $(".topic_content a,.reply_content a").attr "target", "_blank"
  return

