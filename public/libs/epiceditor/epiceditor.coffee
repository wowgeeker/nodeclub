###
EpicEditor - An Embeddable JavaScript Markdown Editor (https://github.com/OscarGodson/EpicEditor)
Copyright (c) 2011-2012, Oscar Godson. (MIT Licensed)
###
((window, undefined_) ->
  
  ###
  Applies attributes to a DOM object
  @param  {object} context The DOM obj you want to apply the attributes to
  @param  {object} attrs A key/value pair of attributes you want to apply
  @returns {undefined}
  ###
  _applyAttrs = (context, attrs) ->
    for attr of attrs
      context[attr] = attrs[attr]  if attrs.hasOwnProperty(attr)
    return
  
  ###
  Applies styles to a DOM object
  @param  {object} context The DOM obj you want to apply the attributes to
  @param  {object} attrs A key/value pair of attributes you want to apply
  @returns {undefined}
  ###
  _applyStyles = (context, attrs) ->
    for attr of attrs
      context.style[attr] = attrs[attr]  if attrs.hasOwnProperty(attr)
    return
  
  ###
  Returns a DOM objects computed style
  @param  {object} el The element you want to get the style from
  @param  {string} styleProp The property you want to get from the element
  @returns {string} Returns a string of the value. If property is not set it will return a blank string
  ###
  _getStyle = (el, styleProp) ->
    x = el
    y = null
    if window.getComputedStyle
      y = document.defaultView.getComputedStyle(x, null).getPropertyValue(styleProp)
    else y = x.currentStyle[styleProp]  if x.currentStyle
    y
  
  ###
  Saves the current style state for the styles requested, then applies styles
  to overwrite the existing one. The old styles are returned as an object so
  you can pass it back in when you want to revert back to the old style
  @param   {object} el     The element to get the styles of
  @param   {string} type   Can be "save" or "apply". apply will just apply styles you give it. Save will write styles
  @param   {object} styles Key/value style/property pairs
  @returns {object}
  ###
  _saveStyleState = (el, type, styles) ->
    returnState = {}
    style = undefined
    if type is "save"
      for style of styles
        returnState[style] = _getStyle(el, style)  if styles.hasOwnProperty(style)
      
      # After it's all done saving all the previous states, change the styles
      _applyStyles el, styles
    else _applyStyles el, styles  if type is "apply"
    returnState
  
  ###
  Gets an elements total width including it's borders and padding
  @param  {object} el The element to get the total width of
  @returns {int}
  ###
  _outerWidth = (el) ->
    b = parseInt(_getStyle(el, "border-left-width"), 10) + parseInt(_getStyle(el, "border-right-width"), 10)
    p = parseInt(_getStyle(el, "padding-left"), 10) + parseInt(_getStyle(el, "padding-right"), 10)
    w = el.offsetWidth
    t = undefined
    
    # For IE in case no border is set and it defaults to "medium"
    b = 0  if isNaN(b)
    t = b + p + w
    t
  
  ###
  Gets an elements total height including it's borders and padding
  @param  {object} el The element to get the total width of
  @returns {int}
  ###
  _outerHeight = (el) ->
    b = parseInt(_getStyle(el, "border-top-width"), 10) + parseInt(_getStyle(el, "border-bottom-width"), 10)
    p = parseInt(_getStyle(el, "padding-top"), 10) + parseInt(_getStyle(el, "padding-bottom"), 10)
    w = parseInt(_getStyle(el, "height"), 10)
    t = undefined
    
    # For IE in case no border is set and it defaults to "medium"
    b = 0  if isNaN(b)
    t = b + p + w
    t
  
  ###
  Inserts a <link> tag specifically for CSS
  @param  {string} path The path to the CSS file
  @param  {object} context In what context you want to apply this to (document, iframe, etc)
  @param  {string} id An id for you to reference later for changing properties of the <link>
  @returns {undefined}
  ###
  _insertCSSLink = (path, context, id) ->
    id = id or ""
    headID = context.getElementsByTagName("head")[0]
    cssNode = context.createElement("link")
    _applyAttrs cssNode,
      type: "text/css"
      id: id
      rel: "stylesheet"
      href: path
      name: path
      media: "screen"

    headID.appendChild cssNode
    return
  
  # Simply replaces a class (o), to a new class (n) on an element provided (e)
  _replaceClass = (e, o, n) ->
    e.className = e.className.replace(o, n)
    return
  
  # Feature detects an iframe to get the inner document for writing to
  _getIframeInnards = (el) ->
    el.contentDocument or el.contentWindow.document
  
  # Grabs the text from an element and preserves whitespace
  _getText = (el) ->
    theText = undefined
    
    # Make sure to check for type of string because if the body of the page
    # doesn't have any text it'll be "" which is falsey and will go into
    # the else which is meant for Firefox and shit will break
    if typeof document.body.innerText is "string"
      theText = el.innerText
    else
      
      # First replace <br>s before replacing the rest of the HTML
      theText = el.innerHTML.replace(/<br>/g, "\n")
      
      # Now we can clean the HTML
      theText = theText.replace(/<(?:.|\n)*?>/g, "")
      
      # Now fix HTML entities
      theText = theText.replace(/&lt;/g, "<")
      theText = theText.replace(/&gt;/g, ">")
    theText
  _setText = (el, content) ->
    
    # Don't convert lt/gt characters as HTML when viewing the editor window
    # TODO: Write a test to catch regressions for this
    content = content.replace(/</g, "&lt;")
    content = content.replace(/>/g, "&gt;")
    content = content.replace(/\n/g, "<br>")
    
    # Make sure to there aren't two spaces in a row (replace one with &nbsp;)
    # If you find and replace every space with a &nbsp; text will not wrap.
    # Hence the name (Non-Breaking-SPace).
    # TODO: Probably need to test this somehow...
    content = content.replace(/<br>\s/g, "<br>&nbsp;")
    content = content.replace(/\s\s\s/g, "&nbsp; &nbsp;")
    content = content.replace(/\s\s/g, "&nbsp; ")
    content = content.replace(/^ /, "&nbsp;")
    el.innerHTML = content
    true
  
  ###
  Converts the 'raw' format of a file's contents into plaintext
  @param   {string} content Contents of the file
  @returns {string} the sanitized content
  ###
  _sanitizeRawContent = (content) ->
    
    # Get this, 2 spaces in a content editable actually converts to:
    # 0020 00a0, meaning, "space no-break space". So, manually convert
    # no-break spaces to spaces again before handing to marked.
    # Also, WebKit converts no-break to unicode equivalent and FF HTML.
    content.replace(/\u00a0/g, " ").replace /&nbsp;/g, " "
  
  ###
  Will return the version number if the browser is IE. If not will return -1
  TRY NEVER TO USE THIS AND USE FEATURE DETECTION IF POSSIBLE
  @returns {Number} -1 if false or the version number if true
  ###
  _isIE = ->
    rv = -1 # Return value assumes failure.
    ua = navigator.userAgent
    re = undefined
    if navigator.appName is "Microsoft Internet Explorer"
      re = /MSIE ([0-9]{1,}[\.0-9]{0,})/
      rv = parseFloat(RegExp.$1, 10)  if re.exec(ua)?
    rv
  
  ###
  Same as the isIE(), but simply returns a boolean
  THIS IS TERRIBLE AND IS ONLY USED BECAUSE FULLSCREEN IN SAFARI IS BORKED
  If some other engine uses WebKit and has support for fullscreen they
  probably wont get native fullscreen until Safari's fullscreen is fixed
  @returns {Boolean} true if Safari
  ###
  _isSafari = ->
    n = window.navigator
    n.userAgent.indexOf("Safari") > -1 and n.userAgent.indexOf("Chrome") is -1
  
  ###
  Same as the isIE(), but simply returns a boolean
  THIS IS TERRIBLE ONLY USE IF ABSOLUTELY NEEDED
  @returns {Boolean} true if Safari
  ###
  _isFirefox = ->
    n = window.navigator
    n.userAgent.indexOf("Firefox") > -1 and n.userAgent.indexOf("Seamonkey") is -1
  
  ###
  Determines if supplied value is a function
  @param {object} object to determine type
  ###
  _isFunction = (functionToCheck) ->
    getType = {}
    functionToCheck and getType.toString.call(functionToCheck) is "[object Function]"
  
  ###
  Overwrites obj1's values with obj2's and adds obj2's if non existent in obj1
  @param {boolean} [deepMerge=false] If true, will deep merge meaning it will merge sub-objects like {obj:obj2{foo:'bar'}}
  @param {object} first object
  @param {object} second object
  @returnss {object} a new object based on obj1 and obj2
  ###
  _mergeObjs = ->
    
    # copy reference to target object
    target = arguments_[0] or {}
    i = 1
    length = arguments_.length
    deep = false
    options = undefined
    name = undefined
    src = undefined
    copy = undefined
    
    # Handle a deep copy situation
    if typeof target is "boolean"
      deep = target
      target = arguments_[1] or {}
      
      # skip the boolean and the target
      i = 2
    
    # Handle case when target is a string or something (possible in deep copy)
    target = {}  if typeof target isnt "object" and not _isFunction(target)
    
    # extend jQuery itself if only one argument is passed
    if length is i
      target = this
      --i
    while i < length
      
      # Only deal with non-null/undefined values
      if (options = arguments_[i])?
        
        # Extend the base object
        for name of options
          
          # @NOTE: added hasOwnProperty check
          if options.hasOwnProperty(name)
            src = target[name]
            copy = options[name]
            
            # Prevent never-ending loop
            continue  if target is copy
            
            # Recurse if we're merging object values
            if deep and copy and typeof copy is "object" and not copy.nodeType
              
              # Never move original objects, clone them
              target[name] = _mergeObjs(deep, src or ((if copy.length? then [] else {})), copy)
            # Don't bring in undefined values
            else target[name] = copy  if copy isnt `undefined`
      i++
    
    # Return the modified object
    target
  
  ###
  Initiates the EpicEditor object and sets up offline storage as well
  @class Represents an EpicEditor instance
  @param {object} options An optional customization object
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor = (options) ->
    
    # Default settings will be overwritten/extended by options arg
    self = this
    opts = options or {}
    _defaultFileSchema = undefined
    _defaultFile = undefined
    defaults =
      container: "epiceditor"
      basePath: "epiceditor"
      textarea: `undefined`
      clientSideStorage: true
      localStorageName: "epiceditor"
      useNativeFullscreen: true
      file:
        name: null
        defaultContent: ""
        autoSave: 100 # Set to false for no auto saving

      theme:
        base: "/themes/base/epiceditor.css"
        preview: "/themes/preview/github.css"
        editor: "/themes/editor/epic-dark.css"

      focusOnLoad: false
      shortcut: # alt keycode
        modifier: 18
        fullscreen: 70 # f keycode
        preview: 80 # p keycode

      string:
        togglePreview: "Toggle Preview Mode"
        toggleEdit: "Toggle Edit Mode"
        toggleFullscreen: "Enter Fullscreen"

      parser: (if typeof marked is "function" then marked else null)
      autogrow: false
      button:
        fullscreen: true
        preview: true
        bar: "auto"

    defaultStorage = undefined
    autogrowDefaults =
      minHeight: 80
      maxHeight: false
      scroll: true

    self.settings = _mergeObjs(true, defaults, opts)
    buttons = self.settings.button
    self._fullscreenEnabled = (if typeof (buttons) is "object" then typeof buttons.fullscreen is "undefined" or buttons.fullscreen else buttons is true)
    self._editEnabled = (if typeof (buttons) is "object" then typeof buttons.edit is "undefined" or buttons.edit else buttons is true)
    self._previewEnabled = (if typeof (buttons) is "object" then typeof buttons.preview is "undefined" or buttons.preview else buttons is true)
    unless typeof self.settings.parser is "function" and typeof self.settings.parser("TEST") is "string"
      self.settings.parser = (str) ->
        str
    if self.settings.autogrow
      if self.settings.autogrow is true
        self.settings.autogrow = autogrowDefaults
      else
        self.settings.autogrow = _mergeObjs(true, autogrowDefaults, self.settings.autogrow)
      self._oldHeight = -1
    
    # If you put an absolute link as the path of any of the themes ignore the basePath
    # preview theme
    self.settings.theme.preview = self.settings.basePath + self.settings.theme.preview  unless self.settings.theme.preview.match(/^https?:\/\//)
    
    # editor theme
    self.settings.theme.editor = self.settings.basePath + self.settings.theme.editor  unless self.settings.theme.editor.match(/^https?:\/\//)
    
    # base theme
    self.settings.theme.base = self.settings.basePath + self.settings.theme.base  unless self.settings.theme.base.match(/^https?:\/\//)
    
    # Grab the container element and save it to self.element
    # if it's a string assume it's an ID and if it's an object
    # assume it's a DOM element
    if typeof self.settings.container is "string"
      self.element = document.getElementById(self.settings.container)
    else self.element = self.settings.container  if typeof self.settings.container is "object"
    
    # Figure out the file name. If no file name is given we'll use the ID.
    # If there's no ID either we'll use a namespaced file name that's incremented
    # based on the calling order. As long as it doesn't change, drafts will be saved.
    unless self.settings.file.name
      if typeof self.settings.container is "string"
        self.settings.file.name = self.settings.container
      else if typeof self.settings.container is "object"
        if self.element.id
          self.settings.file.name = self.element.id
        else
          EpicEditor._data.unnamedEditors = []  unless EpicEditor._data.unnamedEditors
          EpicEditor._data.unnamedEditors.push self
          self.settings.file.name = "__epiceditor-untitled-" + EpicEditor._data.unnamedEditors.length
    self.settings.button.bar = true  if self.settings.button.bar is "show"
    self.settings.button.bar = false  if self.settings.button.bar is "hide"
    
    # Protect the id and overwrite if passed in as an option
    # TODO: Put underscrore to denote that this is private
    self._instanceId = "epiceditor-" + Math.round(Math.random() * 100000)
    self._storage = {}
    self._canSave = true
    
    # Setup local storage of files
    self._defaultFileSchema = ->
      content: self.settings.file.defaultContent
      created: new Date()
      modified: new Date()

    if localStorage and self.settings.clientSideStorage
      @_storage = localStorage
      if @_storage[self.settings.localStorageName] and self.getFiles(self.settings.file.name) is `undefined`
        _defaultFile = self._defaultFileSchema()
        _defaultFile.content = self.settings.file.defaultContent
    unless @_storage[self.settings.localStorageName]
      defaultStorage = {}
      defaultStorage[self.settings.file.name] = self._defaultFileSchema()
      defaultStorage = JSON.stringify(defaultStorage)
      @_storage[self.settings.localStorageName] = defaultStorage
    
    # A string to prepend files with to save draft versions of files
    # and reset all preview drafts on each load!
    self._previewDraftLocation = "__draft-"
    self._storage[self._previewDraftLocation + self.settings.localStorageName] = self._storage[self.settings.localStorageName]
    
    # This needs to replace the use of classes to check the state of EE
    self._eeState =
      fullscreen: false
      preview: false
      edit: false
      loaded: false
      unloaded: false

    
    # Now that it exists, allow binding of events if it doesn't exist yet
    self.events = {}  unless self.events
    this
  
  ###
  Inserts the EpicEditor into the DOM via an iframe and gets it ready for editing and previewing
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::load = (callback) ->
    
    # Get out early if it's already loaded
    
    # TODO: Gotta get the privates with underscores!
    # TODO: Gotta document what these are for...
    # i is reused for loops
    
    # Startup is a way to check if this EpicEditor is starting up. Useful for
    # checking and doing certain things before EpicEditor emits a load event.
    
    # Fucking Safari's native fullscreen works terribly
    # REMOVE THIS IF SAFARI 7 WORKS BETTER
    
    # It opens edit mode by default (for now);
    
    # The editor HTML
    # TODO: edit-mode class should be dynamically added
    
    # This is wrapping iframe element. It contains the other two iframes and the utilbar
    
    # The previewer is just an empty box for the generated HTML to go into
    
    # Write an iframe and then select it for the editor
    
    # Because browsers add things like invisible padding and margins and stuff
    # to iframes, we need to set manually set the height so that the height
    # doesn't keep increasing (by 2px?) every time reflow() is called.
    # FIXME: Figure out how to fix this without setting this
    
    # Store a reference to the iframeElement itself
    
    # Grab the innards of the iframe (returns the document.body)
    # TODO: Change self.iframe to self.iframeDocument
    
    # Now that we got the innards of the iframe, we can grab the other iframes
    
    # Setup the editor iframe
    
    # Need something for... you guessed it, Firefox
    
    # Setup the previewer iframe
    
    # Base tag is added so that links will open a new tab and not inside of the iframes
    
    # Insert Base Stylesheet
    
    # Insert Editor Stylesheet
    
    # Insert Previewer Stylesheet
    
    # Add a relative style to the overall wrapper to keep CSS relative to the editor
    
    # Set the position to relative so we hide them with left: -999999px
    
    # Now grab the editor and previewer for later use
    
    # Firefox's <body> gets all fucked up so, to be sure, we need to hardcode it
    
    # Should actually check what mode it's in!
    
    # Keep long lines from being longer than the editor
    
    # FIXME figure out why it needs +2 px
    
    # If there is a file to be opened with that filename and it has content...
    
    # We need to wait until all three iframes are done loading by waiting until the parent
    # iframe's ready state == complete, then we can focus on the contenteditable
    
    # Because IE scrolls the whole window to hash links, we need our own
    # method of scrolling the iframe to an ID from clicking a hash
    
    # Make sure the link is a hash and the link is local to the iframe
    
    # Prevent the whole window from scrolling
    
    # Prevent opening a new window
    
    # Scroll to the matching element, if an element exists
    
    # TODO: Move into fullscreen setup function (_setupFullscreen)
    
    # Set the state of EE in fullscreen
    # We set edit and preview to true also because they're visible
    # we might want to allow fullscreen edit mode without preview (like a "zen" mode)
    
    # Cache calculations
    
    # Without this the scrollbars will get hidden when scrolled to the bottom in faux fullscreen (see #66)
    
    # This MUST come first because the editor is 100% width so if we change the width of the iframe or wrapper
    # the editor's width wont be the same as before
    # Most browsers
    # FF
    # Older IEs
    
    # the previewer
    # Most browsers
    # FF
    # Older IEs
    
    # Setup the containing element CSS for fullscreen
    # Most browsers
    # Firefox
    
    # Should use the base styles background!
    # Try to hide the site below
    
    # The iframe element
    
    # ...Oh, and hide the buttons and prevent scrolling
    
    # We want to always revert back to the original styles in the CSS so,
    # if it's a fluid width container it will expand on resize and not get
    # stuck at a specific width after closing fullscreen.
    
    # Put the editor back in the right state
    # TODO: This is ugly... how do we make this nicer?
    # setting fullscreen to false here prevents the
    # native fs callback from calling this function again
    
    # This setups up live previews by triggering preview() IF in fullscreen on keyup
    
    # Sets up the onclick event on utility buttons
    
    # Sets up the NATIVE fullscreen editor/previewer for WebKit
    
    # TODO: Move utilBar stuff into a utilBar setup function (_setupUtilBar)
    
    # Hide it at first until they move their mouse
    utilBarHandler = (e) ->
      return  if self.settings.button.bar isnt "auto"
      
      # Here we check if the mouse has moves more than 5px in any direction before triggering the mousemove code
      # we do this for 2 reasons:
      # 1. On Mac OS X lion when you scroll and it does the iOS like "jump" when it hits the top/bottom of the page itll fire off
      #    a mousemove of a few pixels depending on how hard you scroll
      # 2. We give a slight buffer to the user in case he barely touches his touchpad or mouse and not trigger the UI
      if Math.abs(mousePos.y - e.pageY) >= 5 or Math.abs(mousePos.x - e.pageX) >= 5
        utilBar.style.display = "block"
        
        # if we have a timer already running, kill it out
        clearTimeout utilBarTimer  if utilBarTimer
        
        # begin a new timer that hides our object after 1000 ms
        utilBarTimer = window.setTimeout(->
          utilBar.style.display = "none"
          return
        , 1000)
      mousePos =
        y: e.pageY
        x: e.pageX

      return
    
    # Add keyboard shortcuts for convenience.
    shortcutHandler = (e) ->
      isMod = true  if e.keyCode is self.settings.shortcut.modifier # check for modifier press(default is alt key), save to var
      isCtrl = true  if e.keyCode is 17 # check for ctrl/cmnd press, in order to catch ctrl/cmnd + s
      
      # Check for alt+p and make sure were not in fullscreen - default shortcut to switch to preview
      if isMod is true and e.keyCode is self.settings.shortcut.preview and not self.is("fullscreen")
        e.preventDefault()
        if self.is("edit") and self._previewEnabled
          self.preview()
        else self.edit()  if self._editEnabled
      
      # Check for alt+f - default shortcut to make editor fullscreen
      if isMod is true and e.keyCode is self.settings.shortcut.fullscreen and self._fullscreenEnabled
        e.preventDefault()
        self._goFullscreen fsElement
      
      # Set the modifier key to false once *any* key combo is completed
      # or else, on Windows, hitting the alt key will lock the isMod state to true (ticket #133)
      isMod = false  if isMod is true and e.keyCode isnt self.settings.shortcut.modifier
      
      # When a user presses "esc", revert everything!
      self._exitFullscreen fsElement  if e.keyCode is 27 and self.is("fullscreen")
      
      # Check for ctrl + s (since a lot of people do it out of habit) and make it do nothing
      if isCtrl is true and e.keyCode is 83
        self.save()
        e.preventDefault()
        isCtrl = false
      
      # Do the same for Mac now (metaKey == cmd).
      if e.metaKey and e.keyCode is 83
        self.save()
        e.preventDefault()
      return
    shortcutUpHandler = (e) ->
      isMod = false  if e.keyCode is self.settings.shortcut.modifier
      isCtrl = false  if e.keyCode is 17
      return
    pasteHandler = (e) ->
      content = undefined
      if e.clipboardData
        
        #FF 22, Webkit, "standards"
        e.preventDefault()
        content = e.clipboardData.getData("text/plain")
        self.editorIframeDocument.execCommand "insertText", false, content
      else if window.clipboardData
        
        #IE, "nasty"
        e.preventDefault()
        content = window.clipboardData.getData("Text")
        content = content.replace(/</g, "&lt;")
        content = content.replace(/>/g, "&gt;")
        content = content.replace(/\n/g, "<br>")
        content = content.replace(/\r/g, "") #fuck you, ie!
        content = content.replace(/<br>\s/g, "<br>&nbsp;")
        content = content.replace(/\s\s\s/g, "&nbsp; &nbsp;")
        content = content.replace(/\s\s/g, "&nbsp; ")
        self.editorIframeDocument.selection.createRange().pasteHTML content
      return
    return this  if @is("loaded")
    self = this
    _HtmlTemplates = undefined
    iframeElement = undefined
    baseTag = undefined
    utilBtns = undefined
    utilBar = undefined
    utilBarTimer = undefined
    keypressTimer = undefined
    mousePos =
      y: -1
      x: -1

    _elementStates = undefined
    _isInEdit = undefined
    nativeFs = false
    nativeFsWebkit = false
    nativeFsMoz = false
    nativeFsW3C = false
    fsElement = undefined
    isMod = false
    isCtrl = false
    eventableIframes = undefined
    i = undefined
    boundAutogrow = undefined
    self._eeState.startup = true
    if self.settings.useNativeFullscreen
      nativeFsWebkit = (if document.body.webkitRequestFullScreen then true else false)
      nativeFsMoz = (if document.body.mozRequestFullScreen then true else false)
      nativeFsW3C = (if document.body.requestFullscreen then true else false)
      nativeFs = nativeFsWebkit or nativeFsMoz or nativeFsW3C
    if _isSafari()
      nativeFs = false
      nativeFsWebkit = false
    self._eeState.edit = true  if not self.is("edit") and not self.is("preview")
    callback = callback or ->

    _HtmlTemplates =
      chrome: "<div id=\"epiceditor-wrapper\" class=\"epiceditor-edit-mode\">" + "<iframe frameborder=\"0\" id=\"epiceditor-editor-frame\"></iframe>" + "<iframe frameborder=\"0\" id=\"epiceditor-previewer-frame\"></iframe>" + "<div id=\"epiceditor-utilbar\">" + ((if self._previewEnabled then "<button title=\"" + @settings.string.togglePreview + "\" class=\"epiceditor-toggle-btn epiceditor-toggle-preview-btn\"></button> " else "")) + ((if self._editEnabled then "<button title=\"" + @settings.string.toggleEdit + "\" class=\"epiceditor-toggle-btn epiceditor-toggle-edit-btn\"></button> " else "")) + ((if self._fullscreenEnabled then "<button title=\"" + @settings.string.toggleFullscreen + "\" class=\"epiceditor-fullscreen-btn\"></button>" else "")) + "</div>" + "</div>"
      previewer: "<div id=\"epiceditor-preview\"></div>"
      editor: "<!doctype HTML>"

    self.element.innerHTML = "<iframe scrolling=\"no\" frameborder=\"0\" id= \"" + self._instanceId + "\"></iframe>"
    self.element.style.height = self.element.offsetHeight + "px"
    iframeElement = document.getElementById(self._instanceId)
    self.iframeElement = iframeElement
    self.iframe = _getIframeInnards(iframeElement)
    self.iframe.open()
    self.iframe.write _HtmlTemplates.chrome
    self.editorIframe = self.iframe.getElementById("epiceditor-editor-frame")
    self.previewerIframe = self.iframe.getElementById("epiceditor-previewer-frame")
    self.editorIframeDocument = _getIframeInnards(self.editorIframe)
    self.editorIframeDocument.open()
    self.editorIframeDocument.write _HtmlTemplates.editor
    self.editorIframeDocument.close()
    self.previewerIframeDocument = _getIframeInnards(self.previewerIframe)
    self.previewerIframeDocument.open()
    self.previewerIframeDocument.write _HtmlTemplates.previewer
    baseTag = self.previewerIframeDocument.createElement("base")
    baseTag.target = "_blank"
    self.previewerIframeDocument.getElementsByTagName("head")[0].appendChild baseTag
    self.previewerIframeDocument.close()
    self.reflow()
    _insertCSSLink self.settings.theme.base, self.iframe, "theme"
    _insertCSSLink self.settings.theme.editor, self.editorIframeDocument, "theme"
    _insertCSSLink self.settings.theme.preview, self.previewerIframeDocument, "theme"
    self.iframe.getElementById("epiceditor-wrapper").style.position = "relative"
    self.editorIframe.style.position = "absolute"
    self.previewerIframe.style.position = "absolute"
    self.editor = self.editorIframeDocument.body
    self.previewer = self.previewerIframeDocument.getElementById("epiceditor-preview")
    self.editor.contentEditable = true
    self.iframe.body.style.height = @element.offsetHeight + "px"
    self.previewerIframe.style.left = "-999999px"
    @editorIframeDocument.body.style.wordWrap = "break-word"
    @previewer.style.height = parseInt(_getStyle(@previewer, "height"), 10) + 2  if _isIE() > -1
    @open self.settings.file.name
    if self.settings.focusOnLoad
      self.iframe.addEventListener "readystatechange", ->
        self.focus()  if self.iframe.readyState is "complete"
        return

    self.previewerIframeDocument.addEventListener "click", (e) ->
      el = e.target
      body = self.previewerIframeDocument.body
      if el.nodeName is "A"
        if el.hash and el.hostname is window.location.hostname
          e.preventDefault()
          el.target = "_self"
          body.scrollTop = body.querySelector(el.hash).offsetTop  if body.querySelector(el.hash)
      return

    utilBtns = self.iframe.getElementById("epiceditor-utilbar")
    _elementStates = {}
    self._goFullscreen = (el) ->
      @_fixScrollbars "auto"
      if self.is("fullscreen")
        self._exitFullscreen el
        return
      if nativeFs
        if nativeFsWebkit
          el.webkitRequestFullScreen()
        else if nativeFsMoz
          el.mozRequestFullScreen()
        else el.requestFullscreen()  if nativeFsW3C
      _isInEdit = self.is("edit")
      self._eeState.fullscreen = true
      self._eeState.edit = true
      self._eeState.preview = true
      windowInnerWidth = window.innerWidth
      windowInnerHeight = window.innerHeight
      windowOuterWidth = window.outerWidth
      windowOuterHeight = window.outerHeight
      windowOuterHeight = window.innerHeight  unless nativeFs
      _elementStates.editorIframe = _saveStyleState(self.editorIframe, "save",
        width: windowOuterWidth / 2 + "px"
        height: windowOuterHeight + "px"
        float: "left"
        cssFloat: "left"
        styleFloat: "left"
        display: "block"
        position: "static"
        left: ""
      )
      _elementStates.previewerIframe = _saveStyleState(self.previewerIframe, "save",
        width: windowOuterWidth / 2 + "px"
        height: windowOuterHeight + "px"
        float: "right"
        cssFloat: "right"
        styleFloat: "right"
        display: "block"
        position: "static"
        left: ""
      )
      _elementStates.element = _saveStyleState(self.element, "save",
        position: "fixed"
        top: "0"
        left: "0"
        width: "100%"
        "z-index": "9999"
        zIndex: "9999"
        border: "none"
        margin: "0"
        background: _getStyle(self.editor, "background-color")
        height: windowInnerHeight + "px"
      )
      _elementStates.iframeElement = _saveStyleState(self.iframeElement, "save",
        width: windowOuterWidth + "px"
        height: windowInnerHeight + "px"
      )
      utilBtns.style.visibility = "hidden"
      document.body.style.overflow = "hidden"  unless nativeFs
      self.preview()
      self.focus()
      self.emit "fullscreenenter"
      return

    self._exitFullscreen = (el) ->
      @_fixScrollbars()
      _saveStyleState self.element, "apply", _elementStates.element
      _saveStyleState self.iframeElement, "apply", _elementStates.iframeElement
      _saveStyleState self.editorIframe, "apply", _elementStates.editorIframe
      _saveStyleState self.previewerIframe, "apply", _elementStates.previewerIframe
      self.element.style.width = (if self._eeState.reflowWidth then self._eeState.reflowWidth else "")
      self.element.style.height = (if self._eeState.reflowHeight then self._eeState.reflowHeight else "")
      utilBtns.style.visibility = "visible"
      self._eeState.fullscreen = false
      unless nativeFs
        document.body.style.overflow = "auto"
      else
        if nativeFsWebkit
          document.webkitCancelFullScreen()
        else if nativeFsMoz
          document.mozCancelFullScreen()
        else document.exitFullscreen()  if nativeFsW3C
      if _isInEdit
        self.edit()
      else
        self.preview()
      self.reflow()
      self.emit "fullscreenexit"
      return

    self.editor.addEventListener "keyup", ->
      window.clearTimeout keypressTimer  if keypressTimer
      keypressTimer = window.setTimeout(->
        self.preview()  if self.is("fullscreen")
        return
      , 250)
      return

    fsElement = self.iframeElement
    utilBtns.addEventListener "click", (e) ->
      targetClass = e.target.className
      if targetClass.indexOf("epiceditor-toggle-preview-btn") > -1
        self.preview()
      else if targetClass.indexOf("epiceditor-toggle-edit-btn") > -1
        self.edit()
      else self._goFullscreen fsElement  if targetClass.indexOf("epiceditor-fullscreen-btn") > -1
      return

    if nativeFsWebkit
      document.addEventListener "webkitfullscreenchange", (->
        self._exitFullscreen fsElement  if not document.webkitIsFullScreen and self._eeState.fullscreen
        return
      ), false
    else if nativeFsMoz
      document.addEventListener "mozfullscreenchange", (->
        self._exitFullscreen fsElement  if not document.mozFullScreen and self._eeState.fullscreen
        return
      ), false
    else if nativeFsW3C
      document.addEventListener "fullscreenchange", (->
        self._exitFullscreen fsElement  if not document.fullscreenElement? and self._eeState.fullscreen
        return
      ), false
    utilBar = self.iframe.getElementById("epiceditor-utilbar")
    utilBar.style.display = "none"  if self.settings.button.bar isnt true
    utilBar.addEventListener "mouseover", ->
      clearTimeout utilBarTimer  if utilBarTimer
      return

    
    # Hide and show the util bar based on mouse movements
    eventableIframes = [
      self.previewerIframeDocument
      self.editorIframeDocument
    ]
    i = 0
    while i < eventableIframes.length
      eventableIframes[i].addEventListener "mousemove", (e) ->
        utilBarHandler e
        return

      eventableIframes[i].addEventListener "scroll", (e) ->
        utilBarHandler e
        return

      eventableIframes[i].addEventListener "keyup", (e) ->
        shortcutUpHandler e
        return

      eventableIframes[i].addEventListener "keydown", (e) ->
        shortcutHandler e
        return

      eventableIframes[i].addEventListener "paste", (e) ->
        pasteHandler e
        return

      i++
    
    # Save the document every 100ms by default
    # TODO: Move into autosave setup function (_setupAutoSave)
    if self.settings.file.autoSave
      self._saveIntervalTimer = window.setInterval(->
        return  unless self._canSave
        self.save false, true
        return
      , self.settings.file.autoSave)
    
    # Update a textarea automatically if a textarea is given so you don't need
    # AJAX to submit a form and instead fall back to normal form behavior
    self._setupTextareaSync()  if self.settings.textarea
    window.addEventListener "resize", ->
      
      # If NOT webkit, and in fullscreen, we need to account for browser resizing
      # we don't care about webkit because you can't resize in webkit's fullscreen
      if self.is("fullscreen")
        _applyStyles self.iframeElement,
          width: window.outerWidth + "px"
          height: window.innerHeight + "px"

        _applyStyles self.element,
          height: window.innerHeight + "px"

        _applyStyles self.previewerIframe,
          width: window.outerWidth / 2 + "px"
          height: window.innerHeight + "px"

        _applyStyles self.editorIframe,
          width: window.outerWidth / 2 + "px"
          height: window.innerHeight + "px"

      
      # Makes the editor support fluid width when not in fullscreen mode
      else self.reflow()  unless self.is("fullscreen")
      return

    
    # Set states before flipping edit and preview modes
    self._eeState.loaded = true
    self._eeState.unloaded = false
    if self.is("preview")
      self.preview()
    else
      self.edit()
    self.iframe.close()
    self._eeState.startup = false
    if self.settings.autogrow
      self._fixScrollbars()
      boundAutogrow = ->
        setTimeout (->
          self._autogrow()
          return
        ), 1
        return

      
      #for if autosave is disabled or very slow
      [
        "keydown"
        "keyup"
        "paste"
        "cut"
      ].forEach (ev) ->
        self.getElement("editor").addEventListener ev, boundAutogrow
        return

      self.on "__update", boundAutogrow
      self.on "edit", ->
        setTimeout boundAutogrow, 50
        return

      self.on "preview", ->
        setTimeout boundAutogrow, 50
        return

      
      #for browsers that have rendering delays
      setTimeout boundAutogrow, 50
      boundAutogrow()
    
    # The callback and call are the same thing, but different ways to access them
    callback.call this
    @emit "load"
    this

  EpicEditor::_setupTextareaSync = ->
    self = this
    textareaFileName = self.settings.file.name
    _syncTextarea = undefined
    
    # Even if autoSave is false, we want to make sure to keep the textarea synced
    # with the editor's content. One bad thing about this tho is that we're
    # creating two timers now in some configurations. We keep the textarea synced
    # by saving and opening the textarea content from the draft file storage.
    self._textareaSaveTimer = window.setInterval(->
      return  unless self._canSave
      self.save true
      return
    , 100)
    _syncTextarea = ->
      
      # TODO: Figure out root cause for having to do this ||.
      # This only happens for draft files. Probably has something to do with
      # the fact draft files haven't been saved by the time this is called.
      # TODO: Add test for this case.
      self._textareaElement.value = self.exportFile(textareaFileName, "text", true) or self.settings.file.defaultContent
      return

    if typeof self.settings.textarea is "string"
      self._textareaElement = document.getElementById(self.settings.textarea)
    else self._textareaElement = self.settings.textarea  if typeof self.settings.textarea is "object"
    
    # On page load, if there's content in the textarea that means one of two
    # different things:
    #
    # 1. The editor didn't load and the user was writing in the textarea and
    # now he refreshed the page or the JS loaded and the textarea now has
    # content. If this is the case the user probably expects his content is
    # moved into the editor and not lose what he typed.
    #
    # 2. The developer put content in the textarea from some server side
    # code. In this case, the textarea will take precedence.
    #
    # If the developer wants drafts to be recoverable they should check if
    # the local file in localStorage's modified date is newer than the server.
    if self._textareaElement.value isnt ""
      self.importFile textareaFileName, self._textareaElement.value
      
      # manually save draft after import so there is no delay between the
      # import and exporting in _syncTextarea. Without this, _syncTextarea
      # will pull the saved data from localStorage which will be <=100ms old.
      self.save true
    
    # Update the textarea on load and pull from drafts
    _syncTextarea()
    
    # Make sure to keep it updated
    self.on "__update", _syncTextarea
    return

  
  ###
  Will NOT focus the editor if the editor is still starting up AND
  focusOnLoad is set to false. This allows you to place this in code that
  gets fired during .load() without worrying about it overriding the user's
  option. For example use cases see preview() and edit().
  @returns {undefined}
  ###
  
  # Prevent focus when the user sets focusOnLoad to false by checking if the
  # editor is starting up AND if focusOnLoad is true
  EpicEditor::_focusExceptOnLoad = ->
    self = this
    self.focus()  if (self._eeState.startup and self.settings.focusOnLoad) or not self._eeState.startup
    return

  
  ###
  Will remove the editor, but not offline files
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::unload = (callback) ->
    
    # Make sure the editor isn't already unloaded.
    throw new Error("Editor isn't loaded")  if @is("unloaded")
    self = this
    editor = window.parent.document.getElementById(self._instanceId)
    editor.parentNode.removeChild editor
    self._eeState.loaded = false
    self._eeState.unloaded = true
    callback = callback or ->

    if self.settings.textarea
      self._textareaElement.value = ""
      self.removeListener "__update"
    window.clearInterval self._saveIntervalTimer  if self._saveIntervalTimer
    window.clearInterval self._textareaSaveTimer  if self._textareaSaveTimer
    callback.call this
    self.emit "unload"
    self

  
  ###
  reflow allows you to dynamically re-fit the editor in the parent without
  having to unload and then reload the editor again.
  
  reflow will also emit a `reflow` event and will return the new dimensions.
  If it's called without params it'll return the new width and height and if
  it's called with just width or just height it'll just return the width or
  height. It's returned as an object like: { width: '100px', height: '1px' }
  
  @param {string|null} kind Can either be 'width' or 'height' or null
  if null, both the height and width will be resized
  @param {function} callback A function to fire after the reflow is finished.
  Will return the width / height in an obj as the first param of the callback.
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::reflow = (kind, callback) ->
    self = this
    widthDiff = _outerWidth(self.element) - self.element.offsetWidth
    heightDiff = _outerHeight(self.element) - self.element.offsetHeight
    elements = [
      self.iframeElement
      self.editorIframe
      self.previewerIframe
    ]
    eventData = {}
    newWidth = undefined
    newHeight = undefined
    if typeof kind is "function"
      callback = kind
      kind = null
    callback = ->  unless callback
    x = 0

    while x < elements.length
      if not kind or kind is "width"
        newWidth = self.element.offsetWidth - widthDiff + "px"
        elements[x].style.width = newWidth
        self._eeState.reflowWidth = newWidth
        eventData.width = newWidth
      if not kind or kind is "height"
        newHeight = self.element.offsetHeight - heightDiff + "px"
        elements[x].style.height = newHeight
        self._eeState.reflowHeight = newHeight
        eventData.height = newHeight
      x++
    self.emit "reflow", eventData
    callback.call this, eventData
    self

  
  ###
  Will take the markdown and generate a preview view based on the theme
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::preview = ->
    self = this
    x = undefined
    theme = self.settings.theme.preview
    anchors = undefined
    _replaceClass self.getElement("wrapper"), "epiceditor-edit-mode", "epiceditor-preview-mode"
    
    # Check if no CSS theme link exists
    unless self.previewerIframeDocument.getElementById("theme")
      _insertCSSLink theme, self.previewerIframeDocument, "theme"
    else self.previewerIframeDocument.getElementById("theme").href = theme  if self.previewerIframeDocument.getElementById("theme").name isnt theme
    
    # Save a preview draft since it might not be saved to the real file yet
    self.save true
    
    # Add the generated draft HTML into the previewer
    self.previewer.innerHTML = self.exportFile(null, "html", true)
    
    # Hide the editor and display the previewer
    unless self.is("fullscreen")
      self.editorIframe.style.left = "-999999px"
      self.previewerIframe.style.left = ""
      self._eeState.preview = true
      self._eeState.edit = false
      self._focusExceptOnLoad()
    self.emit "preview"
    self

  
  ###
  Helper to focus on the editor iframe. Will figure out which iframe to
  focus on based on which one is active and will handle the cross browser
  issues with focusing on the iframe vs the document body.
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::focus = (pageload) ->
    self = this
    isPreview = self.is("preview")
    focusElement = (if isPreview then self.previewerIframeDocument.body else self.editorIframeDocument.body)
    focusElement = self.previewerIframe  if _isFirefox() and isPreview
    focusElement.focus()
    this

  
  ###
  Puts the editor into fullscreen mode
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::enterFullscreen = ->
    return this  if @is("fullscreen")
    @_goFullscreen @iframeElement
    this

  
  ###
  Closes fullscreen mode if opened
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::exitFullscreen = ->
    return this  unless @is("fullscreen")
    @_exitFullscreen @iframeElement
    this

  
  ###
  Hides the preview and shows the editor again
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::edit = ->
    self = this
    _replaceClass self.getElement("wrapper"), "epiceditor-preview-mode", "epiceditor-edit-mode"
    self._eeState.preview = false
    self._eeState.edit = true
    self.editorIframe.style.left = ""
    self.previewerIframe.style.left = "-999999px"
    self._focusExceptOnLoad()
    self.emit "edit"
    this

  
  ###
  Grabs a specificed HTML node. Use it as a shortcut to getting the iframe contents
  @param   {String} name The name of the node (can be document, body, editor, previewer, or wrapper)
  @returns {Object|Null}
  ###
  EpicEditor::getElement = (name) ->
    available =
      container: @element
      wrapper: @iframe.getElementById("epiceditor-wrapper")
      wrapperIframe: @iframeElement
      editor: @editorIframeDocument
      editorIframe: @editorIframe
      previewer: @previewerIframeDocument
      previewerIframe: @previewerIframe

    
    # Check that the given string is a possible option and verify the editor isn't unloaded
    # without this, you'd be given a reference to an object that no longer exists in the DOM
    if not available[name] or @is("unloaded")
      null
    else
      available[name]

  
  ###
  Returns a boolean of each "state" of the editor. For example "editor.is('loaded')" // returns true/false
  @param {String} what the state you want to check for
  @returns {Boolean}
  ###
  EpicEditor::is = (what) ->
    self = this
    switch what
      when "loaded"
        self._eeState.loaded
      when "unloaded"
        self._eeState.unloaded
      when "preview"
        self._eeState.preview
      when "edit"
        self._eeState.edit
      when "fullscreen"
        self._eeState.fullscreen
      
      # TODO: This "works", but the tests are saying otherwise. Come back to this
      # and figure out how to fix it.
      # case 'focused':
      #   return document.activeElement == self.iframeElement;
      else
        false

  
  ###
  Opens a file
  @param   {string} name The name of the file you want to open
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::open = (name) ->
    self = this
    defaultContent = self.settings.file.defaultContent
    fileObj = undefined
    name = name or self.settings.file.name
    self.settings.file.name = name
    if @_storage[self.settings.localStorageName]
      fileObj = self.exportFile(name)
      if fileObj isnt `undefined`
        _setText self.editor, fileObj
        self.emit "read"
      else
        _setText self.editor, defaultContent
        self.save() # ensure a save
        self.emit "create"
      self.previewer.innerHTML = self.exportFile(null, "html")
      self.emit "open"
    this

  
  ###
  Saves content for offline use
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::save = (_isPreviewDraft, _isAuto) ->
    self = this
    storage = undefined
    isUpdate = false
    file = self.settings.file.name
    previewDraftName = ""
    data = @_storage[previewDraftName + self.settings.localStorageName]
    content = _getText(@editor)
    previewDraftName = self._previewDraftLocation  if _isPreviewDraft
    
    # This could have been false but since we're manually saving
    # we know it's save to start autoSaving again
    @_canSave = true
    
    # Guard against storage being wiped out without EpicEditor knowing
    # TODO: Emit saving error - storage seems to have been wiped
    if data
      storage = JSON.parse(@_storage[previewDraftName + self.settings.localStorageName])
      
      # If the file doesn't exist we need to create it
      if storage[file] is `undefined`
        storage[file] = self._defaultFileSchema()
      
      # If it does, we need to check if the content is different and
      # if it is, send the update event and update the timestamp
      else if content isnt storage[file].content
        storage[file].modified = new Date()
        isUpdate = true
      
      #don't bother autosaving if the content hasn't actually changed
      else return  if _isAuto
      storage[file].content = content
      @_storage[previewDraftName + self.settings.localStorageName] = JSON.stringify(storage)
      
      # After the content is actually changed, emit update so it emits the updated content
      if isUpdate
        self.emit "update"
        
        # Emit a private update event so it can't get accidentally removed
        self.emit "__update"
      if _isAuto
        @emit "autosave"
      else @emit "save"  unless _isPreviewDraft
    this

  
  ###
  Removes a page
  @param   {string} name The name of the file you want to remove from localStorage
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::remove = (name) ->
    self = this
    s = undefined
    name = name or self.settings.file.name
    
    # If you're trying to delete a page you have open, block saving
    self._canSave = false  if name is self.settings.file.name
    s = JSON.parse(@_storage[self.settings.localStorageName])
    delete s[name]

    @_storage[self.settings.localStorageName] = JSON.stringify(s)
    @emit "remove"
    this

  
  ###
  Renames a file
  @param   {string} oldName The old file name
  @param   {string} newName The new file name
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::rename = (oldName, newName) ->
    self = this
    s = JSON.parse(@_storage[self.settings.localStorageName])
    s[newName] = s[oldName]
    delete s[oldName]

    @_storage[self.settings.localStorageName] = JSON.stringify(s)
    self.open newName
    this

  
  ###
  Imports a file and it's contents and opens it
  @param   {string} name The name of the file you want to import (will overwrite existing files!)
  @param   {string} content Content of the file you want to import
  @param   {string} kind The kind of file you want to import (TBI)
  @param   {object} meta Meta data you want to save with your file.
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::importFile = (name, content, kind, meta) ->
    self = this
    isNew = false
    name = name or self.settings.file.name
    content = content or ""
    kind = kind or "md"
    meta = meta or {}
    isNew = true  if JSON.parse(@_storage[self.settings.localStorageName])[name] is `undefined`
    
    # Set our current file to the new file and update the content
    self.settings.file.name = name
    _setText self.editor, content
    self.emit "create"  if isNew
    self.save()
    self.preview()  if self.is("fullscreen")
    
    #firefox has trouble with importing and working out the size right away
    if self.settings.autogrow
      setTimeout (->
        self._autogrow()
        return
      ), 50
    this

  
  ###
  Gets the local filestore
  @param   {string} name Name of the file in the store
  @returns {object|undefined} the local filestore, or a specific file in the store, if a name is given
  ###
  EpicEditor::_getFileStore = (name, _isPreviewDraft) ->
    previewDraftName = ""
    store = undefined
    previewDraftName = @_previewDraftLocation  if _isPreviewDraft
    store = JSON.parse(@_storage[previewDraftName + @settings.localStorageName])
    if name
      store[name]
    else
      store

  
  ###
  Exports a file as a string in a supported format
  @param   {string} name Name of the file you want to export (case sensitive)
  @param   {string} kind Kind of file you want the content in (currently supports html and text, default is the format the browser "wants")
  @returns {string|undefined}  The content of the file in the content given or undefined if it doesn't exist
  ###
  EpicEditor::exportFile = (name, kind, _isPreviewDraft) ->
    self = this
    file = undefined
    content = undefined
    name = name or self.settings.file.name
    kind = kind or "text"
    file = self._getFileStore(name, _isPreviewDraft)
    
    # If the file doesn't exist just return early with undefined
    return  if file is `undefined`
    content = file.content
    switch kind
      when "html"
        content = _sanitizeRawContent(content)
        self.settings.parser content
      when "text"
        _sanitizeRawContent content
      when "json"
        file.content = _sanitizeRawContent(file.content)
        JSON.stringify file
      when "raw"
        content
      else
        content

  
  ###
  Gets the contents and metadata for files
  @param   {string} name Name of the file whose data you want (case sensitive)
  @param   {boolean} excludeContent whether the contents of files should be excluded
  @returns {object} An object with the names and data of every file, or just the data of one file if a name was given
  ###
  EpicEditor::getFiles = (name, excludeContent) ->
    file = undefined
    data = @_getFileStore(name)
    if name
      if data isnt `undefined`
        if excludeContent
          delete data.content
        else
          data.content = _sanitizeRawContent(data.content)
      data
    else
      for file of data
        if data.hasOwnProperty(file)
          if excludeContent
            delete data[file].content
          else
            data[file].content = _sanitizeRawContent(data[file].content)
      data

  
  # EVENTS
  # TODO: Support for namespacing events like "preview.foo"
  ###
  Sets up an event handler for a specified event
  @param  {string} ev The event name
  @param  {function} handler The callback to run when the event fires
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::on = (ev, handler) ->
    self = this
    @events[ev] = []  unless @events[ev]
    @events[ev].push handler
    self

  
  ###
  This will emit or "trigger" an event specified
  @param  {string} ev The event name
  @param  {any} data Any data you want to pass into the callback
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::emit = (ev, data) ->
    invokeHandler = (handler) ->
      handler.call self, data
      return
    self = this
    x = undefined
    data = data or self.getFiles(self.settings.file.name)
    return  unless @events[ev]
    x = 0
    while x < self.events[ev].length
      invokeHandler self.events[ev][x]
      x++
    self

  
  ###
  Will remove any listeners added from EpicEditor.on()
  @param  {string} ev The event name
  @param  {function} handler Handler to remove
  @returns {object} EpicEditor will be returned
  ###
  EpicEditor::removeListener = (ev, handler) ->
    self = this
    unless handler
      @events[ev] = []
      return self
    return self  unless @events[ev]
    
    # Otherwise a handler and event exist, so take care of it
    @events[ev].splice @events[ev].indexOf(handler), 1
    self

  
  ###
  Handles autogrowing the editor
  ###
  EpicEditor::_autogrow = ->
    editorHeight = undefined
    newHeight = undefined
    minHeight = undefined
    maxHeight = undefined
    el = undefined
    style = undefined
    maxedOut = false
    
    #autogrow in fullscreen is nonsensical
    unless @is("fullscreen")
      if @is("edit")
        el = @getElement("editor").documentElement
      else
        el = @getElement("previewer").documentElement
      editorHeight = _outerHeight(el)
      newHeight = editorHeight
      
      #handle minimum
      minHeight = @settings.autogrow.minHeight
      minHeight = minHeight(this)  if typeof minHeight is "function"
      newHeight = minHeight  if minHeight and newHeight < minHeight
      
      #handle maximum
      maxHeight = @settings.autogrow.maxHeight
      maxHeight = maxHeight(this)  if typeof maxHeight is "function"
      if maxHeight and newHeight > maxHeight
        newHeight = maxHeight
        maxedOut = true
      if maxedOut
        @_fixScrollbars "auto"
      else
        @_fixScrollbars "hidden"
      
      #actual resize
      unless newHeight is @oldHeight
        @getElement("container").style.height = newHeight + "px"
        @reflow()
        window.scrollBy 0, newHeight - @oldHeight  if @settings.autogrow.scroll
        @oldHeight = newHeight
    return

  
  ###
  Shows or hides scrollbars based on the autogrow setting
  @param {string} forceSetting a value to force the overflow to
  ###
  EpicEditor::_fixScrollbars = (forceSetting) ->
    setting = undefined
    if @settings.autogrow
      setting = "hidden"
    else
      setting = "auto"
    setting = forceSetting or setting
    @getElement("editor").documentElement.style.overflow = setting
    @getElement("previewer").documentElement.style.overflow = setting
    return

  EpicEditor.version = "0.2.2"
  
  # Used to store information to be shared across editors
  EpicEditor._data = {}
  window.EpicEditor = EpicEditor
  return
) window

###
marked - a markdown parser
Copyright (c) 2011-2013, Christopher Jeffrey. (MIT Licensed)
https://github.com/chjj/marked
###

###
Block-Level Grammar
###

###
Normal Block Grammar
###

###
GFM Block Grammar
###

###
GFM + Tables Block Grammar
###

###
Block Lexer
###

###
Expose Block Rules
###

###
Static Lex Method
###

###
Preprocessing
###

###
Lexing
###

# newline

# code

# fences (gfm)

# heading

# table no leading pipe (gfm)

# lheading

# hr

# blockquote

# Pass `top` to keep the current
# "toplevel" state. This is exactly
# how markdown.pl works.

# list

# Get each top-level item.

# Remove the list item's bullet
# so it is seen as the next token.

# Outdent whatever the
# list item contains. Hacky.

# Determine whether item is loose or not.
# Use: /(^|\n)(?! )[^\n]+\n\n(?!\s*$)/
# for discount behavior.

# Recurse.

# html

# def

# table (gfm)

# top-level paragraph

# text

# Top-level should never reach here.

###
Inline-Level Grammar
###

###
Normal Inline Grammar
###

###
Pedantic Inline Grammar
###

###
GFM Inline Grammar
###

###
GFM + Line Breaks Inline Grammar
###

###
Inline Lexer & Compiler
###

###
Expose Inline Rules
###

###
Static Lexing/Compiling Method
###

###
Lexing/Compiling
###

# escape

# autolink

# url (gfm)

# tag

# link

# reflink, nolink

# strong

# em

# code

# br

# del (gfm)

# text

###
Compile Link
###

###
Mangle Links
###

###
Parsing & Compiling
###

###
Static Parse Method
###

###
Parse Loop
###

###
Next Token
###

###
Preview Next Token
###

###
Parse Text Tokens
###

###
Parse Current Token
###

# header

# body

###
Helpers
###

###
Marked
###

###
Options
###

###
Expose
###
(->
  Lexer = (options) ->
    @tokens = []
    @tokens.links = {}
    @options = options or marked.defaults
    @rules = block.normal
    if @options.gfm
      if @options.tables
        @rules = block.tables
      else
        @rules = block.gfm
    return
  InlineLexer = (links, options) ->
    @options = options or marked.defaults
    @links = links
    @rules = inline.normal
    throw new Error("Tokens array requires a `links` property.")  unless @links
    if @options.gfm
      if @options.breaks
        @rules = inline.breaks
      else
        @rules = inline.gfm
    else @rules = inline.pedantic  if @options.pedantic
    return
  Parser = (options) ->
    @tokens = []
    @token = null
    @options = options or marked.defaults
    return
  escape = (html, encode) ->
    html.replace((if not encode then /&(?!#?\w+;)/g else /&/g), "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace /'/g, "&#39;"
  replace = (regex, opt) ->
    regex = regex.source
    opt = opt or ""
    self = (name, val) ->
      return new RegExp(regex, opt)  unless name
      val = val.source or val
      val = val.replace(/(^|[^\[])\^/g, "$1")
      regex = regex.replace(name, val)
      self
  noop = ->
  merge = (obj) ->
    i = 1
    target = undefined
    key = undefined
    while i < arguments_.length
      target = arguments_[i]
      for key of target
        obj[key] = target[key]  if Object::hasOwnProperty.call(target, key)
      i++
    obj
  marked = (src, opt) ->
    try
      return Parser.parse(Lexer.lex(src, opt), opt)
    catch e
      e.message += "\nPlease report this to https://github.com/chjj/marked."
      return "An error occured:\n" + e.message  if (opt or marked.defaults).silent
      throw e
    return
  block =
    newline: /^\n+/
    code: /^( {4}[^\n]+\n*)+/
    fences: noop
    hr: /^( *[-*_]){3,} *(?:\n+|$)/
    heading: /^ *(#{1,6}) *([^\n]+?) *#* *(?:\n+|$)/
    nptable: noop
    lheading: /^([^\n]+)\n *(=|-){3,} *\n*/
    blockquote: /^( *>[^\n]+(\n[^\n]+)*\n*)+/
    list: /^( *)(bull) [\s\S]+?(?:hr|\n{2,}(?! )(?!\1bull )\n*|\s*$)/
    html: /^ *(?:comment|closed|closing) *(?:\n{2,}|\s*$)/
    def: /^ *\[([^\]]+)\]: *([^\s]+)(?: +["(]([^\n]+)[")])? *(?:\n+|$)/
    table: noop
    paragraph: /^([^\n]+\n?(?!hr|heading|lheading|blockquote|tag|def))+\n*/
    text: /^[^\n]+/

  block.bullet = /(?:[*+-]|\d+\.)/
  block.item = /^( *)(bull) [^\n]*(?:\n(?!\1bull )[^\n]*)*/
  block.item = replace(block.item, "gm")(/bull/g, block.bullet)()
  block.list = replace(block.list)(/bull/g, block.bullet)("hr", /\n+(?=(?: *[-*_]){3,} *(?:\n+|$))/)()
  block._tag = "(?!(?:" + "a|em|strong|small|s|cite|q|dfn|abbr|data|time|code" + "|var|samp|kbd|sub|sup|i|b|u|mark|ruby|rt|rp|bdi|bdo" + "|span|br|wbr|ins|del|img)\\b)\\w+(?!:/|@)\\b"
  block.html = replace(block.html)("comment", /<!--[\s\S]*?-->/)("closed", /<(tag)[\s\S]+?<\/\1>/)("closing", /<tag(?:"[^"]*"|'[^']*'|[^'">])*?>/)(/tag/g, block._tag)()
  block.paragraph = replace(block.paragraph)("hr", block.hr)("heading", block.heading)("lheading", block.lheading)("blockquote", block.blockquote)("tag", "<" + block._tag)("def", block.def)()
  block.normal = merge({}, block)
  block.gfm = merge({}, block.normal,
    fences: /^ *(`{3,}|~{3,}) *(\w+)? *\n([\s\S]+?)\s*\1 *(?:\n+|$)/
    paragraph: /^/
  )
  block.gfm.paragraph = replace(block.paragraph)("(?!", "(?!" + block.gfm.fences.source.replace("\\1", "\\2") + "|")()
  block.tables = merge({}, block.gfm,
    nptable: /^ *(\S.*\|.*)\n *([-:]+ *\|[-| :]*)\n((?:.*\|.*(?:\n|$))*)\n*/
    table: /^ *\|(.+)\n *\|( *[-:]+[-| :]*)\n((?: *\|.*(?:\n|$))*)\n*/
  )
  Lexer.rules = block
  Lexer.lex = (src, options) ->
    lexer = new Lexer(options)
    lexer.lex src

  Lexer::lex = (src) ->
    src = src.replace(/\r\n|\r/g, "\n").replace(/\t/g, "    ").replace(/\u00a0/g, " ").replace(/\u2424/g, "\n")
    @token src, true

  Lexer::token = (src, top) ->
    src = src.replace(/^ +$/g, "")
    next = undefined
    loose = undefined
    cap = undefined
    item = undefined
    space = undefined
    i = undefined
    l = undefined
    while src
      if cap = @rules.newline.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push type: "space"  if cap[0].length > 1
      if cap = @rules.code.exec(src)
        src = src.substring(cap[0].length)
        cap = cap[0].replace(/^ {4}/g, "")
        @tokens.push
          type: "code"
          text: (if not @options.pedantic then cap.replace(/\n+$/, "") else cap)

        continue
      if cap = @rules.fences.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push
          type: "code"
          lang: cap[2]
          text: cap[3]

        continue
      if cap = @rules.heading.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push
          type: "heading"
          depth: cap[1].length
          text: cap[2]

        continue
      if top and (cap = @rules.nptable.exec(src))
        src = src.substring(cap[0].length)
        item =
          type: "table"
          header: cap[1].replace(/^ *| *\| *$/g, "").split(RegExp(" *\\| *"))
          align: cap[2].replace(/^ *|\| *$/g, "").split(RegExp(" *\\| *"))
          cells: cap[3].replace(/\n$/, "").split("\n")

        i = 0
        while i < item.align.length
          if /^ *-+: *$/.test(item.align[i])
            item.align[i] = "right"
          else if /^ *:-+: *$/.test(item.align[i])
            item.align[i] = "center"
          else if /^ *:-+ *$/.test(item.align[i])
            item.align[i] = "left"
          else
            item.align[i] = null
          i++
        i = 0
        while i < item.cells.length
          item.cells[i] = item.cells[i].split(RegExp(" *\\| *"))
          i++
        @tokens.push item
        continue
      if cap = @rules.lheading.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push
          type: "heading"
          depth: (if cap[2] is "=" then 1 else 2)
          text: cap[1]

        continue
      if cap = @rules.hr.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push type: "hr"
        continue
      if cap = @rules.blockquote.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push type: "blockquote_start"
        cap = cap[0].replace(/^ *> ?/g, "")
        @token cap, top
        @tokens.push type: "blockquote_end"
        continue
      if cap = @rules.list.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push
          type: "list_start"
          ordered: isFinite(cap[2])

        cap = cap[0].match(@rules.item)
        next = false
        l = cap.length
        i = 0
        while i < l
          item = cap[i]
          space = item.length
          item = item.replace(/^ *([*+-]|\d+\.) +/, "")
          if ~item.indexOf("\n ")
            space -= item.length
            item = (if not @options.pedantic then item.replace(new RegExp("^ {1," + space + "}", "gm"), "") else item.replace(/^ {1,4}/g, ""))
          loose = next or /\n\n(?!\s*$)/.test(item)
          if i isnt l - 1
            next = item[item.length - 1] is "\n"
            loose = next  unless loose
          @tokens.push type: (if loose then "loose_item_start" else "list_item_start")
          @token item, false
          @tokens.push type: "list_item_end"
          i++
        @tokens.push type: "list_end"
        continue
      if cap = @rules.html.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push
          type: (if @options.sanitize then "paragraph" else "html")
          pre: cap[1] is "pre"
          text: cap[0]

        continue
      if top and (cap = @rules.def.exec(src))
        src = src.substring(cap[0].length)
        @tokens.links[cap[1].toLowerCase()] =
          href: cap[2]
          title: cap[3]

        continue
      if top and (cap = @rules.table.exec(src))
        src = src.substring(cap[0].length)
        item =
          type: "table"
          header: cap[1].replace(/^ *| *\| *$/g, "").split(RegExp(" *\\| *"))
          align: cap[2].replace(/^ *|\| *$/g, "").split(RegExp(" *\\| *"))
          cells: cap[3].replace(/(?: *\| *)?\n$/, "").split("\n")

        i = 0
        while i < item.align.length
          if /^ *-+: *$/.test(item.align[i])
            item.align[i] = "right"
          else if /^ *:-+: *$/.test(item.align[i])
            item.align[i] = "center"
          else if /^ *:-+ *$/.test(item.align[i])
            item.align[i] = "left"
          else
            item.align[i] = null
          i++
        i = 0
        while i < item.cells.length
          item.cells[i] = item.cells[i].replace(/^ *\| *| *\| *$/g, "").split(RegExp(" *\\| *"))
          i++
        @tokens.push item
        continue
      if top and (cap = @rules.paragraph.exec(src))
        src = src.substring(cap[0].length)
        @tokens.push
          type: "paragraph"
          text: cap[0]

        continue
      if cap = @rules.text.exec(src)
        src = src.substring(cap[0].length)
        @tokens.push
          type: "text"
          text: cap[0]

        continue
      throw new Error("Infinite loop on byte: " + src.charCodeAt(0))  if src
    @tokens

  inline =
    escape: /^\\([\\`*{}\[\]()#+\-.!_>|])/
    autolink: /^<([^ >]+(@|:\/)[^ >]+)>/
    url: noop
    tag: /^<!--[\s\S]*?-->|^<\/?\w+(?:"[^"]*"|'[^']*'|[^'">])*?>/
    link: /^!?\[(inside)\]\(href\)/
    reflink: /^!?\[(inside)\]\s*\[([^\]]*)\]/
    nolink: /^!?\[((?:\[[^\]]*\]|[^\[\]])*)\]/
    strong: /^__([\s\S]+?)__(?!_)|^\*\*([\s\S]+?)\*\*(?!\*)/
    em: /^\b_((?:__|[\s\S])+?)_\b|^\*((?:\*\*|[\s\S])+?)\*(?!\*)/
    code: /^(`+)([\s\S]*?[^`])\1(?!`)/
    br: /^ {2,}\n(?!\s*$)/
    del: noop
    text: /^[\s\S]+?(?=[\\<!\[_*`]| {2,}\n|$)/

  inline._inside = /(?:\[[^\]]*\]|[^\]]|\](?=[^\[]*\]))*/
  inline._href = /\s*<?([^\s]*?)>?(?:\s+['"]([\s\S]*?)['"])?\s*/
  inline.link = replace(inline.link)("inside", inline._inside)("href", inline._href)()
  inline.reflink = replace(inline.reflink)("inside", inline._inside)()
  inline.normal = merge({}, inline)
  inline.pedantic = merge({}, inline.normal,
    strong: /^__(?=\S)([\s\S]*?\S)__(?!_)|^\*\*(?=\S)([\s\S]*?\S)\*\*(?!\*)/
    em: /^_(?=\S)([\s\S]*?\S)_(?!_)|^\*(?=\S)([\s\S]*?\S)\*(?!\*)/
  )
  inline.gfm = merge({}, inline.normal,
    escape: replace(inline.escape)("])", "~])")()
    url: /^(https?:\/\/[^\s]+[^.,:;"')\]\s])/
    del: /^~{2,}([\s\S]+?)~{2,}/
    text: replace(inline.text)("]|", "~]|")("|", "|https?://|")()
  )
  inline.breaks = merge({}, inline.gfm,
    br: replace(inline.br)("{2,}", "*")()
    text: replace(inline.gfm.text)("{2,}", "*")()
  )
  InlineLexer.rules = inline
  InlineLexer.output = (src, links, opt) ->
    inline = new InlineLexer(links, opt)
    inline.output src

  InlineLexer::output = (src) ->
    out = ""
    link = undefined
    text = undefined
    href = undefined
    cap = undefined
    while src
      if cap = @rules.escape.exec(src)
        src = src.substring(cap[0].length)
        out += cap[1]
        continue
      if cap = @rules.autolink.exec(src)
        src = src.substring(cap[0].length)
        if cap[2] is "@"
          text = (if cap[1][6] is ":" then @mangle(cap[1].substring(7)) else @mangle(cap[1]))
          href = @mangle("mailto:") + text
        else
          text = escape(cap[1])
          href = text
        out += "<a href=\"" + href + "\">" + text + "</a>"
        continue
      if cap = @rules.url.exec(src)
        src = src.substring(cap[0].length)
        text = escape(cap[1])
        href = text
        out += "<a href=\"" + href + "\">" + text + "</a>"
        continue
      if cap = @rules.tag.exec(src)
        src = src.substring(cap[0].length)
        out += (if @options.sanitize then escape(cap[0]) else cap[0])
        continue
      if cap = @rules.link.exec(src)
        src = src.substring(cap[0].length)
        out += @outputLink(cap,
          href: cap[2]
          title: cap[3]
        )
        continue
      if (cap = @rules.reflink.exec(src)) or (cap = @rules.nolink.exec(src))
        src = src.substring(cap[0].length)
        link = (cap[2] or cap[1]).replace(/\s+/g, " ")
        link = @links[link.toLowerCase()]
        if not link or not link.href
          out += cap[0][0]
          src = cap[0].substring(1) + src
          continue
        out += @outputLink(cap, link)
        continue
      if cap = @rules.strong.exec(src)
        src = src.substring(cap[0].length)
        out += "<strong>" + @output(cap[2] or cap[1]) + "</strong>"
        continue
      if cap = @rules.em.exec(src)
        src = src.substring(cap[0].length)
        out += "<em>" + @output(cap[2] or cap[1]) + "</em>"
        continue
      if cap = @rules.code.exec(src)
        src = src.substring(cap[0].length)
        out += "<code>" + escape(cap[2], true) + "</code>"
        continue
      if cap = @rules.br.exec(src)
        src = src.substring(cap[0].length)
        out += "<br>"
        continue
      if cap = @rules.del.exec(src)
        src = src.substring(cap[0].length)
        out += "<del>" + @output(cap[1]) + "</del>"
        continue
      if cap = @rules.text.exec(src)
        src = src.substring(cap[0].length)
        out += escape(cap[0])
        continue
      throw new Error("Infinite loop on byte: " + src.charCodeAt(0))  if src
    out

  InlineLexer::outputLink = (cap, link) ->
    if cap[0][0] isnt "!"
      "<a href=\"" + escape(link.href) + "\"" + ((if link.title then " title=\"" + escape(link.title) + "\"" else "")) + ">" + @output(cap[1]) + "</a>"
    else
      "<img src=\"" + escape(link.href) + "\" alt=\"" + escape(cap[1]) + "\"" + ((if link.title then " title=\"" + escape(link.title) + "\"" else "")) + ">"

  InlineLexer::mangle = (text) ->
    out = ""
    l = text.length
    i = 0
    ch = undefined
    while i < l
      ch = text.charCodeAt(i)
      ch = "x" + ch.toString(16)  if Math.random() > 0.5
      out += "&#" + ch + ";"
      i++
    out

  Parser.parse = (src, options) ->
    parser = new Parser(options)
    parser.parse src

  Parser::parse = (src) ->
    @inline = new InlineLexer(src.links, @options)
    @tokens = src.reverse()
    out = ""
    out += @tok()  while @next()
    out

  Parser::next = ->
    @token = @tokens.pop()

  Parser::peek = ->
    @tokens[@tokens.length - 1] or 0

  Parser::parseText = ->
    body = @token.text
    body += "\n" + @next().text  while @peek().type is "text"
    @inline.output body

  Parser::tok = ->
    switch @token.type
      when "space"
        ""
      when "hr"
        "<hr>\n"
      when "heading"
        "<h" + @token.depth + ">" + @inline.output(@token.text) + "</h" + @token.depth + ">\n"
      when "code"
        if @options.highlight
          code = @options.highlight(@token.text, @token.lang)
          if code? and code isnt @token.text
            @token.escaped = true
            @token.text = code
        @token.text = escape(@token.text, true)  unless @token.escaped
        "<pre><code" + ((if @token.lang then " class=\"lang-" + @token.lang + "\"" else "")) + ">" + @token.text + "</code></pre>\n"
      when "table"
        body = ""
        heading = undefined
        i = undefined
        row = undefined
        cell = undefined
        j = undefined
        body += "<thead>\n<tr>\n"
        i = 0
        while i < @token.header.length
          heading = @inline.output(@token.header[i])
          body += (if @token.align[i] then "<th align=\"" + @token.align[i] + "\">" + heading + "</th>\n" else "<th>" + heading + "</th>\n")
          i++
        body += "</tr>\n</thead>\n"
        body += "<tbody>\n"
        i = 0
        while i < @token.cells.length
          row = @token.cells[i]
          body += "<tr>\n"
          j = 0
          while j < row.length
            cell = @inline.output(row[j])
            body += (if @token.align[j] then "<td align=\"" + @token.align[j] + "\">" + cell + "</td>\n" else "<td>" + cell + "</td>\n")
            j++
          body += "</tr>\n"
          i++
        body += "</tbody>\n"
        "<table>\n" + body + "</table>\n"
      when "blockquote_start"
        body = ""
        body += @tok()  while @next().type isnt "blockquote_end"
        "<blockquote>\n" + body + "</blockquote>\n"
      when "list_start"
        type = (if @token.ordered then "ol" else "ul")
        body = ""
        body += @tok()  while @next().type isnt "list_end"
        "<" + type + ">\n" + body + "</" + type + ">\n"
      when "list_item_start"
        body = ""
        body += (if @token.type is "text" then @parseText() else @tok())  while @next().type isnt "list_item_end"
        "<li>" + body + "</li>\n"
      when "loose_item_start"
        body = ""
        body += @tok()  while @next().type isnt "list_item_end"
        "<li>" + body + "</li>\n"
      when "html"
        (if not @token.pre and not @options.pedantic then @inline.output(@token.text) else @token.text)
      when "paragraph"
        "<p>" + @inline.output(@token.text) + "</p>\n"
      when "text"
        "<p>" + @parseText() + "</p>\n"

  noop.exec = noop
  marked.options = marked.setOptions = (opt) ->
    marked.defaults = opt
    marked

  marked.defaults =
    gfm: true
    tables: true
    breaks: false
    pedantic: false
    sanitize: false
    silent: false
    highlight: null

  marked.Parser = Parser
  marked.parser = Parser.parse
  marked.Lexer = Lexer
  marked.lexer = Lexer.lex
  marked.InlineLexer = InlineLexer
  marked.inlineLexer = InlineLexer.output
  marked.parse = marked
  if typeof module isnt "undefined"
    module.exports = marked
  else if typeof define is "function" and define.amd
    define ->
      marked

  else
    @marked = marked
  return
).call ->
  this or ((if typeof window isnt "undefined" then window else global))
()
