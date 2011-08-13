sample = "/* Type here! */\n\n" +
  "(function ($) {\n" +
  "  $.fn.highlight = function () {\n" +
  "    $(this).css({ color: 'red', background: 'yellow' });\n" +
  "    $(this).fadeIn();\n" +
  "  };\n" +
  "})(jQuery);";

$(function() {
  var $editor = $("#editor");
  var $output = $("#output");

  $editor.live('keydown', function() {
    var self = this;
    window.setTimeout(function() {
      onChange.apply(self);
    }, 50);
  });

  function onChange() {
    var input = $(this).val();

    try {
      var out = Js2coffee.build(input);
      $("#error").hide();
      $output.val(out);
    }
    catch (e) {
      $("#error").html(e.toString());;
      $("#error").show();
    }
  };

  $editor.val(sample);
  onChange.apply($editor);
});
