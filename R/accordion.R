#' @title AdminLTE2 accordion container
#'
#' @description Create an accordion container
#'
#' @param ... slot for accordionItem.
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
#'       title = "Accordion Demo",
#'       accordion(
#'         accordionItem(
#'           id = 1,
#'           title = "Accordion Item 1",
#'           color = "danger",
#'           "This is some text!"
#'         ),
#'         accordionItem(
#'           id = 2,
#'           title = "Accordion Item 2",
#'           color = "warning",
#'           "This is some text!"
#'         ),
#'         accordionItem(
#'           id = 3,
#'           title = "Accordion Item 3",
#'           color = "info",
#'           "This is some text!"
#'         )
#'       )
#'      )
#'     ),
#'     title = "Description Blocks"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
accordion <- function(...) {
  shiny::tags$div(
    class = "box-group",
    id = "accordion",
    ...
  )
}


#' @title AdminLTE2 accordion item
#'
#' @description Create an accordion item to put inside an accordion container
#'
#' @param ... text to write in the item.
#' @param id unique item id.
#' @param title item title.
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
accordionItem <- function(..., id, title = NULL, color = NULL) {
  
  stopifnot(!is.null(id))
  
  cl <- "panel box"
  if (!is.null(color)) cl <- paste0(cl, " box-", color)
  
  shiny::tags$div(
    class = cl,
    
    # box header
    shiny::tags$div(
      class = "box-header with-border",
      shiny::tags$h4(
        class = "box-title",
        shiny::tags$a(
          href = paste0("#collapse", id),
          `data-toggle` = "collapse",
          `data-parent` = "#accordion",
          `aria-expanded` = "false",
          class= "collapsed",
          title
        )
      )
    ),
    
    shiny::tags$div(
      id = paste0("collapse", id), 
      class = "panel-collapse collapse",
      `aria-expanded` = "false",
      style = "height: 0px;",
      shiny::tags$div(class = "box-body", ...)
    )
    
  )
}