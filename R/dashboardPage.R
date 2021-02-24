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
#' @param preloader shinydashboardPlus uses waiter (see \url{https://waiter.john-coene.com/#/}).
#' Pass a list like \code{list(html = spin_1(), color = "#333e48")}.
#' \code{waiter} expects to provide a sub-list to configure \link[waiter]{waiter_show_on_load} (refer to
#' the package help for all styles). \code{duration} defines the loader timeout.
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
                          freshTheme = NULL, preloader = NULL,
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
      if (!is.null(preloader)) {
        shiny::tagList(
          waiter::use_waiter(), # dependencies
          do.call(waiter_show_on_load, preloader)
        )
      },
      onload = if (!is.null(preloader)) {
        paste0(
          "window.ran = false;",
          "$(document).on('shiny:idle', function(event){
            if(!window.ran)
              $('.waiter-overlay').fadeOut(1000);
            window.ran = true;
          });"
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