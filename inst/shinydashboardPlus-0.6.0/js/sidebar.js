$(function() {
  
  // toggle sidebar at start depending on the body class
  var sidebarCollapsed = $('.main-sidebar').attr('data-collapsed');
  if (sidebarCollapsed) {
    $('body').addClass('sidebar-collapse');
  }
  
  // Determine whether the sidebar should be minified instead of fully collapsed
  var sidebarMinified = $('.main-sidebar').attr('data-minified');
  if (sidebarMinified) {
    $('body').addClass('sidebar-mini');
  }
  
});
