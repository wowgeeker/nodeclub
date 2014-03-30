###
创建一个 EpicEditor

@param {Element} textarea
@return {EpicEditor}
###
createEpicEditor = (textarea) ->
  
  # 进入全屏模式时，给编辑器增加一些额外的样式
  _fullscreenenter = ($e) ->
    d =
      margin: "90px 8px 8px 8px"
      padding: "8px"
      border: "1px solid #aaa"
      width: $e.width() - 34
      height: $e.height() - 114

    setTimeout (->
      $e.css d
      return
    ), 100
    return
  _fullscreenexit = ($e) ->
    $e.css
      margin: "0"
      padding: "0"
      border: "none"

    return
  fullscreenenter = ->
    _fullscreenenter $(editor.editorIframe)
    _fullscreenenter $(editor.previewerIframe)
    window.e = editor
    return
  fullscreenexit = ->
    _fullscreenexit $(editor.editorIframe)
    _fullscreenexit $(editor.previewerIframe)
    return
  $node = $(textarea)
  id = $node.attr("id")
  h = $node.height()
  l = $node.parents(".reply2_form").find("#editor_" + id).length
  $node.before "<div id=\"editor_" + id + "\" style=\"height:" + h + "px; border: 1px solid #DDD; border-radius: 4px;\"></div>"  if l is 0
  $node.hide()
  opts =
    container: "editor_" + id
    textarea: id
    basePath: "/public/libs/epiceditor"
    clientSideStorage: false
    useNativeFullscreen: true
    parser: marked
    theme:
      base: "/themes/base/epiceditor.css"
      preview: "/themes/preview/github.css"
      editor: "/themes/editor/epic-light.css"

    button:
      preview: true
      fullscreen: true
      bar: true

    focusOnLoad: false
    shortcut:
      modifier: 18
      fullscreen: 70
      preview: 80

    string:
      togglePreview: "预览"
      toggleEdit: "编辑"
      toggleFullscreen: "全屏"

    autogrow:
      minHeight: 200

  editor = new EpicEditor(opts)
  editor.on "fullscreenenter", fullscreenenter
  editor.on "fullscreenexit", fullscreenexit
  $(window).resize ->
    fullscreenenter()  if editor.is("fullscreen")
    return

  editor

###
向EpicEditor末尾增加内容

@param {EpicEditor} editor
@param {String} text
@return {String}
###
epicEditorAppend = (editor, text) ->
  editor.getElement("editor").body.innerHTML += text

###
向EpicEditor前面增加内容

@param {EpicEditor} editor
@param {String} text
@return {String}
###
epicEditorPrepend = (editor, text) ->
  editor.getElement("editor").body.innerHTML = text + editor.getElement("editor").body.innerHTML

# 自动创建编辑框
$ ->
  $node = $("#wmd-input")
  createEpicEditor($node).load()  if $node.length > 0
  return

