#' @title AdminLTE2 block quote
#'
#' @description If you want to quote text
#'
#' @param ... any element.
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
#'      box(
#'       title = "BlockQuote example",
#'       blockQuote("I quote some text here!")
#'      )
#'     ),
#'     title = "Description Blocks"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
blockQuote <- function(...) {
  shiny::tags$blockquote(
    ...
  )
}