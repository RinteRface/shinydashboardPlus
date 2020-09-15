#' Dashboard Page with a right sidebar
#'
#' This creates a dashboard page for use in a Shiny app.
#'
#' @param header A header created by \code{\link{dashboardHeader}}.
#' @param sidebar A sidebar created by \code{\link{dashboardSidebar}}.
#' @param body A body created by \code{\link[shinydashboard]{dashboardBody}}.
#' @param controlbar A right sidebar created by \link{dashboardControlbar}. NULL by
#'   default.
#' @param footer A footer created by \link{dashboardFooter}.
#' @param title A title to display in the browser's title bar. If no value is
#'   provided, it will try to extract the title from the
#'   \code{dashboardHeaderPlus}.
#' @param skin A color theme. See \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' If the skin is light, the sidebar will have a light background. Not compatible with freshTheme.
#' @param freshTheme A skin powered by the fresh package. Not compatible with skin.
#' See \url{https://dreamrs.github.io/fresh/articles/vars-shinydashboard.html}.
#' @param preloader Whether to enable a page loader. FALSE by default.
#' @param duration Loader duration in seconds. 2s by default.
#' @param md Whether to enable material design. Experimental...
#' @param options Extra option to overwrite the vanilla AdminLTE configuration. See 
#' \url{https://adminlte.io/themes/AdminLTE/documentation/index.html#adminlte-options}.
#' Expect a list.
#'
#' @seealso \code{\link{dashboardHeader}}, \code{\link{dashboardSidebar}},
#'   \code{\link[shinydashboard]{dashboardBody}}.
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  library(fresh)
#'  
#'  shinyApp(
#'    ui = dashboardPage(
#'      freshTheme = create_theme(
#'       adminlte_color(
#'         light_blue = "#55e7ff",
#'         blue = "#2011a2",
#'         navy = "#201148",
#'         red = "#ff34b3"
#'       ),
#'       adminlte_sidebar(
#'         dark_bg = "#D8DEE9",
#'         dark_hover_bg = "#81A1C1",
#'         dark_color = "#2E3440"
#'       ),
#'       adminlte_global(
#'         content_bg = "#FFF",
#'         box_bg = "#D8DEE9", 
#'         info_box_bg = "#D8DEE9"
#'       )
#'      ),
#'      options = list(sidebarExpandOnHover = TRUE),
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'       box(background = "red"),
#'       box(background = "blue"),
#'       box(background = "navy")
#'      ),
#'      controlbar = dashboardControlbar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
dashboardPage <- function(header, sidebar, body, controlbar = NULL, footer = NULL, title = NULL,
                          skin = c(
                            "blue", "blue-light","black","black-light", 
                            "purple","purple-light", "green","green-light",
                            "red","red-light", "yellow","yellow-light", "midnight"
                          ),
                          freshTheme = NULL, preloader = FALSE, duration = 2,
                          md = FALSE, options = NULL) {
  
  skin <- match.arg(skin)
  if (!is.null(freshTheme) && !is.null(skin)) {
    message(sprintf("Customizing AdminLTE %s skin with the current {fresh} theme", skin))
  }
  
  tagAssert(header, type = "header", class = "main-header")
  tagAssert(sidebar, type = "aside", class = "main-sidebar")
  tagAssert(body, type = "div", class = "content-wrapper")
  if (!is.null(footer)) {
    tagAssert(footer, type = "footer", class = "main-footer")
  } 
  if (!is.null(controlbar)) {
    tagAssert(controlbar[[2]][[1]], type = "aside", class = "control-sidebar")
    tagAssert(controlbar[[2]][[2]], type = "div", class = "control-sidebar-bg")
  }
  
  bodyCl <- paste0("hold-transition skin-", skin)
  
  extractTitle <- function(header) {
    x <- header$children[[1]]
    if (x$name == "span" &&
        !is.null(x$attribs$class) &&
        x$attribs$class == "logo" &&
        length(x$children) != 0)
    {
      x$children[[1]]
    } else {
      ""
    }
  }
  
  title <- title %OR% extractTitle(header)
  
  content <- shiny::tags$div(
    class = "wrapper",
    header, 
    sidebar, 
    if (preloader) preloader(),
    body, 
    footer,
    controlbar,
    if (!is.null(freshTheme)) {
      fresh::use_theme(freshTheme)
    }
  )
  
  addDeps(
    shiny::tags$body(
      # preloader, if any
      onload = if (preloader) {
        duration <- duration * 1000
        paste0(
          "$(document).ready(function() {
            setTimeout(function(){
            $('body').addClass('loaded');
            $('h1').css('color','#222222');
            }, ", duration, ");
          });
          "
        )
      },
      class = bodyCl,
      `data-skin` = skin,
      style = "min-height: 611px;",
      shiny::bootstrapPage(content, title = title)
    ),
    md = md,
    options = options
  )
}




