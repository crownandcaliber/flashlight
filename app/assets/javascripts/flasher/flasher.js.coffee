jQuery ->
  $.cookie.json = true
  $('<div id="flasher-container"></div>').prependTo 'body'

  $(document).on 'page:load', ->
    $('<div id="flasher-container"></div>').prependTo 'body'

  Flasher.show()

  $(document).on 'ajaxComplete', (event, request) ->
    Flasher.show()

Flasher = (->
  hideFlash = (flash) ->
    flash.slideUp 100, ->
      flash.remove()

  flashMessage = (message, options) ->
    options = $.extend(type: "notice", timeout: 5000, options)

    flash = $("<div class='flasher-wrapper'><div class='flash #{message['type']}'>#{message['message']}</div></div>")
    $("#flasher-container").prepend flash
    flash.hide().delay(300).slideDown 100
    flash.click ->
      hideFlash flash

    setTimeout (->
      hideFlash flash
    ), options.timeout

  getFlashFromCookies = (request) ->
    if flash = $.cookie('flash')
      $.removeCookie('flash');
      flash

  show: ->
    flashMessages = getFlashFromCookies() || []
    $.each flashMessages, (_, message) ->
      flashMessage(type: message[0], message: message[1])

)()


