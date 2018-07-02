$(function () {
  // select all tabs
  var $tabs = $("#right_sidebar .nav.nav-tabs li");
  // get only the one with the active class
  var $selectedTab = $tabs.filter(".active");
  var $index = $selectedTab.index();
  
  //$('#right_sidebar .nav.nav-tabs li a').tab('show');
  
  //if ($selectedTab.length === 0) {
  //  // If no tab starts selected, use the first one, if present
  //  $('#right_sidebar .nav.nav-tabs li:eq(0) a').tab('show');
  //  $('#right_sidebar .nav.nav-tabs li:eq(0) a').addClass('active');
  //} else {
  //  $("#right_sidebar .nav.nav-tabs li:eq(" + $index + ") a").tab("show");
  //  $("#right_sidebar .nav.nav-tabs li:eq(" + $index + ")").addClass('active');
  //}
});