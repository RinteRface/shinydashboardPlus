#' Dashboard Footer
#'
#' This creates a dashboard footer 
#' 
#' @param left_text Left text.
#' @param right_text Right text.
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
#'      left_text = "By Divad Nojnarg",
#'      right_text = "Zurich, 2019"
#'     ),
#'     title = "DashboardPage"
#'   ),
#'   server = function(input, output) { }
#' )
#' }
#' @export
dashboardFooter <- function(left_text = NULL, right_text = NULL) {
  htmltools::tags$footer(
    class = "main-footer",
    shiny::tags$div(class = "pull-right hidden-xs", right_text),
    left_text
  )
}