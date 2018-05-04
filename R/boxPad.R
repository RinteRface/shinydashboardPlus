#' @title AdminLTE2 vertical block container
#'
#' @description Create a vertical container for descriptionBlock.
#'
#' @param ... any element such as descriptionBlock.
#' @param color background color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param style custom CSS, if any.
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
#'      box(title = "Box with right pad",
#'       status = "warning",
#'       fluidRow(
#'         column(width = 6),
#'         column(
#'           width = 6,
#'           boxPad(
#'             color = "green",
#'             descriptionBlock(
#'               header = "8390", 
#'               text = "VISITS", 
#'               right_border = FALSE,
#'               margin_bottom = TRUE
#'             ),
#'             descriptionBlock(
#'               header = "30%", 
#'               text = "REFERRALS", 
#'               right_border = FALSE,
#'               margin_bottom = TRUE
#'             ),
#'             descriptionBlock(
#'               header = "70%", 
#'               text = "ORGANIC", 
#'               right_border = FALSE,
#'               margin_bottom = FALSE
#'             )
#'           )
#'         )
#'       )
#'      )
#'     ),
#'     title = "boxPad"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
boxPad <- function(..., color = NULL, style = NULL) {
  cl <- "pad box-pane-right"
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  shiny::tags$div(
    class = cl,
    style = style,
    ...
  )
}