#' AdminLTE2 preloader
#'
#' This creates a preloader used by \link{dashboardPage}
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @keywords internal
#' @noRd
preloader <- function() {
  loaderTag <- shiny::tags$div(
    id = "loader-wrapper",
    shiny::tags$div(id = "loader"),
    shiny::tags$div(class = "loader-section section-left"),
    shiny::tags$div(class = "loader-section section-right")
  )
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$style(
          shiny::HTML(
            paste0(
              '#loader-wrapper {
              position: fixed;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              z-index: 5000;
              }
              #loader {
              display: block;
              position: relative;
              left: 50%;
              top: 50%;
              width: 150px;
              height: 150px;
              margin: -75px 0 0 -75px;
              border: 3px solid transparent;
              border-top-color: #3498db;
              border-radius: 50%;
              z-index: 5001;
              -webkit-animation: spin 2s linear infinite;
              animation: spin 2s linear infinite;
              }
              #loader:before {
              content: "";
              position: absolute;
              top: 5px;
              left: 5px;
              right: 5px;
              bottom: 5px;
              border: 3px solid transparent;
              border-top-color: #e74c3c;
              border-radius: 50%;
              -webkit-animation: spin 3s linear infinite;
              animation: spin 3s linear infinite;
              }
              #loader:after {
              content: "";
              position: absolute;
              top: 15px;
              left: 15px;
              right: 15px;
              bottom: 15px;
              border: 3px solid transparent;
              border-top-color: #f9c922;
              border-radius: 50%;
              }
              
              
              /* copy and paste the animation inside all 3 elements */
              /* #loader, #loader:before, #loader:after */
              -webkit-animation: spin 1.5s linear infinite;
              animation: spin 1.5s linear infinite;
              
              /* include this only once */
              @-webkit-keyframes spin {
              0%   {
              -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: rotate(0deg);  /* IE 9 */
              transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
              }
              100% {
              -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: rotate(360deg);  /* IE 9 */
              transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
              }
              }
              @keyframes spin {
              0%   {
              -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: rotate(0deg);  /* IE 9 */
              transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
              }
              100% {
              -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: rotate(360deg);  /* IE 9 */
              transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
              }
              }
              
              
              #loader-wrapper .loader-section {
              position: fixed;
              top: 0;
              width: 51%;
              height: 100%;
              background: #222222;
              z-index: 5000;
              }
              #loader-wrapper .loader-section.section-left {
              left: 0;
              }
              #loader-wrapper .loader-section.section-right {
              right: 0;
              }
              
              
              /* Loaded */
              .loaded #loader-wrapper .loader-section.section-left {
              -webkit-transform: translateX(-100%);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: translateX(-100%);  /* IE 9 */
              transform: translateX(-100%);  /* Firefox 16+, IE 10+, Opera */
              }
              .loaded #loader-wrapper .loader-section.section-right {
              -webkit-transform: translateX(100%);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: translateX(100%);  /* IE 9 */
              transform: translateX(100%);  /* Firefox 16+, IE 10+, Opera */
              }
              
              .loaded #loader {
              opacity: 0;
              }
              
              .loaded #loader-wrapper {
              visibility: hidden;
              }
              
              .loaded #loader {
              opacity: 0;
              -webkit-transition: all 0.3s ease-out; 
              transition: all 0.3s ease-out;
              }
              
              .loaded #loader-wrapper .loader-section.section-right,
              .loaded #loader-wrapper .loader-section.section-left {
              
              -webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000); 
              transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
              }
              .loaded #loader-wrapper {
              -webkit-transform: translateY(-100%);
              -ms-transform: translateY(-100%);
              transform: translateY(-100%);
              
              -webkit-transition: all 0.3s 1s ease-out; 
              transition: all 0.3s 1s ease-out;
              }
              '
            )
          )
        )
      )
    ),
    loaderTag
  )
}