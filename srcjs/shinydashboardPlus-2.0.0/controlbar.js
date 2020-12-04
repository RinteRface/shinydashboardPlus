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
      // this depends on the overlay value. If overlay, the sidebar will have the class.
      // If overlay is false, the body will have the class.
      return (
        $("body").hasClass("control-sidebar-open") ||
        $(el).hasClass("control-sidebar-open")
      );
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

  var controlbarChange = function() {
    // 1) Trigger the resize event (so images are responsive and resize)
    $(window).trigger("resize");
  };

  // Whenever the right sidebar (controlbar) finishes a transition (which it does every time it
  // changes from collapsed to expanded and vice versa), call controlbarChange()
  $(".control-sidebar").on(
    "webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend",
    controlbarChange
  );

  // this step is to overwrite global adminLTE options
  // to set the controlbar slide value
  var overlay = $(".control-sidebar").attr("data-overlay") === "true";
  $.AdminLTE.options.controlSidebarOptions.slide = overlay;

  // toggle controlbar at start
  var controlbarCollapsed = $(".control-sidebar").attr("data-collapsed");
  if (controlbarCollapsed === "false") {
    // this depends on the overlay value. If overlay, the sidebar will have the class.
    // If overlay is false, the body will have the class.
    if (overlay) {
      $(".control-sidebar").addClass("control-sidebar-open");
    } else {
      $("body").addClass("control-sidebar-open");
    }
  }

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

