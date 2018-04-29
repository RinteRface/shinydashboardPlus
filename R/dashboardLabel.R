#' @title AdminLTE2 label
#'
#' @description Create a label
#'
#' @param ... any text.
#' @param status label status: "danger", "success", "info", "primary", "warning".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      dashboardLabel("Label 1", status = "info")
#'     )
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
dashboardLabel <- function(..., status = "primary") {
  validateStatus(status)
  shiny::tags$span(
    class = paste0("label", " label-", status),
    ...
  )
}
