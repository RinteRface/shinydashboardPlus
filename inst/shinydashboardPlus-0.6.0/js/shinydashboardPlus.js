//---------------------------------------------------------------------
// Source file: ../srcjs/_start.js

$(function() {
  
  // code to make sure that a carousel item is displayed
  // when it is generated via a shiny Output function
  // Thanks Dean Attali for the report
  $('.carousel').on('slide.bs.carousel', function () {
    $(this).trigger("shown");
  });
  
  // overwrite box animation speed. Putting 500 ms add unnecessary delay for Shiny.
  $.AdminLTE.boxWidget.animationSpeed = 10;

  //---------------------------------------------------------------------
  // Source file: ../srcjs/tabs.js

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
    var $tablinks = $(".sidebar-menu a[data-toggle='tab']," +
      ".sidebar-menu li.treeview > a");
  
    // If any other items are active, deactivate them
    $tablinks.not($(this)).parent("li").removeClass("active");
  
    // Trigger event for the tabItemInputBinding
    var $obj = $('.sidebarMenuSelectedTabItem');
    var inputBinding = $obj.data('shiny-input-binding');
    if (typeof inputBinding !== 'undefined') {
      inputBinding.setValue($obj, $(this).attr('data-value'));
      $obj.trigger('change');
    }
  };

  $(document).on('shown.bs.tab', '.sidebar-menu a[data-toggle="tab"]',
               deactivateOtherTabs);

  // When document is ready, if there is a sidebar menu with no activated tabs,
  // activate the one specified by `data-start-selected`, or if that's not
  // present, the first one.
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
      $(".sidebarMenuSelectedTabItem").attr("data-value",
        $startTab.attr("data-value"));
    }
  };
  
  ensureActivatedTab();

  //---------------------------------------------------------------------
  // Source file: ../srcjs/sidebar.js

  // Optionally disable sidebar (set through the `disable` argument
  // to the `dashboardSidebar` function)
  if ($("section.sidebar").data("disable")) {
    $("body").addClass("sidebar-collapse");
    $(".navbar > .sidebar-toggle").hide();
  }

 // toggle sidebar at start depending on the body class
  var sidebarCollapsed = $('.main-sidebar').attr('data-collapsed');
  if (sidebarCollapsed === "true") {
    $('body').addClass('sidebar-collapse');
  }


  // handle the sidebar partial collapse feature
  var sidebarMinified = $('.main-sidebar').attr('data-minified');
    if (sidebarMinified === "true") {
      $('body').addClass('sidebar-mini');
  }

  // Get the correct value for `input$sidebarCollapsed`, depending on
  // whether or not the left offset on the sidebar is negative (hidden
  // - so `input$sidebarCollapsed` should be TRUE) or 0 (shown - so
  // `input$sidebarCollapsed` should be FALSE). That we know of,
  // `$(".main-sidebar").is(":visible")` is always true, so there is
  // no need to check for that.
  // Determine whether the sidebar should be minified instead of fully collapsed
   var sidebarCollapsedValue = function() {
      if ($("body").hasClass("sidebar-collapse")) return(true);
      else return(false);
  };
 

  // Whenever the sidebar changes from collapsed to expanded and vice versa,
  // call this function, so that we can trigger the resize event on the rest
  // of the window and also update the value for the sidebar's input binding.
  var sidebarChange = function() {
    // 1) Trigger the resize event (so images are responsive and resize)
    $(window).trigger("resize");
  
    // 2) Update the value for the sidebar's input binding
    var $obj = $('.main-sidebar.shiny-bound-input');
    var inputBinding = $obj.data('shiny-input-binding');
    inputBinding.setValue($obj, sidebarCollapsedValue());
    $obj.trigger('change');
  };

  // Whenever the sidebar finishes a transition (which it does every time it
  // changes from collapsed to expanded and vice versa), call sidebarChange()
  $(".main-sidebar").on(
    'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend',
      sidebarChange);

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
    var $obj = $('section.sidebar.shiny-bound-input');
    setTimeout(function() { $obj.trigger('change'); }, 600);
  });


  //---------------------------------------------------------------------
  // Source file: ../srcjs/controlbar.js
  
  // toggle controlbar at start
  var controlbarCollapsed = $('.control-sidebar').attr('data-collapsed');
  if (controlbarCollapsed === "false") {
    $('body').addClass('control-sidebar-open');
  }
  
  // hide the right sidebar toggle 
  // if no right sidebar is specified
  var noControlbar = ($(".control-sidebar").length === 0);
  if (noControlbar) {
    $("[data-toggle='control-sidebar']").hide();
  }
  
  // hide the right sidebar toggle if the controlbar is disable
  var disableControlbar = $(".control-sidebar").attr("data-show");
  if (disableControlbar === "false") {
    $("[data-toggle='control-sidebar']").hide();
  }

  
  var controlbarChange = function() {
    // 1) Trigger the resize event (so images are responsive and resize)
    $(window).trigger("resize");
  };
  
  // Whenever the right sidebar (controlbar) finishes a transition (which it does every time it
  // changes from collapsed to expanded and vice versa), call controlbarChange()
  $(".control-sidebar").on(
  'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend',
    controlbarChange);

  //---------------------------------------------------------------------
  // Source file: ../srcjs/output_binding_menu.js
  
  /* global Shiny */
  
  // menuOutputBinding
  // ------------------------------------------------------------------
  // Based on Shiny.htmlOutputBinding, but instead of putting the result in a
  // wrapper div, it replaces the origin DOM element with the new DOM elements,
  // copying over the ID and class.
  var menuOutputBinding = new Shiny.OutputBinding();
  $.extend(menuOutputBinding, {
    find: function(scope) {
      return $(scope).find('.shinydashboard-menu-output');
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
      } else if (typeof(data) === 'string') {
        html = data;
      } else if (typeof(data) === 'object') {
        html = data.html;
        dependencies = data.deps;
      }
  
      var $html = $($.parseHTML(html));
  
      // Convert the inner contents to HTML, and pass to renderHtml
      Shiny.renderHtml($html.html(), el, dependencies);
  
      // Extract class of wrapper, and add them to the wrapper element
      el.className = 'shinydashboard-menu-output shiny-bound-output ' +
                     $html.attr('class');
  
      Shiny.initializeInputs(el);
      Shiny.bindAll(el);
      if ($(el).hasClass("sidebar-menu")) ensureActivatedTab(); // eslint-disable-line
    }
  });
  Shiny.outputBindings.register(menuOutputBinding,
                                "shinydashboard.menuOutputBinding");

  //---------------------------------------------------------------------
  // Source file: ../srcjs/input_binding_tabItem.js
  
  /* global Shiny */
  
  // tabItemInputBinding
  // ------------------------------------------------------------------
  // Based on Shiny.tabItemInputBinding, but customized for tabItems in
  // shinydashboard, which have a slightly different structure.
  var tabItemInputBinding = new Shiny.InputBinding();
  $.extend(tabItemInputBinding, {
    find: function(scope) {
      return $(scope).find('.sidebarMenuSelectedTabItem');
    },
    getValue: function(el) {
      var value = $(el).attr('data-value');
      if (value === "null") return null;
      return value;
    },
    setValue: function(el, value) {
      var self = this;
      var anchors = $(el).parent('ul.sidebar-menu').find('li:not(.treeview)').children('a');
      anchors.each(function() { // eslint-disable-line consistent-return
        if (self._getTabName($(this)) === value) {
          $(this).tab('show');
          $(el).attr('data-value', self._getTabName($(this)));
          return false;
        }
      });
    },
    receiveMessage: function(el, data) {
      if (data.hasOwnProperty('value'))
        this.setValue(el, data.value);
    },
    subscribe: function(el, callback) {
      // This event is triggered by deactivateOtherTabs, which is triggered by
      // shown. The deactivation of other tabs must occur before Shiny gets the
      // input value.
      $(el).on('change.tabItemInputBinding', function() {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off('.tabItemInputBinding');
    },
    _getTabName: function(anchor) {
      return anchor.attr('data-value');
    }
  });
  
  Shiny.inputBindings.register(tabItemInputBinding, 'shinydashboard.tabItemInput');

  //---------------------------------------------------------------------
  // Source file: ../srcjs/input_binding_sidebarCollapsed.js
  
  /* global Shiny */
  
  // sidebarCollapsedInputBinding
  // ------------------------------------------------------------------
  // This keeps tracks of whether the sidebar is expanded (default)
  // or collapsed
  var sidebarCollapsedInputBinding = new Shiny.InputBinding();
  $.extend(sidebarCollapsedInputBinding, {
    find: function(scope) {
      // This will also have id="sidebarCollapsed"
      return $(scope).find('.main-sidebar').first();
    },
    getValue: function(el) {
      return $(el).attr("data-collapsed") === "false";
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
      if (data.hasOwnProperty('value'))
        this.setValue(el, data.value);
        $("[data-toggle='offcanvas']").click();
    },
    subscribe: function(el, callback) {
      $(el).on('change.sidebarCollapsedInputBinding', function() {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off('.sidebarCollapsedInputBinding');
    }
  });
  Shiny.inputBindings.register(sidebarCollapsedInputBinding,
    'shinydashboard.sidebarCollapsedInputBinding');

  //---------------------------------------------------------------------
  // Source file: ../srcjs/input_binding_sidebarmenuExpanded.js
  
  /* global Shiny */
  
  // sidebarmenuExpandedInputBinding
  // ------------------------------------------------------------------
  // This keeps tracks of what menuItem (if any) is expanded
  var sidebarmenuExpandedInputBinding = new Shiny.InputBinding();
  $.extend(sidebarmenuExpandedInputBinding, {
    find: function(scope) {
      // This will also have id="sidebarItemExpanded"
      return $(scope).find('section.sidebar');
    },
    getValue: function(el) {
      var $open = $(el).find('li ul.menu-open');
      if ($open.length === 1) return $open.attr('data-expanded');
      else return null;
    },
    setValue: function(el, value) {
      var $menuItem = $(el).find("[data-expanded='" + value + "']");
      // This will trigger actions defined by AdminLTE, as well as actions
      // defined in sidebar.js.
      $menuItem.prev().trigger("click");
    },
    subscribe: function(el, callback) {
      $(el).on('change.sidebarmenuExpandedInputBinding', function() {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off('.sidebarmenuExpandedInputBinding');
    }
  });
  Shiny.inputBindings.register(sidebarmenuExpandedInputBinding,
    'shinydashboard.sidebarmenuExpandedInputBinding');
  
  
  
  //---------------------------------------------------------------------
  // Source file: ../srcjs/input_binding_box.js
  
  /* global Shiny */
  
  // boxBinding
  // ------------------------------------------------------------------
  // This code creates an input binding for the boxPlus component
  var boxBinding = new Shiny.InputBinding();
  $.extend(boxBinding, { 
    find: function(scope) {
      return $(scope).find('.box');
    },
    getValue: function(el) {
      var isCollapsed = $(el).hasClass('collapsed-box');
      var display = $(el).css('display');
    
      var visible;
      if (display === "none") {
        visible = false;
      } else {
        visible = true;
      }
      return {collapsed: isCollapsed, visible: visible}; // this will be a list in R
    },
    setValue: function(el, value) {
      if (value === "restore") {
        // only restore if not visible
        if ($(el).css('display') == 'none') {
          $(el).show();
        } else {
          console.warn("This box is already visible!");
        }
      } else if (value === "toggle") {
        if ($(el).css('display') !== 'none') {
          $(el).toggleBox();
        } else {
          console.warn("This box is not visible. It does not make sense to collapse it!");
        }
      } else {
        if ($(el).css('display') !== 'none') {
          $(el).removeBox();
        } else {
          console.warn("This box is not visible!");
        }
      }
    },
    receiveMessage: function(el, data) {
      this.setValue(el, data);
      $(el).trigger('change');
    },
    subscribe: function(el, callback) {
      // handle manual click on collapse button
      $(el).on('click', '[data-widget="collapse"]', function(event) {
        setTimeout(function() {
          callback();
        }, 50);
      });
      
      // handle manual click on remove button
      $(el).on('click', '[data-widget="remove"]', function(event) {
        setTimeout(function() {
          callback();
        }, 50);
      });
  
      // handle change event triggered in the setValue method 
      $(el).on('change', function(event) {
        setTimeout(function() {
          callback();
        }, 50);
      });
    },
    unsubscribe: function(el) {
      $(el).off('.boxBinding');
    }
  });
  
  Shiny.inputBindings.register(boxBinding, 'box-input');



  //---------------------------------------------------------------------
  // Source file: ../srcjs/input_binding_box_sidebar.js
  
  /* global Shiny */
  
  // boxSidebarBinding
  // ------------------------------------------------------------------
  // This code creates an input binding for the boxPlus sidebar component
  var boxSidebarBinding = new Shiny.InputBinding();
  $.extend(boxSidebarBinding, {
    
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
      $(el).trigger('click');
      $(el).trigger("shown");
    },
    
    subscribe: function(el, callback) {
      $(el).on('click', function(e) {
        // set a delay so that Shiny get the input value when the collapse animation
        // is finished. 
        setTimeout(
          function() {
            callback();
          }, 10);
      });
    },
    
    unsubscribe: function(el) {
      $(el).off(".boxSidebarBinding");
    }
  });
  
  Shiny.inputBindings.register(boxSidebarBinding, "box-sidebar-input");
  

  
  //---------------------------------------------------------------------
  // Source file: ../srcjs/input_binding_controlbar.js
  
  /* global Shiny */
  
  // boxSidebarBinding
  // ------------------------------------------------------------------
  // This code creates an input binding for the dashboard controlbar component
  var controlbarBinding = new Shiny.InputBinding();
  
  $.extend(controlbarBinding, {
    initialize: function(el) {
      // this step is to overwrite global adminLTE options
      // to set the controlbar slide value
      var overlay = ($(el).attr('data-overlay') === "true");
      $.AdminLTE.options.controlSidebarOptions.slide = overlay;
    },
    find: function(scope) {
      // we need to re-activate the controlbar to consider the new options
      $.AdminLTE.controlSidebar.activate();
      return $(scope).find(".control-sidebar");
    },
  
    // Given the DOM element for the input, return the value
    getValue: function(el) {
      // this depends on the overlay value. If overlay, the sidebar will have the class.
      // If overlay is false, the body will have the class.
      return $("body").hasClass("control-sidebar-open") || $(el).hasClass("control-sidebar-open");
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

  
  //---------------------------------------------------------------------
  // Source file: ../srcjs/_end.js

});

//# sourceMappingURL=shinydashboard.js.map