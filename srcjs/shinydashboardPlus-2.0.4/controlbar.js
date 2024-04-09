$(function() {
  // boxSidebarBinding
  // ------------------------------------------------------------------
  // This code creates an input binding for the dashboard controlbar component
  var controlbarBinding = new Shiny.InputBinding();

  $.extend(controlbarBinding, {
    find: function(scope) {
      return $(scope).find(".control-sidebar");
    },

    // Given the DOM element for the input, return the value
    getValue: function(el) {
      // this handles the case where the controlbar is not collapsed at start
      var controlbarCollapsed = $(el).attr('data-collapsed');
      var overlay = $(".control-sidebar").attr("data-overlay") === "true";
      // We have to overwrite the existing options by the user provided.
      $.AdminLTE.options.controlSidebarOptions.slide = overlay;
      if (controlbarCollapsed === "false") {
        $("[data-toggle='control-sidebar']").click();
        $(el).attr('data-collapsed', "true");
        return true;
      } else {
        if (!overlay) {
          return $("body").hasClass("control-sidebar-open"); 
        } else {
          return $(el).hasClass("control-sidebar-open");
        }
      }
    },

    // see updateControlbar
    receiveMessage: function(el, data) {
      $("[data-toggle='control-sidebar']").click();
    },

    subscribe: function(el, callback) {
      $("[data-toggle='control-sidebar']").on("click", function(e) {
        callback();
      });
    },

    unsubscribe: function(el) {
      $(el).off(".controlbarBinding");
    }
  });

  Shiny.inputBindings.register(controlbarBinding, "controlbar-input");

  // This prevent box content from going outside their container 
  // when the control-bar is on push mode
  $("[data-toggle='control-sidebar']").on("click",
    function() {
      if (!$.AdminLTE.options.controlSidebarOptions.slide) {
        $(window).trigger("resize"); 
      }
  });

  // hide the right sidebar toggle
  // if no right sidebar is specified
  var noControlbar = $(".control-sidebar").length === 0;
  if (noControlbar) {
    $("[data-toggle='control-sidebar']").hide();
  }

  // hide the right sidebar toggle if the controlbar is disable
  var disableControlbar = $(".control-sidebar").attr("data-show");
  if (disableControlbar === "false") {
    $("[data-toggle='control-sidebar']").hide();
  }
});

