(($, undefined_) ->
  
  ###
  Unobtrusive scripting adapter for jQuery
  https://github.com/rails/jquery-ujs
  
  Requires jQuery 1.7.0 or later.
  
  Released under the MIT license
  ###
  
  # Cut down on the number of issues from people inadvertently including jquery_ujs twice
  # by detecting and raising an error when it happens.
  $.error "jquery-ujs has already been loaded!"  if $.rails isnt `undefined`
  
  # Shorthand to make it a little easier to call public rails functions from within rails.js
  rails = undefined
  $document = $(document)
  $.rails = rails =
    
    # Link elements bound by jquery-ujs
    linkClickSelector: "a[data-confirm], a[data-method], a[data-remote], a[data-disable-with]"
    
    # Button elements bound by jquery-ujs
    buttonClickSelector: "button[data-remote]"
    
    # Select elements bound by jquery-ujs
    inputChangeSelector: "select[data-remote], input[data-remote], textarea[data-remote]"
    
    # Form elements bound by jquery-ujs
    formSubmitSelector: "form"
    
    # Form input elements bound by jquery-ujs
    formInputClickSelector: "form input[type=submit], form input[type=image], form button[type=submit], form button:not([type])"
    
    # Form input elements disabled during form submission
    disableSelector: "input[data-disable-with], button[data-disable-with], textarea[data-disable-with]"
    
    # Form input elements re-enabled after form submission
    enableSelector: "input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled"
    
    # Form required input elements
    requiredInputSelector: "input[name][required]:not([disabled]),textarea[name][required]:not([disabled])"
    
    # Form file input elements
    fileInputSelector: "input[type=file]"
    
    # Link onClick disable selector with possible reenable after remote submission
    linkDisableSelector: "a[data-disable-with]"
    
    # Make sure that every Ajax request sends the CSRF token
    CSRFProtection: (xhr) ->
      token = $("meta[name=\"csrf-token\"]").attr("content")
      xhr.setRequestHeader "X-CSRF-Token", token  if token
      return

    
    # making sure that all forms have actual up-to-date token(cached forms contain old one)
    refreshCSRFTokens: ->
      csrfToken = $("meta[name=csrf-token]").attr("content")
      csrfParam = $("meta[name=csrf-param]").attr("content")
      $("form input[name=\"" + csrfParam + "\"]").val csrfToken
      return

    
    # Triggers an event on an element and returns false if the event result is false
    fire: (obj, name, data) ->
      event = $.Event(name)
      obj.trigger event, data
      event.result isnt false

    
    # Default confirm dialog, may be overridden with custom confirm dialog in $.rails.confirm
    confirm: (message) ->
      confirm message

    
    # Default ajax function, may be overridden with custom function in $.rails.ajax
    ajax: (options) ->
      $.ajax options

    
    # Default way to get an element's href. May be overridden at $.rails.href.
    href: (element) ->
      element.attr "href"

    
    # Submits "remote" forms and links with ajax
    handleRemote: (element) ->
      method = undefined
      url = undefined
      data = undefined
      elCrossDomain = undefined
      crossDomain = undefined
      withCredentials = undefined
      dataType = undefined
      options = undefined
      if rails.fire(element, "ajax:before")
        elCrossDomain = element.data("cross-domain")
        crossDomain = (if elCrossDomain is `undefined` then null else elCrossDomain)
        withCredentials = element.data("with-credentials") or null
        dataType = element.data("type") or ($.ajaxSettings and $.ajaxSettings.dataType)
        if element.is("form")
          method = element.attr("method")
          url = element.attr("action")
          data = element.serializeArray()
          
          # memoized value from clicked submit button
          button = element.data("ujs:submit-button")
          if button
            data.push button
            element.data "ujs:submit-button", null
        else if element.is(rails.inputChangeSelector)
          method = element.data("method")
          url = element.data("url")
          data = element.serialize()
          data = data + "&" + element.data("params")  if element.data("params")
        else if element.is(rails.buttonClickSelector)
          method = element.data("method") or "get"
          url = element.data("url")
          data = element.serialize()
          data = data + "&" + element.data("params")  if element.data("params")
        else
          method = element.data("method")
          url = rails.href(element)
          data = element.data("params") or null
        options =
          type: method or "GET"
          data: data
          dataType: dataType
          
          # stopping the "ajax:beforeSend" event will cancel the ajax request
          beforeSend: (xhr, settings) ->
            xhr.setRequestHeader "accept", "*/*;q=0.5, " + settings.accepts.script  if settings.dataType is `undefined`
            rails.fire element, "ajax:beforeSend", [
              xhr
              settings
            ]

          success: (data, status, xhr) ->
            element.trigger "ajax:success", [
              data
              status
              xhr
            ]
            return

          complete: (xhr, status) ->
            element.trigger "ajax:complete", [
              xhr
              status
            ]
            return

          error: (xhr, status, error) ->
            element.trigger "ajax:error", [
              xhr
              status
              error
            ]
            return

          crossDomain: crossDomain

        
        # There is no withCredentials for IE6-8 when
        # "Enable native XMLHTTP support" is disabled
        options.xhrFields = withCredentials: withCredentials  if withCredentials
        
        # Only pass url to `ajax` options if not blank
        options.url = url  if url
        jqxhr = rails.ajax(options)
        element.trigger "ajax:send", jqxhr
        jqxhr
      else
        false

    
    # Handles "data-method" on links such as:
    # <a href="/users/5" data-method="delete" rel="nofollow" data-confirm="Are you sure?">Delete</a>
    handleMethod: (link) ->
      href = rails.href(link)
      method = link.data("method")
      target = link.attr("target")
      csrfToken = $("meta[name=csrf-token]").attr("content")
      csrfParam = $("meta[name=csrf-param]").attr("content")
      form = $("<form method=\"post\" action=\"" + href + "\"></form>")
      metadataInput = "<input name=\"_method\" value=\"" + method + "\" type=\"hidden\" />"
      metadataInput += "<input name=\"" + csrfParam + "\" value=\"" + csrfToken + "\" type=\"hidden\" />"  if csrfParam isnt `undefined` and csrfToken isnt `undefined`
      form.attr "target", target  if target
      form.hide().append(metadataInput).appendTo "body"
      form.submit()
      return

    
    # Disables form elements:
    #      - Caches element value in 'ujs:enable-with' data store
    #      - Replaces element text with value of 'data-disable-with' attribute
    #      - Sets disabled property to true
    #    
    disableFormElements: (form) ->
      form.find(rails.disableSelector).each ->
        element = $(this)
        method = (if element.is("button") then "html" else "val")
        element.data "ujs:enable-with", element[method]()
        element[method] element.data("disable-with")
        element.prop "disabled", true
        return

      return

    
    # Re-enables disabled form elements:
    #      - Replaces element text with cached value from 'ujs:enable-with' data store (created in `disableFormElements`)
    #      - Sets disabled property to false
    #    
    enableFormElements: (form) ->
      form.find(rails.enableSelector).each ->
        element = $(this)
        method = (if element.is("button") then "html" else "val")
        element[method] element.data("ujs:enable-with")  if element.data("ujs:enable-with")
        element.prop "disabled", false
        return

      return

    
    # For 'data-confirm' attribute:
    #      - Fires `confirm` event
    #      - Shows the confirmation dialog
    #      - Fires the `confirm:complete` event
    #
    #      Returns `true` if no function stops the chain and user chose yes; `false` otherwise.
    #      Attaching a handler to the element's `confirm` event that returns a `falsy` value cancels the confirmation dialog.
    #      Attaching a handler to the element's `confirm:complete` event that returns a `falsy` value makes this function
    #      return false. The `confirm:complete` event is fired whether or not the user answered true or false to the dialog.
    #   
    allowAction: (element) ->
      message = element.data("confirm")
      answer = false
      callback = undefined
      return true  unless message
      if rails.fire(element, "confirm")
        answer = rails.confirm(message)
        callback = rails.fire(element, "confirm:complete", [answer])
      answer and callback

    
    # Helper function which checks for blank inputs in a form that match the specified CSS selector
    blankInputs: (form, specifiedSelector, nonBlank) ->
      inputs = $()
      input = undefined
      valueToCheck = undefined
      selector = specifiedSelector or "input,textarea"
      allInputs = form.find(selector)
      allInputs.each ->
        input = $(this)
        valueToCheck = (if input.is("input[type=checkbox],input[type=radio]") then input.is(":checked") else input.val())
        
        # If nonBlank and valueToCheck are both truthy, or nonBlank and valueToCheck are both falsey
        if not valueToCheck is not nonBlank
          
          # Don't count unchecked required radio if other radio with same name is checked
          return true  if input.is("input[type=radio]") and allInputs.filter("input[type=radio]:checked[name=\"" + input.attr("name") + "\"]").length # Skip to next input
          inputs = inputs.add(input)
        return

      (if inputs.length then inputs else false)

    
    # Helper function which checks for non-blank inputs in a form that match the specified CSS selector
    nonBlankInputs: (form, specifiedSelector) ->
      rails.blankInputs form, specifiedSelector, true # true specifies nonBlank

    
    # Helper function, needed to provide consistent behavior in IE
    stopEverything: (e) ->
      $(e.target).trigger "ujs:everythingStopped"
      e.stopImmediatePropagation()
      false

    
    #  replace element's html with the 'data-disable-with' after storing original html
    #  and prevent clicking on it
    disableElement: (element) ->
      element.data "ujs:enable-with", element.html() # store enabled state
      element.html element.data("disable-with") # set to disabled state
      element.bind "click.railsDisable", (e) -> # prevent further clicking
        rails.stopEverything e

      return

    
    # restore element to its original state which was disabled by 'disableElement' above
    enableElement: (element) ->
      if element.data("ujs:enable-with") isnt `undefined`
        element.html element.data("ujs:enable-with") # set to old enabled state
        element.removeData "ujs:enable-with" # clean up cache
      element.unbind "click.railsDisable" # enable element
      return

  if rails.fire($document, "rails:attachBindings")
    $.ajaxPrefilter (options, originalOptions, xhr) ->
      rails.CSRFProtection xhr  unless options.crossDomain
      return

    $document.delegate rails.linkDisableSelector, "ajax:complete", ->
      rails.enableElement $(this)
      return

    $document.delegate rails.linkClickSelector, "click.rails", (e) ->
      link = $(this)
      method = link.data("method")
      data = link.data("params")
      metaClick = e.metaKey or e.ctrlKey
      return rails.stopEverything(e)  unless rails.allowAction(link)
      rails.disableElement link  if not metaClick and link.is(rails.linkDisableSelector)
      if link.data("remote") isnt `undefined`
        return true  if metaClick and (not method or method is "GET") and not data
        handleRemote = rails.handleRemote(link)
        
        # response from rails.handleRemote() will either be false or a deferred object promise.
        if handleRemote is false
          rails.enableElement link
        else
          handleRemote.error ->
            rails.enableElement link
            return

        false
      else if link.data("method")
        rails.handleMethod link
        false

    $document.delegate rails.buttonClickSelector, "click.rails", (e) ->
      button = $(this)
      return rails.stopEverything(e)  unless rails.allowAction(button)
      rails.handleRemote button
      false

    $document.delegate rails.inputChangeSelector, "change.rails", (e) ->
      link = $(this)
      return rails.stopEverything(e)  unless rails.allowAction(link)
      rails.handleRemote link
      false

    $document.delegate rails.formSubmitSelector, "submit.rails", (e) ->
      form = $(this)
      remote = form.data("remote") isnt `undefined`
      blankRequiredInputs = rails.blankInputs(form, rails.requiredInputSelector)
      nonBlankFileInputs = rails.nonBlankInputs(form, rails.fileInputSelector)
      return rails.stopEverything(e)  unless rails.allowAction(form)
      
      # skip other logic when required values are missing or file upload is present
      return rails.stopEverything(e)  if blankRequiredInputs and form.attr("novalidate") is `undefined` and rails.fire(form, "ajax:aborted:required", [blankRequiredInputs])
      if remote
        if nonBlankFileInputs
          
          # slight timeout so that the submit button gets properly serialized
          # (make it easy for event handler to serialize form without disabled values)
          setTimeout (->
            rails.disableFormElements form
            return
          ), 13
          aborted = rails.fire(form, "ajax:aborted:file", [nonBlankFileInputs])
          
          # re-enable form elements if event bindings return false (canceling normal form submission)
          unless aborted
            setTimeout (->
              rails.enableFormElements form
              return
            ), 13
          return aborted
        rails.handleRemote form
        false
      else
        
        # slight timeout so that the submit button gets properly serialized
        setTimeout (->
          rails.disableFormElements form
          return
        ), 13
      return

    $document.delegate rails.formInputClickSelector, "click.rails", (event) ->
      button = $(this)
      return rails.stopEverything(event)  unless rails.allowAction(button)
      
      # register the pressed submit button
      name = button.attr("name")
      data = (if name then
        name: name
        value: button.val()
       else null)
      button.closest("form").data "ujs:submit-button", data
      return

    $document.delegate rails.formSubmitSelector, "ajax:beforeSend.rails", (event) ->
      rails.disableFormElements $(this)  if this is event.target
      return

    $document.delegate rails.formSubmitSelector, "ajax:complete.rails", (event) ->
      rails.enableFormElements $(this)  if this is event.target
      return

    $ ->
      rails.refreshCSRFTokens()
      return

  return
) jQuery
