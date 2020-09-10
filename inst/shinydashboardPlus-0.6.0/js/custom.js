$(function(){
  // code to make sure that a carousel item is displayed
  // when it is generated via a shiny Output function
  // Thanks Dean Attali for the report
  $('.carousel').on('slide.bs.carousel', function () {
    $(this).trigger("shown");
  });
  
  // overwrite box animation speed. Putting 500 ms add unnecessary delay for Shiny.
  $.AdminLTE.boxWidget.animationSpeed = 10;
  
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
});