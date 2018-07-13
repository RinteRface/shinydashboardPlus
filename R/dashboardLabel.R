#' @title AdminLTE2 label
#'
#' @description Create a label
#'
#' @param ... any text.
#' @param status label status: "danger", "success", "info", "primary", "warning".
#' @param style label border style: "default" (rounded angles), "circle" or "square".
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
#'      dashboardLabel("Label 1", status = "info"),
#'      dashboardLabel("Label 2", status = "danger", style = "circle"),
#'      dashboardLabel("Label 3", status = "success", style = "square")
#'     )
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
dashboardLabel <- function(..., status = "primary", style = "default") {
  validateStatus(status)
  shiny::tags$span(
    class = paste0("label", " label-", status),
    style = if (style == "circle") {
      "border-radius: 50%;"
    } else if (style == "square") {
      "border-radius: 0%;"
    } else NULL,
    ...
  )
}
