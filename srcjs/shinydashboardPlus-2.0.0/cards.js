// boxBinding
// ------------------------------------------------------------------
// This code creates an input binding for the boxPlus component
var boxBinding = new Shiny.InputBinding();
$.extend(boxBinding, {
  find: function(scope) {
    return $(scope).find(".box");
  },
  getValue: function(el) {
    var config = $(el)
      .parent()
      .find("script[data-for='" + el.id + "']");
    config = JSON.parse(config.html());

    var isCollapsed = $(el).hasClass("collapsed-box");
    var display = $(el).css("display");

    var visible;
    if (display === "none") {
      visible = false;
    } else {
      visible = true;
    }
    return {
      collapsible: config.collapsible,
      collapsed: isCollapsed,
      closable: config.closable,
      visible: visible,
      status: config.status,
      solidHeader: config.solidHeader,
      background: config.background,
      width: config.width,
      height: config.height
    }; // this will be a list in R
  },
  _updateWidth: function(el, o, n) {
    $(el)
      .parent()
      .toggleClass("col-sm-" + o);
    $(el)
      .parent()
      .addClass("col-sm-" + n);
    // trigger resize so that output resize
    $(el).trigger("resize");
  },
  setValue: function(el, value) {
    var config = $(el)
      .parent()
      .find("script[data-for='" + el.id + "']");
    config = JSON.parse(config.html());

    if (value.action === "update") {
      var isUserCard = $(el).hasClass("user-card");
      var isSocialCard = $(el).hasClass("social-card");

      // handle HTML tags (harder)
      if (value.options.hasOwnProperty("title")) {
        if (value.options.title !== config.title) {
          var newTitle = $.parseHTML(value.options.title);
          var tools = $(el).find(".box-tools");
          if (value.options.status !== config.status) {
            var btns = $(tools).find(".btn");
            // remove any existing background
            $(btns).removeClass("btn-" + config.status);
            // apply new background
            if (config.background != null) {
              $(btns)
                .find(".btn")
                .addClass("btn-" + config.background);
            }
          }
          // social box
          if (isSocialCard) {
            $(el)
              .find(".user-block")
              .replaceWith($(newTitle));
          } else if (isUserCard) {
            // handle 2 cards types
            if (newTitle.length === 3) {
              // don't take newTitle[1] (contains some text)
              newTitle = [newTitle[0], newTitle[2]];
              // change widget-use class
              $(el)
                .removeClass("widget-user-2")
                .addClass("widget-user");
              // insert header and image after
              $(el)
                .find(".widget-user-header")
                .replaceWith($(newTitle[0]));
              $(newTitle[1]).insertAfter($(el).find(".widget-user-header"));
            } else {
              $(el)
                .removeClass("widget-user")
                .addClass("widget-user-2");
              $(el)
                .find(".widget-user-header")
                .replaceWith($(newTitle));
            }

            // add background color
            if (value.options.status != null) {
              if (value.options.gradient) {
                $(el)
                  .find(".widget-user-header")
                  .addClass("bg-" + value.options.status + "-gradient");
              } else {
                $(el)
                  .find(".widget-user-header")
                  .addClass("bg-" + value.options.status);
              }
            }

            // add tools as first child of widget-user-header
            $(el)
              .find(".widget-user-header")
              .prepend($(tools));
          } else {
            if (!$(newTitle).hasClass("box-title"))
              $(newTitle).addClass("box-title");
            $(el)
              .find(".box-title")
              .replaceWith($(newTitle));
          }
        }
      }

      // To remove status explicitly set status = NULL in updateBox. Don't apply
      // to socialBox in AdminLTE2!!!
      if (value.options.hasOwnProperty("status")) {
        if (!isSocialCard) {
          if (value.options.status !== config.status) {
            var statusTarget = $(el);
            var oldClass, newClass;
            if (isUserCard) {
              statusTarget = $(statusTarget).find(".widget-user-header");
              oldClass = "bg-" + config.status;
              newClass = "bg-" + value.options.status;
            } else {
              oldClass = "box-" + config.status;
              newClass = "box-" + value.options.status;
            }

            if (value.options.gradient || config.gradient) {
              oldClass = oldClass + "-gradient";
              newClass = newClass + "-gradient";
            }

            // don't touch if null
            if (config.status != null) {
              $(statusTarget).removeClass(oldClass);
            }
            if (value.options.status != null) {
              $(statusTarget).addClass(newClass);
            }

            config.status = value.options.status;
          }
        }
      }
      // Don't apply to userBox and socialBox in AdminLTE2!!!
      if (value.options.hasOwnProperty("solidHeader")) {
        // only update if config an new value are different
        if (!isSocialCard && !userCard) {
          if (value.options.solidHeader !== config.solidHeader) {
            $(el).toggleClass("box-solid");
            config.solidHeader = value.options.solidHeader;
          }
        }
      }
      // To remove background explicitly set background = NULL in updateBox
      if (value.options.hasOwnProperty("background")) {
        if (value.options.background !== config.background) {
          var newBoxClass = "bg-";
          // don't touch if null
          if (config.background != null) {
            // if gradient, the class has a gradient at the end!
            newBoxClass = newBoxClass + config.background;
            if (config.gradient) {
              newBoxClass = newBoxClass + "-gradient";
            }
            // handle userBox
            // for which we also have to toggle the header bg color
            // and the box tools buttons color
            if (isUserCard) {
              var header = $(el).find(".widget-user-header");
              $(header).toggleClass(newBoxClass);
            }
            $(el).toggleClass(newBoxClass);
            $(el)
              .find(".btn-box-tool")
              .toggleClass("btn-" + config.background);
          }
          if (value.options.background != null) {
            newBoxClass = newBoxClass + value.options.background;
            if (config.gradient) {
              newBoxClass = newBoxClass + "-gradient";
            }
            if (isUserCard) {
              var header = $(el).find(".widget-user-header");
              $(header).addClass(newBoxClass);
            }
            $(el).addClass(newBoxClass);
            $(el)
              .find(".btn-box-tool")
              .toggleClass("btn-" + value.options.background);
          }
          config.background = value.options.background;
        }
      }
      if (value.options.hasOwnProperty("width")) {
        if (value.options.width !== config.width) {
          this._updateWidth(el, config.width, value.options.width);
          config.width = value.options.width;
        }
      }
      if (value.options.hasOwnProperty("height")) {
        if (value.options.height !== config.height) {
          if (value.options.height == null) {
            $(el)
              .find(".box-body")
              .css("height", "");
          } else {
            $(el)
              .find(".box-body")
              .css("height", value.options.height);
          }

          config.height = value.options.height;
          // don't need to trigger resize since the output height
          // is not controlled by the box size ...
        }
      }
      if (value.options.hasOwnProperty("collapsible")) {
        if (value.options.collapsible !== config.collapsible) {
          if (!value.options.collapsible) {
            $(el)
              .find('[data-widget = "collapse"]')
              .remove();
            config.collapsible = false;
          } else {
            // only add if no collapsible
            if ($(el).find('[data-widget = "collapse"]').length === 0) {
              $(el)
                .find(".box-tools.pull-right")
                .prepend(
                  $(
                    '<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>'
                  )
                );
              config.collapsible = true;
            }
          }
        }
      }
      if (value.options.hasOwnProperty("closable")) {
        if (value.options.closable !== config.closable) {
          if (!value.options.closable) {
            $(el)
              .find('[data-widget = "remove"]')
              .remove();
            config.closable = false;
          } else {
            if ($(el).find('[data-widget = "remove"]').length === 0) {
              $(el)
                .find(".box-tools.pull-right")
                .append(
                  $(
                    '<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>'
                  )
                );
              config.closable = true;
            }
          }
        }
      }

      // replace the old JSON config by the new one to update the input value
      $(el)
        .parent()
        .find("script[data-for='" + el.id + "']")
        .replaceWith(
          '<script type="application/json" data-for="' +
            el.id +
            '">' +
            JSON.stringify(config) +
            "</script>"
        );
    } else {
      if (value === "restore") {
        // only restore if not visible
        if ($(el).css("display") == "none") {
          $(el).show();
        } else {
          console.warn("This box is already visible!");
        }
      } else if (value === "toggle") {
        if ($(el).css("display") !== "none") {
          $(el).toggleBox();
        } else {
          console.warn(
            "This box is not visible. It does not make sense to collapse it!"
          );
        }
      } else {
        if ($(el).css("display") !== "none") {
          $(el).removeBox();
        } else {
          console.warn("This box is not visible!");
        }
      }
    }
  },
  receiveMessage: function(el, data) {
    this.setValue(el, data);
    $(el).trigger("change");
  },
  subscribe: function(el, callback) {
    // handle manual click on collapse button
    $(el).on("click", '[data-widget="collapse"]', function(event) {
      setTimeout(function() {
        callback();
      }, 50);
    });

    // handle manual click on remove button
    $(el).on("click", '[data-widget="remove"]', function(event) {
      setTimeout(function() {
        callback();
      }, 50);
    });

    // handle change event triggered in the setValue method
    $(el).on("change", function(event) {
      setTimeout(function() {
        callback();
      }, 50);
    });
  },
  unsubscribe: function(el) {
    $(el).off(".boxBinding");
  }
});

