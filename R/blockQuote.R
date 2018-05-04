#' @title AdminLTE2 block quote
#'
#' @description If you want to quote text
#'
#' @param ... any element.
#' @param side blockauote orientation. "left" by default, can be set to "right".
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
#'     title = "blockQuote"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
blockQuote <- function(..., side = "left") {
  shiny::tags$blockquote(
    class = if (side == "right") "pull-right" else NULL,
    ...
  )
}