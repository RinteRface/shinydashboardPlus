#' @title AdminLTE2 special large button
#'
#' @description Create a large button ideal for web applications but identical
#' to the classic Shiny action button.
#'
#' @inheritParams shiny::actionButton
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "App Buttons",
#'       status = NULL,
#'       appButton(
#'         inputId = "myAppButton",
#'         label = "Users", 
#'         icon = icon("users"), 
#'         dashboardBadge(textOutput("btnVal"), color = "blue")
#'       )
#'      )
#'     ),
#'     title = "App buttons"
#'   ),
#'   server = function(input, output) {
#'    output$btnVal <- renderText(input$myAppButton)
#'   }
#'  )
#' }
#'
#' @export
appButton <- function(..., inputId, label, icon = NULL, width = NULL) {
  
  if (!is.null(icon)) tagAssert(icon, type = "i")
  
  shiny::tagAppendAttributes(
    shiny::actionButton(inputId, label, icon, width, ...),
    class = "btn-app"
  )
}


#adminLTEToggle <- function(inputId) {
#  tags$div(
#    class = "btn-group",
#    `data-toggle` = "btn-toggle",
#    tags$button(
#      type = "button",
#      class = "btn btn-default btn-sm active",
#      tags$i(class = "fa fa-square text-green")
#    ),
#    tags$button(
#      type = "button",
#      class = "btn btn-default btn-sm",
#      tags$i(class = "fa fa-square text-red")
#    )
#  )
#}