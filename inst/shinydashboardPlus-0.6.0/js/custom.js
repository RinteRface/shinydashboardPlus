$(function(){
  // code to make sure that a carousel item is displayed
  // when it is generated via a shiny Output function
  // Thanks Dean Attali for the report
  $('.carousel').on('slide.bs.carousel', function () {
    $(this).trigger("shown");
  });
  
  // overwrite box animation speed. Putting 500 ms add unnecessary delay for Shiny.
  $.AdminLTE.boxWidget.animationSpeed = 10;
});