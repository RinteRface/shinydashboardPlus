$(function(){
  // code to make sure that a carousel item is displayed
  // when it is generated via a shiny Output function
  // Thanks Dean Attali for the report
  $('.carousel').on('slide.bs.carousel', function () {
    $(this).trigger("shown");
  });
  
  // overwrite box animation speed. Putting 500 ms add unnecessary delay for Shiny.
  $.AdminLTE.boxWidget.animationSpeed = 10;
  
  
  var controlbarChange = function() {
    // 1) Trigger the resize event (so images are responsive and resize)
    $(window).trigger("resize");
  };
  
  // Whenever the right sidebar (controlbar) finishes a transition (which it does every time it
  // changes from collapsed to expanded and vice versa), call controlbarChange()
  $(".control-sidebar").on(
  'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend',
    controlbarChange);
});