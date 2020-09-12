#' Dashboard Page with a right sidebar
#'
#' This creates a dashboard page for use in a Shiny app.
#'
#' @param header A header created by \code{dashboardHeaderPlus}.
#' @param sidebar A sidebar created by \code{\link[shinydashboard]{dashboardSidebar}} or 
#' \code{\link{dashboardSidebarPlus}}.
#' @param body A body created by \code{\link[shinydashboard]{dashboardBody}}.
#' @param controlbar A right sidebar created by \link{dashboardControlbar}. NULL by
#'   default.
#' @param footer A footer created by \link{dashboardFooter}.
#' @param title A title to display in the browser's title bar. If no value is
#'   provided, it will try to extract the title from the
#'   \code{dashboardHeaderPlus}.
#' @param skin A color theme. See \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' If the skin is light, the sidebar will have a light background.
#' @param preloader Whether to enable a page loader. FALSE by default.
#' @param duration Loader duration in seconds. 2s by default.
#' @param md Whether to enable material design. Experimental...
#' @param options Extra option to overwrite the vanilla AdminLTE configuration. See 
#' \url{https://adminlte.io/themes/AdminLTE/documentation/index.html#adminlte-options}.
#' Expect a list.
#'
#' @seealso \code{\link{dashboardHeaderPlus}}, \code{\link[shinydashboard]{dashboardSidebar}},
#'   \code{\link[shinydashboard]{dashboardBody}}.
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'    ui = dashboardPagePlus(
#'      collapse_sidebar = TRUE,
#'      options = list(sidebarExpandOnHover = TRUE),
#'      header = dashboardHeaderPlus(
#'       enable_rightsidebar = TRUE,
#'       rightSidebarIcon = "gears"
#'      ),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(),
#'      rightsidebar = rightSidebar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
dashboardPagePlus <- function(header, sidebar, body, controlbar = NULL, footer = NULL, title = NULL,
                              skin = c("blue", "blue-light","black","black-light", 
                                       "purple","purple-light", "green","green-light",
                                       "red","red-light", "yellow","yellow-light", "midnight"),
                              preloader = FALSE, duration = 2,
                              md = FALSE, options = NULL) {
  
  tagAssert(header, type = "header", class = "main-header")
  tagAssert(sidebar, type = "aside", class = "main-sidebar")
  tagAssert(body, type = "div", class = "content-wrapper")
  if (!is.null(footer)) {
    tagAssert(footer, type = "footer", class = "main-footer")
  } 
  if (!is.null(controlbar)) {
    tagAssert(controlbar, type = "aside", class = "control-sidebar")
  }
  skin <- match.arg(skin)
  
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
    controlbar
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