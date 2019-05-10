$(function(){
  // code to make sure that a carousel item is displayed
  // when it is generated via a shiny Output function
  // Thanks Dean Attali for the report
  $('.carousel').on('slide.bs.carousel', function () {
    $(this).trigger("shown");
  });
});