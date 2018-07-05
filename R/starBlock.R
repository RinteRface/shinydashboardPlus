#' @title AdminLTE2 starBlock
#'
#' @description Create a starBlock item (ideal for rating)
#'
#' @param maxstar Maximum number of stars by block.
#' @param grade Current score. Should be positive and lower or equal to maxstar.
#' @param color Star color: see \code{validColors()} in the documentation.
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
#'       title = "Star example",
#'       starBlock(grade = 5),
#'       starBlock(grade = 5, color = "olive"),
#'       starBlock(grade = 1, color = "maroon"),
#'       starBlock(grade = 3, color = "teal")
#'      )
#'     ),
#'     title = "starBlock"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
starBlock <- function(maxstar = 5, grade, color = "yellow") {
  
  stopifnot(!is.null(grade))
  stopifnot(grade >= 0)
  stopifnot(grade <= maxstar)
  
  shiny::tags$td(
    class = "mailbox-star",
    shiny::tags$a(
      href = "javascript:void(0)",
      if (grade > 0) {
        full_star <- lapply(1:grade, FUN = function(i) {
          shiny::tags$i(class = paste0("fa text-", color, " fa-star"))
        })
      },
      if (grade < maxstar) {
        empty_star <- lapply(1:(maxstar - grade), FUN = function(i) {
          shiny::tags$i(class = paste0("fa text-", color, " fa-star-o"))
        })
      }
    ),
    shiny::tags$br()
  )
}