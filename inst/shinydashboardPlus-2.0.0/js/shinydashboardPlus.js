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
          if (config.gradient !== value.options.gradient &&
          value.options.gradient !== undefined) {
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

var ensureActivatedTab = function() {
  var $tablinks = $(".sidebar-menu a[data-toggle='tab']");

  // If there's a `data-start-selected` attribute and we can find a tab with
  // that name, activate it.
  var $startTab = $tablinks.filter("[data-start-selected='1']");
  if ($startTab.length === 0) {
    // If no tab starts selected, use the first one, if present
    $startTab = $tablinks.first();
  }

  // If there are no tabs, $startTab.length will be 0.
  if ($startTab.length !== 0) {
    $startTab.tab("show");

    // This is indirectly setting the value of the Shiny input by setting
    // an attribute on the html element it is bound to. We cannot use the
    // inputBinding's setValue() method here because this is called too
    // early (before Shiny has fully initialized)
    $(".sidebarMenuSelectedTabItem").attr(
      "data-value",
      $startTab.attr("data-value")
    );
  }
};

$(function() {
  // tabItemInputBinding
  // ------------------------------------------------------------------
  // Based on Shiny.tabItemInputBinding, but customized for tabItems in
  // shinydashboard, which have a slightly different structure.
  var tabItemInputBinding = new Shiny.InputBinding();
  $.extend(tabItemInputBinding, {
    find: function(scope) {
      return $(scope).find(".sidebarMenuSelectedTabItem");
    },
    getValue: function(el) {
      var value = $(el).attr("data-value");
      if (value === "null") return null;
      return value;
    },
    setValue: function(el, value) {
      var self = this;
      var anchors = $(el)
        .parent("ul.sidebar-menu")
        .find("li:not(.treeview)")
        .children("a");
      anchors.each(function() {
        // eslint-disable-line consistent-return
        if (self._getTabName($(this)) === value) {
          $(this).tab("show");
          $(el).attr("data-value", self._getTabName($(this)));
          return false;
        }
      });
    },
    receiveMessage: function(el, data) {
      if (data.hasOwnProperty("value")) this.setValue(el, data.value);
    },
    subscribe: function(el, callback) {
      // This event is triggered by deactivateOtherTabs, which is triggered by
      // shown. The deactivation of other tabs must occur before Shiny gets the
      // input value.
      $(el).on("change.tabItemInputBinding", function() {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off(".tabItemInputBinding");
    },
    _getTabName: function(anchor) {
      return anchor.attr("data-value");
    }
  });

  Shiny.inputBindings.register(
    tabItemInputBinding,
    "shinydashboard.tabItemInput"
  );

  // sidebarCollapsedInputBinding
  // ------------------------------------------------------------------
  // This keeps tracks of whether the sidebar is expanded (default)
  // or collapsed
  var sidebarCollapsedInputBinding = new Shiny.InputBinding();
  $.extend(sidebarCollapsedInputBinding, {
    find: function(scope) {
      // This will also have id="sidebarCollapsed"
      return $(scope)
        .find(".main-sidebar")
        .first();
    },
    getValue: function(el) {
      if ($(el).attr("id") === "sidebarCollapsed") {
        return $(el).attr("data-collapsed") === "true";
      } else {
        return $(el).attr("data-collapsed") === "false";
      }
    },
    setValue: function(el, value) {
      $(el).attr("data-collapsed", value);
    },
    toggleValue: function(el) {
      var current = this.getValue(el);
      var newVal = current ? "false" : "true";
      this.setValue(el, newVal);
    },
    receiveMessage: function(el, data) {
      if (data.hasOwnProperty("value")) this.setValue(el, data.value);
      $("[data-toggle='offcanvas']").click();
    },
    subscribe: function(el, callback) {
      $(el).on("change.sidebarCollapsedInputBinding", function() {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off(".sidebarCollapsedInputBinding");
    }
  });
  Shiny.inputBindings.register(
    sidebarCollapsedInputBinding,
    "shinydashboard.sidebarCollapsedInputBinding"
  );

  // sidebarmenuExpandedInputBinding
  // ------------------------------------------------------------------
  // This keeps tracks of what menuItem (if any) is expanded
  $("section.sidebar a i").click(function() {
    if ($(this).hasClass("fa-angle-down")) {
      self = $(this);
      setTimeout(function() {
        self.removeClass("fa-angle-down").addClass("fa-angle-left");
      }, 500);
    }
  });

  var sidebarmenuExpandedInputBinding = new Shiny.InputBinding();
  $.extend(sidebarmenuExpandedInputBinding, {
    find: function(scope) {
      // This will also have id="sidebarItemExpanded"
      return $(scope).find("section.sidebar");
    },
    getValue: function(el) {
      var $open = $(el).find("li ul.menu-open");
      var icon = $(el)
        .find(".treeview.active > a i")
        .eq(1);
      if ($open.length === 1) {
        $(icon)
          .toggleClass("fa-angle-left")
          .addClass("fa-angle-down");
        return $open.attr("data-expanded");
      } else {
        return null;
      }
    },
    setValue: function(el, value) {
      var $menuItem = $(el).find("[data-expanded='" + value + "']");
      // This will trigger actions defined by AdminLTE, as well as actions
      // defined in sidebar.js.
      $menuItem.prev().trigger("click");
    },
    subscribe: function(el, callback) {
      $(el).on("change.sidebarmenuExpandedInputBinding", function() {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off(".sidebarmenuExpandedInputBinding");
    }
  });
  Shiny.inputBindings.register(
    sidebarmenuExpandedInputBinding,
    "shinydashboard.sidebarmenuExpandedInputBinding"
  );

  // Optionally disable sidebar (set through the `disable` argument
  // to the `dashboardSidebar` function)
  if ($("section.sidebar").data("disable")) {
    $("body").addClass("sidebar-collapse");
    $(".navbar > .sidebar-toggle").hide();
  }

  // toggle sidebar at start depending on the body class
  var sidebarCollapsed = $(".main-sidebar").attr("data-collapsed");
  if (sidebarCollapsed === "true") {
    $("body").addClass("sidebar-collapse");
  }

  // handle the sidebar partial collapse feature
  var sidebarMinified = $(".main-sidebar").attr("data-minified");
  if (sidebarMinified === "true") {
    $("body").addClass("sidebar-mini");
  }

  // Get the correct value for `input$sidebarCollapsed`, depending on
  // whether or not the left offset on the sidebar is negative (hidden
  // - so `input$sidebarCollapsed` should be TRUE) or 0 (shown - so
  // `input$sidebarCollapsed` should be FALSE). That we know of,
  // `$(".main-sidebar").is(":visible")` is always true, so there is
  // no need to check for that.
  // Determine whether the sidebar should be minified instead of fully collapsed
  var sidebarCollapsedValue = function() {
    if ($("body").hasClass("sidebar-collapse")) return true;
    else return false;
  };

  // Whenever the sidebar changes from collapsed to expanded and vice versa,
  // call this function, so that we can trigger the resize event on the rest
  // of the window and also update the value for the sidebar's input binding.
  var sidebarChange = function() {
    // 1) Trigger the resize event (so images are responsive and resize)
    $(window).trigger("resize");

    // 2) Update the value for the sidebar's input binding
    var $obj = $(".main-sidebar.shiny-bound-input");
    var inputBinding = $obj.data("shiny-input-binding");
    inputBinding.setValue($obj, sidebarCollapsedValue());
    $obj.trigger("change");
  };

  // Whenever the sidebar finishes a transition (which it does every time it
  // changes from collapsed to expanded and vice versa), call sidebarChange()
  $(".main-sidebar").on(
    "webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend",
    sidebarChange
  );

  // This fixes an edge case: when the app starts up with the sidebar already
  // collapsed (either because the screen is small or because
  // `dashboardSidebar(disable = TRUE`), make sure that `input$sidebarCollapsed`
  // is set to `FALSE`. Whenever this is the case, `$(".main-sidebar").offset().left`
  // is negative. That we know of, `$(".main-sidebar").is(":visible")` is always
  // true, so there is no need to check for that.
  if ($("body").hasClass("sidebar-collapse")) {
    // This is indirectly setting the value of the Shiny input by setting
    // an attribute on the html element it is bound to. We cannot use the
    // inputBinding's setValue() method here because this is called too
    // early (before Shiny has fully initialized)
    $(".main-sidebar").attr("data-collapsed", "true");
  }

  // Whenever we expand a menuItem (to be expandable, it must have children),
  // update the value for the expandedItem's input binding (this is the
  // tabName of the fist subMenuItem inside the menuItem that is currently
  // expanded)
  $(document).on("click", ".treeview > a", function() {
    var $menu = $(this).next();
    // If this menuItem was already open, then clicking on it again,
    // should trigger the "hidden" event, so Shiny doesn't worry about
    // it while it's hidden (and vice versa).
    if ($menu.hasClass("menu-open")) $menu.trigger("hidden");
    else if ($menu.hasClass("treeview-menu")) $menu.trigger("shown");

    // need to set timeout to account for the slideUp/slideDown animation
    var $obj = $("section.sidebar.shiny-bound-input");
    setTimeout(function() {
      $obj.trigger("change");
    }, 600);
  });

  // This function handles a special case in the AdminLTE sidebar: when there
  // is a sidebar-menu with items, and one of those items has sub-items, and
  // they are used for tab navigation. Normally, if one of the items is
  // selected and then a sub-item is clicked, both the item and sub-item will
  // retain the "active" class, so they will both be highlighted. This happens
  // because they're not designed to be used together for tab panels. This
  // code ensures that only one item will have the "active" class.
  var deactivateOtherTabs = function() {
    // Find all tab links under sidebar-menu even if they don't have a
    // tabName (which is why the second selector is necessary)
    var $tablinks = $(
      ".sidebar-menu a[data-toggle='tab']," + ".sidebar-menu li.treeview > a"
    );

    // If any other items are active, deactivate them
    $tablinks
      .not($(this))
      .parent("li")
      .removeClass("active");

    // Trigger event for the tabItemInputBinding
    var $obj = $(".sidebarMenuSelectedTabItem");
    var inputBinding = $obj.data("shiny-input-binding");
    if (typeof inputBinding !== "undefined") {
      inputBinding.setValue($obj, $(this).attr("data-value"));
      $obj.trigger("change");
    }
  };

  $(document).on(
    "shown.bs.tab",
    '.sidebar-menu a[data-toggle="tab"]',
    deactivateOtherTabs
  );

  // When document is ready, if there is a sidebar menu with no activated tabs,
  // activate the one specified by `data-start-selected`, or if that's not
  // present, the first one.
  ensureActivatedTab();
});

$(function() {
  
  // box vertical overflow
  $(".content-wrapper").css("overflow-y", "auto");

  // slide to top button
  var $slideToTop = $("<div />");

  $slideToTop.html('<i class="fa fa-chevron-up"></i>');

  $slideToTop.css({
    position: "fixed",
    bottom: "20px",
    right: "25px",
    width: "40px",
    height: "40px",
    color: "#eee",
    "font-size": "",
    "line-height": "40px",
    "text-align": "center",
    "background-color": "#222d32",
    cursor: "pointer",
    "border-radius": "5px",
    "z-index": "99999",
    opacity: ".7",
    display: "none"
  });

  $slideToTop.on("mouseenter", function() {
    $(this).css("opacity", "1");
  });

  $slideToTop.on("mouseout", function() {
    $(this).css("opacity", ".7");
  });

  $(".wrapper").append($slideToTop);

  $(window).scroll(function() {
    if ($(window).scrollTop() >= 150) {
      if (!$($slideToTop).is(":visible")) {
        $($slideToTop).fadeIn(500);
      }
    } else {
      $($slideToTop).fadeOut(500);
    }
  });

  $($slideToTop).click(function() {
    $("html, body").animate(
      {
        scrollTop: 0
      },
      500
    );
  });

  // code to make sure that a carousel item is displayed
  // when it is generated via a shiny Output function
  // Thanks Dean Attali for the report
  $(".carousel").on("slide.bs.carousel", function() {
    $(this).trigger("shown");
  });

  /**
   * List of all the available skins
   *
   * @type Array
   */
  var mySkins = [
    "skin-blue",
    "skin-black",
    "skin-red",
    "skin-yellow",
    "skin-purple",
    "skin-green",
    "skin-blue-light",
    "skin-black-light",
    "skin-red-light",
    "skin-yellow-light",
    "skin-purple-light",
    "skin-green-light"
  ];

  /**
   * Store a new settings in the browser
   *
   * @param String name Name of the setting
   * @param String val Value of the setting
   * @returns void
   */
  function store(name, val) {
    if (typeof Storage !== "undefined") {
      localStorage.setItem(name, val);
    } else {
      window.alert(
        "Please use a modern browser to properly view this template!"
      );
    }
  }

  /**
   * Replaces the old skin with the new skin
   * @param String cls the new skin class
   * @returns Boolean false to prevent link's default action
   */
  changeSkin = function(cls) {
    $.each(mySkins, function(i) {
      $("body").removeClass(mySkins[i]);
    });

    $("body").addClass(cls);
    store("skin", cls);
    return false;
  };
});

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

// menuOutputBinding
// ------------------------------------------------------------------
// Based on Shiny.htmlOutputBinding, but instead of putting the result in a
// wrapper div, it replaces the origin DOM element with the new DOM elements,
// copying over the ID and class.
var menuOutputBinding = new Shiny.OutputBinding();
$.extend(menuOutputBinding, {
  find: function(scope) {
    return $(scope).find(".shinydashboard-menu-output");
  },
  onValueError: function(el, err) {
    Shiny.unbindAll(el);
    this.renderError(el, err);
  },
  renderValue: function(el, data) {
    Shiny.unbindAll(el);

    var html;
    var dependencies = [];
    if (data === null) {
      return;
    } else if (typeof data === "string") {
      html = data;
    } else if (typeof data === "object") {
      html = data.html;
      dependencies = data.deps;
    }

    var $html = $($.parseHTML(html));

    // Convert the inner contents to HTML, and pass to renderHtml
    Shiny.renderHtml($html.html(), el, dependencies);

    // Extract class of wrapper, and add them to the wrapper element
    el.className =
      "shinydashboard-menu-output shiny-bound-output " + $html.attr("class");

    Shiny.initializeInputs(el);
    Shiny.bindAll(el);
    if ($(el).hasClass("sidebar-menu")) ensureActivatedTab(); // eslint-disable-line
  }
});
Shiny.outputBindings.register(
  menuOutputBinding,
  "shinydashboard.menuOutputBinding"
);

// This code creates acustom handler for userMessages
Shiny.addCustomMessageHandler("user-messages", function(message) {
  var id = message.id,
    action = message.action,
    content = message.body,
    index = message.index;

  // message text
  // We use Shiny.renderHtml to handle the case where the user pass input/outputs in the updated content that require a new dependency not available in the
  // page at startup.
  if (content.hasOwnProperty("text")) {
    var text;
    if (content.text.html === undefined) {
      text = content.text;
    } else {
      text = Shiny.renderHtml(content.text.html, $([]), content.text.deps).html;
    }
  }

  // unbind all
  Shiny.unbindAll();

  if (action === "remove") {
    $("#" + id)
      .find(".direct-chat-msg")
      .eq(index - 1)
      .remove();
  } else if (action === "add") {
    var author = content.author,
      date = content.date,
      image = content.image,
      type = content.type;

    // build the new message
    var newMessage =
      '<div class="direct-chat-info clearfix">' +
      '<span class="direct-chat-name">' +
      author +
      "</span>" +
      '<span class="direct-chat-timestamp" style="margin-left: 4px">' +
      date +
      "</span>" +
      "</div>" +
      '<img class="direct-chat-img" src="' +
      image +
      '"/>' +
      '<div class="direct-chat-text">' +
      text +
      "</div>";

    // build wrapper
    var newMessageWrapper;
    if (type === "sent") {
      newMessageWrapper =
        '<div class="direct-chat-msg right">' + newMessage + "</div>";
    } else {
      newMessageWrapper =
        '<div class="direct-chat-msg">' + newMessage + "</div>";
    }

    // append message
    $("#" + id)
      .find(".direct-chat-messages")
      .append(newMessageWrapper);
  } else if (action === "update") {
    // today's date
    var d = new Date();
    var month = d.getMonth() + 1;
    var day = d.getDate();
    var today =
      d.getFullYear() +
      "/" +
      (("" + month).length < 2 ? "0" : "") +
      month +
      "/" +
      (("" + day).length < 2 ? "0" : "") +
      day;

    // we assume only text may be updated. Does not make sense to modify author/date

    $("#" + id)
      .find(".direct-chat-text")
      .eq(index - 1)
      .replaceWith(
        '<div class="direct-chat-text"><small class="text-red">(modified: ' +
          today +
          ")</small><br>" +
          text +
          "</div>"
      );
  }

  // Calls .initialize() for all of the input objects in all input bindings,
  // in the given scope (document)
  Shiny.initializeInputs();
  Shiny.bindAll(); // bind all inputs/outputs
});

