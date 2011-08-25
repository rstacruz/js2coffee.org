samples =
  js: [
    """
    /* Type here! */

    (function ($) {
        $.fn.highlight = function () {
            $(this).css({ color: 'red', background: 'yellow' });
            $(this).fadeIn();
        };
    })(jQuery);
    """
  ,
    """
    /* Type here! */

    Scope.prototype.find = function(name, options) {
        if (this.check(name, options)) {
            return true;
        }
        
        this.add(name, 'var');
        return false;
    }
    """
  ,
    """
    /* Type here! */

    Widget = {
        hide: function() {
            return this.element
              .animate({opacity: 0.0, top: -10});
        },
        show: function() {
            return this.element
              .animate({opacity: 1.0, top: 0});
        },
        element: $(".widget")
    }
    """
  ]
  coffee: [
    """
    # Type here!

    math =
      root:   Math.sqrt
      square: square
      cube:   (x) -> x * square x

    alert "Three cubed is \#{math.cube 3}"
    """
  ,
    """
    # Type here!

    days =
      monday: 1
      tuesday: 2
      wednesday: 3
      thursday: 4
      friday: 5
      saturday: 6
      sunday: 7
      
    if yesterday is thursday
      today = friday
      we.excited()
      we.have ball: today
    """
  ]

randomFrom = (arr) ->
  arr[parseInt(Math.random() * arr.length)]

# Makes an Ace field out of a given <pre> ID.
#
activate = (id, options) ->
  editor = ace.edit(id)
  s = editor.getSession()

  editor.setTheme "ace/theme/clouds"

  if options.type == "javascript"
    JavaScriptMode = require("ace/mode/javascript").Mode
    editor.getSession().setMode new JavaScriptMode()

  else if options.type == "coffeescript"
    CoffeeMode = require("ace/mode/coffee").Mode
    editor.getSession().setMode new CoffeeMode()

  editor.getSession().setTabSize (options['tabSize'] || 4)
  editor.getSession().setUseSoftTabs true

  editor.renderer.setShowPrintMargin false
  editor.renderer.setHScrollBarAlwaysVisible false
  editor.renderer.setShowGutter false

  editor.setReadOnly true  if options.readonly
  editor.setHighlightActiveLine false  if options.noActiveLine

  editor

activate_js2coffee = ->
  editor = activate("js2coffee_editor", type: "javascript")
  output = activate("js2coffee_output", type: "coffeescript", tabSize: 2, noActiveLine: true)

  onchange = ->
    input = editor.getSession().getValue()

    try
      out = Js2coffee.build(input)
      $("#js2coffee .error").hide()
      output.getSession().setValue out

    catch e
      $("#js2coffee .error").html "#{e}"
      $("#js2coffee .error").show()

  editor.getSession().on "change", onchange
  editor.getSession().setValue randomFrom(samples.js)

  onchange()

coffeejs_is_active = false

activate_coffee2js = ->
  return  if coffeejs_is_active

  coffeejs_is_active = true

  editor = activate("coffee2js_editor", type: "coffeescript", tabSize: 2)
  output = activate("coffee2js_output", type: "javascript", noActiveLine: true)

  onchange = ->
    input = editor.getSession().getValue()

    try
      out = CoffeeScript.compile(input, bare: "on")
      $("#coffee2js .error").hide()
      output.getSession().setValue out

    catch e
      $("#coffee2js .error").html "#{e}"
      $("#coffee2js .error").show()

  editor.getSession().on "change", onchange
  editor.getSession().setValue randomFrom(samples.coffee)

  onchange()

# Tab switcher
#
$("#tabs a").live "click", ->
  target = $(this).attr("href").substr(1)
  $form  = $("form#" + target)

  # Activate the entry field
  $("#editors form").hide()
  $("##{target}").show()
  activate_coffee2js()  if target == 'coffee2js'

  # Text field focus
  $("##{target} .editor textarea").focus()

  # Activate the tab button
  $("#tabs a").removeClass "active"
  $(this).addClass "active"

  false

# Automatically resize the editor panes
$(window).resize ->
  h = $(window).height() - 95
  h = 500  if h < 500

  $("#editors").css height: h
  $("#editors form").css height: h

# The "more info" button
$("p.more-info a").live 'click', ->
  $("body").animate scrollTop: ($("#info").offset().top - 10), 1000

  false

$(window).trigger 'resize'
$ ->
  activate_js2coffee()
  $("#js2coffee .editor textarea").focus()
  $(window).trigger 'resize'
