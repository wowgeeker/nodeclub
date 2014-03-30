$(document).ready ->
  
  # pretty code
  prettyPrint()
  
  #fancy image
  $(".topic_content img,.reply_content img").each ->
    $(this).width 500  if $(this).width > 500
    elem = $("<a class=\"content_img\"></a>")
    elem.attr "href", $(this).attr("src")
    $(this).wrap elem
    return

  $(".content_img").fancybox
    transitionIn: "elastic"
    transitionOut: "elastic"

  return

