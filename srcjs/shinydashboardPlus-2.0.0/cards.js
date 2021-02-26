// Buttons valid colors are part of statuses
const validStatuses = ["primary", "success", "info", "warning", "danger"];

// Background goes in colors
const validColors = [
  "red",
  "yellow",
  "aqua",
  "blue",
  "light-blue",
  "green",
  "navy",
  "teal",
  "olive",
  "lime",
  "orange",
  "fuchsia",
  "purple",
  "maroon",
  "black",
  "gray"
];

// Cards may have 6 additional statuses
const validStatusesPlus = [
  "navy",
  "teal",
  "purple",
  "orange",
  "maroon",
  "black"
];

const status_2_color = status => {
  switch (status) {
    case "primary":
      return "light-blue";
      break;
    case "success":
      return "green";
      break;
    case "danger":
      return "red";
      break;
    case "warning":
      return "yellow";
      break;
    case "info":
      return "aqua";
      break;
    case "navy":
      return "navy";
      break;
    case "teal":
      return "teal";
      break;
    case "purple":
      return "purple";
      break;
    case "orange":
      return "orange";
      break;
    case "maroon":
      return "maroon";
      break;
    case "black":
      return "black";
      break;
  }
};

const color_2_status = color => {
  switch (color) {
    case "light-blue":
      return "primary";
      break;
    case "green":
      return "success";
      break;
    case "red":
      return "danger";
      break;
    case "yellow":
      return "warning";
      break;
    case "aqua":
      return "info";
      break;
    case "navy":
      return "navy";
      break;
    case "teal":
      return "teal";
      break;
    case "purple":
      return "purple";
      break;
    case "orange":
      return "orange";
      break;
    case "maroon":
      return "maroon";
      break;
    case "black":
      return "black";
      break;
  }
};
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
          var newTitle;
          if (typeof value.options.title !== "string") {
            newTitle = $.parseHTML(value.options.title[0]);
          } else {
            newTitle = $.parseHTML(value.options.title);
          }

          var tools = $(el).find(".box-tools");
          // social box
          if (isSocialCard) {
            $(el)
              .find(".user-block")
              .replaceWith($(newTitle));
          } else if (isUserCard) {
            // handle 2 cards types
            if (typeof value.options.title === "string") {
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
              // remove old user inage if old type was 1
              $(el)
                .find(".widget-user-image")
                .remove();
              $(el)
                .find(".widget-user-header")
                .replaceWith($(newTitle));
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
          config.title = value.options.title;
        }
      }

      // Box tools must come before status, background as they are being changed after
      // to add background or status color, depending on user options.
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
                    '<button class="btn btn-box-tool btn-sm" data-widget="collapse"><i class="fa fa-minus"></i></button>'
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
                    '<button class="btn btn-box-tool btn-sm" data-widget="remove"><i class="fa fa-times"></i></button>'
                  )
                );
              config.closable = true;
            }
          }
        }
      }

      // Must come before status and background since status relies on soliHeader
      // Don't apply to userBox and socialBox in AdminLTE2!!!
      if (value.options.hasOwnProperty("solidHeader")) {
        // only update if config an new value are different
        if (!isSocialCard && !isUserCard) {
          if (
            value.options.solidHeader !== config.solidHeader &&
            !$(el).hasClass("box-solid")
          ) {
            $(el).addClass("box-solid");
            config.solidHeader = true;
          } else {
            if ($(el).hasClass("box-solid") && !value.options.solidHeader) {
              var cond = config.status || value.options.status;
              // solidheader cannot be removed if status and background exist or if status is null
              if (!(value.options.background && cond)) {
                $(el).removeClass("box-solid");
                config.solidHeader = false;
              } else if (
                value.options.background === null &&
                !(config.background && cond)
              ) {
                $(el).removeClass("box-solid");
                config.solidHeader = false;
              }
            } else if (!$(el).hasClass("box-solid")) {
              var cond = config.status || value.options.status;
              // solidheader cannot be removed if status and background exist or if status is null
              if (value.options.background && cond) {
                $(el).addClass("box-solid");
                config.solidHeader = true;
              } else if (config.background && cond) {
                $(el).addClass("box-solid");
                config.solidHeader = false;
              }
            }
          }
        }
      }

      // To remove status explicitly set status = NULL in updateBox. Don't apply
      // to socialBox in AdminLTE2!!!
      if (value.options.hasOwnProperty("status")) {
        if (!isSocialCard) {
          if (value.options.status !== config.status) {
            var oldClass, newClass;
            // If there was a status and the user decide to remove any status
            if (value.options.status === null && config.status !== null) {
              if (!isUserCard) $(el).removeClass("box-" + config.status);
              // add class box-solid for better render (status = NULL)
              // renders with grey border which is not nice
              if (!$(el).hasClass("box-solid") && !isUserCard) {
                $(el).addClass("box-solid");
              }

              // Apply new background color to buttons if any
              if (value.options.background) {
                var background = color_2_status(value.options.background);
                if (validStatusesPlus.indexOf(background) > -1) {
                  $(el)
                    .find(".btn-box-tool")
                    .addClass("bg-" + background);
                } else if (validStatuses.indexOf(background) > -1) {
                  $(el)
                    .find(".btn-box-tool")
                    .addClass("btn-" + background);
                }
              }

              // in case there is a status and it is not null (indeed we can send null through R)
            } else if (value.options.status) {
              // apply new status
              if (isUserCard) {
                newClass = "bg-" + status_2_color(value.options.status);
                if (value.options.gradient) {
                  newClass = newClass + "-gradient";
                }
                $(el)
                  .find(".widget-user-header")
                  .addClass(newClass);
              } else {
                newClass = "box-" + value.options.status;
                $(el).addClass(newClass);
              }
              
              // remove old status, if there was one ...
              if (config.status) {
                if (isUserCard) {
                  oldClass = "bg-" + status_2_color(config.status);
                  if (config.gradient) {
                    oldClass = oldClass + "-gradient";
                  }
                  $(el)
                    .find(".widget-user-header")
                    .removeClass(oldClass);
                } else {
                  oldClass = "box-" + config.status;
                  $(el).removeClass(oldClass);
                }
              }

              // Add new color for Buttons. We handle extra statuses in which case
              // the button class changes. Only if solidHeader
              if ($(el).hasClass("box-solid") || isUserCard) {
                if (isUserCard) {
                  $(el)
                    .find(".btn-box-tool")
                    .addClass("bg-" + status_2_color(value.options.status));
                } else {
                  if (validStatusesPlus.indexOf(value.options.status) > -1) {
                    $(el)
                      .find(".btn-box-tool")
                      .addClass("bg-" + value.options.status);
                  } else if (validStatuses.indexOf(value.options.status) > -1) {
                    $(el)
                      .find(".btn-box-tool")
                      .addClass("btn-" + value.options.status);
                  }
                }
                
              }
            }

            // If there was a status or background, we must cleanup the old button status
            // since status predominate over background. We also handle extra
            // statuses ...
            var status;
            if (config.status || config.background) {
              // status dominates
              if (config.status) {
                status = config.status;
              } else if (config.background) {
                status = config.background;
              }

              if (isUserCard) {
                $(el)
                    .find(".btn-box-tool")
                    .removeClass("bg-" + status_2_color(status));
              } else {
                if (validStatusesPlus.indexOf(status) > -1) {
                  $(el)
                    .find(".btn-box-tool")
                    .removeClass("bg-" + status);
                } else if (validStatuses.indexOf(status) > -1) {
                  $(el)
                    .find(".btn-box-tool")
                    .removeClass("btn-" + status);
                }
              }
            }
            config.status = value.options.status;
          }
        }
      }

      // To remove background explicitly set background = NULL in updateBox
      if (value.options.hasOwnProperty("background")) {
        if (value.options.background !== config.background) {
          var oldBgClass = "bg-",
            newBgClass = oldBgClass;
          // don't touch if null
          if (config.background) {
            // if gradient, the class has a gradient at the end!
            oldBgClass = oldBgClass + config.background;
            if (config.gradient) {
              oldBgClass = oldBgClass + "-gradient";
            }
            // handle userBox
            // for which we also have to toggle the header bg color
            // and the box tools buttons color
            if (isUserCard && !(config.status || value.options.status)) {
              var header = $(el).find(".widget-user-header");
              $(header).removeClass(oldBgClass);
            }

            $(el).removeClass(oldBgClass);
          }
          if (value.options.background) {
            newBgClass = newBgClass + value.options.background;
            if (config.gradient || value.options.gradient) {
              newBgClass = newBgClass + "-gradient";
            }
            if (isUserCard && !(config.status || value.options.status)) {
              var header = $(el).find(".widget-user-header");
              $(header).addClass(newBgClass);
            }
            $(el).addClass(newBgClass);
          }
          if (config.gradient !== value.options.gradient) {
            config.gradient = value.options.gradient;
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
          if (value.options.height === null) {
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
      }, 550);
    });

    // handle manual click on remove button
    $(el).on("click", '[data-widget="remove"]', function(event) {
      setTimeout(function() {
        callback();
      }, 550);
    });

    // handle change event triggered in the setValue method
    $(el).on("change", function(event) {
      setTimeout(function() {
        callback();
      }, 550);
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

