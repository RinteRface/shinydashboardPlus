#' @title AdminLTE2 nav pill container
#'
#' @description Create a container for nav elements
#'
#' @param ... slot for navPillsItem.
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
#'       title = "Nav Pills",
#'       status = "info",
#'       "Box Body",
#'       footer = navPills(
#'         navPillsItem(
#'           pillName = "Item 1", 
#'           pillColor = "green",
#'           pillIcon = NULL, 
#'           pillText = 10
#'         ),
#'         navPillsItem(
#'           pillName = "Item 2", 
#'           pillColor = "red",
#'           pillIcon = "fa fa-angle-down", 
#'           pillText = "10%",
#'           active = TRUE
#'         )
#'       )
#'      )
#'     ),
#'     title = "Nav Pills"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
navPills <- function(...) {
  shiny::tags$ul(
    class = "nav nav-pills nav-stacked",
    ...
  )
}


#' @title AdminLTE2 nav pill item
#'
#' @description Create a nav pill item
#'
#' @param pillName pill name.
#' @param pillColor pill color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param pillIcon pill icon, if any. Should be written like "fa fa-times".
#' @param pillText pill text. Can also be a number.
#' @param active Whether the item is active or not. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
navPillsItem <- function(pillName = NULL, pillColor = NULL, 
                         pillIcon = NULL, pillText = NULL,
                         active = FALSE) {
  cl <- "pull-right"
  if (!is.null(pillColor)) cl <- paste0(cl, " text-", pillColor)
  
  shiny::tags$li(
    class = if (isTRUE(active)) "active" else NULL,
    shiny::tags$a(
      href = "#", 
      pillName,
      shiny::tags$span(
        class = cl,
        shiny::tags$i(class = pillIcon),
        pillText
      )
    )
  )
}