Shiny.inputBindings.register(boxBinding, "box-input");

// boxSidebarBinding
// ------------------------------------------------------------------
// This code creates an input binding for the boxPlus sidebar component
var boxSidebarBinding = new Shiny.InputBinding();
$.extend(boxSidebarBinding, {
  initialize: function(el) {
    // erase default to avoid seeing moving sidebars on initialization
    $(".direct-chat-contacts, .direct-chat-messages").css({
      transition: "transform .0s ease-in-out"
    });

    var background = $(el).attr("data-background")
      ? $(el).attr("data-background")
      : "#343a40";
    var width = $(el).attr("data-width")
      ? parseInt($(el).attr("data-width"))
      : 100;
    var closeTranslationRate = (100 * 100) / width;
    var contacts = $(el)
      .closest(".direct-chat")
      .find(".direct-chat-contacts");

    // apply width and background
    $(contacts).css({
      background: `${background}`,
      width: `${width}%`
    });

    // If start open, apply openTranslationRate else apply closeTranslationRate ...
    if ($(el).attr("data-start-open") === "true") {
      var openTranslationRate = closeTranslationRate - 100;
      $(contacts).css({ transform: `translate(${openTranslationRate}%, 0)` });
    } else {
      $(contacts).css({ transform: `translate(${closeTranslationRate}%, 0)` });
    }

    // Restore for better transitions
    setTimeout(function() {
      $(".direct-chat-contacts, .direct-chat-messages").css({
        transition: "transform .5s ease-in-out"
      });
    }, 300);
  },

  find: function(scope) {
    return $(scope).find('[data-widget="chat-pane-toggle"]');
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var boxWrapper = $(el).closest(".box");
    return $(boxWrapper).hasClass("direct-chat-contacts-open");
  },

  // see updateBoxSidebar
  receiveMessage: function(el, data) {
    $(el).trigger("click");
    $(el).trigger("shown");
  },

  subscribe: function(el, callback) {
    var self = this;
    $(el).on("click", function(e) {
      var width = $(el).attr("data-width")
        ? parseInt($(el).attr("data-width"))
        : 100;
      var closeTranslationRate = (100 * 100) / width;
      var openTranslationRate = closeTranslationRate - 100;
      // set a delay so that Shiny get the input value when the collapse animation
      // is finished.
      var target = e.currentTarget;
      setTimeout(function(e = target) {
        // apply correct translation rate depending on current state
        var contacts = $(e)
          .closest(".direct-chat")
          .find(".direct-chat-contacts");
        if (self.getValue(el)) {
          $(contacts).css({
            transform: `translate(${openTranslationRate}%, 0)`
          });
        } else {
          $(contacts).css({
            transform: `translate(${closeTranslationRate}%, 0)`
          });
        }
        callback();
      }, 10);
    });
  },

  unsubscribe: function(el) {
    $(el).off(".boxSidebarBinding");
  }
});

