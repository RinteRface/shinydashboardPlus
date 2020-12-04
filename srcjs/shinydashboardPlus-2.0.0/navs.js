// navPills
// ------------------------------------------------------------------
// This code creates an input binding for the navPills component
var navPillsBinding = new Shiny.InputBinding();

$.extend(navPillsBinding, {
  find: function(scope) {
    return $(scope).find(".nav.nav-pills.nav-stacked");
  },
  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var activeItem =
      $(el)
        .find(".active")
        .index() + 1;
    if (activeItem === 0) {
      $(el)
        .children()
        .first()
        .addClass("active");
      activeItem = 1;
    }
    // returns the index of the active item from the R point of view
    return activeItem;
  },

  setValue: function(el, value) {
    $(el)
      .children()
      .eq(value - 1)
      .trigger("click");
  },

  // see updateControlbar
  receiveMessage: function(el, data) {
    this.setValue(el, data);
  },

  subscribe: function(el, callback) {
    $(el).on("click", "li", function(e) {
      if (!$(this).hasClass("active")) {
        $(el)
          .find(".active")
          .removeClass("active");
        $(this).addClass("active");
        callback();
      } else {
        return;
      }
    });
  },

  unsubscribe: function(el) {
    $(el).off(".navPillsBinding");
  }
});

Shiny.inputBindings.register(navPillsBinding, "navPills-input");

