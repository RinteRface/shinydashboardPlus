#' Dashboard Footer
#'
#' This creates a dashboard footer 
#' 
#' @param left Left text.
#' @param right Right text.
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(shinydashboard)
#' library(shinydashboardPlus)
#' 
#' shinyApp(
#'   ui = dashboardPagePlus(
#'     header = dashboardHeaderPlus(
#'      enable_rightsidebar = TRUE,
#'      rightSidebarIcon = "gears"
#'     ),
#'     sidebar = dashboardSidebar(),
#'     body = dashboardBody(),
#'     rightsidebar = rightSidebar(),
#'     footer = dashboardFooter(
#'      left = "By Divad Nojnarg",
#'      right = "Zurich, 2019"
#'     ),
#'     title = "DashboardPage"
#'   ),
#'   server = function(input, output) { }
#' )
#' }
#' @export
dashboardFooter <- function(left = NULL, right = NULL) {
  htmltools::tags$footer(
    class = "main-footer",
    shiny::tags$div(class = "pull-right hidden-xs", right),
    left
  )
}