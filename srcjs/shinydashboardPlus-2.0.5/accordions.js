// accordion
// ------------------------------------------------------------------
// This code creates an input binding for the accordion component
var accordionBinding = new Shiny.InputBinding();

$.extend(accordionBinding, {
  find: function(scope) {
    return $(scope).find(".box-group.accordion");
  },
  // Given the DOM element for the input, return the value
  getValue: function(el) {
    // active is given by the setValue method
    var activeItem =
      $(el)
        .find(".active")
        .index() + 1;
    if (activeItem === 0) return;
    // returns the index of the active item from the R point of view. It is possible
    // that no item is shown at start. In this case,  NULL is returned
    return activeItem;
  },

  setValue: function(el, value) {
    // remove active class from all other panels
    $(el)
      .find(".active")
      .removeClass("active");

    // add active class to current panel
    $(el)
      .children()
      .eq(value - 1)
      .addClass("active");

    // click on the header to trigger a collapse
    $(el)
      .children()
      .eq(value - 1)
      .find('[data-toggle="collapse"]')
      .click();

    // trigger change to tell Shiny to update the value
    $(el).trigger("change");
  },

  // see updateAccordion
  receiveMessage: function(el, data) {
    this.setValue(el, data);
  },

  subscribe: function(el, callback) {
    // cf setValue
    $(el).on("change", function(e) {
      callback();
    });

    // manual click will update
    $(el)
      .find('[data-toggle="collapse"]')
      .on("click", function(e) {
        if (
          !$(this)
            .closest(".panel")
            .hasClass("active")
        ) {
          $(el)
            .find(".active")
            .removeClass("active");
        }
        $(this)
          .closest(".panel")
          .addClass("active");
        callback();
      });
  },

  unsubscribe: function(el) {
    $(el).off(".accordionBinding");
  }
});

Shiny.inputBindings.register(accordionBinding, "accordion-input");

