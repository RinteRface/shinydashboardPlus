#' @title AdminLTE2 gradient box
#'
#' @description Create an enhanced box
#'
#' @param ... body content.
#' @param title box title.
#' @param icon header icon, if any. Should be written like "fa fa-times".
#' @param gradientColor color of the box: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param boxToolSize size of the toolbox: choose among "xs", "sm", "md", "lg".
#' @param footer the box footer. 
#' @param width box width (between 1 and 12). 
#' @param height box height.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the box. 
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
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
#'      gradientBox(
#'       title = "My gradient Box",
#'       icon = "fa fa-th",
#'       gradientColor = "teal", 
#'       boxToolSize = "sm", 
#'       footer = fluidRow(
#'         column(
#'           width = 6,
#'           descriptionBlock(
#'             number = "17%", 
#'             number_color = "green", 
#'             number_icon = "fa fa-caret-up",
#'             header = "$35,210.43", 
#'             text = "TOTAL REVENUE", 
#'             right_border = TRUE,
#'             margin_bottom = FALSE
#'           )
#'         ),
#'         column(
#'           width = 6,
#'           descriptionBlock(
#'             number = "18%", 
#'             number_color = "red", 
#'             number_icon = "fa fa-caret-down",
#'             header = "1200", 
#'             text = "GOAL COMPLETION", 
#'             right_border = FALSE,
#'             margin_bottom = FALSE
#'           )
#'         )
#'       ),
#'       "This is a gradient box"
#'       )
#'     ),
#'     title = "Description Blocks"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
gradientBox <- function(..., title = NULL, icon = NULL, gradientColor = NULL, 
                        boxToolSize = "sm", footer = NULL, width = 6, height = NULL,
                        collapsible = TRUE, closable = FALSE) {
  cl <- "box box-solid"
  if (!is.null(gradientColor)) cl <- paste0(cl, " bg-", gradientColor, "-gradient")
  
  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height))
  }
  
  shiny::column(
    width = width,
    shiny::tags$div(
      class = cl,
      style = style,
      
      # box header
      shiny::tags$div(
        class = "box-header",
        style="cursor: move;",
        
        shiny::tags$i(class = icon),
        shiny::tags$h3(class = "box-title", title),
        
        # box header buttons
        shiny::tags$div(
          class = "pull-right box-tools",
          if (collapsible) {
            shiny::tags$button(
              class = paste0("btn", " bg-", gradientColor, " btn-", boxToolSize),
              `data-widget` = "collapse",
              type = "button",
              shiny::tags$i(class = "fa fa-minus")
            )
          },
          if (closable) {
            shiny::tags$button(
              class = paste0("btn", " bg-", gradientColor, " btn-", boxToolSize),
              `data-widget` = "remove",
              type = "button",
              shiny::tags$i(class = "fa fa-times")
            )
          }
        )
      ),
      
      # box body
      shiny::tags$div(
        class = "box-body border-radius-none",
        ...
      ),
      
      # box footer
      shiny::tags$div(
        class="box-footer no-border",
        footer
      )
    )
  )
}