###
AJAX Upload ( http://valums.com/ajax-upload/ )
Copyright (c) Andrew Valums
Licensed under the MIT license
###
(->
  
  ###
  Attaches event to a dom element.
  @param {Element} el
  @param type event name
  @param fn callback This refers to the passed element
  ###
  addEvent = (el, type, fn) ->
    if el.addEventListener
      el.addEventListener type, fn, false
    else if el.attachEvent
      el.attachEvent "on" + type, ->
        fn.call el
        return

    else
      throw new Error("not supported or DOM not loaded")
    return
  
  ###
  Attaches resize event to a window, limiting
  number of event fired. Fires only when encounteres
  delay of 100 after series of events.
  
  Some browsers fire event multiple times when resizing
  http://www.quirksmode.org/dom/events/resize.html
  
  @param fn callback This refers to the passed element
  ###
  addResizeEvent = (fn) ->
    timeout = undefined
    addEvent window, "resize", ->
      clearTimeout timeout  if timeout
      timeout = setTimeout(fn, 100)
      return

    return
  
  # Needs more testing, will be rewriten for next version        
  # getOffset function copied from jQuery lib (http://jquery.com/)
  
  # Get Offset using getBoundingClientRect
  # http://ejohn.org/blog/getboundingclientrect-is-awesome/
  # for ie 
  
  # In Internet Explorer 7 getBoundingClientRect property is treated as physical,
  # while others are logical. Make all logical, like in IE8.	
  
  # Get offset adding all offsets 
  
  ###
  Returns left, top, right and bottom properties describing the border-box,
  in pixels, with the top-left relative to the body
  @param {Element} el
  @return {Object} Contains left, top, right,bottom
  ###
  getBox = (el) ->
    left = undefined
    right = undefined
    top = undefined
    bottom = undefined
    offset = getOffset(el)
    left = offset.left
    top = offset.top
    right = left + el.offsetWidth
    bottom = top + el.offsetHeight
    left: left
    right: right
    top: top
    bottom: bottom
  
  ###
  Helper that takes object literal
  and add all properties to element.style
  @param {Element} el
  @param {Object} styles
  ###
  addStyles = (el, styles) ->
    for name of styles
      el.style[name] = styles[name]  if styles.hasOwnProperty(name)
    return
  
  ###
  Function places an absolutely positioned
  element on top of the specified element
  copying position and dimentions.
  @param {Element} from
  @param {Element} to
  ###
  copyLayout = (from, to) ->
    box = getBox(from)
    addStyles to,
      position: "absolute"
      left: box.left + "px"
      top: box.top + "px"
      width: from.offsetWidth + "px"
      height: from.offsetHeight + "px"

    return
  
  ###
  Creates and returns element from html chunk
  Uses innerHTML to create an element
  ###
  
  ###
  Function generates unique id
  @return unique id
  ###
  
  ###
  Get file name from path
  @param {String} file path to file
  @return filename
  ###
  fileFromPath = (file) ->
    file.replace /.*(\/|\\)/, ""
  
  ###
  Get file extension lowercase
  @param {String} file name
  @return file extenstion
  ###
  getExt = (file) ->
    (if (-1 isnt file.indexOf(".")) then file.replace(/.*[.]/, "") else "")
  hasClass = (el, name) ->
    re = new RegExp("\\b" + name + "\\b")
    re.test el.className
  addClass = (el, name) ->
    el.className += " " + name  unless hasClass(el, name)
    return
  removeClass = (el, name) ->
    re = new RegExp("\\b" + name + "\\b")
    el.className = el.className.replace(re, "")
    return
  removeNode = (el) ->
    el.parentNode.removeChild el
    return
  if document.documentElement.getBoundingClientRect
    getOffset = (el) ->
      box = el.getBoundingClientRect()
      doc = el.ownerDocument
      body = doc.body
      docElem = doc.documentElement
      clientTop = docElem.clientTop or body.clientTop or 0
      clientLeft = docElem.clientLeft or body.clientLeft or 0
      zoom = 1
      if body.getBoundingClientRect
        bound = body.getBoundingClientRect()
        zoom = (bound.right - bound.left) / body.clientWidth
      if zoom > 1
        clientTop = 0
        clientLeft = 0
      top = box.top / zoom + (window.pageYOffset or docElem and docElem.scrollTop / zoom or body.scrollTop / zoom) - clientTop
      left = box.left / zoom + (window.pageXOffset or docElem and docElem.scrollLeft / zoom or body.scrollLeft / zoom) - clientLeft
      top: top
      left: left
  else
    getOffset = (el) ->
      top = 0
      left = 0
      loop
        top += el.offsetTop or 0
        left += el.offsetLeft or 0
        el = el.offsetParent
        break unless el
      left: left
      top: top
  toElement = (->
    div = document.createElement("div")
    (html) ->
      div.innerHTML = html
      el = div.firstChild
      div.removeChild el
  )()
  getUID = (->
    id = 0
    ->
      "ValumsAjaxUpload" + id++
  )()
  
  ###
  Easy styling and uploading
  @constructor
  @param button An element you want convert to
  upload button. Tested dimentions up to 500x500px
  @param {Object} options See defaults below.
  ###
  window.AjaxUpload = (button, options) ->
    @_settings =
      
      # Location of the server-side upload script
      action: "upload.php"
      
      # File upload name
      name: "userfile"
      
      # Select & upload multiple files at once FF3.6+, Chrome 4+
      multiple: false
      
      # Additional data to send
      data: {}
      
      # Submit file as soon as it's selected
      autoSubmit: true
      
      # The type of data that you're expecting back from the server.
      # html and xml are detected automatically.
      # Only useful when you are using json data as a response.
      # Set to "json" in that case. 
      responseType: false
      
      # Class applied to button when mouse is hovered
      hoverClass: "hover"
      
      # Class applied to button when button is focused
      focusClass: "focus"
      
      # Class applied to button when AU is disabled
      disabledClass: "disabled"
      
      # When user selects a file, useful with autoSubmit disabled
      # You can return false to cancel upload			
      onChange: (file, extension) ->

      
      # Callback to fire before file is uploaded
      # You can return false to cancel upload
      onSubmit: (file, extension) ->

      
      # Fired when file upload is completed
      # WARNING! DO NOT USE "FALSE" STRING AS A RESPONSE!
      onComplete: (file, response) ->

    
    # Merge the users options with our defaults
    for i of options
      @_settings[i] = options[i]  if options.hasOwnProperty(i)
    
    # button isn't necessary a dom element
    if button.jquery
      
      # jQuery object was passed
      button = button[0]
    else if typeof button is "string"
      
      # If jQuery user passes #elementId don't break it					
      button = button.slice(1)  if /^#.*/.test(button)
      button = document.getElementById(button)
    throw new Error("Please make sure that you're passing a valid element")  if not button or button.nodeType isnt 1
    if button.nodeName.toUpperCase() is "A"
      
      # disable link                       
      addEvent button, "click", (e) ->
        if e and e.preventDefault
          e.preventDefault()
        else window.event.returnValue = false  if window.event
        return

    
    # DOM element
    @_button = button
    
    # DOM element                 
    @_input = null
    
    # If disabled clicking on button won't do anything
    @_disabled = false
    
    # if the button was disabled before refresh if will remain
    # disabled in FireFox, let's fix it
    @enable()
    @_rerouteClicks()
    return

  
  # assigning methods to our class
  AjaxUpload:: =
    setData: (data) ->
      @_settings.data = data
      return

    disable: ->
      addClass @_button, @_settings.disabledClass
      @_disabled = true
      nodeName = @_button.nodeName.toUpperCase()
      @_button.setAttribute "disabled", "disabled"  if nodeName is "INPUT" or nodeName is "BUTTON"
      
      # hide input
      
      # We use visibility instead of display to fix problem with Safari 4
      # The problem is that the value of input doesn't change if it 
      # has display none when user selects a file
      @_input.parentNode.style.visibility = "hidden"  if @_input.parentNode  if @_input
      return

    enable: ->
      removeClass @_button, @_settings.disabledClass
      @_button.removeAttribute "disabled"
      @_disabled = false
      return

    
    ###
    Creates invisible file input
    that will hover above the button
    <div><input type='file' /></div>
    ###
    _createInput: ->
      self = this
      input = document.createElement("input")
      input.setAttribute "type", "file"
      input.setAttribute "name", @_settings.name
      input.setAttribute "multiple", "multiple"  if @_settings.multiple
      addStyles input,
        position: "absolute"
        
        # in Opera only 'browse' button
        # is clickable and it is located at
        # the right side of the input
        right: 0
        margin: 0
        padding: 0
        fontSize: "480px"
        
        # in Firefox if font-family is set to
        # 'inherit' the input doesn't work
        fontFamily: "sans-serif"
        cursor: "pointer"

      div = document.createElement("div")
      addStyles div,
        display: "block"
        position: "absolute"
        overflow: "hidden"
        margin: 0
        padding: 0
        opacity: 0
        
        # Make sure browse button is in the right side
        # in Internet Explorer
        direction: "ltr"
        
        #Max zIndex supported by Opera 9.0-9.2
        zIndex: 2147483583

      
      # Make sure that element opacity exists.
      # Otherwise use IE filter            
      if div.style.opacity isnt "0"
        throw new Error("Opacity not supported by the browser")  if typeof (div.filters) is "undefined"
        div.style.filter = "alpha(opacity=0)"
      addEvent input, "change", ->
        return  if not input or input.value is ""
        
        # Get filename from input, required                
        # as some browsers have path instead of it          
        file = fileFromPath(input.value)
        if false is self._settings.onChange.call(self, file, getExt(file))
          self._clearInput()
          return
        
        # Submit form when value is changed
        self.submit()  if self._settings.autoSubmit
        return

      addEvent input, "mouseover", ->
        addClass self._button, self._settings.hoverClass
        return

      addEvent input, "mouseout", ->
        removeClass self._button, self._settings.hoverClass
        removeClass self._button, self._settings.focusClass
        
        # We use visibility instead of display to fix problem with Safari 4
        # The problem is that the value of input doesn't change if it 
        # has display none when user selects a file
        input.parentNode.style.visibility = "hidden"  if input.parentNode
        return

      addEvent input, "focus", ->
        addClass self._button, self._settings.focusClass
        return

      addEvent input, "blur", ->
        removeClass self._button, self._settings.focusClass
        return

      div.appendChild input
      document.body.appendChild div
      @_input = input
      return

    _clearInput: ->
      return  unless @_input
      
      # this._input.value = ''; Doesn't work in IE6                               
      removeNode @_input.parentNode
      @_input = null
      @_createInput()
      removeClass @_button, @_settings.hoverClass
      removeClass @_button, @_settings.focusClass
      return

    
    ###
    Function makes sure that when user clicks upload button,
    the this._input is clicked instead
    ###
    _rerouteClicks: ->
      self = this
      
      # IE will later display 'access denied' error
      # if you use using self._input.click()
      # other browsers just ignore click()
      addEvent self._button, "mouseover", ->
        return  if self._disabled
        self._createInput()  unless self._input
        div = self._input.parentNode
        copyLayout self._button, div
        div.style.visibility = "visible"
        return

      return

    
    # commented because we now hide input on mouseleave
    ###
    When the window is resized the elements
    can be misaligned if button position depends
    on window size
    ###
    
    #addResizeEvent(function(){
    #    if (self._input){
    #        copyLayout(self._button, self._input.parentNode);
    #    }
    #});            
    
    ###
    Creates iframe with unique name
    @return {Element} iframe
    ###
    _createIframe: ->
      
      # We can't use getTime, because it sometimes return
      # same value in safari :(
      id = getUID()
      
      # We can't use following code as the name attribute
      # won't be properly registered in IE6, and new window
      # on form submit will open
      # var iframe = document.createElement('iframe');
      # iframe.setAttribute('name', id);                        
      iframe = toElement("<iframe src=\"javascript:false;\" name=\"" + id + "\" />")
      
      # src="javascript:false; was added
      # because it possibly removes ie6 prompt 
      # "This page contains both secure and nonsecure items"
      # Anyway, it doesn't do any harm.            
      iframe.setAttribute "id", id
      iframe.style.display = "none"
      document.body.appendChild iframe
      iframe

    
    ###
    Creates form, that will be submitted to iframe
    @param {Element} iframe Where to submit
    @return {Element} form
    ###
    _createForm: (iframe) ->
      settings = @_settings
      
      # We can't use the following code in IE6
      # var form = document.createElement('form');
      # form.setAttribute('method', 'post');
      # form.setAttribute('enctype', 'multipart/form-data');
      # Because in this case file won't be attached to request                    
      form = toElement("<form method=\"post\" enctype=\"multipart/form-data\"></form>")
      form.setAttribute "action", settings.action
      form.setAttribute "target", iframe.name
      form.style.display = "none"
      document.body.appendChild form
      
      # Create hidden input element for each data key
      for prop of settings.data
        if settings.data.hasOwnProperty(prop)
          el = document.createElement("input")
          el.setAttribute "type", "hidden"
          el.setAttribute "name", prop
          el.setAttribute "value", settings.data[prop]
          form.appendChild el
      form

    
    ###
    Gets response from iframe and fires onComplete event when ready
    @param iframe
    @param file Filename to use in onComplete callback
    ###
    _getResponse: (iframe, file) ->
      
      # getting response
      toDeleteFlag = false
      self = this
      settings = @_settings
      addEvent iframe, "load", ->
        # For Safari 
        
        # For FF, IE
        if iframe.src is "javascript:'%3Chtml%3E%3C/html%3E';" or iframe.src is "javascript:'<html></html>';"
          
          # First time around, do not delete.
          # We reload to blank page, so that reloading main page
          # does not re-submit the post.
          if toDeleteFlag
            
            # Fix busy state in FF3
            setTimeout (->
              removeNode iframe
              return
            ), 0
          return
        doc = (if iframe.contentDocument then iframe.contentDocument else window.frames[iframe.id].document)
        
        # fixing Opera 9.26,10.00
        
        # Opera fires load event multiple times
        # Even when the DOM is not ready yet
        # this fix should not affect other browsers
        return  if doc.readyState and doc.readyState isnt "complete"
        
        # fixing Opera 9.64
        
        # In Opera 9.64 event was fired second time
        # when body.innerHTML changed from false 
        # to server response approx. after 1 sec
        return  if doc.body and doc.body.innerHTML is "false"
        response = undefined
        if doc.XMLDocument
          
          # response is a xml document Internet Explorer property
          response = doc.XMLDocument
        else if doc.body
          
          # response is html document or plain text
          response = doc.body.innerHTML
          if settings.responseType and settings.responseType.toLowerCase() is "json"
            
            # If the document was sent as 'application/javascript' or
            # 'text/javascript', then the browser wraps the text in a <pre>
            # tag and performs html encoding on the contents.  In this case,
            # we need to pull the original text content from the text node's
            # nodeValue property to retrieve the unmangled content.
            # Note that IE6 only understands text/html
            if doc.body.firstChild and doc.body.firstChild.nodeName.toUpperCase() is "PRE"
              doc.normalize()
              response = doc.body.firstChild.firstChild.nodeValue
            if response
              response = eval_("(" + response + ")")
            else
              response = {}
        else
          
          # response is a xml document
          response = doc
        settings.onComplete.call self, file, response
        
        # Reload blank page, so that reloading main page
        # does not re-submit the post. Also, remember to
        # delete the frame
        toDeleteFlag = true
        
        # Fix IE mixed content issue
        iframe.src = "javascript:'<html></html>';"
        return

      return

    
    ###
    Upload file contained in this._input
    ###
    submit: ->
      self = this
      settings = @_settings
      return  if not @_input or @_input.value is ""
      file = fileFromPath(@_input.value)
      
      # user returned false to cancel upload
      if false is settings.onSubmit.call(this, file, getExt(file))
        @_clearInput()
        return
      
      # sending request    
      iframe = @_createIframe()
      form = @_createForm(iframe)
      
      # assuming following structure
      # div -> input type='file'
      removeNode @_input.parentNode
      removeClass self._button, self._settings.hoverClass
      removeClass self._button, self._settings.focusClass
      form.appendChild @_input
      form.submit()
      
      # request set, clean up                
      removeNode form
      form = null
      removeNode @_input
      @_input = null
      
      # Get response from iframe and fire onComplete event when ready
      @_getResponse iframe, file
      
      # get ready for next request            
      @_createInput()
      return

  return
)()