Shiny.inputBindings.register(boxSidebarBinding, "box-sidebar-input");

// flipbox
// ------------------------------------------------------------------
// This code creates an input binding for the flipbox component
var flipBoxBinding = new Shiny.InputBinding();

$.extend(flipBoxBinding, {
  find: function(scope) {
    return $(scope).find(".flipbox");
  },
  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return $(el)
      .find(".card-front")
      .hasClass("active");
  },

  setValue: function(el, value) {
    var currentSide = $(el).find(".active");
    if ($(el).data("rotate") === "hover") {
      if ($(currentSide).hasClass("card-front")) {
        $(currentSide).trigger("mouseenter");
      } else {
        $(currentSide).trigger("mouseleave");
      }
    } else if ($(el).data("rotate") === "click") {
      $(currentSide).trigger("click");
    }
  },

  // see updateAccordion
  receiveMessage: function(el, data) {
    this.setValue(el, data);
  },
  _clickOnFront: function(el) {
    $(el)
      .find(".card-front")
      .css({
        "-webkit-transform": "perspective(1600px) rotateY(-180deg)",
        transform: "perspective(1600px) rotateY(-180deg)"
      })
      .toggleClass("active");
    $(el)
      .find(".card-back")
      .css({
        "-webkit-transform": "perspective(1600px) rotateY(0deg)",
        transform: "perspective(1600px) rotateY(0deg)"
      })
      .toggleClass("active");
  },
  _clickOnBack: function(el) {
    $(el)
      .find(".card-front")
      .css({ "-webkit-transform": "", transform: "" })
      .toggleClass("active");
    $(el)
      .find(".card-back")
      .css({ "-webkit-transform": "", transform: "" })
      .toggleClass("active");
  },
  subscribe: function(el, callback) {
    var self = this; // this will not work inside event listeners since it will
    // refer to the element we clicked on and not the input binding object!!!

    // use the data object to identify the trigger
    if ($(el).data("rotate") === "hover") {
      $(el)
        .find(".card-front")
        .on("mouseenter", function() {
          self._clickOnFront(el);
          callback();
        });

      $(el)
        .find(".card-back")
        .on("mouseleave", function() {
          self._clickOnBack(el);
          callback();
        });
    } else if ($(el).data("rotate") === "click") {
      // click front
      $(el).on("click", ".card-front", function(e) {
        self._clickOnFront(el);
        callback();
      });

      // click back
      $(el).on("click", ".card-back", function(e) {
        self._clickOnBack(el);
        callback();
      });
    }
  },

  unsubscribe: function(el) {
    $(el).off(".flipBoxBinding");
  }
});

Shiny.inputBindings.register(flipBoxBinding, "flipbox-input");

