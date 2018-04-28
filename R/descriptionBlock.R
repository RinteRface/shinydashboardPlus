#' @title AdminLTE2 description block
#'
#' @description Create a description block, perfect for writing statistics
#'
#' @param number any number.
#' @param number_color number color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param number_icon number icon, if any. Should be written like "fa fa-times".
#' @param header bold text.
#' @param text additional text.
#' @param right_border TRUE by default. Whether to display a right border to
#'   separate two blocks. The last block on the right should not have a right border.
#' @param margin_bottom FALSE by default. Set it to TRUE when the
#'   descriptionBlock is used in a boxPad context.
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
#'       solidHeader = FALSE,
#'       title = "Status summary",
#'       background = NULL,
#'       width = 4,
#'       status = "danger",
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
descriptionBlock <- function(number = NULL, number_color = NULL, number_icon = NULL,
                             header = NULL, text = NULL, right_border = TRUE,
                             margin_bottom = FALSE) {
  
  cl <- "description-block"
  if (isTRUE(right_border)) cl <- paste0(cl, " border-right")
  if (isTRUE(margin_bottom)) cl <- paste0(cl, " margin-bottom")
  
  numcl <- "description-percentage"
  if (!is.null(number_color)) numcl <- paste0(numcl, " text-", number_color)
  
  shiny::tags$div(
    class = cl,
    shiny::tags$span(
      class = numcl, 
      number,
      if (!is.null(number_icon)) shiny::tags$i(class = number_icon)
    ),
    shiny::tags$h5(class = "description-header", header),
    shiny::tags$span(class = "description-text", text)
  )
}