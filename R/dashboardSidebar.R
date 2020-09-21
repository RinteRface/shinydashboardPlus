#' Create a dashboard sidebar.
#'
#' A dashboard sidebar typically contains a \code{\link{sidebarMenu}}, although
#' it may also contain a \code{\link{sidebarSearchForm}}, or other Shiny inputs.
#'
#' @param ... Items to put in the sidebar.
#' @param disable If \code{TRUE}, the sidebar will be disabled.
#' @param width The width of the sidebar. This must either be a number which
#'   specifies the width in pixels, or a string that specifies the width in CSS
#'   units.
#' @param collapsed If \code{TRUE}, the sidebar will be collapsed on app startup.
#' @param minified Whether to slightly close the sidebar but still show item icons. Default
#' to TRUE.
#' @param id Sidebar input id. Returns the current state of the sidebar.
#' @export
#' @rdname sidebar
dashboardSidebar <- function(..., disable = FALSE, width = NULL, collapsed = FALSE,
                             minified = TRUE, id = NULL) {
  width <- shiny::validateCssUnit(width)
  
  if (is.null(id)) id <- "sidebarCollapsed"
  
  # Set up custom CSS for custom width
  custom_css <- NULL
  if (!is.null(width)) {
    # This CSS is derived from the sidebar-related instances of '230px' (the
    # default sidebar width) from inst/AdminLTE/AdminLTE.css. One difference is
    # that instead making changes to the global settings, we've put them in a
    # media query (min-width: 768px), so that it won't override other media
    # queries (like max-width: 767px) that work for narrower screens.
    custom_css <- shiny::tags$head(shiny::tags$style(shiny::HTML(gsub("_WIDTH_", width, fixed = TRUE, '
      .main-sidebar, .left-side {
        width: _WIDTH_;
      }
      @media (min-width: 768px) {
        .content-wrapper,
        .right-side,
        .main-footer {
          margin-left: _WIDTH_;
        }
        .main-sidebar,
        .left-side {
          width: _WIDTH_;
        }
      }
      @media (max-width: 767px) {
        .sidebar-open .content-wrapper,
        .sidebar-open .right-side,
        .sidebar-open .main-footer {
          -webkit-transform: translate(_WIDTH_, 0);
          -ms-transform: translate(_WIDTH_, 0);
          -o-transform: translate(_WIDTH_, 0);
          transform: translate(_WIDTH_, 0);
        }
      }
      @media (max-width: 767px) {
        .main-sidebar,
        .left-side {
          -webkit-transform: translate(-_WIDTH_, 0);
          -ms-transform: translate(-_WIDTH_, 0);
          -o-transform: translate(-_WIDTH_, 0);
          transform: translate(-_WIDTH_, 0);
        }
      }
      @media (min-width: 768px) {
        .sidebar-collapse .main-sidebar,
        .sidebar-collapse .left-side {
          -webkit-transform: translate(-_WIDTH_, 0);
          -ms-transform: translate(-_WIDTH_, 0);
          -o-transform: translate(-_WIDTH_, 0);
          transform: translate(-_WIDTH_, 0);
        }
      }
    '))))
  }
  
  # If we're restoring a bookmarked app, this holds the value of whether or not the
  # sidebar was collapsed. If this is not the case, the default is whatever the user
  # specified in the `collapsed` argument.
  dataValue <- shiny::restoreInput(id = id, default = collapsed)
  if (disable) dataValue <- TRUE # this is a workaround to fix #209
  dataValueString <- if (dataValue) "true" else "false"
  
  # The expanded/collapsed state of the sidebar is actually set by adding a
  # class to the body (not to the sidebar). However, it makes sense for the
  # `collapsed` argument to belong in this function. So this information is
  # just passed through (as the `data-collapsed` attribute) to the
  # `dashboardPage()` function
  shiny::tags$aside(
    id = id,
    class = "main-sidebar", 
    `data-minified` = if (minified) "true" else "false", 
    `data-collapsed` = dataValueString, 
    custom_css,
    shiny::tags$section(
      id = "sidebarItemExpanded",
      class = "sidebar",
      `data-disable` = if (disable) 1 else NULL,
      list(...)
    )
  )
}




#' Function to programmatically toggle the state of the sidebar
#' 
#' \link{updateSidebar} allows to toggle a \link{dashboardSidebar} on the client.
#'
#' @param id Sidebar id.
#' @param session Shiny session object.
#' @export
#' @rdname sidebar
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'    ui = dashboardPage(
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(id = "sidebar"),
#'      body = dashboardBody(
#'        actionButton(inputId = "sidebarToggle", label = "Toggle Sidebar")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      
#'      observeEvent(input$sidebar, {
#'        if (input$sidebar) {
#'          showModal(modalDialog(
#'            title = "Alert",
#'            "The sidebar is opened.",
#'            easyClose = TRUE,
#'            footer = NULL
#'          ))
#'        }
#'      })
#'      
#'      observeEvent(input$sidebarToggle, {
#'        updateSidebar("sidebar")
#'      })
#'      
#'      observe({
#'        print(input$sidebar)
#'      })
#'    }
#'  )
#' }
updateSidebar <- function(id, session = shiny::getDefaultReactiveDomain()) {
  message <- list(value = !session$input[[id]])
  session$sendInputMessage(id, message)
}