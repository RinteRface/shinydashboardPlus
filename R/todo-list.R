#' @title AdminLTE2 todo list container
#'
#' @description Create a todo list container
#'
#' @param ... slot for todoListItem.
#' @param sortable Whether the list elements are sortable or not.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinyjqui)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       "Sortable todo list demo",
#'       status = "warning",
#'       todoList(
#'         todoListItem(
#'           label = "Design a nice theme",
#'           "Some text here"
#'         ),
#'         todoListItem(
#'           label = "Make the theme responsive",
#'           "Some text here"
#'         ),
#'         todoListItem(
#'           checked = TRUE,
#'           label = "Let theme shine like a star"
#'         )
#'        )
#'       ),
#'       box(
#'       "Simple todo list demo",
#'       status = "warning",
#'       todoList(
#'       sortable = FALSE,
#'         todoListItem(
#'           label = "Design a nice theme",
#'           "Some text here"
#'         ),
#'         todoListItem(
#'           label = "Make the theme responsive",
#'           "Some text here"
#'         ),
#'         todoListItem(
#'           checked = TRUE,
#'           label = "Let theme shine like a star"
#'         )
#'        )
#'       )
#'     ),
#'     title = "Todo Lists"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
todoList <- function(..., sortable = TRUE) {
  todoListTag <- shiny::tags$ul(
    class = "todo-list",
    ...
  )
  
  if (isTRUE(sortable)) todoListTag <- shinyjqui::jqui_sortabled(todoListTag) 
  
  todoListTag
  
}



#' @title AdminLTE2 todo list item
#'
#' @description Create a todo list item
#'
#' @param ... any element such as labels, ...
#' @param checked Whether the list item is checked or not.
#' @param label item label.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
todoListItem <- function(..., checked = FALSE, label = NULL) {
  cl <- NULL
  if (isTRUE(checked)) cl <- "done"
  
  shiny::tags$li(
    class = cl,
    
    # sortable icon
    shiny::tags$span(
      class = "handle",
      shiny::tags$i(class = "fa fa-ellipsis-v"),
      shiny::tags$i(class = "fa fa-ellipsis-v")
    ),
    
    # checkbox trigger
    # need to be implemented (custom binding js)
    #shiny::tags$input(type = "checkbox"),
    
    # label
    shiny::tags$span(class = "text", label),
    
    # any element
    shiny::tags$small(
      ...
    )
  )
  
}